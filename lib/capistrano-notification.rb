require 'validatable'
require 'shout-bot'

module CapistranoNotification
  def self.extended(config)
    config.set :local_user, ENV['USER'] || ENV['USERNAME'] || 'unknown'
    config.set :deploy_target, config.fetch(:stage, config.fetch(:rails_env, 'production'))
  end

  class Base
    include Validatable

    def self.var(name, opts = {})
      define_method name do |*args|
        case args.size
        when 0
          if value = instance_variable_get("@#{name}")
            value
          else
            default = opts[:default]
            send name, default.is_a?(Proc) ? default.call(self) : default
          end
        when 1
          instance_variable_set "@#{name}", args.first
        else
          raise ArgumentError, "wrong number of arguments (#{args.size} for 0 or 1)"
        end
      end

      if opts[:required]
        validates_presence_of name
      end
    end

    def initialize(vars = {}, &block)
      vars.each do |k, v|
        send k, v
      end

      block.call(self) if block
    end

    validates_presence_of :name
  end

  class IRC < Base
    var :name, :default => 'IRC'
    var :user, :required => true, :default => 'capistrano'
    var :password
    var :host, :required => true
    var :port, :required => true, :default => 6667
    var :channel, :required => true
    var :message, :required => true

    def run
      ShoutBot.shout("irc://#{login}@#{host}:#{port}/#{channel}") do |channel|
        channel.say message
      end
    end

    def login
      [user, password].compact.join(':')
    end
  end

  def irc(opts = {}, &block)
    add IRC.new(opts, &block)
  end

  def add(notification)
    task_name = notification.name.downcase.gsub(' ', '_')

    namespace :deploy do
      namespace :notify do
        desc "Notify #{name} of the deployment."
        task task_name, :roles => :app, :except => {:no_release => true} do
          if notification.valid?
            notification.run
          else
            $stderr.puts notification.errors.full_messages
          end
        end
      end
    end

    after 'deploy', "deploy:notify:#{task_name}"
  end
end

Capistrano.plugin :notification, CapistranoNotification

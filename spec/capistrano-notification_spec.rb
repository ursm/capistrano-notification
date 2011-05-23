require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module CapistranoNotification
  describe Base do
    describe ".var" do
      def base_subclass_instance(&block)
        klass = Class.new(Base)
        klass.module_eval(&block)
        @subject = klass.new
      end

      describe "w/ symbol only" do
        subject do
          base_subclass_instance do
            var :name
          end
        end

        before { subject.name("foo") }
        its(:name) { should == "foo" }
      end

      describe "w/ default value" do
        subject do
          base_subclass_instance do
            var :name, :default => 'bar'
          end
        end
        its(:name) { should == "bar" }
      end

      describe "w/ required" do
        context "when valid" do
          subject do
            base_subclass_instance do
              var :name, :required => true
            end
          end

          before { subject.name("baz") }
          it { should be_valid }
          its(:name) { should == "baz" }
        end

        context "when invalid" do
          subject do
            base_subclass_instance do
              var :name, :default => "anonymous_base_subclass"
              var :foo, :required => true
            end
          end
          specify do
            subject.should_not be_valid
          end
        end
      end

      describe "pass via block" do
        subject do
          base_subclass_instance do
            var :name
          end
        end
        before { subject.name{ "pass_via_block" } }
        its(:name) { should == "pass_via_block" }
      end
    end
  end
end

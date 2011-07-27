require 'spec_helper'

module HealthRails
  describe HealthCheck do
    let(:health_check) { HealthRails::HealthCheck.new }

    before(:each) do
      HealthRails::HealthCheck.stub(:checks).and_return({})
      HealthRails.stub(:health_checks).and_return([])
    end

    describe "run all checks and return status" do
      it "fails" do
        check "Failing" do
          raise HealthCheckFailure, "Exception"
        end
        check "Passing" do
          nil
        end
        health_check.all_ok?.should be(false)
      end

      it "passes" do
        check "Passing 1" do
          nil
        end
        check "Passing 2" do
          nil
        end
        health_check.all_ok?.should be(true)
      end
    end

    describe "check" do
      it "push check in checks hash" do
        block = lambda {}
        check("Foo Bar", &block)
        health_check.checks.size.should be(1)
        health_check.check("Foo Bar").should be(block)
      end

      it "push check in health_checks config if auto activated" do
        check "Foo" do
          nil
        end
        check "Bar", false do
          nil
        end
        check "Baz" do
          nil
        end
        HealthRails.health_checks.should eql(["Foo", "Baz"])
      end
    end

    it "join error messages" do
      health_check.stub(:errors).and_return(["Foo", "Bar", "Baz"])
      health_check.error_messages.should eql("Foo\nBar\nBaz")
    end

    describe "process check" do
      it "pushes error on exception" do
      check "Foo Bar" do
          raise HealthCheckFailure, "Exception"
        end
        health_check.process_check("Foo Bar")
        health_check.errors.size.should be(1)
        health_check.errors.first.should eql("Foo Bar: Exception")
      end
    end

    describe "process checks" do
      it "run process check on each check" do
        check "Foo" do
          raise HealthCheckFailure, "Exception"
        end
        check "Bar" do
          raise HealthCheckFailure, "Exception"
        end
        check "Baz" do
          nil
        end
        health_check.process_checks
        health_check.errors.size.should be(2)
        health_check.errors.first.should eql("Foo: Exception")
        health_check.errors.last.should eql("Bar: Exception")
      end

      it "run only checks which are in the health_checks config" do
        check "Foo", false do
          raise HealthCheckFailure, "Exception"
        end
        check "Bar" do
          raise HealthCheckFailure, "Exception"
        end
        check "Baz" do
          nil
        end
        health_check.process_checks
        health_check.errors.size.should be(1)
        health_check.errors.last.should eql("Bar: Exception")        
      end
    end

  end
end

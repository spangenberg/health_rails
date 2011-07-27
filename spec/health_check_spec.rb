require 'spec_helper'

module HealthRails
  describe HealthCheck do
    let(:health_check) { HealthRails::HealthCheck.new }

    before(:each) do
      HealthRails::HealthCheck.stub(:checks).and_return({})
    end

    describe "run all checks and return status" do
      it "fails" do
        HealthRails::HealthCheck.check("Failing") do
          raise HealthRails::HealthCheck::HealthCheckFailure, "Exception"
        end
        HealthRails::HealthCheck.check("Passing") do
          nil
        end
        health_check.all_ok?.should be(false)
      end

      it "passes" do
        HealthRails::HealthCheck.check("Passing 1") do
          nil
        end
        HealthRails::HealthCheck.check("Passing 2") do
          nil
        end
        health_check.all_ok?.should be(true)
      end
    end

    it "push check in checks hash" do
      block = lambda {}
      HealthRails::HealthCheck.check("Foo Bar", &block)
      HealthRails::HealthCheck.checks.size.should be(1)
      HealthRails::HealthCheck.check("Foo Bar").should be(block)
    end

    it "join error messages" do
      health_check.stub(:errors).and_return(["Foo", "Bar", "Baz"])
      health_check.error_messages.should eql("Foo\nBar\nBaz")
    end

    describe "process check" do
      it "pushes error on exception" do
        HealthRails::HealthCheck.check("Foo Bar") do
          raise HealthRails::HealthCheck::HealthCheckFailure, "Exception"
        end
        health_check.process_check("Foo Bar")
        health_check.errors.size.should be(1)
        health_check.errors.first.should eql("Foo Bar: Exception")
      end
    end

    describe "process checks" do
      it "run process check on each" do
        HealthRails::HealthCheck.check("Foo") do
          raise HealthRails::HealthCheck::HealthCheckFailure, "Exception"
        end
        HealthRails::HealthCheck.check("Bar") do
          raise HealthRails::HealthCheck::HealthCheckFailure, "Exception"
        end
        HealthRails::HealthCheck.check("Baz") do
          nil
        end
        health_check.process_checks
        health_check.errors.size.should be(2)
        health_check.errors.first.should eql("Foo: Exception")
        health_check.errors.last.should eql("Bar: Exception")
      end
    end

  end
end

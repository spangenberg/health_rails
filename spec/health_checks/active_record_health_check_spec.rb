require 'spec_helper'
require 'active_record'

describe "active record health check" do
  let(:health_check) { HealthRails::HealthCheck.new }

  it "raise exception if connection is not active" do
    foo_bar_adapter = mock("ActiveRecord::ConnectionAdapters::FooBarAdapter", active?: false, adapter_name: "FooBar")
    ActiveRecord::Base.stub(:connection).and_return(foo_bar_adapter)
    health_check.process_check("ActiveRecord connection")
    health_check.errors.size.should be(1)
    health_check.errors.first.should eql("ActiveRecord connection: FooBar connection is gone from us!")
  end
end

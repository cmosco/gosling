require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


class TestFlow < Gosling::Flow
	def perform
	end
end

describe "method_missing" do
	it "should create and return a new flow class" do
		require File.join(Gosling.flows_path, "yay_flow.rb")
		params = {"foo" => "bar"}
		YayFlow.any_instance.expects(:perform).with(params)
		Gosling::Flows.yay_flow(params)
	end

	it "should work for flows with no params" do
		TestFlow.any_instance.expects(:perform)
		Gosling::Flows.test_flow
	end
end
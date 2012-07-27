require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

   describe "method_missing" do
   		it "should call into my flow" do
   			require File.join(Gosling.flows_path, "yay_flow.rb")
   			YayFlow.any_instance.expects(:perform)
   			Gosling::Flow.yay_flow
   		end
   end
module Gosling
    class Flow

      def self.method_missing(name, *args, &block)
        require File.join(Gosling.flows_path, "#{name.to_s}.rb")
        class_name = camel_case(name.to_s)  
        Object::const_get(class_name).new.perform    
      end

      def self.camel_case(file_name)
        file_name.split('_').map{|e| e.capitalize}.join
    end
  end
end
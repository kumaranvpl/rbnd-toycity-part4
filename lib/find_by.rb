class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    attributes.each do |type|
	    find_method = %Q{
		    def find_by_#{type}(filter_value)
		    	objects = self.all
				objects.each {|object| return object if object.#{type}.to_s == filter_value}
		   	end
		}

		self.instance_eval(find_method)
	end
  end

  def method_missing(method_name, *arguments)
  	super unless method_name.to_s.start_with?("find_by")
	  create_finder_methods(method_name.to_s[8..-1])
  	send(method_name, *arguments)
  end
end

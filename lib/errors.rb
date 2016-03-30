# Your custom error classes will be placed here
class ProductNotFoundError
	class NoSuchProduct < StandardError
  	end

  	class IdDoesNotExist < StandardError
  	end
end

module Analyzable
  # Your code goes here!
  	def count_by_brand(products)
		brands = {}
		products.each do |product|
			brand = product.brand
			brands[brand] = brands.has_key?(brand) ? brands[brand] + 1 : 1
		end
		brands
	end

	def count_by_name(input_products)
		products = {}
		input_products.each do |product|
			product_name = product.name
			products[product_name] = products.has_key?(product_name) ? products[product_name] + 1 : 1
		end
		products
	end

	def average_price(products)
		prices = []
		products.each {|product| prices.push(product.price)}
		sum_price = prices.inject { |result, element| result.to_f + element.to_f }
		(sum_price/products.length).round(2)
	end

	def print_report(products)
		output = "Average Price: "
		output += average_price(products).to_s
		counted_brands = count_by_brand(products)
		counted_products = count_by_name(products)

		output += "\nInventory by Brand:"
		counted_brands.each {|key, value| output += "\n\t- " + key.to_s + ": " + value.to_s}
		output += "\nInventory by Name:"
		counted_products.each {|key, value| output += "\n\t- " + key.to_s + ": " + value.to_s}
		output
	end
end

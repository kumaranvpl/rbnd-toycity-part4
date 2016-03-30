require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
  # Your code goes here!
  data_path = File.dirname(__FILE__) + "/../data/data.csv"

  products = []
  10.times do |id|
    brand = Faker::Company.name
    product = Faker::Commerce.product_name
    price = Faker::Commerce.price
    products.push(Product.create(brand: brand, name: product, price: price))
  end
end

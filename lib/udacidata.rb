require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"

  def self.all
    objects = []
    database = CSV.read(@@data_path)
    database.shift
    database.each do |row|
      objects << self.new(id: row[0], brand: row[1], name: row[2], price: row[3])
    end
    objects
  end

  def self.create(attributes = nil)
    # create the object
    item = self.new(**attributes)
    add_to_database(item)
    # return the object
    item
  end

  def self.first(n=1)
    objects = self.all
    return objects[0] if n == 1
    return objects.first(n)
  end

  def self.last(n=1)
    objects = self.all
    return objects[-1] if n == 1
    return objects.last(n)
  end

  def self.destroy(id)
    objects = self.all
    object_to_destroy = nil
    objects.each {|object| object_to_destroy = objects.delete(object) if object.id == id}
    raise ProductNotFoundError::IdDoesNotExist, "The product can’t be destroyed because ID #{id} does not exist" if object_to_destroy == nil
    save_database_header
    objects.each {|object| add_to_database(object)}
    object_to_destroy
  end

  def self.find(id)
    objects = self.all
    objects.each {|object| return object if object.id == id}
    raise ProductNotFoundError::NoSuchProduct, "The product ID #{id} can’t be found"
  end

  def self.where(opts={})
    objects = self.all
    found_objects = []
    opts.each do |key, value|
      found_objects = objects.select { |object| object.send(key) == value }
    end
    found_objects
  end

  def update(opts={})
    object_variables = self.instance_variables.map { |name| [name[1..-1].to_sym, instance_variable_get(name)] }
    Product.destroy(self.id)
    new_attributes = {}
    object_variables.each {|key, value| new_attributes[key] = opts.has_key?(key) ? opts[key] : value}
    Product.create(new_attributes)
  end

  def self.save_database_header
    CSV.open(@@data_path, "wb") do |csv|
      csv << ["id", "brand", "product", "price"]
    end
  end

  def self.add_to_database(item)
    CSV.open(@@data_path, "ab") do |csv|
      csv << [item.id.to_s, item.brand.to_s, item.name.to_s, item.price.to_s]
    end
  end

end
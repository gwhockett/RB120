## CARS SPIKE
# There is a vehicle company called Cool Car Factory
# There are 3 trucks and two cars there.
# A blue garbage truck has orange wheels and picks up garbage 
# An orange recycling truck has blue wheels and picks up recycling 
# A purple car called Do Not Touch Anything Dirty has black wheels and if it touches something dirty says "hey don't touch any dirty stuff!" 
# a green race car that races and has black wheels 
# A red firetruck with black wheels that puts out fires 
# All truck/car's of these types would have these same attributes and you can pass only one argument on instantiation 
# all trucks can carry heavy stuff
# all cars and the firetruck can go fast
# all vehicles can drive
# calling puts on an object of any class should return a sentence describing that object

# Nouns
# Car, Super is Auto
#   has a body color, wheel color, type
#   drives
#   goes fast
#   can make a statement
# Truck, Super is Auto
#   has a body color, wheel color, type
#   drives
#   carries heavy stuff, firetrucks can go fast
# Company
#   holds vehicles
#   has a name

# class Company
#   attr_reader :name, :vehicles
# 
#   def initialize(name)
#     @name = name
#     @vehicles = {trucks: [], cars: []}
#   end
# 
#   def vehicle_types(auto)
#     if auto.class == Truck
#       self.vehicles[:trucks] << auto
#     else
#       self.vehicles[:cars] << auto
#     end
#   end
# 
#   def to_s
#     "This is the #{name}. We have #{vehicles[:trucks].size} trucks and #{vehicles[:cars].size} cars."
#   end
# end
# 
# class Autos
#   attr_reader :body_color, :wheel_color, :speed, :drives
# 
#   def initialize(info)
#     @body_color = info[0]
#     @wheel_color = info[1]
#     @drives = "can drive"
#   end
# 
# end
# 
# class Truck < Autos
#   attr_reader :type
# 
#   def initialize(info)
#     @type = info[2]
#     @task = info[3]
#     super(info[0..1])
#     if type == "firetruck"
#       @speed = "can go fast"
#     else
#       @speed = "does not go fast"
#     end
#   end
# 
#   def to_s
# 
#   end
# end
# 
# class Car < Autos
#   attr_accessor :statement
# 
#   def initialize(info)
#     @speed = "can go fast"
#     super(info[0..1])
#   end
# 
#   def to_s
# 
#   end
# end
# 
# cool_cars = Company.new("Cool Car Factory")
# 
# garbage_truck = Truck.new(["blue body", "orange wheels", "garbage", "picks up garbage"])
# p garbage_truck
# firetruck = Truck.new(["red body", "black wheels", "firetruck", "puts out fires"])
# p firetruck
# recycling_truck = Truck.new(["orange body", "blue wheels", "recycling", "picks up recycling"])
# p recycling_truck
# green_racecar = Car.new(["green body", "black wheels"])
# p green_racecar

## GOLDEN GIRLS SPIKE
# The girls live in a house with an address of 6151 Richmond Street Miami, FL. There are four inhabitants of the house:
# - Dorothy Zbornak
# - Blanche Deveraux
# - Rose Nylund
# - Sofia Petrillo
# All of the girls are American, except for Sofia-- she's Italian. All the girls work, except for Sofia. All of them are widows, except for Dorothy.
# - Only Dorothy stays home on Saturday evenings.
# - Only Rose has a long-term boyfriend.
# - Only Blanche dates younger men.
# - All of the girls are over 50.
# - Dorothy has an ex-husband by the name of Stan Zbornak.

# House class with GoldenGirls as collaborators
# has an address
# can add and remove occupants

# Golden Girl class
# has a nationallity
# has a work status
# has an age
# has a marriage status
# has a Saturday night activity (goes out or not)
# has a dating preference
# has a romantic relationship status

# class House
#   attr_reader :address, :occupants
#   def initialize(address)
#     @address = address
#     @occupants = []
#   end
# 
#   def add_occupant(new_occupant)
#     occupants << new_occupant
#   end
# 
#   def remove_occupant(occupant)
#     occupants.delete(occupant)
#   end
# end
# 
# class GoldenGirl
#   attr_reader :nationality
#   attr_accessor :age, :work_status, :marriage_status, :relationship_status, :dating_preference
# 
#   def initialize(nationality, age, work, marriage, relationship, dating)
#     @nationality = nationality
#     self.age = age
#     self.work_status = work
#     self.marriage_status = marriage
#     self.relationship_status = relationship
#     self.dating_preference = dating
#   end
# 
#   def move_in_house(house)
#     house.add_occupant(self)
#   end
# end

## STORE INVENTORY MANAGEMENT SYSTEM
# You are tasked with implementing a program that simulates a basic inventory management system for a small store.
# The store has a limited number of items in stock, and the system should allow for adding items to the inventory, updating the stock levels,
# and retrieving the current stock levels for each item.

# Your program should have the following functionalities:
# Add an item to the inventory: Allow the user to input the name, price, and initial stock level for a new item, and add it to the inventory. 
# Update stock levels: Allow the user to update the stock level of an existing item in the inventory by specifying the item name and the new stock level.
# Retrieve stock levels: Allow the user to retrieve the current stock level for a specific item in the inventory by specifying the item name.


# Store with an inventory collaborator
# has a name

# Inventory class with items as collaborators
# belongs to a store
# has stock level for an item
# can update stock level via the name and new stock level
# can retrieve the stock level for an item via the item's name

# Item class
# has a name
# has a price
# has a stock level

class Store
  attr_reader :store_name

  def initialize(name)
    @store_name = name
    @store_inventory = Inventory.new
  end

end

class Inventory
  attr_reader :stock

  def initialize
    @stock = {}
  end

  def list_item(item, level)
    stock << item
    item.level
  end

  def update_item_level(item, level)
    item.level
  end
end


class Item
  attr_reader :item_name, :item_price
  attr_accessor :level

  def initialize(name, price)
    @item_name = name
    @price = price
    @level = 0
  end
end

seven_eleven = Store.new("7-11")
p seven_eleven
snickers = Item.new("Snickers", 2.09)


module Speed
  def go_fast
  end
end

class CoolCarFactory
  def wheels
    puts "wheels!"
  end
  def to_s
    "I'm a #{vehicle_color} #{self} with #{wheel_color} wheels"
  end
end

class Truck < CoolCarFactory
  def heavy_stuff
  end
  def wheels
    "#{wheel_color}" + super
  end
end

class Car < CoolCarFactory
  include Speed
end

class GarbageTruck < Truck
  attr_reader :wheel_color
  def initialize(wheel_color)
    @wheel_color = wheel_color
  end
  def pick_up_garbage
  end
end

class RecyclingTruck < Truck
  def pick_up_recycling
  end
end

class RecyclingTruck < Truck
  def initialize(wheel_color)
    @wheel_color = wheel_color
    @vehicle_color = "orange"
  end
  def pick_up_recycling
  end
end

class FireTruck < Truck
  include Speed
  def initialize(wheel_color)
    @wheel_color = wheel_color
    @vehicle_color = "red"
  end
  def put_out_fires
  end
end

class DNTcar < Car
  def initialize(wheel_color)
    @wheel_color = wheel_color
    @vehicle_color = "purple"
  end
  def say_this
    puts "hey don't touch any dirty stuff!"
  end
end

class RaceCar  < Car
  def initialize(wheel_color)
    @wheel_color = wheel_color
    @vehicle_color = "green"
  end
  def race
    puts "I'm racing!"
  end
end

firetruck = FireTruck.new("orange")
racecar = RaceCar.new("orange")
garbage_truck = GarbageTruck.new("orange")
dnt_car = DNTcar.new("orange")
recycling_truck = RecyclingTruck.new("blue")
p firetruck # #<FireTruck:0x00007fe9658a76f8 @wheel_color=“orange”, @vehicle_color=“red”>
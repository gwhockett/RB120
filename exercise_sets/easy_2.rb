=begin
Fix the Program - Mailable
Correct the following program so it will work properly. Assume that the
Customer and Employee classes have complete implementations; just make the
smallest possible change to ensure that objects of both types have access to
the print_address method

module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  include Mailable

  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  include Mailable

  attr_reader :name, :address, :city, :state, :zipcode
end

betty = Customer.new 
bob = Employee.new
betty.print_address
bob.print_address

Fix the Program - Drivable
Correct the following program so it will work properly. Assume that the Car
class has a complete implementation; just make the smallest possible change to
ensure that cars have access to the drive method.

module Drivable
  def drive #removed `self`
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive

Complete The Program - Houses
Assume you have the following code:
and this output:
Home 1 is cheaper
Home 2 is more expensive
Modify the House class so that the above program will work. You are permitted
to define only one new method in House.

class House
  include Comparable

  attr_reader :price

  def initialize(price)
    @price = price
  end

  def <=>(other)
    price <=> other.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

Reverse Engineering
Write a class that will display:

ABC
xyz

when the following code is run:

class Transform
  def initialize(str)
    @str = str
  end

  def self.lowercase(string_value)
    string_value.downcase
  end

  def uppercase
    @str.upcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

What Will This Do?

What will the following code print?

class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata #=> This will print `"ByeBye"`
puts thing.dupdata #=> This will print `"HelloHello"`

Comparing Wallets

Consider the following broken code:
Modify this code so it works. Do not make the amount in the wallet accessible
to any method that isn't part of the Wallet class.

class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

  protected

  attr_reader :amount
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end

Pet Shelter
Consider the following code:

Write the classes and methods that will be necessary to make this code run,
and print the following output:

P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.

The order of the output does not matter, so long as all of the information is
presented.

`adopt` and `print_adoptions` are behaviors of `Shelter` class instances
`adoptions` is a state of `Shelter` class instances

`Pet` and `Owner` class instances are colloborator objects of `Shelter` class
objects

`@number_of_pets` is a state of `Owner` instances
`Pets` and `Owners` instances have an `@name` state
`Pets` instances have a `@pet_type` state

class Shelter
  attr_reader :adoptions

  def initialize
    @adoptions = {}
  end

  def adopt(owner, pet)
    if @adoptions.has_key?(owner)
      @adoptions[owner] << pet
    else
      @adoptions[owner] = [pet]
    end

    owner.increment_number_of_pets
  end

  def print_adoptions
    @adoptions.each_key do |key|
      puts "#{key.name} has adopted the following pets:"
      @adoptions[key].each do |pet|
        puts "a #{pet.pet_type} named #{pet.name}"
      end
    end
  end
end

class Owner
  attr_reader :name, :number_of_pets

  def initialize(name)
    @name = name
    @number_of_pets = 0
  end

  def increment_number_of_pets
    @number_of_pets += 1
  end
end

class Pet
  attr_reader :pet_type, :name

  def initialize(pet_type, name)
    @name = name
    @pet_type = pet_type
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

Moving
You have the following classes.
You need to modify the code so that this works:

You are only allowed to write one new method to do this.

module Walkable
  def walk
    puts "#{name} #{gait} forward"
  end
end

class Person
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"

Nobility
Now that we have a Walkable module, we are given a new challenge. Apparently
some of our users are nobility, and the regular way of walking simply isn't
good enough. Nobility need to strut.

We need a new class Noble that shows the title and name when walk is called:

module Walkable
  def walk
    puts "#{self} #{name} #{gait} forward"
  end
end

class Noble
  include Walkable
  attr_reader :title, :name

  def initialize(name, title)
    @title = title
    @name = name
  end

  def to_s
    title
  end

  private

  def gait
    "struts"
  end
end

byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"
=end
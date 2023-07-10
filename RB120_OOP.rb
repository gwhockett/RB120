=begin
#OO Basics: Classes and Objects 1

#1 Find the Class
puts "Hello".class
puts 5.class
puts [1, 2, 3].class

#2 Create the Class
class Cat; end

#3 Create the Object
class Cat ; end
kitty = Cat.new

#4 What Are You?
class Cat
  def initialize
    puts "I'm a cat!"
  end
end
kitty = Cat.new

#5 Hello, Sophie! (Part 1)

class Cat
  def initialize(n)
    @name = n
    puts "Hello! My name is #{@name}!"
  end
end
kitty = Cat.new('Sophie')

#6 Hello, Sophie! (Part 2)

class Cat
  def initialize(n)
    @name = n
  end

  def greet
    puts "Hello! My name is #{@name}!"
  end
end
kitty = Cat.new('Sophie')
kitty.greet

#7 Hello, Sophie! (Part 2)

class Cat
  attr_reader :name

  def initialize(n)
    @name = n
  end

  #def name
  #  @name
  #end

  def greet
    puts "Hello! My name is #{name}!"
  end
end
kitty = Cat.new('Sophie')
kitty.greet

#8 Hello, Sophie! (Part 2)

class Cat
  attr_accessor :name
  #attr_reader :name
  #attr_writer :name
  def initialize(n)
    @name = n
  end

  #def name
  #  @name
  #end
  #def name=(new_name)
  #  @name = new_name
  #end

  def greet
    puts "Hello! My name is #{name}!"
  end
end
kitty = Cat.new('Sophie')
kitty.greet
kitty.name = ("Luna")
kitty.greet

#9 Hello, Sophie! (Part 2)

class Cat
  attr_accessor :name
  #attr_reader :name
  #attr_writer :name
  def initialize(n)
    @name = n
  end

  #def name
  #  @name
  #end
  #def name=(new_name)
  #  @name = new_name
  #end

  def greet
    puts "Hello! My name is #{name}!"
  end
end
kitty = Cat.new('Sophie')
kitty.greet
kitty.name = ("Luna")
kitty.greet

#10 Hello, Sophie! (Part 2) A walk for a cat?

module Walkable
  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  include Walkable

  attr_accessor :name
  #attr_reader :name
  #attr_writer :name
  def initialize(n)
    @name = n
  end

  #def name
  #  @name
  #end
  #def name=(new_name)
  #  @name = new_name
  #end

  def greet
    puts "Hello! My name is #{name}!"
  end
end
kitty = Cat.new('Sophie')
kitty.greet
kitty.walk

#  OO Basics: Classes and Objects 2
#1 Generic Greeting (Part 1)

class Cat
  def self.generic_greeting #Class method because `self` is prepended
    puts "Hello! I'm a cat!"
  end
end

kitty = Cat.new
kitty.class.generic_greeting #kitty.class returns the class of kitty

#2 Hello, Chloe!

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(name)
    self.name = name #This calls the setter created at line 168
                     #because `self` is prepended Ruby knows we are trying
                     #to call the setter method. Otherwise we would need to
                     #reassign the instance variable @name to the parameter
                     #name on line 175.
  end
end

kitty = Cat.new('Sophie')
puts kitty.name
kitty.rename('Chloe')
puts kitty.name

#3 Identify Yourself (Part 1)

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def identify
    self
  end
end

kitty = Cat.new('Sophie')
p kitty.identify
p kitty

#4 Generic Greeting (Part 2)

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end

  def personal_greeting
    puts "Hello! My name is #{@name}!"
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting

#5 Counting Cats

class Cat
  @@num_of_cats = 0

  def initialize
    @@num_of_cats += 1
  end

  def self.total
    @@num_of_cats
  end
end

kitty1 = Cat.new
kitty2 = Cat.new

p Cat.total

#6 Colorful Cat

class Cat
  COLOR = "green"
  attr_reader :name

  def initialize(name)
    @name = name
  end
  def greet
    puts "Hello! My name is #{name} and I'm a #{COLOR} cat!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet

#7 Identify Yourself (Part 2)

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def to_s
    "I'm #{name}!"
  end
end

kitty = Cat.new('Sophie')
puts kitty

#8 Public Secret

class Person
  attr_accessor :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
puts person1.secret

#9 Private Secret

class Person
  attr_writer :secret

  def share_secret
    puts secret
  end
  
  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
person1.share_secret

#10 Protected Secret

class Person
  attr_writer :secret

  def compare_secret(other_person)
    other_person.secret == secret
  end

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)

#OO Basics Inheritance

#1 Inhertied Year

class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle

end

class Car < Vehicle

end

truck1 = Truck.new(1994)
puts truck1.year

car1 = Car.new(2006)
puts car1.year

#2 Start the Engine (Part 1)

class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  def initialize
    super         #causes Truck's initialize method to yield to Vehicle's
                  #initialize method
    start_engine
  end

  def start_engine
    puts 'Ready to go!'
  end
end

truck1 = Truck.new(1994)
puts truck1.year

#3 Only Pass the Year

class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  attr_reader :bed_type
  def initialize(year, bed_type)
    super(year)
    @bed_type = bed_type
  end
end

class Car < Vehicle
end

truck1 = Truck.new(1994, 'Short')
puts truck1.year
puts truck1.bed_type

#4 Start the Engine (Part 2)

class Vehicle
  def start_engine
      "Ready to go!"
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super() +  " Drive #{speed}, please!"
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')

#5 Towable (Part 1)

module Towable
  def tow
    puts "I can tow a tralier!"
  end
end

class Truck
  include Towable
end

class Car
end

truck1 = Truck.new
truck1.tow

#6 Towable (Part 2)

module Towable
  def tow
    'I can tow a trailer!'
  end
end

class Vehicle
  attr_reader :year
  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  include Towable
end

class Car < Vehicle
end

truck1 = Truck.new(1994)
puts truck1.year
puts truck1.tow

car1 = Car.new(2006)
puts car1.year

#7 Method Lookup (Part 1)

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new('Black')
puts cat1.class.ancestors

#8 Method Lookup (Part 2)

class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color

#9 Method Lookup (Part 3)

module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

bird1 = Bird.new('Red')
bird1.color

#10 Transportation

module Transportation
  class Vehicle
  
  end
  class Truck < Vehicle
  
  end
  class Car < Vehicle
  
  end
end

#OO Basics: Accessor Methods
#1 Reading and Writing

class Person
  attr_accessor :name
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name

#2 Choose the Right Method

class Person
  attr_accessor :name
  attr_writer :phone_number
end

person1 = Person.new
person1.name = 'Jessica'
person1.phone_number = '0123456789'
puts person1.name

#3 Access Denied

class Person
  attr_reader :phone_number

  def initialize(number)
    @phone_number = number
  end
end

person1 = Person.new(1234567899)
puts person1.phone_number

person1.phone_number = 9987654321
puts person1.phone_number

#4 Comparing Names

class Person
  attr_writer :last_name
  attr_accessor :first_name

  def first_equals_last?
    first_name == last_name
  end

  private

  attr_reader :last_name
end

person1 = Person.new
person1.first_name = 'Dave'
person1.last_name = 'Smith'
puts person1.first_equals_last?

#5 Who is Older?

class Person
  attr_writer :age

  def older_than?(other)
    age > other.age
  end

  protected

  attr_reader :age
end

person1 = Person.new
person1.age = 17

person2 = Person.new
person2.age = 26

puts person1.older_than?(person2)

#6 Guaranteed Formatting

class Person
  attr_reader :name

  def name=(n)
    @name = n.capitalize
  end

end

person1 = Person.new
person1.name = 'eLiZaBeTh'
puts person1.name

#7 Prefix the Name

class Person
  attr_writer :name
  def name
    "Mr. " + @name
  end
end

person1 = Person.new
person1.name = 'James'
puts person1.name

#8 Avoid Mutation

class Person

  def initialize(name)
    @name = name
  end
  
  def name
    @name.dup
  end

end

person1 = Person.new('James')
person1.name.reverse!
puts person1.name

#9 Calculated Age

class Person
  def age
    @age * 2
  end

  def age=(i)
    @age = i * 2
  end
end

person1 = Person.new
person1.age = 20
puts person1.age

#10 Unexpected Change

class Person

  def name=(name)
    @first, @last = name.split
  end

  def name
    @first + ' ' + @last
  end

  def last
    @last
  end

  def first
    @first
  end

end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name
puts person1.last
puts person1.first

#OOP Easy 1
#Banner Class

class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-#{"-" * @message.size}-+"
  end

  def empty_line
    "| #{" " * @message.size} |"
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

banner_empty = Banner.new('')
puts banner_empty

#What's the Ouput?

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end
  
  def to_s #this method is not intended to mutate
    #@name.upcase!
    "My name is #{@name.upcase}."
  end
end

thing = 'Fluffy'
fluffy = Pet.new(thing)
puts fluffy.name
puts fluffy # thing object mutated here because puts calls to_s
puts fluffy.name
puts thing

#Fix the Program = Books (Part 1)
#Expected output:
#The author of "Snow Crash" is Neil Stephenson.
#book = "Snow Crash", by Neil Stephenson.

class Book
  attr_reader :author, :title #added

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

thing = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{thing.title}" is #{thing.author}.)
puts %(book = #{thing}.)

#Fix the Program - Books (Part 2)
#Expected Output:
#The author of "Snow Crash" is Neil Stephenson.
#book = "Snow Crash", by Neil Stephenson.

class Book
  attr_accessor :author, :title #added

  def to_s
    %("#{title}", by #{author})
  end
end

thing = Book.new
thing.author = "Neil Stephenson"
thing.title = "Snow Crash"
puts %(The author of "#{thing.title}" is #{thing.author}.)
puts %(book = #{thing}.)

#Fix the Program - Persons
#Expected output:
#John Doe
#Jane Smith

class Person

  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def first_name= (value)
    @first_name = value.capitalize
  end

  def last_name= (value)
    @last_name = value.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

dude = Person.new('john', 'doe')
puts dude

dude.first_name = 'jane'
dude.last_name = 'smith'
puts dude

#Fix the Program - Flight Data

class Flight
  attr_accessor :database_handle # delete this line

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

#Buggy Code - Car Mileage

class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total #needs to call the instance variable or
    #use the `self` to call the setter which is best practice
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678

#Rectangles and Squares

class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

class Square < Rectangle
  def initialize(side)
    super(side, side)
  end
end

square = Square.new(5)
puts "area of square = #{square.area}"

#Complete the Program - Cats!
#We should see the following output:
#My cat Pudding is 7 years old and has black and white fur.
#My cat Butterscotch is 10 years old and has tan and white fur.
class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  attr_reader :name, :age, :color


  def initialize(name, age, color)
    super(name, age)
    @color = color
  end

  def to_s
    "My cat #{name} is #{age} years old and has #{color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

#Refactoring Vehicles

class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

#Easy 2
#Fix the Program - Mailable

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

#Fix the Program - Drivable

module Drivable
  def drive #removed self from the name of the method
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive

#Complete The Program - Houses
#The following should be output:
#Home 1 is cheaper
#Home 2 is more expensive

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

#Reverse Engineering

class Transform
  def initialize(str)
    @str = str
  end

  def uppercase
    @str.upcase
  end

  def self.lowercase(str2)
    str2.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')
#What Will This Do?

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
puts Something.dupdata
puts thing.dupdata

#Comparing Wallets

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

#Pet Shelter

class Pet
  attr_reader :name, :type

  def initialize(type, name)
    @name = name
    @type = type
  end

  def to_s
    "a #{type} named #{name}"
  end
end

class Owner
  attr_reader :name, :adopted_pets

  def initialize(name)
    @name = name
    @adopted_pets = []
  end

  def adoption(pet)
    @adopted_pets << pet
  end

  def number_of_pets
    adopted_pets.size
  end

  def print_pets
    puts adopted_pets #calls to_s from Pets
  end
end

class Shelter
  def initialize
    @homed_pets = {}
  end

  def adopt(owner, pet)
    owner.adoption(pet)
    @homed_pets[owner.name] ||= owner
  end

  def print_adoptions
    @homed_pets.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts
    end
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

#Moving

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

#Nobility

module Walkable
  def walk
    puts "#{self} #{gait} forward"
  end
end

class Person
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
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

  def to_s
    name
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

  def to_s
    name
  end

  private

  def gait
    "runs"
  end
end

class Noble
  include Walkable
  attr_reader :name, :title

  def initialize(name, title)
    @name = name
    @title = title
  end

  def to_s
    "#{title} #{name}"
  end

  private

  def gait
    "struts"
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

byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"

#Medium 1

#Privacy
class Machine
  attr_writer :switch

  def start
    flip_switch(:on) #removed self as a caller of flip_switch
  end

  def stop
    flip_switch(:off) #removed self as a caller of flip_switch
  end

  private

  attr_writer :switch

  def flip_switch(desired_state)
    self.switch = desired_state #switch must be called by self being a private method
  end
end

#Fixed Array
=end
class FixedArray
  def initialize(count)
    @ary = Array.new(count)
  end

  def [](fetch)
    @array.fetch(index)
  end
end

fixed_array = FixedArray.new(5)
p fixed_array
puts fixed_array[3] == nil
#puts fixed_array.to_a == [nil] * 5
#
#fixed_array[3] = 'a'
#puts fixed_array[3] == 'a'
#puts fixed_array.to_a == [nil, nil, nil, 'a', nil]
#
#fixed_array[1] = 'b'
#puts fixed_array[1] == 'b'
#puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]
#
#fixed_array[1] = 'c'
#puts fixed_array[1] == 'c'
#puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]
#
#fixed_array[4] = 'd'
#puts fixed_array[4] == 'd'
#puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
#puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'
#
#puts fixed_array[-1] == 'd'
#puts fixed_array[-4] == 'c'
#
#begin
#  fixed_array[6]
#  puts false
#rescue IndexError
#  puts true
#end
#
#begin
#  fixed_array[-7] = 3
#  puts false
#rescue IndexError
#  puts true
#end
#
#begin
#  fixed_array[7] = 3
#  puts false
#rescue IndexError
#  puts true
#end
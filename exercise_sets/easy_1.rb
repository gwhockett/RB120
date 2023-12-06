=begin
# Banner Class
# Behold this incomplete class for constructing boxed banners.
class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  attr_reader :message

  def horizontal_rule
    "+-#{'-' * message.size}-+"
  end

  def empty_line
    "| #{' ' * message.size} |"
  end

  def message_line
    "| #{message} |"
  end
end

# Complete this class so that the test cases shown below work as intended. You
# are free to add any methods or instance variables you need. However, do not 
# make the implementation details public.
# 
# You may assume that the input will always fit in your terminal window.
# 
# Test 

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

# What's the Output?
# Take a look at the following code:
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
# What output does this code print? Fix this class so that there are no
# surprises waiting in store for the unsuspecting developer.

Fix the Program - Books (Part 1)
Complete this program so that it produces the expected output:
Expected output:
The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.

class Book
  attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

Fix the Program - Books (Part 2)
Complete this program so that it produces the expected output:
Expected output:
The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.

class Book
  attr_accessor :title, :author

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

Fix the Program - Persons

Complete this program so that it produces the expected output:
Expected output:
John Doe
Jane Smith

class Person
  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def first_name= (first_name)
    @first_name = first_name.capitalize
  end

  def last_name= (last_name)
    @last_name = last_name.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person

Fix the Program - Flight Data

Consider the following class definition:
There is nothing technically incorrect about this class, but the definition may
lead to problems in the future. How can this class be fixed to be resistant to
future problems?

  #attr_accessor :database_handle (This should be deleted because its 
  # `@database_handle = Database.init` implementation detail and should not be
  # exposed)
class Flight
  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

Buggy Code - Car Mileage
Fix the following code so it works properly:

class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total #added `self` so Ruby calls the setter `mileage`
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678

Rectangles and Squares

Given the following class:
Write a class called Square that inherits from Rectangle, and is used like
this:

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
  def initialize(size)
    super(size, size)
  end
end

square = Square.new(5)
puts "area of square = #{square.area}"

Complete the Program - Cats!

Consider the following program.
Update this code so that when you run it, you see the following output:
My cat Pudding is 7 years old and has black and white fur.
My cat Butterscotch is 10 years old and has tan and white fur.

class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, color)
    super(name, age)
    @color = color
  end

  def to_s
    "My cat #{@name} is #{@age} and has #{@color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

Refactoring Vehicles
Consider the following classes:
Refactor these classes so they all use a common superclass, and inherit behavior as needed.

def Automobile
  attr_reader :make, :model, :wheels

  def initialize(make, model, wheel_num)
    @make = make
    @model = model
    @wheels = wheel_num
  end
end

class Car < Automobile
end

class Motorcycle < Automobile
end

class Truck < Automobile
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end
end
=end

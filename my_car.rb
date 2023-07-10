=begin
class MyCar
  def initialize(y, m, c)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @switch = false
  end

  attr_accessor :model, :speed, :switch

  def current_speed
    if switch
      "The #{model} currently has a speed of #{speed}."
    else
      "The #{model} motor is off and not moving."
    end
  end

  def motor_switch
    self.switch = !self.switch
  end

  def change_speed(s)
    if s + speed > 0
      self.speed += s
    else
      self.speed = 0
    end
  end
end

toyo = MyCar.new(2011, "Prius", "White")
p toyo
p toyo.current_speed
p toyo.motor_switch
p toyo.current_speed
p toyo.change_speed(50)
p toyo.current_speed
p toyo.motor_switch
p toyo.current_speed

class MyCar
  
  def initialize(y, m, c) #constructor method, must be named 'initialize'
    @year          = y
    @model         = m
    @color         = c
    @current_speed = 0
  end

  def speed_up(number) #setter
    @current_speed += number
    puts "You push the gas and speed up #{number} mph."
  end

  def brake(number) #setter
    @current_speed -= number
    puts "You push the brake and slow down #{number} mph."
  end

  def current_speed #getter
    puts "You are going #{@current_speed} mph."
  end

  def shut_down #setter
    @current_speed = 0
    puts "The car is parked"
  end

  attr_accessor :color
  attr_reader :year
  attr_reader :model

  def spray_paint
    puts "Pleas tell us what color you would like to paint your car?"
    color = gets.chomp
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def self.miles_per_gallon(miles, gallons)
    "#{miles / gallons} miles per gallon of gas."
  end

  def to_s
    "My car is a #{color}, #{year}, #{model}."
  end
end

prius = MyCar.new(2011, 'Toyota Prius', 'white')
prius.speed_up(20)
prius.current_speed
prius.speed_up(20)
prius.current_speed
prius.brake(20)
prius.current_speed
prius.shut_down
prius.current_speed
puts "Your #{prius.model} is currently painted #{prius.color}."
prius.spray_paint
puts prius.color
puts prius.year
puts MyCar.miles_per_gallon(490, 10)
puts prius.to_s


class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"

=end

=begin
class Vehicle
  @@number_of_vehicles = 0

  def initialize(y, m, c) #constructor method, must be named 'initialize'
    @year          = y
    @model         = m
    @color         = c
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  attr_accessor :color
  attr_reader :year
  attr_reader :model

  def speed_up(number) #setter
    @current_speed += number
    puts "You push the gas and speed up the #{model} to #{number} mph."
  end

  def brake(number) #setter
    @current_speed -= number
    puts "You push the brake and slow down the #{model} to #{number} mph."
  end

  def current_speed #getter
    puts "The #{model} is going #{@current_speed} mph."
  end

  def shut_down #setter
    @current_speed = 0
    puts "The #{model} is parked"
  end

  def self.miles_per_gallon(miles, gallons)
    "#{miles / gallons} miles per gallon of gas."
  end

  def spray_paint
    puts "Please tell us what color you would like to paint your #{model}?"
    color = gets.chomp
    self.color = color
    puts "Your #{model} has a new #{color} paint job and looks great!"
  end

  def self.total_number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles."
  end

end

module TowHitch

  def can_tow?(pounds)
    pounds < 4000
  end

end

class MyCar < Vehicle
  
  NUMBER_OF_DOORS = 4

  def to_s
    "This car is a #{color}, #{year}, #{model}."
  end

  def how_old
    "This #{model} is #{age} years old."
  end

  private

  def age
    Time.now.year - year
  end

end

class MyTruck < Vehicle
  include TowHitch

  NUMBER_OF_DOORS = 2
  
  def to_s
    "The truck is a #{color}, #{year}, #{model}."
  end
end

prius = MyCar.new(2011, 'Toyota Prius', 'white')
#prius.speed_up(20)
#prius.current_speed
#prius.speed_up(20)
#prius.current_speed
#prius.brake(20)
#prius.current_speed
#prius.shut_down
#prius.current_speed
#puts "Your #{prius.model} is currently painted #{prius.color}."
#prius.spray_paint
puts prius.color
puts prius.year
puts MyCar.miles_per_gallon(490, 10)
puts prius.to_s

ram = MyTruck.new(2012, 'Dodge Ram', 'red')
puts "Your #{ram.model} is currently painted #{ram.color}."
puts MyTruck.miles_per_gallon(405, 18)
puts ram.to_s
Vehicle.total_number_of_vehicles

puts ram.can_tow?(4001)
puts "######"
puts MyCar.ancestors
puts "######"
puts MyTruck.ancestors
puts "######"
puts Vehicle.ancestors
puts "######"
puts prius.how_old

class Student
  def initialize(n, g)
    @name = n
    @grade = g
  end

  attr_reader :name

  def better_grade_than?(other_person)
    other_person.grade > self.grade
  end

  protected #allows other objects within the class to use protected methods
  #private #allows only the calling object to call private methods
  attr_reader :grade

end

joe = Student.new("Joe", 89)
bob = Student.new("Bob", 90)
puts "Well done!" if joe.better_grade_than?(bob)

=end
class Boats
  def my_land_yacht
    "I drive my land yacht in public."
  end
end

class MyCar < Boats

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def driving
    "#{my_land_yacht}"
  end

  private

  def to_s
    "This bad boy is a #{color} #{year} #{model}."
  end

  def my_land_yacht
    "My land yacht is private but I drive it in public."
  end

  attr_accessor :current_speed
  attr_reader :year, :color, :model
end

buick = MyCar.new(1974, 'White', 'Buick Century')
puts buick #=> This bad boy is a White 1974 Buick Century.
puts buick.to_s #=> Private method error.
puts buick.driving #=> My land yacht is private but I drive it in public.
puts buick.my_land_yacht #=> Private method error.
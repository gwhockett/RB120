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
=end

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"

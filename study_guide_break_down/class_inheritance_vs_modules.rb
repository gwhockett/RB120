# Class Inheritance vs. Interface Inheirtance (mixins)
module Walkable
  def walk
    "walked"
  end
end

module Fuelable
  def gasoline
    "gas added"
  end
end

module Sleepable
  def sleep
    "sleeps"
  end
end

class Mammal
  include Sleepable
end

class Dog < Mammal
  include Walkable

  def bark
    "barks"
  end
end

class Beagle < Dog
  def hunt
    "hunts"
  end
end

class Lawnmower
  include Fuelable
  include Walkable
end

subclassed_sleepers = [Mammal.new, Dog.new, Beagle.new]
mixed_in_walkers = [Dog.new, Beagle.new, Lawnmower.new]

subclassed_sleepers.each { |animal| puts "I am an animal that #{animal.sleep} but may not walk." }
mixed_in_walkers.each { |mover| puts mover.walk }

puts Beagle.new.bark
puts Lawnmower.new.gasoline
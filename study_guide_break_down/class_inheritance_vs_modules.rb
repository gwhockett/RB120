# Class Inheritance vs. Modules
=end
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
    "sleeping"
  end
end

class Mammal
  include Sleepable
  attr_reader :warm_blooded

  def initialize
    @warm_blooded = "warm_blooded"
  end
end

class Dog < Mammal
  include Walkable

  def bark
    "bark"
  end
end

class Beagle < Dog
  def hunt
    "hunt"
  end
end

class Lawnmower
  include Fuelable
  include Walkable
end

subclassed_warm_blooded_sleepers = [Dog.new, Beagle.new]
mixed_in_walkers = [Dog.new, Beagle.new, Lawnmower.new]

subclassed_warm_blooded_sleepers.each { |animal| puts "#{animal.warm_blooded} and #{animal.sleep}" }
mixed_in_walkers.each { |mover| puts mover.walk }
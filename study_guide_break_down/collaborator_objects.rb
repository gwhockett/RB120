class Car
  attr_accessor :fuel
  attr_reader :name
  
  def initialize
    @name = "Model T"
  end

  def gas?
    fuel.class == Gasoline
  end

  def drive
    if gas? == true
      "We have gas! Let's drive!"
    else
      "No gas! Can't drive!"
    end
  end
end

class Gasoline
end

old_car = Car.new
# the string `"Model T"` referenced by `@name` scoped within `old_car` is not considered
# to be a collaborating object.
p old_car
# Since `old_car` doesn't have a `Gasoline` object stored as state, `old_car`
# can't drive.
puts old_car.drive
old_car.fuel = Gasoline.new
# Now that we have added a collaborating `Gasoline` object to the state of
# `old_car`, `old_car` can drive.
p old_car
puts old_car.drive
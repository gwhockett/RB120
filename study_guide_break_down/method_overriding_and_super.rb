# Method Overriding
class Driver
  def drive
    "car"
  end

  def to_s # Overrides `#to_s` inherited from `Object`
    "I am liscensed to drive a #{drive}."
  end
end

class BusDriver < Driver
  def drive # Overrides `#drive` inherited from `Driver`
    "bus and a " + super # Here `super` incorporates the behavior of the overriden `#drive`
  end
end

sam = Driver.new
bob = BusDriver.new

puts sam
puts bob

# Method Lookup Path
module Boatable
  def drive
    "boat"
  end
end

module Busable
  def drive
    "bus"
  end
end

class BusDriver
  include Boatable
  include Busable
end

class Captain
  include Busable
  include Boatable
end

# Both the `BusDriver` class and `Captain` class have their method lookup paths
# augmented by the order in which their mixins are included. So, Ruby executes
# a different `#drive` for each.
puts BusDriver.new.drive
puts Captain.new.drive
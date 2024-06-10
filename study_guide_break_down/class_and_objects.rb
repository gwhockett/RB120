#classes and objects
class Car
  # `Car` object getter behaviors for exposing state
  attr_reader :type, :year
  def initialize(type, year)
    #Creation of attributes from the arguments passed to `::new`
    #`@type` and `@year` are how a `Car` object reference the data of its state
    @type = type
    @year = year
  end

  # `#drive` is behavior of `Car` objects
  def drive
    '...driving'
  end
end

# Instantiation of a new `Car` object
honda = Car.new('Honda', 2016)
puts honda.type # 'Honda'
puts honda.year # 2016
puts honda.drive # '...driving'
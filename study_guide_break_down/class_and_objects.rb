#classes and objects
class Car
  attr_reader :type, :year # `Car` object getter behaviors for exposing state.

  def initialize(type, year)
    @type = type #Creation of attributes from the arguments passed to `::new`
    @year = year #`@type` and `@year` are how a `Car` object reference the data of its state.
  end

  def drive # A behavior of `Car` objects
    '...driving'
  end
end

honda = Car.new('Honda', 2016) # Instantiation of a new `Car` object.
puts honda.type # 'Honda'
puts honda.year # 2016
puts honda.drive # '...driving'
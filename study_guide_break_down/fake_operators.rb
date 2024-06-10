# Fake Operators
puts 10 == 10 # syntactical sugar
puts 10.==(10) # explicit syntax of a fake operator

class Dog
  attr_reader :age
  def initialize(age)
    @age = age
  end
end

puts Dog.new(10).age # 10
# When we call `==` on the return value of a `#age` we get the expected result
puts Dog.new(10).age == Dog.new(10).age # true
puts Dog.new(20).age == Dog.new(10).age # false
puts Dog.new(20).age > Dog.new(10).age # true
# But invoking `==` with a `Dog` object returns what is a seemingly odd result
# if we don't understand `==`'s inherited behavior.
puts Dog.new(10) == Dog.new(10) # false
puts Dog.new(10) > Dog.new(10) # NoMethodError
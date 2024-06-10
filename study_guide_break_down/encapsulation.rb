# Encapsulation example
class Dog
  def bark
    "bark"
  end
end

class Cat
  attr_accessor :name # Our reader and writer behavior definition for `@name`

  def initialize(name, color)
    # Data can be encapsulated by initialized instance variables
    # that are scoped within an instance object.
    @name = name   
    @color = color 
  end

  def play(other)
    "#{name} is #{color} and plays with #{other.name}."
  end

  # both `@name` and `@color` are checked to see if they point to the same
  # object with the same value in their respective `Cat` objects.
  def state?(other)
    name.equal?(other.name) && color.equal?(other.color)
  end

  def purr
    "purring"
  end

  # method access control encapsulates where objects can exhibit behavior.
  protected
  
  attr_reader :color
end

# OOP in Ruby encapsulates data
initial_name = "max"
initial_color = "black"

cat1 = Cat.new(initial_name, initial_color)
cat2 = Cat.new(initial_name, initial_color)
p cat1.object_id == cat2.object_id # => false
puts cat1.state?(cat2) # => true
puts ''
puts cat1.name # => max
puts cat2.name # => max
# At this point, if we mutate `initial_name`'s reference object,
# `@name`'s value in `cat1` and `@name`'s value in `cat2` also update.
puts ''
puts initial_name.reverse! # => xam
puts cat1.name # => xam
puts cat2.name # => xam
puts cat1.state?(cat2) # => true
# We can see that we have two different `Cat` objects that have the same state,
# i.e. their instance variables reference the same data.
puts ''
# However, even though `cat1` and `cat2` happen to have the same state, each
# `Cat` object's state is unique by way of encapsulation.
# Now we need to see that each `Cat` object encapsulates state.
# We have defined a writer method, `#name=`, for intentional state modification
# of a `Cat` object. Here we reassign `@name` within `cat2` to different data. 
cat2.name = "xnij"
# The data that `cat2` was initialized to,`intial_name`, is now no longer part
# of `cat2`'s state but `intial_name` is still part of `cat1`'s state.
puts cat1.name # => xam
puts cat2.name # => xnij
puts cat1.state?(cat2) # => false
# And we can see how encapsulation protects the data referenced by `cat2`
# along with all other `Cat` objects' data through the use of that setter.
puts ''
cat1.name.reverse!
cat2.name.reverse!
puts initial_name # => max
puts cat1.name # => max
puts cat2.name # => jinx
puts ''
# OOP in Ruby encapsulates behavior
# `Cat#color` can only be exhibited within the scope of a `Cat` instance method
# because it has a method access control implemented.
puts cat1.play(cat2) # => max is black and plays with jinx.
puts cat1.color # No Method Error
# As defined here, `Cat` objects can't invoke `Dog` behavior and vise-versa.
# The fact that classes are unrelated is an encapsulation of their behaviors.
cat1.bark # NoMethodError
Dog.new.purr # NoMethodError
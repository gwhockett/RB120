=begin
Ruby gives us the keyword `super` to call over written methods from earlier in
method lookup path. If a method takes arguments `super` is called with no
arguments, the arguments passed into the current method will automatically be
passed up the lookup path to the overwritten method. e.g.,

class Animal
  def initialize(number_of_legs=0)
    @legs = number_of_legs
  end
end

class Dog < Animal
  def initialize(number_of_legs=4)
    super
  end
end


cliff = Dog.new

p cliff

Your can also pass specific arguments and keep others from going up the path.
If a subclass method takes three argument but the parent method takes two,
`super` should only be given two arguments to prevent an error. Also, `super()`
should be used if the parent method takes no arguments but the child method
takes arguments. The empty parentheses tell Ruby that no argument should be
up the lookup path.

=end
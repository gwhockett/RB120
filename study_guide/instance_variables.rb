=begin
Instance variables keep track of an object instance's state (values). Instance
variables are defined within a class but do not store states within a class.
They are defined within the class using `@` in front of a snake case formated
name. Like this: `@snake_case`. Instance variables can be initialized by the
constructor method `initialize`,defined instance methods and the relevant
methods along the method look up path of a class, e.g.,
`instance_variable_set`. An instance variable's state can be exposed by a
defined instance method and by the relevant methods along the class's method
lookup path. As long as an object instance exists, its initialized instance
variables' values can be referenced and modified. Once an instance variable's
value has been inintialized, it is generally considered to be an attribute of
the instance.
=end

class Dog; end # class definition

instance_of_the_dog = Dog.new # instance object creation by the class Dog invoking `new` 
p instance_of_the_dog # no instance variables initialized for this instance.
instance_of_the_dog.instance_variable_set(:@name, 'Rex') # `@name` initialized via `instance_variable_set`
p instance_of_the_dog # now we can see this instance has a state `"Rex"` tracked by `@name`
instance_of_the_dog.instance_variable_get(:@name) # exposure of `@name` via `instance_variable_get`




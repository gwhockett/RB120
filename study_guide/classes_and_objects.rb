=begin
To define a Class in Ruby we use similar syntax to that of defining a method.
We replace the `def` reserved word with `class` and use the CamelCase format to
name the class. Then use the reserved word `end` to finish the class
definition, e.g., class Dog; end

Now we can create new Dog objects from the Dog class. This is called
"instantiation". This is done by calling the `new` method with the name of the
class. e.g., Dog.new.

When an instance of the Dog class is instantiated it holds a place in phyiscal
memory that can store states and exhibit behavior. To store states, the class 
defines the instance variables a Dog object instance of the Dog class can have,
e.g., @name for a name and @age for an age, that can be initialized during or
after instantiation of the instance. Each instance of the Dog class can then
have a name state and an age state that is different from other Dog objects.
Instance variables are kept within an object instance not within the class. To
get access to, or change the value of an instance variable of a particular
object Ruby must work with a particular object. Ruby does this with instance
methods.

Instance methods are methods that are available to an instance of a class, i.e.
they allow Ruby to expose an object's state and give an object behaviors that
are common to its class. When an instance variable has a method to expose its
state, it is then generally considered to be an attribute.
=end

class Thing
  @@thing_instances = 0

  def initialize(name, hair_color)
    @@thing_instances += 1
    @name = name
    @hair_color = hair_color
    @instance_number = @@thing_instances
  end

  def about_me
    "I am instance #{@instance_number} of the #{self.class} class. "\
    "They call me #{@name}. I have #{@hair_color} colored hair."
  end
end

first_thing = Thing.new("Imogene", "sapphire")
second_thing = Thing.new("Felix", "chartreuse")


puts first_thing.about_me
puts second_thing.about_me

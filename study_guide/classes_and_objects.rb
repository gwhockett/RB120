=begin
Not everything Ruby is an object. For instance: Methods, blocks, and variables
are not objects.

To start bluntly, states (attributes) and behaviors define Classes then Classes
create objects.

To define a Class in Ruby we use similar syntax to that of defining a Method.
We replace the `def` reserved word with `class` and use the CamelCase format to
name the class. Then use the reserved word `end` to finish the class
definition, e.g., class Dog; end

Now we can create new Dog objects from the Dog class. This is called
"instantiation". This is done by calling the `new` method with the name of the
class. e.g., Dog.new.

When an instance of the Dog class is constructed, it then holds a place in
phyiscal memory that can store states. Within the class Dog we can define
instance variables. e.g., @name for a name and @age for an age, that can be
initialized upon constrution of the instance. Each instance of the Dog class
can then have a name state and an age state that is different from other Dog
objects. The scoping of instance variables are at the object (instance) level
not within the class definition. This means to get access to or change the
value of an instance variable of a particular object we must be work in the
scope of a particular object.

Instance methods are methods that are available to an instance of a class, i.e.
they give us access to the scope of an object. While instance variables track
state, instance methods expose states (instance variables) and perform 
behaviors that are common for its class of objects. 
=end

class Dog
  def initialize(name, age)
    @name = name
    @age = age
  end

  def speak
    "I'm an instance of the Dog class"
  end
end

first_instance_of_dog = Dog.new("Rex", 12)
second_instance_of_dog = Dog.new("Felix", 7)


puts first_instance_of_dog.speak
puts second_instance_of_dog.speak

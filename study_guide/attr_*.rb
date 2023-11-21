=begin
Getter and setter methods can be defined in a class using the `attr_*`
methods. They are used to save time in defining a class and reduce the number
of lines needed to define a class. They can take single or mutiple
arguments separated by a comma. The arguments objects are symbols, like this:
`:name, :age`.

There are three ways to use `attr_*` methods:

1. `attr_accessor`
For example `attr_accessor :name, :age` defines the getter and setter methods
for instance variables `@name` and `@age` and is the equivalent of the
following:
  def name # getter
    @name
  end

  def name=(value) # setter
    @name = value
  end

  def age # getter
    @age
  end

  def age=(value) # setter
    @age = value
  end

2. `attr_reader :name, :age` defines the getters for `@name` and `@age` but not
the setters.

3. `attr_writer :name, :age` only the setter methods.
=end

class Dog
#  def name
#    @name
#  end
#
#  def name=(new_name)
#    @name = new_name
#  end
#
#  def age
#    @age
#  end
#
#  def age=(current_age)
#    @age = current_age
#  end
  attr_accessor :name, :age #saves us from 15 lines of code creation

  def initialize(name, age)
    @name = name
    @age = age
  end

  def speak
    "My name is #{name} and I'm an instance of the #{self.class} class."\
    "(pronounced 'woof woof!')"
  end
end

first_instance_of_dog = Dog.new("Rex", 12)
second_instance_of_dog = Dog.new("Felix", 7)

puts first_instance_of_dog.speak
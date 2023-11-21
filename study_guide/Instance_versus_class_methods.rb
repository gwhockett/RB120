=begin
Instance methods are called by an object instance of a class. Instance methods
can be a behavior of an object instance or can be used to expose and modify the
states of its instance variables. They can also expose and modify class
variables of the object's class. They are defined using the reserved words
`def` and `end`, have a snake case format, may or may not take arguments and
can have their accessibility modified through Method Access Control modifiers.

Class methods are called by a class, not the instances of a class. Class
methods can be a behavior of a class and are used to expose and modify the
states of a class. Class methods are defined in the same way instance methods
are but have `self` prepended to the name of the class.
=end

class Person
  @@number_of_introductions = 0

  def initialize(name)
    @name = name
  end

  def introduction # instance method
    @@number_of_introductions += 1
    "Hello, I'm #{@name}."
  end

  def self.number_of_introductions # class method
    @@number_of_introductions
  end
end

bob = Person.new("Bob")
april = Person.new("April")
puts bob.introduction
puts april.introduction
p Person.number_of_introductions
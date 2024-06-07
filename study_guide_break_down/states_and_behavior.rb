#States and Behavior

module Collaboratable
  attr_accessor :collaborator # Instance method - getter and setter behaviors

  def collaborator? # Instance method - test behavior for truthiness for `Person` class objects
    !!collaborator
  end
  
  def collaborator=(other) # Instance method - reassignment behavior of an instance variable
    @collaborator = other
  end

  def collaborators_name
    collaborator? ? " and their name is #{collaborator.name}." : "."
  end

  def collaborator_kept
    "\nI keep a collaborator: This is #{collaborator?}#{collaborators_name}"\
  end
end

class Person
  @@number_of_persons = 0 # A class variable that can share data with other `Person` objects
  
  attr_reader :name # Instance method - getter behavior for `Person` objects

  def initialize(name) # Instance method - constructor behavior for `Person` objects
    @name = name # instance variables can create state unique to the current object
    @@number_of_persons += 1 # an update of `Person`'s data. Can be shared with instances of the `Person` class
  end

  def self.number_of_persons # class method - data exposure behavior for the `Person` class
    @@number_of_persons
  end

  def number_of_persons # Instance method - exposure behavior of class variable data for `Person` instance objects
    Person.number_of_persons
  end

  def info # Instance method - behavior for the output of information about the current object.
    "\n#{self.inspect}; "\
    "\nName: #{name}"\
    "\nI am 1 of #{number_of_persons} persons."
  end
end

puts Person.number_of_persons
bob = Person.new("Bob")
sam = Person.new("Sam")
# Calling `#inspect` or invoking `p` on an instance object doesn't show it's shared data via a class variable but does show an object's
# attributes,i.e. initialized instance variables. 
p bob
# Below we can see `sam` and `bob` share data via a class variable that isn't returned by `#inspect` or `p`.
puts bob.info
puts sam.info
#States and Behavior

module Collaboratable
  # Instance method - getter and setter behaviors
  attr_accessor :collaborator

  # Instance method - test behavior for truthiness for `Person` class objects
  def collaborator?
    !!collaborator
  end
  
  # Instance method - reassignment behavior of an instance variable
  def collaborator=(other)
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
  # A class variable that can share data with other `Person` objects
  @@number_of_persons = 0
  
  # Instance method - getter behavior for `Person` objects
  attr_reader :name

  # Instance method - constructor behavior for `Person` objects
  def initialize(name)
    # instance variables can create state unique to the current object
    @name = name
    # an update of `Person`'s data. Can be shared with instances of the
    # `Person` class
    @@number_of_persons += 1
  end

  # class method - data exposure behavior for the `Person` class
  def self.number_of_persons
    @@number_of_persons
  end

  # Instance method - exposure behavior of class variable data for `Person`
  # instance objects
  def number_of_persons
    Person.number_of_persons
  end

  # Instance method - behavior for the output of information about the
  #  current object.
  def info
    "\n#{self.inspect}; "\
    "\nName: #{name}"\
    "\nI am 1 of #{number_of_persons} persons."
  end
end

puts Person.number_of_persons
bob = Person.new("Bob")
sam = Person.new("Sam")
# Calling `#inspect` or invoking `p` on an instance object doesn't show it's
# shared data via a class variable but does show an object's attributes,i.e.
# initialized instance variables. 
p bob
# Below we can see `sam` and `bob` share data via a class variable that isn't
# returned by `#inspect` or `p`.
puts bob.info
puts sam.info
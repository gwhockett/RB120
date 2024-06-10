# Instance Methods vs. Class Methods
class Dog
  @@instances_created = 0
  attr_accessor :dog_number

  def initialize
    @@instances_created += 1
    self.dog_number = @@instances_created
  end

  # class method definition
  def self.dog
    "\nI am a class method that exposes data of the class `Dog`."\
    "\nI don't expose the data of a `Dog` object."\
    "\nI have instantiated #{@@instances_created} dogs."
  end

  # instance method definition
  def dog
    "\nI am an instance method that exposes data for an object of `Dog` and"\
    "\ndata of the `Dog` class."\
    "\nI am dog #{dog_number} of #{@@instances_created} instantiated dogs."
  end
end

# Invocation of the class method `::dog`
puts Dog.dog 
rex = Dog.new
ginger = Dog.new
# Invocation of the instance method `#dog`
puts rex.dog
puts ginger.dog
# Invocation of the class method `::dog`
puts Dog.dog
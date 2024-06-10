# Getter and Setter creation
class Person
  # accessor getter creation for `@name` and `@age`
  attr_reader :name, :age
  # accessor setter creation for `@age`
  attr_writer :age
  # accessor getter and setter creation for `@occupation`
  attr_accessor :occupation

  def initialize
    @age = 12
    @occupation = "none"
    @shoe_size = 8
    @name = "Sam"
  end

  # getter definition for `@shoe_size`
  def shoe_size
    @shoe_size
  end

  # setter definition for `@shoe_size`
  def shoe_size=(size)
    @shoe_size = size
  end

  def to_s
    "#{name}'s info:"\
    "\nAge: #{age}"\
    "\nOccupation: #{occupation}"\
    "\nShoe size: #{shoe_size}"
  end
end

sam = Person.new
puts sam
puts ''
sam.age = 31
sam.occupation = "Actor"
sam.shoe_size = 11
puts sam
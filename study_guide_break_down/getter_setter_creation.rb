# Getter and Setter creation
class Person
  attr_reader :name, :age # accessor getter creation for `name` and `@age`
  attr_writer :age # accessor setter creation for `@age`
  attr_accessor :occupation # accessor getter and setter creation for `@occupation`

  def initialize
    @age = 12
    @occupation = "none"
    @shoe_size = 8
    @name = "Sam"
  end

  def shoe_size # getter definition for `@shoe_size`
    @shoe_size
  end

  def shoe_size=(size) # setter definition for `@shoe_size`
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
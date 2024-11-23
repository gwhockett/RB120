class Rectangle
  include Comparable
  attr_reader :width, :height

  def initialize(width, height)
    @width = width
    @height = height
  end

  def area
    width * height
  end

  def <=>(other)

  end
end

rect1 = Rectangle.new(6, 4)
rect2 = Rectangle.new(5, 5)

p rect2 > rect1 # true
p rect1 < rect2 # true

# What would happen if we ran this code now? Why? 
# How do we fix it? 



####

class Cat
  attr_reader :name, :color

  def initialize(name)
    @name = name
  end

  def dye_in_blue
    @color = 'blue'
  end
end

# What will this output? Why?

kitty = Cat.new('Kitty')
p kitty.color

#---------------------------------------------------

# Why did it return nil?
# Does the Cat object have an instance variable @color

p kitty

# Why does it return nil?
# An uninitialized instance variable always return nil

p @something

#---------------------------------------------------

#How can you fix it?

kitty.dye_in_blue
p kitty.color # => 'blue'

#----------------------------------------------------

# What's the scope of an instance variable?:

class Cat
  def initialize(name)
    @name = name
  end
end

kitty = Cat.new('Kitty')

p @name
# => nil

p kitty.name
# => NoMethod error
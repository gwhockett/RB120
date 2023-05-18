=begin
class GoodDog
  #def name (getter)
  #  @name
  #end

  #def name=(n) (setter because of the '=' sign)
  #  @name = n
  #end
  # but we can do the following instead
  # attr_accessor creates a getter and setter at the same time
  attr_accessor :name, :height, :weight
  # Now we have
  # name (getter), name= (setter)
  # height (getter), height= (setter)
  # weight (getter), weight= (setter)
  # all with one method and three arguments

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says arf!"
  end

  def change_info(n, h, w)
    # remember syntactical sugar? Here the method #self is needed
    # to call the setters below to ensure that we aren't creating
    # a local variables within the scope of this method.
    self.name = n
    self.height = h
    self.weight = w
  end
  
  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end

p sparky = GoodDog.new("Sparky", "12 inches", "10 lbs")
p sparky.speak
p sparky.info
p sparky.change_info("Spartacus", "24 inches", "45 lbs")
p sparky.speak
p sparky.info
=end

class GoodDog
  attr_accessor :name, :height, :weight #getters setters created, also instance variables?)

  def initialize(n, h, w) #constructor that uses `self` to call the setters
    self.name   = n
    self.height = h
    self.weight = w
  end

  def change_info(n, h, w) #set of setter calls
    self.name   = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall." #self not needed for getters
  end

  def what_is_self
    self
  end

  puts self
end

sparky = GoodDog.new('Sparky', '12 inces', '10 lbs')
p sparky.what_is_self
p sparky.info
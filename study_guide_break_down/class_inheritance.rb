# Class inheritance
class Mammal
  def sleep
    "I am a #{self.class} that is sleeping."
  end

  def run
    "I am a #{self.class} that is running."
  end
end

# now `Dog` has the behaviors of `Mammal` and is refined by `#bark`
class Dog < Mammal
  def bark
    "barking"
  end
end

# now `Cat` has the behaviors of `Mammal` and is refined by `#purr`
class Cat < Mammal
  def purr
    "purring"
  end
end

# use of "dry" code and polymorphic behavior via class inheritance.
[Dog.new, Cat.new].each do |mammal|
  puts mammal.sleep
  puts mammal.run
end

# subclass objects with behaviors specific to their class.
puts Dog.new.bark
puts Cat.new.purr
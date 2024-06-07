# Class inheritance
class Mammal
  def sleep
    "I am a #{self.class} that is sleeping."
  end

  def run
    "I am a #{self.class} that is running."
  end
end

class Dog < Mammal # now `Dog` has the behaviors of `Mammal` and is refined by `#bark`
  def bark
    "barking"
  end
end

class Cat < Mammal # now `Cat` has the behaviors of `Mammal` and is refined by `#purr`
  def purr
    "purring"
  end
end

[Dog.new, Cat.new].each do |mammal| # use of "dry" code and polymorphic behavior via class inheritance.
  puts mammal.sleep
  puts mammal.run
end

puts Dog.new.bark # subclass objects with behaviors specific to their class.
puts Cat.new.purr
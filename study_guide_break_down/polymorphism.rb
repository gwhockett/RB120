# Polymorphism example
module Walkable
  def walk(walk_type="easy")
    "#{walk_type} walk"
  end
end

class Parent
  attr_reader :hair_color

  def initialize
    @hair_color = "Blonde"
  end
end

class Child < Parent
  include Walkable

  def initialize
    @hair_color = "Brown"
  end
end

class Dog
  include Walkable
end

class Duck
  def walk(gait="waddle")
    "#{gait} walk"
  end
end

[Parent.new, Child.new].each { |obj|  puts obj.hair_color } # Polymorphism through class inheritance
[Child.new, Dog.new].each { |obj| puts obj.walk("run") } # Polymorphism through interface inheritance / mixins
[Dog.new, Duck.new].each { |obj| puts obj.walk} # Ducktyping polymorphism

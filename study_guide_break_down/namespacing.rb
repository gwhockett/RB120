# Namespacing: Modules are used to contain classes that are similar in type or
# are related.
# Namespacing makes it easier to recognize similar and related classes.
# Namespacing prevents the collision of similarly named classes.

module Dogs
  def self.type
    self
  end

  class Bulldog
    def speak
      "I am of the class #{self.class}, namespaced within the module #{Dogs.type}."
    end
  end
end

module Mascots
  def self.type
    self
  end

  class Bulldog
    def speak
      "I am of the class #{self.class}, namespaced within the module #{Mascots.type}."
    end
  end
end

p Dogs::Bulldog.new.speak
p Mascots::Bulldog.new.speak
puts ''
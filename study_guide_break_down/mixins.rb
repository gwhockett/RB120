# Modules are used to provide common/polymorphic behaviors to unrelate
# classes, through so called "mixins".
module Personable
  def sit
    "sit on a Zamboni via the mixin #{Personable}"
  end

  def speak
    "I am of the class #{self.class}. I can speak via the mixin #{Personable} and #{sit}."
  end
end

module Birdable
  def sit
    "sit in a treetop via the mixin #{Birdable}"
  end
end

class Mascot
  include Personable
end

class Raptors
  include Personable
  include Birdable
end

p Raptors.new.speak
p Mascot.new.speak
puts ''
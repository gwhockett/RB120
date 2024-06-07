# Module Methods
module Brains
  def self.chess
    "chess"
  end

  def self.tic_tac_toe 
    "tic-tac-toe"
  end
end

class Chicken
  def speak
    "I am a #{self.class} and I can play #{Brains.tic_tac_toe}." # the preferred way to invoke a module method.
  end
end

class Person
  def speak
    "I am a #{self.class} and I can play #{Brains::chess}."
  end
end

puts Chicken.new.speak
puts Person.new.speak
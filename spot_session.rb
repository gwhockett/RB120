=begin
Intros:
-name
-location in the world
-location in RB120/129



Study Guide:
Classes and objects
Use attr_* to create setter and getter methods
How to call setters and getters
Instance variables, class variables, and constants, including the scope of each type and how inheritance can affect that scope
Instance methods vs. class methods
Method Access Control
Referencing and setting instance variables vs. using getters and setters
Class inheritance, encapsulation, and polymorphism
Modules and their use cases
Method lookup path
self
Calling methods with self
More about self
Reading OO code
Fake operators and equality
Working with collaborator objects
Create a code spike
=end
=begin
Design a Sports Team (Author Unknown...thank you!)

- Include 4 players (attacker, midfielder, defender, goalkeeper)

- All the players’ jersey is blue, except the goalkeeper, his jersey is white with blue stripes
  - attribute of the Player class
- All players can run and shoot the ball.
  - behaviors Player class

- Attacker should be able to lob the ball
  - Attacker behavior
- Midfielder should be able to pass the ball

- Defender should be able to block the ball

- The referee has a whistle. He wears black and is able to run and whistle.
=end
module Runnable
  def run
  end
end

class Referee
  include Runnable

  attr_reader :jersey_color

  def initialize
    @jersey_color = "black"
    @whistle = "yes"
  end
end

class Player
  include Runnable
  attr_reader :jersey_color

  def initialize
    @jersey_color = "blue"
  end

  def shoot_ball
  end
end

class Attacker < Player
  def lob_ball
  end
end

class Midfielder < Player
  def pass_ball
  end
end

class Defender < Player
  def block_ball
  end
end

class Goalkeeper < Player
  def initialize
    @jersey_color = "white with blue stripes"
  end
end

goal_keeper = Goalkeeper.new
p goal_keeper.jersey_color
defender = Defender.new
p defender.jersey_color
p defender.block_ball

# class MyParentClass
#   attr_reader :parent_ivar
#   def initialize()
#     @parent_ivar = 'Parent ivar'
#   end
# end

# class MyChildClass < MyParentClass
#   attr_reader :child_ivar
#   def initialize(child_ivar)
#     @child_ivar = child_ivar
#     super()
#   end
# end

# myChildObject = MyChildClass.new('Parent ivar')
# p myChildObject
# p myChildObject.parent_ivar
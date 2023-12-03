=begin
Question 1
You are given the following code:
What is the result of executing the following code:

A new instance of the `Oracle` class is generated and assigned to the variable
`oracle`. Then the instance `oracle` calls the instance method
`predict_the_future` where the string `"You will "` calls the method `+` and
has the return value of the `choices.sample` passed in. `choices.sample`
returns one of the three string values contained in the returned array of the
instance method `choices`. `+` then returns a new conctenated string.

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end


oracle = Oracle.new
p oracle.predict_the_future

Question 2
We have an Oracle class and a RoadTrip class that inherits from the Oracle class.
What is the result of the following:

A new string would be returned. Where "You will " is concatenated to one of the
string objects from the `choices` defined in the class `RoadTrip` not from
`choices` defined in Oracle. Because the calling object is from the `RoadTrip`
class Ruby starts its method lookup path from the `RoadTrip` class and resolves
`choices` there.

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
p trip.predict_the_future


Question 3
How do you find where Ruby will look for a method when that method is called?
How can you find an object's ancestors?
What is the lookup chain for Orange and HotSauce?

To find the method lookup path in Ruby for a method, first you need to know
what class the calling object of the method belongs to. Then call `ancestors`
on the class of the calling object, this returns the inheritance  chain of the
class in an array.
So,
`Orange.ancestors` #=> [Orange, Taste, Object, Kernel, BasicObject]
HotSauce.ancestors #=> [HotSauce, Taste, Object, Kernel, BasicObject]

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

p Orange.ancestors
p HotSauce.ancestors

Question 4
What could you add to this class to simplify it and remove two methods from the
class definition while still maintaining the same functionality?

I would add `attr_accessor :type` to the top of the class definition and remove
the defined `type` and `type=` instance methods because `attr_accessor :type`
gives us both the getter and setter methods for the instance variable `@type`.

class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

Question 5
There are a number of variables listed below. What are the different types and
how do you know which is which?

the first is a local variable because it is initialized with simple snake case
formatting. The second is an instance variable. Instance variables in Ruby are
defined in the same way that local variables are but have an `@` sign prepended.
The third is a class variable because it has a double `@` prepended.

excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"

Question 6
If I have the following class:
Which one of these is a class method (if any) and how do you know? How would
you call a class method?

`self.manufacturer` is a class method because it is defined within the lexical
scope of a class and has `self` prepended. `model` is an instance method
because it is defined within the lexical scope of a class with nothing
prepended. To call a class method replace `self` with the class name prepended,
in this case `Television.manufacturer`

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

Question 7
If we have a class such as the one below:
Explain what the @@cats_count variable does and how it works. What code would
you need to write to test your theory?

`@@cats_count` tracks the number of `Cat` class instances that have been
initialized. This is because `initialize` increments `@@cats_count` up by a
count of `1` when a new instance is created. To check this we would could
output the return value of the class method `self.cats_count` every time we
create new instance of `Cat`

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

p Cat.cats_count #=> 0
Cat.new("tabby")
p Cat.cats_count #=> 1
Cat.new("house")
p Cat.cats_count #=> 2
Cat.new("ferel")
p Cat.cats_count #=> 3

Question 8
If we have this class:
And another class:
What can we add to the Bingo class to allow it to inherit the play method from
the Game class?

We would add ` < Game` the name of the `Bingo` class, like this:
and then to check we would call `play` with an instance of the `Bingo` class.

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

puts Bingo.new.play

If we have this class:
What would happen if we added a play method to the Bingo class, keeping in mind
that there is already a method of this name in the Game class that the Bingo
class inherits from.

Ruby starts its method look up path with the class of the calling object. If
`play` was defined within `Bingo`, Ruby would execute `play` from `Bingo` and
stop looking. So `play` from `Game` would never be executed.   

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end

  def play
    "End the game!"
  end
end

p Game.new.play
p Bingo.new.play

Question 10
What are the benefits of using Object Oriented Programming in Ruby? Think of as
many as you can.

Objects can be thought of and designed with a more natural grammar structure
such as nouns and verbs. This makes it eaiser to conceptualize abstraction, 
program design and makes for more effective complexity management software.

In Ruby OOP, functionality exposure through method access control and namespace
hygine makes encapsulation easier and more effective.

OOP reduces the need for duplication of code. It enables quicker application
builds and updates through the use of pre-written code. 


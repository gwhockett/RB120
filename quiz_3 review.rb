=begin
1. Which of the following are methods, not real operators? Select all that apply.
`*`, `<=`, `%` are fake operators. `&&` is a true operator.

2. Again, which of the following are methods, not real operators? Select all that apply.
`==`, `[]=`, `>` are fake operators. `||` is a true operator.

3. Which of the following conditional expressions can you use to determine whether str1
and str2 point to the same object? Select all that apply.

str1 = "I'm a string"
str2 = str1

`str1.equal?(str2)`, and `str1.object_id == str2.object_id` will test whether they are the
same object.

`str1 == str2` and `str1.eql?(str2)` test whether the two objects have the same return value
not whether they are same object.

4. Which of the following expressions are guaranteed to return true given the results shown below?
Assume str1 and str2 are objects of the String class. Select all that apply.

> str1 = "I am a string"
> str2 = "I am a string"
> p str1
"I am a string"
> p str2
"I am a string"

`str1 == str2` checks the return value only and returns true and is the standard way to test string
equality.

`str1.equal?(str2)` checks whether they are the same object, which they are not and returns false.
`#equal?`

`str1 === str2` checks whether the second object is part of the first object if the first object
is a set of objects. Returns true. Don't use this expression explicitly. Ruby uses this to check
internally in `case` statements.

`(str1 <=> str2) == 0` Returns true. `String#<=>` checks whether the caller and the argument both have
the same return value. If they do then `String#<=>` returns `0`.

5. Which of these code snippets will return true? Select all that apply.

class Thing
  attr_accessor :size

  def initialize(s)
    @size = s
  end

  def ==(other_thing)
    size == other_thing.size
  end
end

thing1 = Thing.new(5)
thing2 = Thing.new(5)
thing3 = thing1
thing1.size = 4

`Thing#==` checks whether the calling `Thing` object's `@size` value has the same as the arugments `@size`
value. `thing1 == thing2` returns false because line 60 changes `thing1`'s `@size` value to `4`.

Again, `thing2 == thing3` will return false. `thing2`'s `@size` value is different than `thing3`'s because
`thing3` and `thing1` are assigned to the same object at line 59.

`thing3.equal? thing2` will return false because `thing3` and `thing2` refer to different objects.

`thing3.equal? thing1` will return true because `thing3` and `thing1` both refer to the same object.

6. Which of these code snippets will return true? Select all that apply.

class Circle
  attr_reader :radius

  def initialize(r)
    @radius = r
  end

  def >(other)
    radius > other.radius
  end

  def ==(other)
    radius == other.radius
  end
end

circle1 = Circle.new(5)
circle2 = Circle.new(3)
circle3 = Circle.new(5)

`circle1 > circle2` will return `true` because `Circle#>` compares whether two `Circle` objects have the same
`@radius` value. `circle1`'s `@radius` value is larger than `cirlce2`'s `@radius` value.

`circle2 < circle3` will return a `NoMethodError` because the class `Circle` does not have a `#<` method
defined.

`circle1 == circle3` will return `true`. `Circle#==` checks whether `Circle` object have the same `@radius`
return value. Both `circle1` and `circle3`'s `@radius` values are `5`.

`circle3 != circle2` will return `true` becuase `Circle#==` is defined. When `==` is defined for a class
in Ruby, Ruby automatically gives the class the `#!=` method. Since `circle3` and `circle2`'s `@radius`
values are different, we get `true`.

7. Which of the following methods does this case statement use to determine which `when` clause is executed?
Select all that apply.

number = 42

case number
when 1          then 'first'
when 10, 20, 30 then 'second'
when 40..49     then 'third'
end

`Range#===` and `Integer#===`

8. Which variables in the Person class are scoped at the object level? Select all that apply.

class Person
  TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']

  @@total_people = 0

  def initialize(name)
    @name = name
  end

  def age
    @age
  end
end

`@age` and `@name` are scoped at the object level.

`TITLES` is a constant and has lexical scope.
`@@total_people` is a class variable and is scoped at the class level.

9.Which of the following instance variables are initialized when we instantiate the `Greyhound` object?
Select all that apply.

module Speedy
  def run_fast
    @speed = 70
  end
end

class Animal
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Dog < Animal
  DOG_YEARS = 7

  def initialize(name, age)
    @dog_age = age * DOG_YEARS
  end
end

class Greyhound < Dog
  include Speedy
end

grey = Greyhound.new('Grey', 3)

`@dog_age` is initialized to the value `21`.

`@speed` is not initialized because `#run_fast` is not invoked by `grey` even though the `Greyhound` class
includes the module `Speedy`.

`Dog#initialize` overrides `Animal#initialize` so `@name` and `@age` ivars can not be initialized for
`Greyhound` objects.

10. Which of the following statements are true? Select all that apply.

class Shape
  @@sides = nil

  def self.sides
    @@sides
  end

  def sides
    @@sides
  end
end

class Triangle < Shape
  def initialize
    @@sides = 3
  end
end

class Quadrilateral < Shape
  def initialize
    @@sides = 4
  end
end

The `Shape` class's `@@sides` will reference `nil`, `3` or `4` but will only reference `3` or `4` depending on
whether a `Quadrilateral` or `Trinangle` object was last instantiated and that they are subclasses of `Shape`.
Whether a `Quadrilateral` or `Triangle` object was last will also determine the return value `Shape::sides` and
`Shape#sides` being that they both return the value of `@@sides`.

So, `Triangle.sides` can sometimes return `4` and `Triangle.sides` will not always return `3`.
`Traingle.new.sides` will always return `3` because `Traingle#intialize` reassigns `@@sides` to `3`

A and D

11. You must make some changes to the below code so that the last three statements return the values shown in
the comments. Which of the following changes do you need to make? (You may need to make more than one change).

module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

Square.sides # => 4 Change the body of of `Shape::sides` from `SIDES` to `self::SIDES`
Square.new.sides # => 4 Needs a `#sides` instance method to return `Quadrilateral::SIDES`
Square.new.describe_shape # => "I am a Square and have 4 sides." change the body of `Describable#describe_shape` to
"I am a #{self.class} and have #{Quadrilateral::SIDE} sides."


B, C, D
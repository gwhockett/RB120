=begin
# Question 1
# If we have this code:
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
# What happens in each of the following cases:
# case 1:
hello = Hello.new
hello.hi
# `"Hello"` is output and `nil` is returned.

# case 2:
hello = Hello.new
hello.bye
# undefined method error is thrown. `Hello` class instances don't have a `bye`
# method along their method lookup path

# case 3:
hello = Hello.new
hello.greet
#Argument error is thrown for wrong number of arguments

# case 4:
hello = Hello.new
hello.greet("Goodbye")
#`"Goodbye"` is output and `nil` returned.

# case 5:
Hello.hi
# Undefined method error thrown, no class method `hi` is defined for the
# `Hello` class.

# Question 2
# In the last question we had the following classes:

class Greeting
  def greet(message)
    puts message
  end

  def self.hi
    puts "This class says 'hi'."
  end

end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

Hello.hi

# If we call Hello.hi we get an error message. How would you fix this?
# We would need to define a `self.hi` class method somewhere along the class
# method lookup path of the class `Hello`. This may or may not have the same
# behavior as the instance method `hi` for `Hello` class instances.

Question 3
When objects are created they are a separate realization of a particular class.
Given the class below, how do we create two different instances of this class
with separate names and ages?

We would call the `new` constructor method with the class `AngryCat`, two times
with an `age` and `name` argument passed in. Like this:

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

#Like this:
bobby = AngryCat.new(3, "Bobby")
mack = AngryCat.new(10, "Mack")

# This gives us two different instances of the `AngryCat` class, each with their
# own `@name` and `@age` states. We then can verify that we two different
# instances by outputting the return value of `bobby` and `mack` like this:
p bobby
p mack
# which shows each has a unique memory location with their own `@name` and
# `@age` states.

Question 4
Given the class below, if we created a new instance of the class and then
called to_s on that instance we would get something like
"#<Cat:0x007ff39b356d30>"

How could we go about changing the to_s output on this method to look like
this: I am a tabby cat? (this is assuming that "tabby" is the type we passed in
during initialization).

We would define a new `to_s` instance method within the `Cat` class as follows:

class Cat
  def initialize(type)
    @type = type
  end
  # new to_s method
  def to_s
    "I am a #{@type} cat"
  end
end

# Here `to_s` overrides `Cat`'s inherited `to_s` and returns a new string that
# directly interpolates the instance's `@type` instance variable.

puts Cat.new("tabby")

Question 5
If we have the following class:
What would happen if I called the methods like shown below?

`tv.manufacturer` would throw an undefined error because the class `Television`
does not have an instance method `manufacturer` defined. `tv.model` would return
the method logic for the instance method `model`. `Television.manufacturer`
would return the method logic for the class method `self.manufacturer` and
`Television.model` would throw an undefied method error because the class
`Television` does not have a class method `self.model` defined.

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer
tv.model

Television.manufacturer
Television.model

Question 6
If we have a class such as the one below:
In the make_one_year_older method we have used self. What is another way we
could write this method so we don't have to use the self prefix?

Replace the setter method call `self.age` with a direct reference to the `@age`
instance variable.

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    #self.age += 1
    @age += 1
  end
end

Question 7
What is used in this class but doesn't add any value?
The `return` keyword. The class method `self.information` will return its
string on the last line without `return`. Also, we could change `attr_accessor`
to `attr_reader` to prevent alteration of a `Light` instances given that the
class method string declares all of its lights are super high brightness with a
color of green.

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end
=end
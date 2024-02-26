=begin
Question 1
Which of the following are objects in Ruby? If they are objects, how can you
find out what class they belong to?

1. true
2. "hello"
3. [1, 2, 3, "happy days"]
4. 142

All are objects in Ruby and each of the can call the `Kernel#class` method
which returns the object type of the caller.

p true.class
p "hello".class
p [1, 2, 3, "happy days"].class
p 142.class

Question 2
If we have a Car class and a Truck class and we want to be able to go_fast, how
can we add the ability for them to go_fast using the module Speed? How can you
check if your Car or Truck can now go fast?

We would add `include Speed` it each of the classes then call `ancestors` with
each of the classes to if the module `Speed` is included on the method lookup
path of the class. We can also create a new instance of the class that has the
included module then use the instance to call a method from the module.

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

p Truck.ancestors

mack = Truck.new
mack.go_fast

Question 3
In the last question we had a module called Speed which contained a go_fast
method. We included this module in the Car class as shown below. When we called
the go_fast method from an instance of the Car class (as shown below) you might
have noticed that the string printed when we go fast includes the name of the
type of vehicle we are using. How is this done?

`self` in the `go_fast` method refers to the calling object. Since the module
`Speed` is included in the class `Car` and the calling object of `go_fast` is
an instance of the `Car` class, the method `class` called by `self` returns
what class the calling object is an instance of. String interpolation `#{}`
call the `to_s`, which converts `self.class` to a string.

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

Question 4
If we have a class AngryCat how do we create a new instance of this class?

The AngryCat class might look something like this:

We would call the constructor method `new` on the class `AngryCat`. When a
class calls the `new` method a new instance of that class is returned.

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

AngryCat.new

Question 5
Which of these two classes would create objects that would have an instance
variable and how do you know?

The `Pizza` class would create an instance with an initialized instance
variable. Instance variable are defined when a variable name has an `@`
prepended, like this: `@name`. While `initialize` is a constructor method
in the `Fruit` class a local variable is created because `name` is not
prepended with `@` but is in `Pizza`.

We could also demonstrate this by calling `instance_variables` on instances
of each class.

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

apple = Fruit.new('Apple')
cheese = Pizza.new('Cheese')

p apple.instance_variables
p cheese.instance_variables

Question 6
What is the default return value of to_s when invoked on an object? Where could
you go to find out if you want to be sure?

You could look up the documentation for Object#to_s. A string value of the
calling object's class is returned along with the object's encoding id and with
any initialized instance variables.

Question 7
If we have a class such as the one below:

You can see in the make_one_year_older method we have used self. What does self
refer to here?

`self` is invoked within an instance method defined within the class `Cat` and
refers to the calling object of the method. In this case, because
`make_one_year_older` is an instance method of the class `Cat`, `self` would be
an object instance of the `Cat` class.

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

Question 8
If we have a class such as the one below:

In the name of the cats_count method we have used self. What does self refer to
in this context?

When defining a method at the lexical scope of a class and the method has
`self` prepended to the name, the method is a class method that can only be
called by the class itself. So `self` in this context is the class `Cat` and
can would look like this: `Cat.cats_count`

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


Question 9
If we have the class below, what would you need to call to create a new
instance of this class.

I would need to call `new` with `Bag` and two arguments passed to `new`, like
this: `Bag.new("brown", "paper")`

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end


+++++++++++++

1. Which of the following are objects in Ruby? If they are objects,
how can you find out what class they belong to?

true
"hello"
[1, 2, 3, "happy days"]
142

These are all objects and to find out what class they belong to, call the 
`#class` method on each object. This will return which class an object belongs to.

2. If we have a Car class and a Truck class and we want to be able to go_fast, how
can we add the ability for them to go_fast using the module Speed? How can you check
if your Car or Truck can now go fast?

Mix in the `Speed` module by adding `include Speed` into each class.


module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

3. When we called the go_fast method from an instance of the Car class (as shown below)
you might have noticed that the string printed when we go fast includes the name of the
type of vehicle we are using. How is this done?

`self.class` is interpolated in the body of `Speed#go_fast`. `self` references the current
object that calls `Speed#go_fast`. Calling `#class` on the current object returns the class
of that object. In this example `small_car` references a `Car` class object. Since
`self.class` is interpolated in a `string` it's return value is automatically converted to
a string, so no need to call `to_s`.

4. If we have a class AngryCat how do we create a new instance of this class?
The AngryCat class might look something like this:

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

Calling the `#new` method on the `AngryCat` class creates a new `AngryCat` object, i.g.,
`AngryCat.new`.

5. Which of these two classes would create objects that would have an instance variable
and how do you know?
  
First we can see that the `Pizza` class initalizes an instance variable within the body
of its `initialize` method, `@name = name`, when it creates a new object. The `Fruit` class
creates a local variable `name` within its `#initialize` method.

Second we could call `instance_variables` method on an object to see what initialized instance
variable that object contains. `instance_variables` returns an array of all the instance variable
for the object it was called on. If it is empty, then it has no instance variables.

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

p Pizza.new("cheese").instance_variables
p Fruit.new("tomato").instance_variables

7. If we have a class such as the one below:
You can see in the make_one_year_older method we have used self. What does self refer to here?

`self` refers to the calling the object of `Cat#make_one_year_older` which must be a `Cat` class
object.

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

8. If we have a class such as the one below:
In the name of the cats_count method we have used self. What does self refer to in this context?

Since `self` is prepended to the name of a method definition within a class, `self` refers to the class
`Cat`

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


9. If we have the class below, what would you need to call to create a new instance of this class.

We would need the name the class, `Bag`, calling the method `new` that has two arguments passed in.
E.g., `Bag.new("blue", "cloth")`.
=end
=begin
1. You must make some changes to the above code so that the last three statements return the values shown
in the comments. Which of the following changes do you need to make? (You may need to make more than one
change).

class Cat
  attr_reader :name # add this line
  @@total_cats = 0

  def initialize(name)
    @name = name
    @@total_cats += 1 # add this line
  end

  def jump
    "#{name} is jumping!" # adding `self.name` won't change anything.
  end

  def self.total_cats
    @@total_cats
  end

  def to_s # this method override
    name
  end
end

mitzi = Cat.new('Mitzi')
mitzi.jump # => "Mitzi is jumping!"
Cat.total_cats # => 1
"The cat's name is #{mitzi}" # => "The cat's name is Mitzi"

2. Which of the following code snippets can you add to the class body so that the above code returns a
Student object whose state matches the comment in the last line shown above? Select all that apply.

class Student
  # class body
end

ade = Student.new('Adewale')
ade # => #<Student:0x00000002a88ef8 @name="Adewale", @grade=nil>

A
def initialize(name, grade=nil)
  @name = name
  @grade = grade
end
c
def initialize(name)
  @name = name
  @grade = nil
end

wrong answers

def initialize(name)
  self.name = name # NoMethodError is raised because a writer has not been defined.
  @grade = nil
end
#
attr_accessor :grade

def initialize(name, grade=nil) # @grade is not initialized
  @name = name 
end

3. We now want to add some attr_* methods to our Student class so that we can access and update the
state of a Student object. Examine the following Ruby code.

Assuming that the Student class already has an appropriate #initialize method, which of the following
code snippets could you add to the Student class to define the getters and setters you need to make the
example code run as shown? Select all that apply.

class Student
  # assume that this code includes an appropriate #initialize method
end

jon = Student.new('John', 22)
jon.name # => 'John'
jon.name = 'Jon'
jon.grade = 'B'
jon.grade # => 'B'

A Incorrect, NoMethodError, no writer `@name`

attr_reader :name
attr_accessor :grade

B Correct

attr_writer :name, :grade
attr_reader :name, :grade

c Correct

attr_accessor :name, :grade

D Incorrect, NoMethodError, no reader for `@grade`

attr_accessor :name
attr_writer :grade

4. You must make some changes to the below code so that the last two statements return the values shown
in the comments. Which of the following changes do you need to make? (You may need to make more than
one change).

Change `Character#speak`'s return value to `"#{name} is speaking."`

Note: When you refer to a class method use the namespace operator (::) not a hash (#). For example if
the class `Character` has a class method then describe it like this, `Character::some_character_class_method`

class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{name} is speaking." #Change made
  end
end

class Knight < Character
  def name
    "Sir " + super
  end
end

sir_gallant = Knight.new("Gallant")
p sir_gallant.name # => "Sir Gallant"
p sir_gallant.speak # => "Sir Gallant is speaking."

5. Let's add a Thief class as a subclass of Character. Examine the following code: 

You must make some changes to the above code so that the last two statements return the values shown in
the comments. Which of the following changes do you need to make?

Override `Character#speak` with `Thief#speak`. The body of `Thief#speak` shoud have `"#{name} is whispering..."`

class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} is speaking."
  end
end

class Thief < Character
  def speak
    "#{name} is whispering..."
  end
end

sneak = Thief.new("Sneak")
p sneak.name # => "Sneak"
p sneak.speak # => "Sneak is whispering..."

6. You must make some changes to the above code so that the last three statements return the values shown in the
comments. Which of the following changes do you need to make? (You may need to make more than one change).

Change the body of `FarmAnimal#speak` to `"#{self.class} says "`
Change the body of `Lamb#speak` to `super + "baaaaaaa!"`

`Sheep.new.speak` invokes `Sheep#speak`. `Sheep#speak` calls `Farmanimal#speak` via `super` which returns
`"Sheep says "` which is concatenated to `"baa!"`

`Lamb.new.speak` invokes `Lamb#speak` which invokes `Sheep#speak` via `super` which invokes `FarmAnimal#speak` via
`super` where `"Lamb says "` is returned. `Sheep#speak` then concatenates `"Lamb says "` to `"baa!"` and finally
`Lamb#speak` concatenates `"Lamb says baa!"` to `"baaaaaaa!"` for the final return value.

The `Cow` class needs to sub class from `FarmAnimal`

class FarmAnimal
  def speak
    "#{self.class} says "
  end
end

class Sheep < FarmAnimal
  def speak
    super + "baa!"
  end
end

class Lamb < Sheep
  def speak
    super + "baaaaaaa!"
  end
end

class Cow < FarmAnimal
  def speak
    super + "mooooooo!"
  end
end

p Sheep.new.speak # => "Sheep says baa!"
p Lamb.new.speak # => "Lamb says baa!baaaaaaa!"
p Cow.new.speak # => "Cow says mooooooo!"

7.  What, specifically, do we mean when we refer to collaborator objects in OO Ruby?
Collaborator objects are objects of a custom class that are held as state in another unrelated object. While
standard library objects can techincally be considered collaborators, they are typically considered true
collaborator objects.

8. Examine the code below. Identify all custom defined objects that act as collaborator objects within the code.
Select all that apply.

The `Person` object referenced by the variable `sara`.

class Person
  def initialize(name)
    @name = name
  end
end

class Cat
  def initialize(name, owner)
    @name = name
    @owner = owner
  end
end

sara = Person.new("Sara")
fluffy = Cat.new("Fluffy", sara)

9. Which of the following are differences between modules and classes? Select all that apply.

Classes can instantiate objects but modules can't.
Modules can be used as a container for similar classes, or namespacing classes.
Modules can be mixing to as many classes as you want but classes can only sub-class along a single
chain of inheritance.

10. What method(s) can't be shared by class inheritance but could be shared by a module to give
unrelated objects the same behavior?



You're designing a Recipe Book application. You've identified some classes that you need:

RecipeBook
Recipe
StarterRecipe
MainCourseRecipe
DessertRecipe
Ingredient

Each Recipe Book has one or more recipes. Starter recipes, main course recipes, and dessert
recipes are all recipe types and share some characteristics but not others. Recipes have
one or more ingredients.

You decide that the application also needs a Conversion module that contains some temperature
and measurement conversion methods required by Recipe and Ingredient objects.

module Conversion

end

class RecipeBook

end

Class Recipe
  include Conversion
end

class StarterRecipe < Recipe

end

class MainCourseRecipe < Recipe

end

class DessertRecipe < Recipe

end

class Ingredient
  include Conversion
end

11. What kind of Object Oriented relationship should exist between RecipeBook and MainCourseRecipe?

Collaboration

12. What kind of Object Oriented relationship should exist between Ingredient and Conversion?

Mixin

13. What kind of Object Oriented relationship should exist between Recipe and DessertRecipe?

Inheritance

14. What kind of Object Oriented relationship should exist between RecipeBook and Ingredient?

None
=end







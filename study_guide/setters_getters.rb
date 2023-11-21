=begin
Getter

An instance variable's value can't be accessed directly inside or outside of a
class. If we want to obtain a value stored in an instance variable of an
object, we must use a method that has access to the object's instance variable.
To do that, a class definition will define a method that gives an instance of
that class the ability to return an instance variable's value. A method that
only returns the value of an instance variable is called a getter. 

Setter

To initialize or change the value of an instance variable we can use an
instance method called a setter. Setters have a specific syntax for Ruby
to recognize it as a setter. For instance, if a getter has the format `rex.age`
that returns the value for an instance variable `@age` then the setter can have
have the same or different name but add an `=` and take an argument, like this:
`rex.age=(8)`. Ruby's syntactical sugar also allows us to invoke a setter with
a more natural `rex.age = 8`. Setters always return the value of the argument
passed in. So here, `8` would be returned even if the last line of this setter
has another expression. For an instance method to be considered a setter it
performs only one job, setting the value of an instance variable. Setters can
also initialize instance variables.

Because getters and setters have only one job, Ruby convention dictates that
getters and setters should have the same name as the variables they expose and
set.

=end
class Dog
  def name
    @name
  end

  def name=(new_name)
    @name = new_name
  end

  def speak
    "I'm an instance of the #{self.class} class."
  end
end

instance_of_the_dog = Dog.new

p instance_of_the_dog.name
#=> nil, because @name has not been initialized
puts instance_of_the_dog.speak

p instance_of_the_dog.name = 'Harold'
#=> @name is initialized and `'Harold'` is returned
puts instance_of_the_dog.name

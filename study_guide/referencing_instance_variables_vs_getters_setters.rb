=begin
Instance variables' state keeping purpose means we need to access them. Access
of an instance variable can't be done directly outside of a class nor outside
of the scope of an instance method within a class, i.e. instance variables can
only be directly referenced within the scope of an instance method or by the
relevant methods along the class's method lookup path.

Directly referencing an instance variable is simiply invoking its name for
whatever the purpose needed. Be that return a value, to be reassigned to a
value or to be initialized. Say you have an instance variable `@name` and a
corresponding getter `name`. To reference the variable and not the getter you
would simply code out the full variable name `@name`. Similarly, to reassign or
initialize an instance variable, code out `@name = some_value`.  

Excluding the `@` symbol would call the getter or initialize a local variable.
To differentiate when an instance method is being invoked, Ruby uses syntax and
scope. When a getter is being called within an instance method without an
explicit `self` as the caller, Ruby's syntactical sugar uses an implicit `self`
as the caller of the getter. When calling a setter within an instance method the
syntax of the setter requires an explicit `self` to call the setter, like this,
`self.name = "Bob"`. Otherwise a syntax that looks like this: `name = "Bob"`
within an instance method is actually a local variable  declaration, not a
setter call.

By convention the getter and setter instance methods of instance variables
should have the same name as their respective instance variables. So, if you
have an instance variable that has been defined with the name `@spring_tension`
then the getter and setter should have the name, `spring_tension` and
`spring_tension=`. This convention is not strictly built into Ruby as a
requirement but should be be kept in mind when calling getters and setters for
clarity in your code.
=end
class Dog
  def name # getter definition
    @name
  end

  def name=(new_name) #setter definition
    @name = new_name
  end

  def speak # setter call that initializes @name
    "Since you asked me to speak, I change my name to "\
    "#{self.name=("Lord Cat Smasher, Carrier of the Flea")}."
  end

  def shake # getter call
    "Hi, my name is #{name}. I want to lick your paw. It smells nice." 
  end

  def was_here # direct instance variable reference
    "Behold! I, #{@name}, have visited your yard!"
  end

  def new_place_new_name(new_name) # direct instance variable reassignment
    @name = new_name
    "I have a new place to stay and a new name, #{@name}."
  end
end

instance_of_the_dog = Dog.new

puts instance_of_the_dog.speak
puts instance_of_the_dog.shake
puts instance_of_the_dog.was_here
puts instance_of_the_dog.new_place_new_name("Ginger")

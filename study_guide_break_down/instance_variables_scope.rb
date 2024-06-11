#Instance Variables and their scope
class Dog
  attr_accessor :name
  attr_reader :age, :hair
  @hair = "wire"

  def initialize
    @name = "fido"
    @age
  end
end

p dog1 = Dog.new # =>#<Dog:0x000055f6ba1dfb30 @name="fido">
p dog1.name # => "fido"
dog1.name = "nick"  # `@name`'s value is reassigned for this instance
p Dog.new.name #=> "fido"
p dog1.name #=> "nick"
p Dog.new.age # => nil
p Dog.new.hair# => nil

# Here, all new `Dog` class instances have an `@name` intialized to a string
# `"fido"`.
# Each `@name` is individulally scoped within the new instance of `Dog`.
# This means that we can change the value of `@name` within a specific instance
# like we did for the instance `dog1`.
# `@age` is named within `#initialize` but not intialized to a value. However,
# since `@age` is not intialized it returns `nil` and is not scoped within an
# object.
# `@hair` is defined at the class level and is not scoped within instances of
# the `Dog` class.
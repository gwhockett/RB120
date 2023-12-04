=begin
Question 1
Ben asked Alyssa to code review the following code:
Alyssa glanced over the code quickly and said - "It looks fine, except that you
forgot to put the @ before balance when you refer to the balance instance
variable in the body of the positive_balance? method."

"Not so fast", Ben replied. "What I'm doing here is valid -
I'm not missing an @!"

Who is right, Ben or Alyssa, and why?

Ben is correct because he defines a getter method for `@balance` with
`attr_reader`. In turn he defined `positive_balance?` to call the getter
`balance` to compare the value of `@balance` with the value `0`.

class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

Question 2
Alan created the following code to keep track of items for a shopping cart
application he's writing:

Alyssa looked at the code and spotted a mistake. "This will fail when
update_quantity is called", she says.

Can you spot the mistake and how to address it?

Within `update_quantity` a local variable `quantity` is initialized. If the
instance method `update_quantity` is supposed to change the value of 
`@quantity` then there are two possiblities to do this:
1. Directly reference the instance variable like this:
   `@quantity = updated_count if updated_count >= 0`
2. Use a setter that could be defined by `attr_writer :quantity`
   Then code out `self.quantity = updated_count if updated_count >= 0`
   Here `self` prepended to `quantity` will ensure that the setter is called.

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

Question 3
In the last question Alan showed Alyssa this code which keeps track of items
for a shopping cart application:

Alyssa noticed that this will fail when update_quantity is called. Since
quantity is an instance variable, it must be accessed with the @quantity
notation when setting it. One way to fix this is to change attr_reader to
attr_accessor and change quantity to self.quantity.

Is there anything wrong with fixing it this way?

It creates a public exposure of the setters `quantity` and `product_name` that
enable clients of the class to change the state of the instannce variables of
those setters.

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

Question 4
Let's practice creating an object hierarchy.

Create a class called Greeting with a single instance method called greet that
takes a string argument and prints that argument to the terminal.

Now create two other classes that are derived from Greeting: one called Hello
and one called Goodbye. The Hello class should have a hi method that takes no
arguments and prints "Hello". The Goodbye class should have a bye method to say
"Goodbye". Make use of the Greeting class greet method when implementing the
Hello and Goodbye classes - do not use any puts in the Hello or Goodbye classes.

class Greeting
  def greet(str)
    puts str
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

Question 5
You are given the following class that has been implemented:
And the following specification of expected behavior:

class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    if @filling_type == nil && @glazing == nil
      "Plain"
    elsif @filling_type != nil && @glazing == nil
      @filling_type
    elsif @filling_type == nil && @glazing != nil
      "Plain" + " with #{@glazing}"
    elsif @filling_type != nil && @glazing != nil
      "#{@filling_type} with #{@glazing}"
    end
  end
  # refactoring needed!
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
 # => "Plain"

puts donut2
 # => "Vanilla"

puts donut3
 # => "Plain with sugar"

puts donut4
 # => "Plain with chocolate sprinkles"

puts donut5
 # => "Custard with icing"

Question 6
If we have these two methods in the Computer class:
What is the difference in the way the code works?

In the first class the instance method `show_template` calls the getter method
`template` with an implicit `self` because there is no ambiguity for Ruby.
In the second class the instance method `show_template` calls the getter method
with `self` explicitly prepended. Both return the value stored in `@template` but
the latter definition has an unneeded `self` as a caller.
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    self.template
  end
end

Question 7
How could you change the method name below so that the method name is more
clear and less repetitive?

You could change the name from `light_status` to something that better
indicates what state is being returned by the method and is less colliding with
the class name., i.e, `brightness_color_status` or just `status`

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def light_status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end

end
=end
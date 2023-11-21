=begin
Method Access Control enables the encapsulation of attributes and behaviors of
class instances in Ruby. There are three access modifiers for instance methods:
`public`, `private` and `protected`. These access modifiers restrict or allow
where an instance method can be used.

Access modifiers are methods that must be invoked within a class definition.
Any instance method below an access modifier call, with no arguments passed to
the modifier, will have that access status until another modifier in the class
is called to change the status of the rest of the following instance methods.

Public methods are the interface that classes and objects use to interact with
the rest of a program. By default, all instance methods are set to public.
Generally, a class should have as few public methods as possible. However,
public access of an instance method in Ruby is one of the main ways
collaborator objects are implemented in Ruby OOP.

#private methods used with methods along the method look up path?

Private methods can only be invoked within the scope of a public method being
called by the current object instance. Trying to call a private method directly
inside or outside of a class will generate a NoMethodError message. Keeping
methods private is useful in the management of sensitive information like
social security numbers, passwords and limiting the interface of objects.

Protected methods are an approach that melds `public` and `private`. Protected
methods can be invoked in a similar way private methods are invoked. This means
protected methods can't be directly invoked outside or inside of a class but
must be invoked by self or other within the scope of an instance method of the
same class. To invoke the protected method of another object of the same class
the other object must be passed into the instance method invoked by self; this
allows collaboration between instances of the same class. Protected methods are
useful for collaboration of same class objects where the attributes and
behaviors of the collaborating object shouldn't be public as well limiting the
interface of the collaborating objects.

```Ruby
class SocialSecurityPrivate
  private
  
  def initialize(n, s)
    @name = n
    @ssn = s
  end

  attr_accessor :name
  attr_reader :ssn

  def redacted_ssn
    ssn[-4..-1]
  end

  public :redacted_ssn, :name=
end

client_1889 = SocialSecurityPrivate.new("Jill", "123-456-7890")
puts client_1889.redacted_ssn
puts client_1889.name = "Bob"
puts client_1889.ssn #=> NoMethodError private

class AccountProtected
  protected

  attr_accessor :email_address, :name

  def initialize(n, e)
    @name = n
    @email_address = e
  end

  def duplicate_email?(other_client)
    other_client.email == email_address
  end

  def duplicate_name?(other_client)
    other_client.name == email_address
  end

  public

  def email_other_client(other_client)
    p "send to: #{other_client.email_address}"
  end

  def redacted_name
    "#{name[0]}****#{name[-1]}"
  end

  def redacted_email
    username = email_address.split("@")[0]
    domain = email_address.split("@")[-1]
    "#{username[0]}*****#{username[-1]}@#{domain}"
  end

  def duplicate_account?(other_client)
    duplicate_name?(other_client) && duplicate_email?(other_client)
  end
end

client_id_1234 = AccountProtected.new("Bert", "open_saysme19@hotmail.com")
client_id_7890 = AccountProtected.new("Ernie", "39th_street_fighter@yahoo.com")
puts client_id_1234.redacted_email
p client_id_1234.duplicate_account?(client_id_7890)
client_id_1234.email_other_client(client_id_7890)
client_id_1234.email #=> NoMethodError protected
```
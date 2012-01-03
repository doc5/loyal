class UserSession
  attr_accessor :email, :password, :remember_me, :errors, :user
  
  def initialize(options={})
    @email = options[:email]
    @password = options[:password]
    @remember_me = options[:remember_me]
  end
  
  def authenticate
    User.authenticate(email, password)    
  end
end
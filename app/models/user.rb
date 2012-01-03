
require 'digest/sha1'
class User < ActiveRecord::Base
  
  # Virtual attribute for the unencrypted password
  attr_accessor :password, :remember_me

  validates_presence_of :email
  validates_presence_of :password, :if => :password_required?
  validates_presence_of :password_confirmation, :if => :password_required?
  validates_length_of :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_length_of :email, :within => 3..100
  validates_uniqueness_of :email, :case_sensitive => false
  before_save :encrypt_password

  # Authenticates a user by their login name and unencrypted password. Returns the user or nil.
  def self.authenticate(email, password)
    u = find_by_email(email) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, password_salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

#  def remember_token?
#    remember_token_expires_at && Time.now.utc < remember_token_expires_at
#  end
#
#  # These create and unset the fields required for remembering users between browser closes
#  def remember_me
#    self.remember_token_expires_at = 2.weeks.from_now.utc
#    self.remember_token = encrypt("#{email}--#{remember_token_expires_at}")
#    save(false)
#  end
#
#  def forget_me
#    self.remember_token_expires_at = nil
#    self.remember_token = nil
#    save(false)
#  end

  protected
  # before filter
  def encrypt_password
    return if password.blank?
    self.password_salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
    self.crypted_password = encrypt(password)
  end
    
  def password_required?
    crypted_password.blank? || !password.blank?
  end
  
  
  
  
  #=> 角色相关
  # in models/user.rb
  def role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
  def super_admin?
    id == 1
  end
  def admin?
    super_admin? || role?(:admin)
  end
  def roles_to_s
    result = ""
    for role in roles
      result << "#{role.name.humanize};"
    end
    result
  end
end

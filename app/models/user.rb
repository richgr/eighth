class User < ActiveRecord::Base

  attr_accessible :name, :email

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true,
                   :length => 5..50

  validates :email, :presence => true,
                    :length => 4..140,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

end

class User < ActiveRecord::Base
  attr_accessible :company_data, :computer_name, :password, :username, :version

  validates_presence_of :company_data, :computer_name, :password, :username, :version, :message => "is required"
  validates :username, :password, length: { minimum: 3 }

end

class User < ActiveRecord::Base
  attr_accessible :company_data, :computer_name, :password, :username, :version

  validates_presence_of :company_data, :computer_name, :password, :username, :version, :message => "is required"
  validates_uniqueness_of :username
  validates :username, :password, length: { minimum: 3 }

  has_many :product_feed_items, dependent: :destroy

end

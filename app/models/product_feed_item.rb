class ProductFeedItem < ActiveRecord::Base
  attr_accessible :description, :inventory, :item_identifier, :name, :price, :user_id

  belongs_to :user
end

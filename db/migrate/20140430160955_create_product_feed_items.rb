class CreateProductFeedItems < ActiveRecord::Migration
  def change
    create_table :product_feed_items do |t|
      t.integer :user_id
      t.string :item_identifier
      t.string :name
      t.string :description
      t.integer :inventory
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end

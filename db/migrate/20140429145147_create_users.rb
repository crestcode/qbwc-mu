class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :computer_name
      t.string :company_data
      t.integer :version

      t.timestamps
    end
  end
end

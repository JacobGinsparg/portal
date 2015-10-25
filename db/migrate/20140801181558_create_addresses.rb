class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :email
      t.boolean :admin, default: false
      t.timestamps
    end
  end
end

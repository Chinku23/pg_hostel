class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :hostel, null: false, foreign_key: true
      t.string :room_type
      t.integer :capacity
      t.integer :price
      t.boolean :availability

      t.timestamps
    end
  end
end

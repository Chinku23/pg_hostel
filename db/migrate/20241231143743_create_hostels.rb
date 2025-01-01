class CreateHostels < ActiveRecord::Migration[7.0]
  def change
    create_table :hostels do |t|
      t.string :name
      t.text :address
      t.text :description

      t.timestamps
    end
  end
end

class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.text :line1
      t.text :line2
      t.text :city
      t.text :province
      t.text :code
      t.text :country
      t.string :addressable_type
      t.string :addressable_id

      t.timestamps
    end

    add_reference :members, :address, foreign_key: true
  end
end

class CreateCouriers < ActiveRecord::Migration[7.2]
  def change
    create_table :couriers do |t|
      t.string :subject
      t.string :to

      t.timestamps
    end
  end
end

class CreateConfigurations < ActiveRecord::Migration[7.2]
  def change
    create_table :configurations do |t|
      t.string :organization, null: false
      t.integer :membership_length, null: false
      t.string :smtp, null: false

      t.timestamps
    end
  end
end

class CreateHooks < ActiveRecord::Migration[7.2]
  def change
    create_table :hooks do |t|
      t.string :name
      t.string :trigger_id
      t.string :hookable_type
      t.integer :hookable_id

      t.timestamps
    end

    add_index :hooks, :trigger_id
  end
end

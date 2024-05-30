class CreateImprints < ActiveRecord::Migration[7.2]
  def change
    create_table :imprints do |t|
      t.string :base
      t.integer :count, default: 0
      t.datetime :coded_at
      t.string :imprintable_type
      t.string :imprintable_id

      t.timestamps
    end
  end
end

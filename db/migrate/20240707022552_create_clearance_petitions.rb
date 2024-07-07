class CreateClearancePetitions < ActiveRecord::Migration[7.2]
  def change
    create_table :clearance_petitions do |t|
      t.string :petitioner_id
      t.string :petitioner_type

      t.timestamps
    end

    add_column :configurations, :clearing, :boolean, default: false, null: false
  end
end

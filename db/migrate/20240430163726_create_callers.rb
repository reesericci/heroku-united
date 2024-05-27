class CreateCallers < ActiveRecord::Migration[7.2]
  def change
    create_table :callers do |t|
      t.string :url

      t.timestamps
    end
  end
end

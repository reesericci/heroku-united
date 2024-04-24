class CreateBroadcasts < ActiveRecord::Migration[7.2]
  def change
    create_table :broadcasts do |t|
      t.string :subject

      t.timestamps
    end
  end
end

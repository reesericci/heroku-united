class AddUsedToImprint < ActiveRecord::Migration[7.2]
  def change
    add_column :imprints, :used, :boolean, default: false
  end
end

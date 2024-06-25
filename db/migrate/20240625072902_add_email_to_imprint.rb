class AddEmailToImprint < ActiveRecord::Migration[7.2]
  def change
    add_column :keycode_imprints, :email, :boolean, default: true, null: false
  end
end

class AddPasswordToConfig < ActiveRecord::Migration[7.2]
  def change
    add_column :configurations, :password_digest, :string
  end
end

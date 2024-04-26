class AddEmailToConfig < ActiveRecord::Migration[7.2]
  def change
    add_column :configurations, :email, :string
  end
end

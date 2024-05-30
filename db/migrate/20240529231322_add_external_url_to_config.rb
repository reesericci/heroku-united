class AddExternalUrlToConfig < ActiveRecord::Migration[7.2]
  def change
    add_column :configurations, :external_url, :string
  end
end

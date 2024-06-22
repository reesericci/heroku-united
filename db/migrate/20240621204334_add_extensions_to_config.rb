class AddExtensionsToConfig < ActiveRecord::Migration[7.2]
  def change
    add_column :configurations, :extensions, :text
  end
end

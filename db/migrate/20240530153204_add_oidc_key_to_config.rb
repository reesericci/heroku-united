class AddOidcKeyToConfig < ActiveRecord::Migration[7.2]
  def change
    add_column :configurations, :oidc_key, :text
  end
end

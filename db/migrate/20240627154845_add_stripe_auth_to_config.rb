class AddStripeAuthToConfig < ActiveRecord::Migration[7.2]
  def change
    add_column :configurations, :stripe_publishable_key, :text
    add_column :configurations, :stripe_secret_key, :text
    add_column :configurations, :payable, :boolean, default: false, null: false
    add_column :configurations, :dues_amount_as_cents, :bigint
    add_column :configurations, :dues_currency, :string
  end
end

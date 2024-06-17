class AddExpiryAdvisedToMembers < ActiveRecord::Migration[7.2]
  def change
    add_column :members, :expiry_advised, :string
  end
end

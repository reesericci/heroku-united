class AddDeceasedToMembers < ActiveRecord::Migration[7.2]
  def change
    add_column :members, :deceased, :boolean, default: false, null: false
  end
end

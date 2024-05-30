class MemberLoginTime < ActiveRecord::Migration[7.2]
  def change
    add_column :members, :last_logged_in_at, :datetime
  end
end

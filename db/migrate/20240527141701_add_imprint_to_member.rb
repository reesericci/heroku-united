class AddImprintToMember < ActiveRecord::Migration[7.2]
  def change
    add_reference :members, :imprint, foreign_key: true
  end
end

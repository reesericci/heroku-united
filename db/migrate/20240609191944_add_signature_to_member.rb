class AddSignatureToMember < ActiveRecord::Migration[7.2]
  def change
    add_column :members, :signature, :text
  end
end

class CreateMembers < ActiveRecord::Migration[7.2]
  def change
    create_table :members,  primary_key: :username, id: false do |t|
      t.string :username, index: { unique: true }
      t.string :email, index: { unique: true }
      t.string :name
      t.string :pronouns
      t.text :auxillary
      t.datetime :expires_at
      t.boolean :banned, default: false

      t.timestamps
    end
  end
end

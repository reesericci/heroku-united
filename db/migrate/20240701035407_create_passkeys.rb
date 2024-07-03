class CreatePasskeys < ActiveRecord::Migration[7.2]
  def change
    create_table :passkeys, id: false do |t|
      t.text :id # standard:disable Rails/DangerousColumnNames
      t.string :name
      t.text :keyring_id
      t.text :public_key
      t.integer :sign_count

      t.timestamps
    end

    create_table :keyrings, id: false do |t|
      t.text :id # standard:disable Rails/DangerousColumnNames`
      t.string :type
      t.string :keyable_type
      t.string :keyable_id
      t.timestamps
    end

    add_index :keyrings, :id, unique: true
    add_index :passkeys, :id, unique: true
  end
end

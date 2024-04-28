class CreateApiKeys < ActiveRecord::Migration[7.2]
  def change
    create_table :api_keys, id: false, primary_key: :id do |t|
      t.string :id, null: false, index: {unique: true}
      t.string :password_digest
      t.string :name

      t.timestamps
    end
  end
end

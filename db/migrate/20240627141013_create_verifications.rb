class CreateVerifications < ActiveRecord::Migration[7.2]
  def change
    create_table :verifications do |t|
      t.belongs_to :verifiable, null: false, polymorphic: true, type: :string
      t.boolean :verified, null: false, default: true
      t.datetime :verified_at

      t.timestamps
    end
  end
end

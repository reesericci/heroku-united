class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.string :state
      t.string :stripe_id, null: false
      t.belongs_to :payee, null: false, polymorphic: true, type: :string

      t.timestamps
    end
  end
end

class CreateExtensions < ActiveRecord::Migration[7.2]
  def change
    create_table :extensions, primary_key: [:name, :extensible_type, :extensible_id] do |t|
      t.string :name
      t.references :extensible, polymorphic: true, type: :string
      t.text :content
      t.timestamps
    end

    remove_column :members, :auxillary, :text
  end
end

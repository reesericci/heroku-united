class ImprintableToKeycodeImprintor < ActiveRecord::Migration[7.2]
  def change
    rename_table :imprints, :keycode_imprints
    rename_column :keycode_imprints, :imprintable_type, :imprintor_type
    rename_column :keycode_imprints, :imprintable_id, :imprintor_id
    rename_column :members, :imprint_id, :keycode_imprint_id
  end
end

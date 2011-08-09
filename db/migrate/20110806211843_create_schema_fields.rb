class CreateSchemaFields < ActiveRecord::Migration
  def self.up
    create_table :schema_fields do |t|
      t.integer :schema_id
      t.string :key
      t.string :short_name
      t.text :description
      t.text :instructions
      t.string :type
      t.integer :position
      t.boolean :default_view
      t.text :render_value_func
      t.text :render_form_func
      t.text :funcs
      t.timestamps
    end
  end

  def self.down
    drop_table :schema_fields
  end
end

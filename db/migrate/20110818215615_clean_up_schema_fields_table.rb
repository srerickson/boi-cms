class CleanUpSchemaFieldsTable < ActiveRecord::Migration
  def self.up
    remove_column :schema_fields, :funcs
    remove_column :schema_fields, :default_view 
  end

  def self.down
    add_column :schema_fields, :funcs, :text
    add_column :schema_fields, :default_view, :text
  end
end

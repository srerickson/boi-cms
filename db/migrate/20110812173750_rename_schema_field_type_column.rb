class RenameSchemaFieldTypeColumn < ActiveRecord::Migration
  def self.up
    remove_column :schema_fields, :type
    add_column :schema_fields, :form_type, :string
  end

  def self.down
    remove_column :schema_fields, :form_type
    add_column :schema_fields, :type, :string
  end
end

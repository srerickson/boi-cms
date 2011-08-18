class AddSchemaFieldGroups < ActiveRecord::Migration
  def self.up
    add_column :schema_fields, :group_name, :string
  end

  def self.down
    remove_column :schema_fields, :group_name
  end
end

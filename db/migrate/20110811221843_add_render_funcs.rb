class AddRenderFuncs < ActiveRecord::Migration
  def self.up
    add_column :schema_fields, :render_list_value_func, :text
  end

  def self.down
    remove_column :schema_fields, :render_list_value_func
  end
end

class AddFieldDescriptions < ActiveRecord::Migration
  def self.up
    add_column :schemas, :field_descriptions, :text
  end

  def self.down
    remove_column :schemas, :field_descriptions
  end
end

class AddQueryViewOptions < ActiveRecord::Migration
  def self.up
    add_column :queries, :user_id, :integer
    add_column :queries, :view_fields, :text
    add_column :queries, :hide_fields, :text
    add_column :queries, :pagination, :integer
    add_column :queries, :schema_id, :integer
    #create_table :query_views do |t|
    #  t.integer :user_id
    #  t.integer :schema_id
    #  t.text :selected_fields
    #  t.text :available_fields
    #  t.integer :pagination
    #  t.string :order_by
    #  t.timestamps
    #end
  end

  def self.down
    remove_column :queries, :user_id
    remove_column :queries, :view_fields
    remove_column :queries, :hide_fields
    remove_column :queries, :pagination
    remove_column :queries, :schema_id
  end

end

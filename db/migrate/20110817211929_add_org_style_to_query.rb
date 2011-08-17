class AddOrgStyleToQuery < ActiveRecord::Migration
  def self.up
    add_column :queries, :org_styles, :text
  end

  def self.down
    remove_column :queries, :org_styles
  end
end

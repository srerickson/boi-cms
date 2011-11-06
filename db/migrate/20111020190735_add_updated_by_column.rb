class AddUpdatedByColumn < ActiveRecord::Migration
  def self.up
    add_column :birds, :updated_by_id, :integer
  end

  def self.down
    remove_column :birds, :updated_by_id
  end
end

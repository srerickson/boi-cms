class AddUpdatedByColumn < ActiveRecord::Migration
  def self.up
    add_column :birds, :updated_by, :integer
  end

  def self.down
    remove_column :birds, :updated_by
  end
end

class AddSummaryColumn < ActiveRecord::Migration
  def self.up
    add_column :birds, :summary, :text
  end

  def self.down
    remove_column :birds, :summary
  end
end

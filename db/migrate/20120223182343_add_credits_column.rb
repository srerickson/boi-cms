class AddCreditsColumn < ActiveRecord::Migration
  def self.up
    add_column :birds, :birder_credits, :text
  end

  def self.down
    remove_column :birds, :birder_credits
  end
end

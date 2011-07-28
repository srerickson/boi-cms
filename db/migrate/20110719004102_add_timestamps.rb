class AddTimestamps < ActiveRecord::Migration
  CHANGE = [:birds, :birders, :habitats, :genus_types, :org_styles, :comments]

  def self.up
    CHANGE.each do |t|
      add_timestamps(t)
    end
  end

  def self.down
    CHANGE.each do |t|
      remove_timestamps(t)
    end
  end
end

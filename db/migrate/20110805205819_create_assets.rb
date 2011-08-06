class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :asset_file_name
      t.string :asset_content_type
      t.integer :asset_file_size
      t.datetime :asset_updated_at

      t.integer :attached_to_id
      t.string :attached_to_type
      t.string :role

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end

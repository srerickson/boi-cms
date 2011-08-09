class CreateSchemas < ActiveRecord::Migration
  def self.up
    create_table :schemas do |t|

      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :schemas
  end
end

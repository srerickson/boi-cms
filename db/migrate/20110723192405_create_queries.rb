class CreateQueries < ActiveRecord::Migration
  def self.up
    create_table :queries do |t|
      t.text :habitats
      t.text :genus_types
      t.text :ids
      t.text :text_search
      t.text :fse_org_styles
      t.text :op_org_styles

      t.timestamps
    end
  end

  def self.down
    drop_table :queries
  end
end

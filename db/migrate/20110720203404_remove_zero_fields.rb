class RemoveZeroFields < ActiveRecord::Migration
  def self.up
    Bird.all.each do |b|
      if b.genus_type_id == 0
        b.genus_type_id = nil
      end
      if b.habitat_id == 0
        b.habitat_id = nil
      end
      if b.fse_org_style_id == 0
        b.fse_org_style_id = nil
      end
      if b.op_org_style_id == 0
        b.op_org_style_id = nil
      end
      b.save
    end
  end

  def self.down
  end
end

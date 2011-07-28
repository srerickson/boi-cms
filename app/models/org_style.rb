class OrgStyle < ActiveRecord::Base

  has_many :fse_birds, :class_name => "Bird", :foreign_key => "fse_org_style_id"
  has_many :op_birds, :class_name => "Bird", :foreign_key => "op_org_style_id"

end

class Bird < ActiveRecord::Base

  belongs_to :genus_type
  belongs_to :habitat
  belongs_to :fse_org_style, :class_name => "OrgStyle", :foreign_key => "fse_org_style_id"
  belongs_to :op_org_style, :class_name => "OrgStyle", :foreign_key => "op_org_style_id"

  validates_presence_of :name


  define_index do 
    indexes :name, :sortable => true
    indexes habitat(:name), :as => :habitat, :sortable => true
    indexes genus_type(:name), :as => :genus, :sortable => true
  end  

end

class Schema < ActiveRecord::Base
  has_many :schema_fields, 
    :order => "position ASC", 
    :dependent => :destroy
  accepts_nested_attributes_for :schema_fields, :allow_destroy => true
end

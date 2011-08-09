class Schema < ActiveRecord::Base
  has_many :schema_fields, 
    :order => "position ASC", 
    :dependent => :destroy
  accepts_nested_attributes_for :schema_fields, :allow_destroy => true

  def field_name_with_key(key)
    f = schema_fields.where(:key => key).first
    return nil if f.nil?
    return f.short_name
  end

end

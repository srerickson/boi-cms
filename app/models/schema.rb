class Schema < ActiveRecord::Base

  validate :json_format

  has_many :schema_fields, 
    :order => "position ASC", 
    :dependent => :destroy
  accepts_nested_attributes_for :schema_fields, :allow_destroy => true

  def field_name_with_key(key)
    f = field_search_by_key(self.fields, key)
    return nil if f.nil?
    return f["short_name"]
  end

  def field_description_with_key(key)
    f = field_search_by_key(self.fields, key)
    return nil if f.nil?
    return f["short_name"]
  end

  def fields
    return ActiveSupport::JSON.decode(field_descriptions)
  end

  def data_fields
    find_leaf_fields(self.fields)
  end

  def sections
    self.fields
  end



protected

  def field_search_by_key(field_list, key)
    field_list.each do |f|
      if f.has_key?("key") and f["key"] == key
        return f
      elsif f.has_key?("fields")
        child_search = field_search_by_key(f["fields"], key)
        return child_search unless child_search.nil?
      end
    end
    return nil;
  end

  def find_leaf_fields(field_list)
    ret = []
    field_list.each do |f|
      if f.has_key?("key") and (f["fields"].nil? or f["fields"].empty?) 
        ret << f
      elsif f.has_key?("fields")
        ret.concat(find_leaf_fields(f["fields"]))
      end
    end
    return ret;
  end


  def json_format
    begin
      ActiveSupport::JSON.decode(field_descriptions)
    rescue
      errors[:base] << "not in json format"
    end
  end

end

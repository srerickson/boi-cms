require 'yaml'

class SchemaField < ActiveRecord::Base
  belongs_to :schema
  #serialize :funcs, Hash
  
  def self.field_types
    ["string","text","integer","built-in"]
  end

  def render_value(obj)
    unless funcs.nil?
      f = YAML::load(funcs)
      if f and f.has_key?("ruby_get_value") and not f["ruby_get_value"].nil?
        return f["ruby_get_value"];
      end
    end
    return obj.attributes[key].nil? ? "" : obj.attributes[key].to_s;
  end

  def first_in_group?
    prev_field = SchemaField.where(:position => self.position-1).first
    if prev_field.nil? or prev_field.group_name != self.group_name
      return true
    else
      return false;
    end
  end

  def last_in_group?
    next_field = SchemaField.where(:position => self.position+1).first
    if next_field.nil? or next_field.group_name != self.group_name
      return true
    else
      return false;
    end
  end

  def self.form_type_options
    return ["String","Text","Other"]
  end

end

require 'yaml'

class SchemaField < ActiveRecord::Base
  belongs_to :schema
  
  def self.field_types
    ["string","text","integer","built-in"]
  end

  def default_value_func(obj)
    if self.form_type == "Text"
      return "<%= simple_format(obj.#{key}) %>"
    else
      return obj.attributes[self.key]
    end
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
    return ["String","Text","Other","Built-In"]
  end

end

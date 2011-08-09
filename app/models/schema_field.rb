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


end

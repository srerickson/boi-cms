#module ActiveRecord;module Acts;end;end;
#module ActiveRecord::Acts::SchemaInstance
module SchemaInstance

  def self.included(base)
    #base.extend(ClassMethods)
    base.send :extend, ClassMethods
  end

  module ClassMethods

    def acts_as_schema_instance(schema_name)

      #The Model Class has a reference to its schema
      cattr_accessor :schema
      self.schema = Schema.find_by_name(schema_name)

      send :include, InstanceMethods
    end

  end

  module InstanceMethods
    def value_of_key(key)
      sf = self.class.schema.schema_fields.where(:key=>key).first
      unless sf.render_value_func.nil? or sf.render_value_func = ""
        return sf.render_value_func
      else
        return self.attributes[key]
      end
    end
  end

end

ActiveRecord::Base.send :include, SchemaInstance

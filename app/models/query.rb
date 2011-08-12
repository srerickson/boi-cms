class Query < ActiveRecord::Base

  serialize :habitats, Hash
  serialize :genus_types, Hash
  serialize :ids, Array
  serialize :text_search, Hash
  serialize :fse_org_styles, Hash
  serialize :op_org_styles, Hash

  serialize :view_fields, Array
  serialize :hide_fields, Array

  attr_accessor :view_fields_list, :hide_fields_list # for form access

  belongs_to :user
  belongs_to :schema

  after_initialize :defaults
  
  def defaults
    bird_schema = Schema.find_by_name("bird")
    self.schema ||= bird_schema
    self.habitats ||= {}
    self.genus_types ||= {}
    self.ids ||= []
    self.text_search ||= {}
    self.text_search["all"] ||= nil
    self.fse_org_styles ||= {}
    self.op_org_styles ||= {}
    self.view_fields ||= bird_schema.schema_fields.where(:key => ["name","logo","genus_type_id","habitat_id"]).map{|f| f.key }
    self.hide_fields = self.schema.schema_fields.map{|f| f.key }.delete_if{|f| self.view_fields.include?(f)}
    self.order_by ||= "name"
  end

  def view_fields_list
    self.view_fields.join(",")
  end
  def view_fields_list=(string)
    self.view_fields = string.split(",")
  end
  def hide_fields_list
    self.hide_fields.join(",")
  end
  def hide_fields_list=(string)
    self.hide_fields = string.split(",")
  end
  
  def results
    search_options = {}

    ts = nil
    unless text_search.nil? or text_search[:all].nil? or text_search[:all] == ""
      ts = text_search[:all]
    end

    unless order_by == "" or order_by.nil?
      search_options[:order] = order_by.to_sym
    end

    withs = {}
    unless habitats.nil? or habitats.empty?
      withs[:habitat_id] = []
      habitats.keys.each do |k|
        withs[:habitat_id] << k
      end
    end

    unless genus_types.nil? or genus_types.empty?
      withs[:genus_type_id] = []
      genus_types.keys.each do |k|
        withs[:genus_type_id] << k
      end
    end

    search_options[:with] = withs
    search_options[:per_page] = 99999 

    if ts.blank?
      res = Bird.where(withs).order(self.order_by)
    else
      res = Bird.search(ts, search_options)
    end
    res.delete_if { |bird| bird.nil? }    

    return res
  end

  def filter_options_count
    self.genus_types.keys.size + self.habitats.keys.size + self.fse_org_styles.keys.size + self.op_org_styles.keys.size
  end

  def self.search_sort_options(selected)
    "<option value='' #{ selected == nil ? "selected='yes'" : ""}>Search Relevance</option>
    <option value='name' #{ selected == 'name' ? "selected='yes'" : ""}>Name</option>
    <option value='genus_type' #{ selected == 'genus_type' ? "selected='yes'" : ""}>Classification</option>
    <option value='habitat' #{ selected == 'habitat' ? "selected='yes'" : ""}>Habitat</option>
    <option value='fse_org_style' #{ selected == 'fse_org_style' ? "selected='yes'" : ""} >FSE Org. Style</option>
    <option value='op_org_style' #{ selected == 'op_org_style' ? "selected='yes'" : ""}>OP Org. Style</option>"
  end


end

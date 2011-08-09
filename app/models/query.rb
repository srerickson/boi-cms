class Query < ActiveRecord::Base

  serialize :habitats, Hash
  serialize :genus_types, Hash
  serialize :ids, Array
  serialize :text_search, Hash
  serialize :fse_org_styles, Hash
  serialize :op_org_styles, Hash

  serialize :view_fields, Array
  serialize :hide_fields, Array

  belongs_to :user
  belongs_to :schema


  def self.default_query
    bird_schema = Schema.find_by_name("bird")
    ret = self.new(:order_by => "name",
      :view_fields => bird_schema.schema_fields.where(:default_view => true).map{|f| f.key },
      :hide_fields => bird_schema.schema_fields.where(:default_view => false).map{|f| f.key })
    ret.setup_dicts
    return ret
  end
  

  def setup_dicts()
    self.habitats ||= {}
    self.genus_types ||= {}
    self.ids ||= []
    self.text_search ||= {}
    self.text_search["all"] ||= nil
    self.fse_org_styles ||= {}
    self.op_org_styles ||= {}
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

    res = Bird.search(ts, search_options)
    res.delete_if { |bird| bird.nil? }    

    return res
  end

  def self.search_sort_options(selected)
    "<option value=''>Search Relevance</option>
    <option value='name' #{ selected == 'name' ? "selected='yes'" : ""}>Name</option>
    <option value='genus_type' #{ selected == 'genus_type' ? "selected='yes'" : ""}>Classification</option>
    <option value='habitat' #{ selected == 'habitat' ? "selected='yes'" : ""}>Habitat</option>
    <option value='fse_org_style' #{ selected == 'fse_org_style' ? "selected='yes'" : ""} >FSE Org. Style</option>
    <option value='op_org_style' #{ selected == 'op_org_style' ? "selected='yes'" : ""}>OP Org. Style</option>"
  end


end

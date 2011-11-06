class Query < ActiveRecord::Base

  serialize :habitats, Hash
  serialize :genus_types, Hash
  serialize :ids, Array
  serialize :text_search, Hash
  serialize :fse_org_styles, Hash
  serialize :op_org_styles, Hash
  serialize :org_styles, Hash

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
    self.org_styles ||= {}
    self.view_fields ||= ["logo","name","genus_type_id","habitat_id"]
    self.hide_fields = self.schema.data_fields.map{|f| f["key"] }.delete_if{|f| self.view_fields.include?(f)}
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
    unless habitats.blank?
      withs[:habitat_id] = []
      habitats.keys.each do |k|
        withs[:habitat_id] << k
      end
    end

    unless genus_types.blank?
      withs[:genus_type_id] = []
      genus_types.keys.each do |k|
        withs[:genus_type_id] << k
      end
    end

    # here we search org_styles of FSE *or* OP
    # http://freelancing-god.github.com/ts/en/common_issues.html#or_attributes
    unless org_styles.blank?
      or_list = org_styles.keys.map{|k| "fse_org_style_id = #{k} OR op_org_style_id = #{k}" }.join(" OR ")
      withs['org_styles'] = 1;
      search_options[:sphinx_select] = "*, IF(#{or_list},1,0) as org_styles"
      puts search_options[:sphinx_select]
    end

    search_options[:with] = withs
    search_options[:per_page] = 99999 

    if ts.blank? and org_styles.blank? and order_by == "name"
      res = Bird.where(withs).order(self.order_by)
    else
      res = Bird.search(ts, search_options)
    end
    res.delete_if { |bird| bird.nil? }    

    return res
  end

  def filter_options_count
    self.genus_types.keys.size + self.habitats.keys.size + self.org_styles.keys.size
  end

  def to_phrase
    phrase_parts = []
    unless genus_types.blank?
      phrase_parts << "<span class='qp_genus_types'>with Classification: #{genus_types.keys.map{|g| "#{GenusType.find(g).name[0..18]}" }.join(" OR ")}</span>"
    end
    unless habitats.blank?
      phrase_parts << "<span class='qp_habitats'>with Habitat: #{habitats.keys.map{|g| "#{Habitat.find(g).name[0..18]}" }.join(" OR ")}</span>"
    end
    unless org_styles.blank?
      phrase_parts << "<span class='qp_org_style'>with Organization Style: #{org_styles.keys.map{|g| "#{OrgStyle.find(g).name[0..18]}" }.join(" OR ")}</span>"
    end
    return "All Birds #{phrase_parts.join(" AND ")}"
  end

  def self.search_sort_options(selected)
    "<option value='' #{ selected == nil ? "selected='yes'" : ""}>Text Search Relevance</option>
    <option value='name' #{ selected == 'name' ? "selected='yes'" : ""}>Name</option>
    <option value='genus_type' #{ selected == 'genus_type' ? "selected='yes'" : ""}>Classification</option>
    <option value='habitat' #{ selected == 'habitat' ? "selected='yes'" : ""}>Habitat</option>
    <option value='fse_org_style' #{ selected == 'fse_org_style' ? "selected='yes'" : ""} >FSE Org. Style</option>
    <option value='op_org_style' #{ selected == 'op_org_style' ? "selected='yes'" : ""}>OP Org. Style</option>
    <option value='created_at' #{ selected == 'created_at' ? "selected='yes'" : ""}>Record Creation Date</option>
    <option value='updated_at' #{ selected == 'updated_at' ? "selected='yes'" : ""}>Record Update Date</option>"
  end


end

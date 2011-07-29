class Query < ActiveRecord::Base

  serialize :habitats, Hash
  serialize :genus_types, Hash
  serialize :ids, Array
  serialize :text_search, Hash
  serialize :fse_org_styles, Hash
  serialize :op_org_styles, Hash
  

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




end

class Query < ActiveRecord::Base

  serialize :habitats, Array
  serialize :genus_types, Array
  serialize :ids, Array
  serialize :text_search, Hash
  serialize :fse_org_styles, Array
  serialize :op_org_styles, Array

end

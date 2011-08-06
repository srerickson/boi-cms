class Bird < ActiveRecord::Base

  belongs_to :genus_type
  belongs_to :habitat
  belongs_to :fse_org_style, :class_name => "OrgStyle", :foreign_key => "fse_org_style_id"
  belongs_to :op_org_style, :class_name => "OrgStyle", :foreign_key => "op_org_style_id"

  has_one :logo, 
    :class_name => "Asset", 
    :as => "attached_to", 
    :conditions => {:role => "logo"},
    :dependent => :destroy    

  accepts_nested_attributes_for :logo, :allow_destroy => true

  attr_accessor :uploaded_logo #upload to this attr for replacing logos
  def uploaded_logo=(img)
    logo.destroy unless logo.nil?
    f = Asset.new(:asset => img, :attached_to => self, :role => "logo")
    f.save
  end
  


  validates_presence_of :name

  define_index do 
    indexes :name, :sortable => true
    indexes habitat(:name), :as => :habitat, :sortable => true
    indexes genus_type(:name), :as => :genus_type, :sortable => true
    indexes foritself
    indexes brand
    indexes fse_name
    indexes fse_org_style(:name), :as => :fse_org_style, :sortable => true
    indexes fse_owner_founder
    indexes fse_significant_member
    indexes fse_mission_statement
    indexes op_name
    indexes op_org_style(:name), :as => :op_org_style, :sortable => true
    indexes op_vip_founders
    indexes op_typical_member
    indexes formation
    indexes history
    indexes lifespan
    indexes resource
    indexes availability
    indexes participation
    indexes tasks
    indexes modularity
    indexes granularity
    indexes metrics
    indexes alliances
    indexes clients 
    indexes sponsors
    indexes elites
    
    has habitat_id, :facet => true
    has genus_type_id, :facet => true
    has fse_org_style_id, :facet => true
    has op_org_style_id, :facet => true
    has created_at
    has updated_at
  end  


  def self.search_sort_options
    "<option value=''>Search Relevance</option>
    <option value='name'>Name</option>
    <option value='genus_type'>Classification</option>
    <option value='habitat'>Habitat</option>
    <option value='fse_org_style'>FSE Org. Style</option>
    <option value='op_org_style'>OP Org. Style</option>"
  end

  def self.default_bird_fields_order()
    return [
      "name",
      "url",
      "logo",
      "genus_type_id",
      "habitat_id",
      "foritself",
      "brand",
      "fse_name",
      "fse_org_style_id",
      "fse_owner_founder",
      "fse_significant_member",
      "fse_mission_statement",
      "op_name",
      "op_org_style_id",
      "op_vip_founders",
      "op_typical_member",
      "formation",
      "history",
      "lifespan",
      "resource",
      "availability",
      "participation",
      "tasks",
      "modularity",
      "granularity",
      "metrics",
      "alliances",
      "clients",
      "sponsors",
      "elites",
    ]
  end


  def self.default_bird_field_names(key=nil)
    vals = {
      "name" => ["Name","Project Name"],
      "url" => ["URL", "Project URL"],
      "logo" => ["Logo","Project's Logo (.png, .jpg, .gif)"],
      "genus_type_id" => ["Classification", "Classification"],
      "habitat_id" => ["Habitat", "Habitat"],
      "foritself" => ["For Itself?", "Is the project in question aware of itself as an entity? Or is it identified by a second order observation of people, behavior?"],
      "brand" => ["Brand","Describe how the brand / logo / visual identity is positioned."],
      "fse_name" => ["FSE Name","What is the name of the formally organized or legally recognized entity (FSE)? Note how this differs from the name applied to the organized public or project (e.g. Linux / Linux foundation; Wikipedia, Wikimedia)?"],
      "fse_org_style_id" => ["FSE Org. Style","FSE Organizational Style"],
      "fse_owner_founder" => ["FSE Founders / Owners", "FSE Founders / Owners"],
      "fse_significant_member" => ["FSE Significant Members","FSE Significant Members"],
      "fse_mission_statement" => ["FSE Mission Statement","FSE Mission Statement"],
      "op_name" => ["OP Name","What is the name of the organized public (OP)? Is it different from that of the formal organization? (E.g. Linux / Linux Foundation)?"],
      "op_org_style_id" => ["OP Org. Style", "OP Organizational Style"],
      "op_vip_founders" => ["OP Founders/VIPs","OP Founders / VIP members"],
      "op_typical_member" => ["OP Typical Member","OP Typical Member"],
      "formation" => ["Formation","How did the entity form? From OP to FSE or the opposite?"],
      "history" => ["Project History","Historicize the entity. Give a brief description of the stages it has been through from founding to current form"],
      "lifespan" => ["Lifespan","Does the project still exist, is it endangered, extinct? Has it been outcompeted by similar entities? What were the causes of its death?"],
      "resource" => ["Resource","What is the resource provided? Who is it provided to (OP, FSE or beyond?), on whose behalf is it provided?"],
      "availability" => ["Availability","What is the Availability of the resource? Is it licensed? Sold? what are the Terms of Service?"],
      "participation" => ["Participation","Who participates in the setting or changing of the goals? FSE, OP, Both, Neither?"],
      "tasks" => ["Tasks","Is there a clear statement of what the project does? Are tasks clearly defined? What constitutes participation and how does one know if one is done or not? Who gets to participate?"],
      "modularity" => ["Task Modularity","What is the level of investment necessary for the task (i.e. how hard is any given task to accomplish?)"],
      "granularity" => ["Task Granularity","What is the Granularity of the Tasks?"],
      "metrics" => ["Task Metrics", "How are tasks measured? What constitutes completion of a task?"],
      "alliances" => ["Alliances","Describe partnerships (mutual goals or compatibilities) and/or alliances (membership in a larger network)"],
      "clients" => ["Project Clientes","Describe the project clients (on whose behalf does the entity provide services)?"],
      "sponsors" => ["Project Sponsors","Describe the project sponsors, i.e. entities that either directly fund it (sponsors, owners, acquirers)?"],
      "elites" => ["Elites","Describe those people who have special forms of access to an entity based on their authority? Charismatic authority, legitimate authority, regulatory authority, political authority, etc?"]
    }
    if key 
      return vals[key]
    else
      return vals
    end
  end


end

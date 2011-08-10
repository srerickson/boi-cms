

namespace :boi do

  desc "Create Bird Schema"
  task :create_bird_schema => :environment do


    unless Schema.where(:name => "bird").first.nil?
      puts "Bird Schema Exists -- Exiting\n"
      exit
    end

    bird_schema = Schema.create(:name => "bird")

    bird_schema.schema_fields.create([
     {:short_name=>"Name",
      :position=>1,
      :key=>"name",
      :description=>"Project Name",
      :default_view => true},
     {:short_name=>"URL",
      :position=>2, 
      :key=>"url", 
      :description=>"Project URL",
      :default_view => true},
     {:short_name=>"Logo",
      :position=>3,
      :key=>"logo",
      :description=>"Project's Logo (.png, .jpg, .gif)",
      :default_view => true},
     {:short_name=>"Classification",
      :position=>4,
      :key=>"genus_type_id",
      :description=>"Classification",
      :default_view => true},
     {:short_name=>"Habitat",
      :position=>5,
      :key=>"habitat_id",
      :description=>"Habitat",
      :default_view => true},
     {:short_name=>"For Itself?",
      :position=>6,
      :key=>"foritself",
      :description=>
       "Is the project in question aware of itself as an entity? Or is it identified by a second order observation of people, behavior?"},
     {:short_name=>"Brand",
      :position=>7,
      :key=>"brand",
      :description=>
       "Describe how the brand / logo / visual identity is positioned."},
     {:short_name=>"FSE Name",
      :position=>8,
      :key=>"fse_name",
      :description=>
       "What is the name of the formally organized or legally recognized entity (FSE)? Note how this differs from the name applied to the organized public or project (e.g. Linux / Linux foundation; Wikipedia, Wikimedia)?",
      :default_view => true},
     {:short_name=>"FSE Org. Style",
      :position=>9,
      :key=>"fse_org_style_id",
      :description=>"FSE Organizational Style",
      :default_view => true},
     {:short_name=>"FSE Founders / Owners",
      :position=>10,
      :key=>"fse_owner_founder",
      :description=>"FSE Founders / Owners"},
     {:short_name=>"FSE Significant Members",
      :position=>11,
      :key=>"fse_significant_member",
      :description=>"FSE Significant Members"},
     {:short_name=>"FSE Mission Statement",
      :position=>12,
      :key=>"fse_mission_statement",
      :description=>"FSE Mission Statement"},
     {:short_name=>"OP Name",
      :position=>13,
      :key=>"op_name",
      :description=>
       "What is the name of the organized public (OP)? Is it different from that of the formal organization? (E.g. Linux / Linux Foundation)?",
      :default_view => true},
     {:short_name=>"OP Org. Style",
      :position=>14,
      :key=>"op_org_style_id",
      :description=>"OP Organizational Style",
      :default_view => true},
     {:short_name=>"OP Founders/VIPs",
      :position=>15,
      :key=>"op_vip_founders",
      :description=>"OP Founders / VIP members"},
     {:short_name=>"OP Typical Member",
      :position=>16,
      :key=>"op_typical_member",
      :description=>"OP Typical Member"},
     {:short_name=>"Formation",
      :position=>17,
      :key=>"formation",
      :description=>"How did the entity form? From OP to FSE or the opposite?"},
     {:short_name=>"Project History",
      :position=>18,
      :key=>"history",
      :description=>
       "Historicize the entity. Give a brief description of the stages it has been through from founding to current form"},
     {:short_name=>"Lifespan",
      :position=>19,
      :key=>"lifespan",
      :description=>
       "Does the project still exist, is it endangered, extinct? Has it been outcompeted by similar entities? What were the causes of its death?"},
     {:short_name=>"Resource",
      :position=>20,
      :key=>"resource",
      :description=>
       "What is the resource provided? Who is it provided to (OP, FSE or beyond?), on whose behalf is it provided?"},
     {:short_name=>"Availability",
      :position=>21,
      :key=>"availability",
      :description=>
       "What is the Availability of the resource? Is it licensed? Sold? what are the Terms of Service?"},
     {:short_name=>"Participation",
      :position=>22,
      :key=>"participation",
      :description=>
       "Who participates in the setting or changing of the goals? FSE, OP, Both, Neither?"},
     {:short_name=>"Tasks",
      :position=>23,
      :key=>"tasks",
      :description=>
       "Is there a clear statement of what the project does? Are tasks clearly defined? What constitutes participation and how does one know if one is done or not? Who gets to participate?"},
     {:short_name=>"Task Modularity",
      :position=>24,
      :key=>"modularity",
      :description=>
       "What is the level of investment necessary for the task (i.e. how hard is any given task to accomplish?)"},
     {:short_name=>"Task Granularity",
      :position=>25,
      :key=>"granularity",
      :description=>"What is the Granularity of the Tasks?"},
     {:short_name=>"Task Metrics",
      :position=>26,
      :key=>"metrics",
      :description=>
       "How are tasks measured? What constitutes completion of a task?"},
     {:short_name=>"Alliances",
      :position=>27,
      :key=>"alliances",
      :description=>
       "Describe partnerships (mutual goals or compatibilities) and/or alliances (membership in a larger network)"},
     {:short_name=>"Project Clientes",
      :position=>28,
      :key=>"clients",
      :description=>
       "Describe the project clients (on whose behalf does the entity provide services)?"},
     {:short_name=>"Project Sponsors",
      :position=>29,
      :key=>"sponsors",
      :description=>
       "Describe the project sponsors, i.e. entities that either directly fund it (sponsors, owners, acquirers)?"},
     {:short_name=>"Elites",
      :position=>30,
      :key=>"elites",
      :description=>
       "Describe those people who have special forms of access to an entity based on their authority? Charismatic authority, legitimate authority, regulatory authority, political authority, etc?"}])
    bird_schema.schema_fields.each{|f| f.default_view = false unless f.default_view == true;}
    bird_schema.save 

  end

  desc "Drop Bird Schema"
  task :destroy_bird_schema => :environment do 
    bird_schema = Schema.where(:name => "bird").first 
    if bird_schema.nil?
      puts "Bird Schema Doesn't Exist -- exiting"
      exit
    else
      bird_schema.destroy
      puts "Destroyed Bird Schema"
    end
  end

  #end

end

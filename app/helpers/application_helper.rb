module ApplicationHelper


  # For dynamic "nested model forms"
  # See http://railscasts.com/episodes/197-nested-model-form-part-2
  #
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      # render(association.to_s.singularize + "_fields", :f => builder)
      render("#{association.to_s}/nested_form", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end


  def sanitize_for_view(val)
    if val.nil? or val == ""
      return raw('&nbsp;')
    else 
      return val.to_s
    end
  end



  def query_to_phrase(query)
    phrase_parts = []
    unless query.genus_types.blank?
      phrase_parts << <<-END_PHRASE_PART
        <span class='qp_genus_types'>with Classification: #{
          query.genus_types.keys.map do |k|
            g = GenusType.find(k);
            link_to( truncate(g.name), "#", {:title => g.description, :onclick=>"return false;"} )
          end.join(" or ")}
        </span> 
      END_PHRASE_PART
    end
    unless query.habitats.blank?
      phrase_parts << <<-END_PHRASE_PART
        <span class='qp_habitats'>with Habitat: #{
          query.habitats.keys.map do |k|
            h = Habitat.find(k);
            link_to( truncate(h.name), "#", {:title => h.description, :onclick=>"return false;"} )
          end.join(" or ")}
        </span> 
      END_PHRASE_PART

    end
    unless query.org_styles.blank?
      phrase_parts << <<-END_PHRASE_PART
        <span class='qp_org_styles'>with Organization Style: #{
          query.org_styles.keys.map do |k|
            os = OrgStyle.find(k);
            link_to( truncate(os.name), "#", {:title => os.description, :onclick=>"return false;"} )
          end.join(" or ")}
        </span> 
      END_PHRASE_PART
    end
    unless query.text_search["all"].blank?
      phrase_parts << "containing text: \"#{query.text_search["all"]}\""
    end

    return "Listing all birds #{phrase_parts.join(" AND ")}"
  end


  def last_saved(obj)
    
  end


end

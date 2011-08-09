// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



$(document).ready(function(){

  $('#search_form').bind("ajax:success", function(evt, data, status, xhr){
    $('#search_results').html(xhr.responseText)
  })


  $('.submittable').live('change', function() {
    $(this).parents('form:first').submit();
  });
  $('.live_search').live('keyup', function() {
    $(this).parents('form:first').submit();
  });

})



/**
* For dynamic "nested model forms"
* See ApplicationHelper#link_to_add_fields.
*/
function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".attributes").hide();
}
function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  //$(link).parent().before(content.replace(regexp, new_id));
  $("#"+association).append(content.replace(regexp, new_id))
  update_list_positions("#"+association+" li") 
}


function update_list_positions(select) {
  $(select).each(function(){
    $(this).find("input.field_position").attr("value",$(select).index(this)+1)
  })
}

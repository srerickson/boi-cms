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


  $(".dialog").dialog({
      autoOpen: false,
  });

})


function set_bird_form_bindings(){
  $('form.new_bird, form.edit_bird').bind('ajax:success', function(evt,dat,stat,xhr){
    $("div.bird_form").html(xhr.responseText);
  });

  $('form.new_bird, form.edit_bird').bind('ajax:before', function(){
    $("div.edit_saved_status").html('<img src="/images/spinner.gif" />')
  });
  $('form.new_bird :input, form.edit_bird :input').keypress(function(){
    //$('div.edit_saved_status .changes').show()
  })
  setup_uploadify()
}


function save_and_redirect($form, url){
  $('form.new_bird, form.edit_bird').bind('ajax:success', function(evt,dat,stat,xhr){
    window.location = url;
  });
  $form.submit();
}


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

function setup_uploadify(){
  // Create an empty object to store our custom script data
  var uploadify_script_data = {};
  
  // Fetch the CSRF meta tag data
  var csrf_token = $('meta[name=csrf-token]').attr('content');
  var csrf_param = $('meta[name=csrf-param]').attr('content');
  
  // Now associate the data in the config, encoding the data safely
  uploadify_script_data[csrf_param] = encodeURI(encodeURIComponent(csrf_token));

  // Associate the session information
  // .... see views/layouts/application.html.erb
  uploadify_script_data[BOI_SESSION_KEY] = BOI_SESSION_VAL;;

  $("#media_file_uploader").uploadify({
        uploader: '/uploadify/uploadify.swf',
        script: 'assets',
        auto: true,
        scriptData: uploadify_script_data,
        multi: true,
        cancelImg: '/images/cancel.png',
        onComplete: function(event, queueID, fileObj, response, data) {
          $("#media_files").html(response);
          $("#media_files").animate({scrollTop: $("#media_files").attr("scrollHeight") - $('#media_files').height()}, 150);
        },
        onError: function(ev,ID,fileObj,errorObj){
          console.log(errorObj)
        }
  });

}




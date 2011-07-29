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


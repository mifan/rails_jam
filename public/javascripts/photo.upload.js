$(function(){
  $(".multifile").swfuploader({
    upload_url      : window.location.href,
    set             :  "MultiFile",
    file_post_name  : "image[attachment]",
    post_params     : {authenticity_token: $('meta[name=csrf-token]').attr('content')},
    file_types      : "*.jpg;*.gif;*.png",
    file_types_description: "Web Image Files", 
    upload_success_handler : function(file, serverData, response){
      var data = eval("("+ serverData + ")");
      $(data.partial).hide().prependTo($(".images")).fadeIn();
    }
  });


  //sort able
  $("#photos").sortable();
  $("#photos").disableSelection();


});
$(function(){

  $(".multifile").swfuploader({
    upload_url      : "/photos",
    set             :  "MultiFile",
    file_post_name  : "image[attachment]",
    file_types      : "*.jpg;*.gif;*.png",
    file_types_description: "Web Image Files", 
    upload_success_handler : function(file, serverData, response){
      var data = eval("("+ serverData + ")");
      $(data.partial).hide().prependTo($(".images")).fadeIn();
    }
  });

});
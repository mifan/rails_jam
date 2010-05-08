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
      $(data.partial).hide().appendTo($("#photos")).fadeIn();
    }
  });


  //sort able
  $( "#photos" ).sortable({

    update: function(event, ui) {

      photos_arr = $.map($(this).sortable('toArray'), function(n){ return (n.substring(6)); });

      $.post(
        window.location.href + '/sort', 
        {
          authenticity_token: $('meta[name=csrf-token]').attr('content') ,
          photos: photos_arr
        },
        function(data){
          //alert(data.toString()) ;
          //var photo_ids = eval("("+ data + ")");
          $.each(data.changed_photos,function(index,value) {
           $("#photo_" + value).effect("highlight", {}, 1000);
           // alert(index + ': ' + value); 
          });
        },
		'json'
      );

    }

  });

  $("#photos").disableSelection();

});
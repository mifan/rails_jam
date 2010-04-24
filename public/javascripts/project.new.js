$(document).ready(function() {

  $('#git_project_button').click(function(){

    var git_reg=/^http:\/\/github\.com\/[a-zA-Z0-9\-_]+\/[a-zA-Z0-9\-_]+$/;
    var link_url = $('#git_project_link').val();
    if(!git_reg.test(link_url)){
      alert('Plase enter a valid github project link like : http://github.com/mocra/fat_free_crm');
      return false;
    }

    $.post('/projects/git', 
      {
        authenticity_token: $('meta[name=csrf-token]').attr('content') ,
        git_project_link: link_url 
      },
      function(data){
        var jObj = $.parseJSON(data);
        if(jObj.repository != 'error'){
		  $('#project_name').val(jObj.repository.name);
		  $('#project_description').val(jObj.repository.description);
		  $('#project_home_page').val(jObj.repository.homepage);
		  $('#project_source_link').val(jObj.repository.url);
		  $('#git-select').hide();
		  $('#normal-input').show();
		}
      }
    );
 
    return false;
  });



 

});

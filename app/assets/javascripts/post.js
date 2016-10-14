$(document).on("ajax:success", "#comment-post", function(event, data, status, xhr) {
  
 if( data.hasOwnProperty('status')){
    alert(data.status);
  }
  else {
    $("#c"+data.parent_id).append('<div class="one-comment"><a class="comment-left" href=""><Image></a><div class="comment-right"><b class="comment-head">'+data.posted_by_id+'</b> '+data.content+'</div></div>');
    $()
  }

});

$(document).ready(function(){
	$(".comment-show").click(function(){
		var secid = $(this).attr('data-show');
		
    $("#"+secid).toggle();
    console.log("Comment"); 

	  if ( $("#"+secid).is(":visible") ){
      $("#c"+secid).empty();
      $.ajax( {
          url: "/comments/get/",
          method: 'GET',
          data: {'secid':secid,
          },
          success: function( data ) {
              alert(JSON.stringify(data));
              for (var i = data.length - 1; i >= 0; i--) {
                  $("#c"+secid).append('<div class="one-comment"><a class="comment-left" href=""><Image></a><div class="comment-right"><b class="comment-head">'+data[i].posted_by_id+'</b> '+data[i].content+'</div></div>');
                }
              }
        });  
    }
    
  });
//Search 
	$("#search" ).autocomplete({
      source: function( request, response ) {
          console.log("Search")
        
        $.ajax( {
          url: "/friends/search/",
          data: $("#search-form").serialize(),
          success: function( data ) {
          	var final = [];
          	var i;
          	for(i=0;i <data.length;i++){
	          	$.each(data[i], function(k, v) {
					final.push(v);	
				});
          	}
            response(final);
          }
        } );
      },
      minLength: 2,      
    } );

// comments


});

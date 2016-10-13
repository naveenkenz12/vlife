$(document).on("ajax:success", "#comment-post", function(event, data, status, xhr) {
    
});

$(document).ready(function(){
	$(".comment-show").click(function(){
		var secid = $(this).attr('data-show');
		$("#"+secid).show();
	});

	$("#search" ).autocomplete({
      source: function( request, response ) {
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
});

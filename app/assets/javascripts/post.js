$(document).on("ajax:success", "#comment-post", function(event, data, status, xhr) {
    
});

$(document).ready(function(){
	$(".comment-show").click(function(){
		var secid = $(this).attr('data-show');
		$("#"+secid).show();
	})
});

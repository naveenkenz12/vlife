$(document).on("turbolinks:load", function() {
//post comments
$(document).on("ajax:success", "#comment-post", function(event, data, status, xhr) {
  

 if( data.hasOwnProperty('status') || status != "success"){
    alert(status);

  }
  else {
    $("#c"+data.parent_id).append('<div class="one-comment"><a class="comment-left" href=""><Image></a><div class="comment-right"><b class="comment-head">'+data.posted_by_id+'</b> '+data.content+'</div></div>');
    $("#comment-text"+data.parent_id).val("");
  }

});

// comments
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
              for (var i = data.length - 1; i >= 0; i--) {
                  $("#c"+secid).append('<div class="one-comment"><a class="comment-left" href=""><Image></a><div class="comment-right"><b class="comment-head"><a href=/'+data[i].posted_by_id+'/profile/ >'+data[i].posted_by_id+'</a></b> '+data[i].content+'</div></div>');
                }
              }
        });  
    }
    
  });
//Search 
	$("#search").autocomplete({
      source: function( request, response ) {
        $.ajax( {
          url: "/friends/search/",
          data: $("#search-form").serialize(),
          success: function( data ) {
            //count number of elements
          	var final = [];
          	var i;
          	for(i=0;i <data.length;i++){
	          	final.push(data[i]);
              console.log(data[i]);
          	}
            response(final);
          }
        } );
      },
      minLength: 1,      
      select: function( event, ui ) {
        window.location = "/"+ui.item.value+"/profile";
      }

    } );



//search groups
$("#search_group").autocomplete({
      source: function( request, response ) {
        $.ajax( {
          url: "/group_pages/search_group/",
          data: $("#search-form_group").serialize(),
          success: function( data ) {
            //count number of elements
            //window.alert(data[0][0]);
            var final = [];
            var i;
            for(i=0;i <data.length;i++){
              final.push(data[i]);
              console.log(data[i][1]);
            }
            //response(final);

            response($.map(final, function(v,i){
            return {
                        label: v[0],
                        value: v[0],
                        href:  v[1]
                       };
        }));

          }
        } );
      },
      minLength: 1,      
      select: function( event, ui ) {
        console.log(ui.item.href);
        window.location = "/group/?page_id="+ui.item.href;
      }

    } );

    setInterval(function(){ 
      $.ajax( {
          url: "/save/online/",
          data: {},
          success: function( data ) {
            console.log(data)
          }
        } ); }, 100000); //every 100s

    $("#dialog").dialog({
      autoOpen: false
    });


    $("#dialog_post").dialog({
      autoOpen: false
    });

    setInterval(function(){ 
      $.ajax( {
          url: "/new/message/",
          data: {},
          success: function( data ) {
            console.log(data);
            if(data['status']=="ok"){
              window.alert(data['sender']+' : '+data['content']);
            }
          }
        } ); }, 2000000); //every 2s

});


//msg = {:sadas => "asdas", :Asda => "asdas" }
//render :json => msg
$(document).on("ajax:success", ".button_to", function(event, data, status, xhr) {
    
    alert("sent");

    if(data.buttonvalue != "" && data.action_value !="")
    {
      $("#f-button").val(data.button_value);
      $(".button_to").attr("action" , "/friends/"+data.action_value+"/"); 
    }
    else{
      alert("Error!!!!");
    }

});


$(document).on("ajax:success", "#slam_form", function(event, data, status, xhr) {
  

 if( data.hasOwnProperty('error')){
    alert(data.error);

  }
  else {
    $("#a"+data.qdone_id).attr('disabled',true);
    $("#b"+data.qdone_id).attr('disabled',true);
    $("#e"+data.qdone_id).attr('disabled',false);
    
    console.log("#a"+data.qdone_id);
  }

});

});
function _send_msg_(r_id) {
    $("#dialog").dialog("open");
    $("#msg_content").val("");
    $("#receiver_id").val(r_id);
  }


function _send_post_(r_id){
    $("#dialog_post").dialog("open");
    $("#post_content").val("");
    $("#posted_to_id").val(r_id);
}



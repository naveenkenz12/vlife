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


  $("#search_inv").autocomplete({
      source: function( request, response ) {
        $.ajax( {
          url: "/group_pages/search_inv/",
          data: $("#search-form_inv").serialize(),
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
  
    //chatbox appear
    $(document).on('click', '#chatb', function(){

        
        var userid = $(this).data("id");
        var name= $(this).data("name");
        var picurl = $(this).data("pic");
        //change head
        $("#chat-title").html(name);
        $.ajax( {
          url: "/"+userid+"/messages/",
          method: 'GET',
          success: function( data ) {

              //fill data
              $('#chat-content').empty();
              for( var i = data.length-1;i>=0;i--){
                if(data[i][2]==userid){
                  $('#chat-content').append('<div class="row msg_container base_receive"><div class="col-md-2 col-xs-2 avatar"><img src='+picurl+' img-responsive "></div><div class="col-xs-10 col-md-10"><div class="messages msg_receive"><p>'+data[i][0]+'</p><time datetime="">'+data[i][2]+'</time></div></div></div>');     
                }
                else{
                  $('#chat-content').append('<div class="row msg_container base_sent"><div class="col-md-10 col-xs-10"><div class="messages msg_sent"><p>'+data[i][0]+'</p><time datetime="2009-11-13T20:00">'+data[i][2]+'</time></div></div><div class="col-md-2 col-xs-2 avatar"><img src="'+data[i][4]+'" class=" img-responsive "></div></div>');
                }
              }
              //Set recievers id
              $('#receiver_id').val(userid);
              $('.chatbox').show();
          }
        });  
        
    });

    $(document).on('click', '#chatclose', function(){
      $('.chatbox').hide();
      $('#chat-content').empty();
    });

    setInterval(function(){ 
      $.ajax( {
          url: "/save/online/",
          data: {},
          success: function( data ) {
            //poopulate chat list
            data = data.value
            $('#chat-list').html("");
            for (var i= data.length-1 ; i>=0;i--){
            $('#chat-list').append('<div class="media" data-id="'+data[i][0].u_id+'" data-name="'+data[i][1][0]+' '+data[i][1][2]+'" data-pic = "'+data[i][2].med_id.xsmall.url+'" id="chatb"><div class="media-left media-middle"><img class="media-object" id = "chat_pic" src='+data[i][2].med_id.xsmall.url+' alt="Profile Picture"></div><div class="media-body"><h5 class="media-heading">'+data[i][1][0]+' '+data[i][1][2]+'</h5></div></div>');}
          }
        
        } ); }, 10000); //every 100s

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
              //if message received
              var chatboxu = $('#receiver_id').val();
              if(data['sender'] == chatboxu )
              { 
                $('#chat-content').append('<div class="row msg_container base_receive"><div class="col-md-2 col-xs-2 avatar"><img src="" img-responsive "></div><div class="col-xs-10 col-md-10"><div class="messages msg_receive"><p>'+data['content']+'</p><time datetime="">'+data['sender']+'</time></div></div></div>');     
              }
              else{

              }
            }
          }

        } ); }, 2000); //every 2s

});


//msg = {:sadas => "asdas", :Asda => "asdas" }
//render :json => msg

$(document).on("ajax:success", "._friend_btn", function(event, data, status, xhr) {
    
    //alert("sent");

    if(data.buttonvalue != "" && data.action_value !="")
    {
      $("#f-button").val(data.button_value);
      $("._friend_btn").attr("action" , "/friends/"+data.action_value+"/"); 
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

$(document).on("ajax:success", "._page_btn", function(event, data, status, xhr) {
    
    //alert("sent");

    if(data.buttonvalue != "" && data.action_value !="")
    {
      $("#p-button").val(data.button_value);
      $("._page_btn").attr("action" , "/group_pages/"+data.action_value+"/"); 
    }
    else{
      alert("Error!!!!");
    }
  });

  $(document).on("ajax:success", "#msg_form", function(event, data, status, xhr) {
      
      alert("sent");
      $('#chat-content').append('<div class="row msg_container base_sent"><div class="col-md-10 col-xs-10"><div class="messages msg_sent"><p>'+data.data+'</p><time datetime="2009-11-13T20:00">'+data.sender+'</time></div></div><div class="col-md-2 col-xs-2 avatar"><img src="'+"asdff"+'" class=" img-responsive "></div></div>');
      $('#btn-input').val("");

  });


  $(document).on("ajax:success", "._page_btn2", function(event, data, status, xhr) {
      
      //alert("sent");

      if(data.buttonvalue != "" && data.action_value !="")
      {
        $("#p-button2").val(data.button_value);
        $("._page_btn2").attr("action" , "/group_pages/"+data.action_value+"/"); 
      }
      else{
        alert("Error!!!!");
      }

  });


});
function _send_msg_(r_id) {
    $("#dialog").dialog("open");
    $('#btn-input').val("");
    
    $("#receiver_id").val(r_id);
  }


function _send_post_(r_id){
    $("#dialog_post").dialog("open");
    $("#post_content").val("");
    $("#posted_to_id").val(r_id);
}
(function(){
	var api_version = Nervous.getJSAPIVersion();
	


	$('#my-output').append("This is the first <b>Nervous JSApp</b>. Live data below is provided <b>natively</b> by the phone.<br/>");
	//$('#my-output').append("using JS nervous api v" + api_version + '<hr/>');
    $('#my-output').append("NervousAPI JS Version " + api_version + "<br/>");
 	
 	$.when(Nervous.getHWAPIVersion()).done(function(data){
    	$('#my-output').append("Local Analytics Engine Version " +data.version+"");
	});



 	setInterval(function(){
		$.when(Nervous.getGyr()).done(function(data){
	    	$('#gyrodataX').html("gyr X: " +data.x);
	    	$('#gyrodataY').html("gyr Y: " +data.x);
	    	$('#gyrodataZ').html("gyr Z: " +data.x);
		});
 	 }, 100);



 	


	//call the UI page "home"
	App.load('home');


})();
(function(){
	var api_version = Nervous.getJSAPIVersion();
	


	$('#my-output').append("hello world! <br/>this is the first nervous app<br/>");
	//$('#my-output').append("using JS nervous api v" + api_version + '<hr/>');
    $('#my-output').append("using JS nervous api v" + api_version + '<hr/>');
 	
 	$.when(Nervous.getHWAPIVersion()).done(function(data){
    	$('#my-output').append("and local analytics engine api v " +data.version+" <hr/>");
	});



 	setInterval(function(){
		$.when(Nervous.getGyr()).done(function(data){
	    	$('#gyrodataX').html("gyr X:" +data.x);
	    	$('#gyrodataY').html("gyr Y:" +data.x);
	    	$('#gyrodataZ').html("gyr Z:" +data.x);
		});
 	 }, 1000);



 	


	//call the UI page "home"
	App.load('home');


})();
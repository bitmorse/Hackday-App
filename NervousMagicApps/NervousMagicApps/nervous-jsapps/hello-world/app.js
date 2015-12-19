(function(){
	var api_version = Nervous.getJSAPIVersion();
	var hwapi_version = Nervous.getHWAPIVersion();


	$('#my-output').append("hello world! <br/>this is the first nervous app<br/>");
	//$('#my-output').append("using JS nervous api v" + api_version + '<hr/>');
    $('#my-output').append("using JS nervous api v" + api_version + '<hr/>');
 	
    $('#my-output').append("and local analytics engine api v" + hwapi_version["version"] + '<hr/>');


	//call the UI page "home"
	App.load('home');




})();
(function(){
	var api_version = Nervous.getJSAPIVersion();
	var matrix = [[1,2,5],[3,5,-1],[7,-3,5]];
	var ev = JSON.stringify(numeric.eig(matrix));

	console.log("hello world this is a user app!");
	console.log(api_version);

	//jquery is included in the nervous api
	$('#my-output').append("hello world! <br/>this is the first nervous app! <br/>");
	$('#my-output').append("the version of the JS nervous api is: " + api_version + '<hr/>');

	$('#my-output').append('we just found some eigenvalues: <pre>'+ev+'</pre>');
})();
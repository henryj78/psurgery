<!DOCTYPE html>  

<html> 

<head> <pre class="lang:js"><script type="text/javascript" src="//js.maxmind.com/js/apis/geoip2/v2.1/geoip2.js"></script>
 
<script type="text/javascript">
 
var onSuccess = function(location){
  alert(
      "Lookup successful:\n\n"
      + JSON.stringify(location, undefined, 4)
  );
};
 
var onError = function(error){
 // alert("Error:\n\n" + JSON.stringify(error, undefined, 4));
  alert("Error:\n\n" + error.code);
};
 
geoip2.city(onSuccess, onError);
 
</script></pre>
</head>
<body>
Test
</body>
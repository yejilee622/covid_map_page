<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<script type="text/javascript">			

$(document).ready(function geoGet(){
	$.ajax({
		url:"https://api.openweathermap.org/data/2.5/onecall",
		method:"GET",
		data:{"lat":"37",
			"lon":"128",
			"appid":"3bf49017d9d50f294c1795956f5e7e6b"},
		datatype:"JSON",
		success: function (geodata){
			console.log(geodata.current.weather[0].icon);
			var datahtml='<img src="http://openweathermap.org/img/wn/'+geodata.current.weather[0].icon+'@2x.png" width="50px" height="50px" alt="">';
			document.getElementById("geoimg").innerHTML=datahtml;
		} 
	});
});

</script>

<div id=geoimg></div>
</body>
</html>
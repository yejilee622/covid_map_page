<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관광지 정보 알아보기</title>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<script type="text/javascript">			

$(document).ready(function geoData(){
	$.ajax({
		url:"https://maps.googleapis.com/maps/api/geocode/json",
		data:{"latlng":"37,128",
			"key":"AIzaSyDLBoEc6SOFTtsotbLdVQg75x0IS3GzlGI"},
		method:"GET",
		datatype:"JSON",
		success: function(data) {
			var htmlData;
			console.log("name: ",data);
			htmlData=data.plus_code.compound_code;
			document.getElementById("geodata").innerHTML=htmlData;
		}
	});
})

</script>

<div id=geodata></div>

</body>
</html>
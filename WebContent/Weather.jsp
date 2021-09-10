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
			"lang":"kr",
			"units":"metric",
			"appid":"3bf49017d9d50f294c1795956f5e7e6b"},
		datatype:"JSON",
		success: function (geodata){
			var datahtml="";
			console.log(geodata);
			datahtml='<img src="http://openweathermap.org/img/wn/'+geodata.daily[0].weather[0].icon+'@2x.png" width="50px" height="50px" alt="">';
			datahtml+='<br>'+geodata.daily[0].weather[0].description;
			datahtml+='<br>아침 온도 '+geodata.daily[0].temp.morn;
			datahtml+='<br>아침 체감 온도 '+geodata.daily[0].feels_like.morn;
			datahtml+='<br>점심 온도 '+geodata.daily[0].temp.day;
			datahtml+='<br>점심 체감 온도 '+geodata.daily[0].feels_like.day;
			datahtml+='<br>저녁 온도 '+geodata.daily[0].temp.eve;
			datahtml+='<br>저녁 체감 온도 '+geodata.daily[0].feels_like.eve;
			datahtml+='<br>밤 온도 '+geodata.daily[0].temp.night;
			datahtml+='<br>밤 체감 온도 '+geodata.daily[0].feels_like.night;
			datahtml+='<br>최저기온 '+geodata.daily[0].temp.min;
			datahtml+='<br>최고기온 '+geodata.daily[0].temp.max;
			datahtml+='<br>습도 '+geodata.daily[0].humidity;
			datahtml+='<br>풍속 '+geodata.daily[0].wind_speed;
			datahtml+='<br>풍향 '+geodata.daily[0].wind_deg;
			datahtml+='<br>구름 '+geodata.daily[0].clouds;
			datahtml+='<br>자외선 '+geodata.daily[0].uvi;
			datahtml+='<br>강수확률 '+geodata.daily[0].pop;
			document.getElementById("geoimg").innerHTML=datahtml;
		} 
	});
});

</script>
      
  <style type="text/css">

      /* Optional: Makes the sample page fill the window. */
      html,
      body {
      	background: #F4D4E7;
        height: 100%;
        margin: 0;
        padding: 0;
        font-family: 'GowunBatang-Regular';
      }
      
      @font-face {
    font-family: 'GowunBatang-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/GowunBatang-Regular.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
    </style>
    
<div id=geoimg></div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전세계 최근 날씨 검색</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
</head>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<script type="text/javascript">

var nation_name="";
var getParameters = function (paramName) { 
var returnValue; 
var url = location.href; 
var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&'); 
for (var i = 0; i < parameters.length; i++) { 
	var varName = parameters[i].split('=')[0]; 
	if (varName.toUpperCase() == paramName.toUpperCase()) { returnValue = parameters[i].split('=')[1]; return decodeURIComponent(returnValue); } } };

nation_name=getParameters('nation_name');

</script>

<%
String c_nm="";
String c_nm_no="";
String c_nm_no2="";
String test = "";
String test2 = "";
String test3 = "";
Connection myConn = null; 
Statement stmt = null;
ResultSet myResultSet = null; 
String mySQL = "";
String dburl= "jdbc:oracle:thin:@localhost:1521/xe";
String user= "db1610479"; String passwd="casiopea86";
String dbdriver = "oracle.jdbc.driver.OracleDriver";

try{
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
	stmt = myConn.createStatement();
} catch(SQLException ex) {
	System.err.println("SQLException: "+ex.getMessage());
}
mySQL="select COUN_NM, COUN_LAT, COUN_LONG from COUNTRY";
try{
myResultSet = stmt.executeQuery(mySQL);
if(myResultSet != null) {
	while(myResultSet.next()) {
		c_nm = myResultSet.getString("COUN_NM");
		c_nm_no = myResultSet.getString("COUN_LAT");
		c_nm_no2 = myResultSet.getString("COUN_LONG");
		test += c_nm+",";
		test2 += c_nm_no+",";
		test3 += c_nm_no2+",";
		}
} 
%>
		
<script type="text/javascript">

let countryStr = "<%=test%>";
let countryList = countryStr.split(",");
let countryStr2 = "<%=test2%>";
let countryList2 = countryStr2.split(",");
let countryStr3 = "<%=test3%>";
let countryList3 = countryStr3.split(",");

var nation_lat="";
var nation_long="";

for(var i=0;i<countryList.length;i++) {
	if(countryList[i]==nation_name) {
		nation_lat=countryList2[i];
		nation_long=countryList3[i];
		break;
	}
}

console.log(nation_name, nation_lat, nation_long);

$(document).ready(function geoGet(){
	$.ajax({
		url:"https://api.openweathermap.org/data/2.5/onecall",
		method:"GET",
		data:{"lat": nation_lat,
			"lon": nation_long,
			"lang":"kr",
			"units":"metric",
			"appid":"3bf49017d9d50f294c1795956f5e7e6b"},
		datatype:"JSON",
		success: function (geodata){
			var datahtml="";
			console.log(geodata);
			datahtml+='<table class="table table-striped">'; 
			datahtml+='<tr><td></td><td>날씨</td><td>아침온도</td><td>점심온도</td><td>저녁온도</td><td>밤온도</td><td>습도</td><td>구름</td><td>자외선</td><td>강수확률</td></tr>';
			for(var i=1;i<=7;i++) {
				datahtml+='<tr><td><img src="http://openweathermap.org/img/wn/'+geodata.daily[i].weather[0].icon+'@2x.png" width="50px" height="50px" alt="" class="blinking"></td>';
				datahtml+='<td>'+geodata.daily[i].weather[0].description+'</td>';
				datahtml+='<td>'+geodata.daily[i].temp.morn+'</td>';
				datahtml+='<td>'+geodata.daily[i].temp.day+'</td>';
				datahtml+='<td>'+geodata.daily[i].temp.eve+'</td>';
				datahtml+='<td>'+geodata.daily[i].temp.night+'</td>';
				datahtml+='<td>'+geodata.daily[i].humidity+'</td>';
				datahtml+='<td>'+geodata.daily[i].clouds+'</td>';
				datahtml+='<td>'+geodata.daily[i].uvi+'</td>';
				datahtml+='<td>'+geodata.daily[i].pop+'</td>';
			}
			datahtml+="</table>"; 
			document.getElementById("geoimg").innerHTML=datahtml;
		} 
	});
});
<%
} catch(SQLException ex) {
System.err.println("SQLException: "+ex.getMessage()); 
}
stmt.close(); myConn.close();
%>

</script>
      
  <style type="text/css">

      /* Optional: Makes the sample page fill the window. */
      html,
      body {
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
    
    .blinking{ -webkit-animation:blink 1.5s ease-in-out infinite alternate; 
    -moz-animation:blink 1.5s ease-in-out infinite alternate; 
    animation:blink 1.5s ease-in-out infinite alternate; } 
    
    @-webkit-keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} } 
    
    @-moz-keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} } 
    
    @keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} }
    
    </style>
<div align="center" style="font-size:20px;">일주일간의 날씨정보입니다</div>
<div id=geoimg></div>

</body>
</html>
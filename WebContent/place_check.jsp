<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<script async
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLBoEc6SOFTtsotbLdVQg75x0IS3GzlGI&libraries=localContext&v=beta&callback=ResMap">
</script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
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
		nation_lat*=1;
		nation_long=countryList3[i];
		nation_long*=1;
		break;
	}
}

console.log(nation_name, nation_lat, nation_long);

let map;

function ResMap() {
  const localContextMapView = new google.maps.localContext.LocalContextMapView({
    element: document.getElementById("map"),
    placeTypePreferences: [
      { type: "restaurant" }
    ],
    maxPlaceCount: 24,
  });
  
  map = localContextMapView.map;
  map.setOptions({
    center: { lat: nation_lat, lng: nation_long },
    zoom: 13,
  });
}

function CafeMap() {
	  const localContextMapView = new google.maps.localContext.LocalContextMapView({
	    element: document.getElementById("map"),
	    placeTypePreferences: [
	      { type: "cafe" }
	    ],
	    maxPlaceCount: 24,
	  });
	  
	  map = localContextMapView.map;
	  map.setOptions({
	    center: { lat: nation_lat, lng: nation_long },
	    zoom: 12,
	  });
	}
	
function ShopMap() {
	  const localContextMapView = new google.maps.localContext.LocalContextMapView({
	    element: document.getElementById("map"),
	    placeTypePreferences: [
	      { type: "shopping_mall" },
	      { type: "clothing_store" },
	      { type: "department_store" },
	      { type: "jewelry_store" },
	      { type: "shoe_store" }
	    ],
	    maxPlaceCount: 24,
	  });
	  
	  map = localContextMapView.map;
	  map.setOptions({
	    center: { lat: nation_lat, lng: nation_long },
	    zoom: 12,
	  });
	}
	
function TourMap() {
	  const localContextMapView = new google.maps.localContext.LocalContextMapView({
	    element: document.getElementById("map"),
	    placeTypePreferences: [
	      { type: "tourist_attraction" }
	    ],
	    maxPlaceCount: 24,
	  });
	  
	  map = localContextMapView.map;
	  map.setOptions({
	    center: { lat: nation_lat, lng: nation_long },
	    zoom: 12,
	  });
	}
	
function BarMap() {
	  const localContextMapView = new google.maps.localContext.LocalContextMapView({
	    element: document.getElementById("map"),
	    placeTypePreferences: [
	      { type: "bar" }
	    ],
	    maxPlaceCount: 24,
	  });
	  
	  map = localContextMapView.map;
	  map.setOptions({
	    center: { lat: nation_lat, lng: nation_long },
	    zoom: 12,
	  });
	}
	
function BreadMap() {
	  const localContextMapView = new google.maps.localContext.LocalContextMapView({
	    element: document.getElementById("map"),
	    placeTypePreferences: [
	      { type: "bakery" }
	    ],
	    maxPlaceCount: 24,
	  });
	  
	  map = localContextMapView.map;
	  map.setOptions({
	    center: { lat: nation_lat, lng: nation_long },
	    zoom: 12,
	  });
	}
	
function BookMap() {
	  const localContextMapView = new google.maps.localContext.LocalContextMapView({
	    element: document.getElementById("map"),
	    placeTypePreferences: [
	      { type: "book_store" }
	    ],
	    maxPlaceCount: 24,
	  });
	  
	  map = localContextMapView.map;
	  map.setOptions({
	    center: { lat: nation_lat, lng: nation_long },
	    zoom: 12,
	  });
	}
	
function MarketMap() {
	  const localContextMapView = new google.maps.localContext.LocalContextMapView({
	    element: document.getElementById("map"),
	    placeTypePreferences: [
	      { type: "supermarket" },
	      { type: "convenience_store" },
	      { type: "drugstore"}
	    ],
	    maxPlaceCount: 24,
	  });
	  
	  map = localContextMapView.map;
	  map.setOptions({
	    center: { lat: nation_lat, lng: nation_long },
	    zoom: 12,
	  });
	}
	
function MovieMap() {
	  const localContextMapView = new google.maps.localContext.LocalContextMapView({
	    element: document.getElementById("map"),
	    placeTypePreferences: [
	      { type: "movie_theater" }
	    ],
	    maxPlaceCount: 24,
	  });
	  
	  map = localContextMapView.map;
	  map.setOptions({
	    center: { lat: nation_lat, lng: nation_long },
	    zoom: 12,
	  });
	}
	
function ParkMap() {
	  const localContextMapView = new google.maps.localContext.LocalContextMapView({
	    element: document.getElementById("map"),
	    placeTypePreferences: [
	      { type: "park" }
	    ],
	    maxPlaceCount: 24,
	  });
	  
	  map = localContextMapView.map;
	  map.setOptions({
	    center: { lat: nation_lat, lng: nation_long },
	    zoom: 12,
	  });
	}
  
<%
} catch(SQLException ex) {
System.err.println("SQLException: "+ex.getMessage()); 
}
stmt.close(); myConn.close();
%>

</script>
<style>
#map {
  height: 95%;
}

/* Optional: Makes the sample page fill the window. */
html,
body {
  height: 100%;
  margin: 0;
  padding: 0;
  }
  
   @font-face {
  		font-family: 'GowunBatang-Regular';
    	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/GowunBatang-Regular.woff') format('woff');
 	    font-weight: normal;
    	font-style: normal;
	  }

	@import url("https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap");
</style>
<!DOCTYPE html>
<html>
  <head>
    <title>관광지 정보 알아보기</title>

  </head>
  <body>
 		<input type=button id=restaurent value="식당" style="font-family:GowunBatang-Regular" onclick="ResMap();">
 		<input type=button id=shopping value="쇼핑" style="font-family:GowunBatang-Regular" onclick="ShopMap();">
 		<input type=button id=cafe value="카페 " style="font-family:GowunBatang-Regular" onclick="CafeMap();">
 		<input type=button id=attraction value="가볼만한 곳" style="font-family:GowunBatang-Regular" onclick="TourMap();">
 		<input type=button id=bar value="바" style="font-family:GowunBatang-Regular" onclick="BarMap();">
  		<input type=button id=restaurent value="빵집" style="font-family:GowunBatang-Regular" onclick="BreadMap();">
  		<input type=button id=restaurent value="서점" style="font-family:GowunBatang-Regular" onclick="BookMap();">
  		<input type=button id=restaurent value="마켓" style="font-family:GowunBatang-Regular" onclick="MarketMap();">
  		<input type=button id=restaurent value="영화관" style="font-family:GowunBatang-Regular" onclick="MovieMap();">
  		<input type=button id=restaurent value="공원" style="font-family:GowunBatang-Regular" onclick="ParkMap();">
 
    <div id="map"></div>

  </body>
</html>
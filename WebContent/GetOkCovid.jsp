<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>해외여행 가능 국가 탐색</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

</head>
<body>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<!-- xml to json xml을 json 형식으로 변경하기 위한 라이브러리를 추가 합니다. -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/fast-xml-parser/3.19.0/parser.min.js"></script>


<div id="map" style="width:65%; height:95vh; float:left; margin-right:10px"></div>
<div id="OkTravel"></div></div>
   
지도 위 마크를 클릭하시면 <br> 해당 국가의 코로나 발생 현황을 알 수 있습니다

<div id="data_Area"></div>
<div id="data_Name"></div>
<div id="data_Death"></div>
<div id="data_Covid"></div>
<div id="data_Rate"></div>
  <style type="text/css">
      
      
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
 
      
      #map {
        height: 90%;
      }

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
      
    </style>
    
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLBoEc6SOFTtsotbLdVQg75x0IS3GzlGI&callback=initMap&libraries=&v=weekly"
      defer
    >
    </script>
    
   <%
	String test = "";
    String test2 = "";
    String test3 = "";
    String test4 = "";
    String test5 = "";
 	Connection myConn = null; 
	Statement stmt = null;
	Statement stmt2 = null;
	ResultSet myResultSet = null; 
	ResultSet myResultSet2 = null;
	String mySQL = "";
	String mySQL2 = "";
	String dburl= "jdbc:oracle:thin:@localhost:1521/xe";
	String user= "db1610479"; String passwd="casiopea86";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	
	try{
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement();
		stmt2 = myConn.createStatement();
	} catch(SQLException ex) {
		System.err.println("SQLException: "+ex.getMessage());
	}
	mySQL="select NATION_NM, ISOLATION_OK from OK_TRAVEL_2021_09";
	mySQL2="select COUN_NM, COUN_LAT, COUN_LONG from COUNTRY where COUN_NM IN (select NATION_NM from OK_TRAVEL_2021_09)";
try{
	myResultSet2 = stmt2.executeQuery(mySQL2);
	if(myResultSet2 != null) {
		while(myResultSet2.next()) {
			String coun_nm = myResultSet2.getString("COUN_NM");
			String coun_lat = myResultSet2.getString("COUN_LAT");
			String coun_long = myResultSet2.getString("COUN_LONG");
			test3 += coun_nm+",";
			test4 += coun_lat+",";
			test5 += coun_long+",";
		}
	}
	myResultSet = stmt.executeQuery(mySQL);
	if(myResultSet != null) {
		while(myResultSet.next()) {
			String c_nm_no = myResultSet.getString("NATION_NM");
			String c_nm_no2 = myResultSet.getString("ISOLATION_OK");
			test += c_nm_no+",";
			test2 += c_nm_no2+",";
			}
			%>
		<script type="text/javascript">		
		
		let countryStr = "<%=test%>";
		let countryList = countryStr.split(",");
		let countryStr2 = "<%=test2%>";
		let countryList2 = countryStr2.split(",");
		let countryStr3 = "<%=test3%>";
		let countryList3 = countryStr3.split(",");
		let latStr = "<%=test4%>";
		let latList = latStr.split(",");
		let longStr = "<%=test5%>";
		let longList = longStr.split(",");
		
		let locationy = new Array(countryList3.length);
		let three = new Array(3);
		

		for (var i=0; i<locationy.length-1; i++) {
			var t=latList[i];
			t *= 1;
			var y=longList[i];
			y *= 1;
			three = [countryList3[i], t, y];
			locationy[i] = three;
		}
		
		var nation_name="";
		var getParameters = function (paramName) { 
		var returnValue; 
		var url = location.href; 
		var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&'); 
		for (var i = 0; i < parameters.length; i++) { 
			var varName = parameters[i].split('=')[0]; 
			if (varName.toUpperCase() == paramName.toUpperCase()) { returnValue = parameters[i].split('=')[1]; return decodeURIComponent(returnValue); } } };
		
		nation_name=getParameters('nation_name');
		
		let dataHtml="";
		
		for(var i=0;i<countryList3.length;i++) {
			if(nation_name==countryList3[i]) {
				dataHtml+='<br><div class="blinking">'+nation_name+'은(는) 해외여행 가능 국가에 해당됩니다</div><br>';
				dataHtml+="해당 국가 내에서의 격리 여부: "+countryList2[i]+"<br><br>";
				break;
			}
			if(i>=countryList3.length-1) {
				dataHtml+='<br><div class="blinking">'+nation_name+"은(는) 해외여행 가능 국가에 해당되지 않습니다</div><br>";
			}
		}

		document.getElementById("OkTravel").innerHTML = dataHtml;
		
			function getCovidData(country_name){
				
				dataHtml = "";
				
				$.ajax({
					url: "http://localhost:8090/GetCovidData",
					type: "get",
					dataType: "text",
					success: function (data) {
						var jsonData = parser.parse(data);
						
						var items = jsonData.response.body.items.item; 		
						
						for(var i=0;i<countryList3.length;i++) {
							if(nation_name==country_name) break;
							if(country_name==countryList3[i]) {
								dataHtml+="<br>"+country_name+"은(는) 해외여행 가능 국가에 해당됩니다<br>";
								dataHtml+="해당 국가 내에서의 격리 여부: "+countryList2[i]+"<br><br>";
							}
						}

						$.each(items, function(index, item){
								if(country_name==item.nationNm) {
									dataHtml+='<table class="table-striped table-sm">'; 
									dataHtml+="<tr><td>대륙명</td>";
									dataHtml+="<td><div id='data_Area'>"+item.areaNm+"</div></td>";
									dataHtml+="</tr>";
									dataHtml+="<tr>";
									dataHtml+="<td>국가명</td>";
									dataHtml+="<td><div id='data_Name'>"+item.nationNm+"</div></td>";
									dataHtml+="</tr>";
									dataHtml+="<tr>";
									dataHtml+="<td>총 사망자 수</td>";
									dataHtml+="<td><div id='data_Death'>"+item.natDeathCnt+"</div></td>";
									dataHtml+="</tr>";
									dataHtml+="<tr>";
									dataHtml+="<td>총 확진자 수</td>";
									dataHtml+="<td><div id='data_Covid'>"+item.natDefCnt+"</div></td>";
									dataHtml+="</tr>";
									dataHtml+="<tr>";
									dataHtml+="<td>확진률 대비 사망률(백분율)</td>";
									dataHtml+="<td><div id='data_Rate'>"+item.natDeathRate+"</div></td>";
									dataHtml+="</tr>";
									dataHtml+="</table>";
									dataHtml+="<br>";
									dataHtml+="<br>";
								}
						});
						
						document.getElementById("OkTravel").innerHTML = dataHtml;
					},
					error: function (xhr, o, err){
						console.log(xhr.status + ":" +o+":"+err);
						console.log(xhr.responseText);
					}

				});
				
			}
			
			function initMap() {
			      const myLatLng = {
			        lat: 36.17,
			        lng: 126.9
			      };
				
			    var map = new google.maps.Map(document.getElementById('map'), {
			      zoom: 1.63,
			      center: myLatLng,
			    });

			    var infowindow = new google.maps.InfoWindow();

			    var marker, i;
			    var image = new google.maps.MarkerImage('./img/gflagm.png');

			    for (i = 0; i < locationy.length-1; i++) {  
			      marker = new google.maps.Marker({
			        position: new google.maps.LatLng(locationy[i][1], locationy[i][2]),
			        map: map,
			        icon: image
			      });

			      google.maps.event.addListener(marker, 'click', (function(marker, i) {
			        return function() {
			          infowindow.setContent(locationy[i][0]);
			          infowindow.open(map, marker);
			          getCovidData(locationy[i][0]);
			        }

			      })(marker, i));
			    }    
			  }

			
			</script>
			<p> <%
		} 
	} catch(SQLException ex) {
		System.err.println("SQLException: "+ex.getMessage()); 
	}
	stmt.close(); myConn.close();
%>
 
  </head>



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


</body>
</html>
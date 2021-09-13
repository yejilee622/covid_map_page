<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<!-- xml to json xml을 json 형식으로 변경하기 위한 라이브러리를 추가 합니다. -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/fast-xml-parser/3.19.0/parser.min.js"></script>


<div id="map" style="width:70%; height:95vh; float:left; margin-right:10px"></div>
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
	Connection myConn = null; Statement stmt=null;
	ResultSet myResultSet = null; String mySQL ="";
	String dburl="jdbc:oracle:thin:@localhost:1521/xe";
	String user="db1610479"; String passwd="oracle";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	
	try{
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement();
	} catch(SQLException ex) {
		System.err.println("SQLException: "+ex.getMessage());
	}
	mySQL="select NATION_NM, ISOLATION_OK from OK_TRAVEL_2021_09";
try{
	myResultSet = stmt.executeQuery(mySQL);
	if(myResultSet != null) {
		int i=0;
		while(myResultSet.next()) {
			String c_nm_no = myResultSet.getString("NATION_NM");
			String str[] = new String[200];
			test += c_nm_no+",";
			str[i]=c_nm_no;
			}%>
		<script type="text/javascript">		
			function getCovidData(country_name){
				var countryStr = "<%=test%>";
				var countryList = countryStr.split(",");
				console.log(countryList, countryList);
				var countryStr2 = "<%=test2%>";
				var countryList2 = countryStr2.split(",");
				console.log(countryList2, countryList2);
				$.ajax({
					url: "http://localhost:8090/GetCovidData",
					type: "get",
					dataType: "text",
					success: function (data) {
						var jsonData = parser.parse(data);
						var dataHtml="";
						var nation_name = "";
					
						var items = jsonData.response.body.items.item; 
						
						var getParameters = function (paramName) { 
						var returnValue; 
						var url = location.href; 
						var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&'); 
						for (var i = 0; i < parameters.length; i++) { 
							var varName = parameters[i].split('=')[0]; 
							if (varName.toUpperCase() == paramName.toUpperCase()) { returnValue = parameters[i].split('=')[1]; return decodeURIComponent(returnValue); } } };
						
						nation_name=getParameters('nation_name');
						
						$.each(items, function(index, item){
							if(nation_name==item.nationNm) {
								dataHtml+=nation_name+"은 해외여행 가능 국가에 해당됩니다<br><br>";
							}
						}) 
						
						$.each(items, function(index, item){
								if(countryname==item.nationNm) {
									dataHtml+="<table width='50%' border>"; 
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
			
			getCovidData();
			
			function initMap() {
			      const myLatLng = {
			        lat: 36.17,
			        lng: 126.9
			      };

			    var locations = [
			      ['서울', 37.54, 127.22],
			      ['경기', 37.36, 127.33],
			      ['강원', 37.71, 128.2],
			      ['충남', 36.17, 126.9],
			      ['충북', 36.77, 127.7],
			      ['전남', 34.86, 126.92],
			      ['전북', 35.7, 127.28],
			      ['경남', 35.5, 128.43],
			      ['경북', 36.33, 128.52],
			      ['세종', 36.56, 127.24],
			      ['인천', 37.34, 126.65],
			      ['대구', 35.81, 128.6],
			      ['부산', 35.14, 129.05],
			      ['제주', 33.30, 126.48],
			      ['대전', 36.3, 127.42],
			      ['울산', 35.53, 129.26],
			      ['광주', 35.15, 126.95]

			    ];

			    var map = new google.maps.Map(document.getElementById('map'), {
			      zoom: 1.7,
			      center: myLatLng,
			    });

			    var infowindow = new google.maps.InfoWindow();

			    var marker, i;

			    for (i = 0; i < locations.length; i++) {  
			      marker = new google.maps.Marker({
			        position: new google.maps.LatLng(locations[i][1], locations[i][2]),
			        map: map
			      });

			      google.maps.event.addListener(marker, 'click', (function(marker, i) {
			        return function() {
			          infowindow.setContent(locations[i][0]);
			          infowindow.open(map, marker);
			          getCovidData(locations[i][0]);
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
  <body>
    <div id="map"> <div id="OkTravel"></div></div>
지도 위 마크를 클릭하시면 <br> 해당 국가의 코로나 발생 현황을 알 수 있습니다


<div id="data_Area"></div>
<div id="data_Name"></div>
<div id="data_Death"></div>
<div id="data_Covid"></div>
<div id="data_Rate"></div>

  <style type="text/css">

      /* Optional: Makes the sample page fill the window. */
      html,
      body {
      	background: #ffc0cb;
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


</body>
</html>
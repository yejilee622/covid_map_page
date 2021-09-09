<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
</head>
<body>
<div id="title" style="font-weight:bold; font-size:25px; color:gray;" align="center">코로나 여행정보 사이트 </div>
<div id="map" style="width:75%; height:75vh; float:left; margin-right:10px"></div>
<div style="float: left;">
<%
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
	mySQL="select COUN_NM from COUNTRY";
try{
	myResultSet = stmt.executeQuery(mySQL);
	if(myResultSet != null) {
		%>
		<select style="font-family: 'GowunBatang-Regular'; font-size:17px;" name="countrynames" id="countrynames"> <%
		while(myResultSet.next()) {
			String c_nm = myResultSet.getString("COUN_NM");
			%>
    		<option value="<%=c_nm %>"><%=c_nm%></option>
			<%
		}%>
		</select><br>
		<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
		<script type="text/javascript">

		function GoToNew() {
			var target = $('#countrynames').val();
			location.href="GetNewCovid.jsp?nation_name="+encodeURI(target,"UTF-8");
		}
		function GoToNo() {
			var target = $('#countrynames').val();
			location.href="GetNoTravel.jsp?nation_name="+encodeURI(target,"UTF-8");
		}
		function GoToOk() {
			var target = $('#countrynames').val();
			location.href="GetOkCovid.jsp?nation_name="+encodeURI(target,"UTF-8");
		}
		function GoToCity() {
			location.href="CityCovid.jsp";
		}
		function GoToWeather() {
			location.href="CityCovid.jsp";
		}
		function GoToPlace() {
			location.href="CityCovid.jsp";
		}
		function GoToStay() {
			location.href="CityCovid.jsp";
		}
		function a(ctn) {
			location.href="GetNewCovid.jsp?nation_name"+encodeURI(ctn,"UTF-8");
		}
		</script>
		<br>
		<input type=button class="button" id=gotonew value="해당 국가 코로나 현황 " style="font-family:GowunBatang-Regular" onclick="GoToNew();">
		<br><br>
		<input type=button class="button" id=gotonew value="격리 면제 국가 확인" style="font-family:GowunBatang-Regular" onclick="GoToNo();">
		<br><br>
		<input type=button class="button" id=gotonew value="해외여행 가능 국가" style="font-family:GowunBatang-Regular" onclick="GoToOk();">
		<br><br>
		<input type=button class="button" id=gotonew value="국내 지역별 코로나 현황 " style="font-family:GowunBatang-Regular" onclick="GoToCity();">
		<br><br>
		<input type=button class="button" id=gotonew value="세계 날씨 조회하기" style="font-family:GowunBatang-Regular" onclick="GoToNew();">
		<br><br>
		<input type=button class="button" id=gotonew value="관광지 알아보기" style="font-family:GowunBatang-Regular" onclick="GoToNew();">
		<br><br>
		<input type=button class="button" id=gotonew value="숙박시설 알아보기" style="font-family:GowunBatang-Regular" onclick="GoToNew();">
		</div><%
	} } catch(SQLException ex) {
		System.err.println("SQLException: "+ex.getMessage()); 
	}
	stmt.close(); myConn.close();
%>
  <br>
  <p>

    <style type="text/css">
      
      #bound {
      	height: 60%;
      	width: 60%;
      }
      
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      
      #map {
        height: 100%;
      }

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
@import url("https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap");
.button {
-webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
margin: 0;
  padding: 0.5rem 1rem;

  font-size: 1rem;
  font-weight: 400;
  text-align: center;
  text-decoration: none;

  display: inline-block;
  width: auto;

  border: none;
  border-radius: 4px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);

  cursor: pointer;

  transition: 0.5s;
}


    </style>
    
    
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLBoEc6SOFTtsotbLdVQg75x0IS3GzlGI&callback=initMap&libraries=&v=weekly"
      defer
    >
    </script>
    
    
  <script>
  
  function initMap() {
      const myLatLng = {
        lat: 37.55902624,
        lng: 126.9749014
      };

    var locations = [
      ['<a href="GetNewCovid.jsp">한국</a>', 37.5546788, 126.9706069],
      ['아르헨티나',	-36.3,	-60],
      ['호주',	-35.15,	149.0],
      ['오스트리아',	48.12,	16.22],
   ['브라질',	-15.47,	-47.55],
     [ '캄보디아',	11.33,	104.5],
      [ '캐나다',	45.27,	-75.42],
    [ '칠레',	-33.24,	-70.4],
   ['중국',	39.55,	116.2],
    [   '쿠바',	23.08,	-82.22],
     [  '체코',	50.05,	14.22],
     [  '콩고',	-4.2,	15.15],
    [   '덴마크',	55.41,	12.34],
     [  '이집트',	30.01,	31.14],
     [   '피지',	-18.06,	178.3],
     [  '핀란드',	60.15,	25.03],
    [   '프랑스',	48.5,	2.2],
    [   '독일',	52.30,	13.25],
     [  '가나',	5.35,	-0.06],
   [    '그리스',	37.58,	23.46],
    [   '그린란드',	64.1,	-51.35],
     [  '헝가리',	47.29,	19.05],
     [  '인도',	28.37,	77.13],
     [  '인도네시아',	-6.09,	106.4],
    [   '아일랜드',	53.21,	-6.15],
     [  '이스라엘',	31.71,	-35.1],
   [    '이탈리아',	41.54,	12.29],
    [   '라오스', 17.58,	102.3],
   [    '룩셈부르크',	49.37,	6.09],
    [   '마카오',	22.12,	113.3],
    [   '마다가스카르',-18.55,	47.31],
  [     '마케도니아',	42.01,	21.26],
  [     '말레이시아',	3.09,	101.4],
   [    '몰디브',	4, 73.28],
    [   '멕시코',	19.2,	-99.1],
   [    '네덜란드',	52.23,	4.54],
   [    '뉴칼레도니아',	-22.17,	166.3],
   [    '뉴질랜드',	-41.19,	174.4],
 [      '노르웨이',	59.55,	10.45],
 [      '팔라우',	7.2,	134.2],
 [      '페루',	-12,	-77],
 [      '필리핀',	14.4,	121],
 [      '폴란드',	52.13,	21],
 [      '포르투갈',	38.42,	-9.1],
 [      '카타르',	25.15,	51.35],
 [      '루마니아',	44.27,	26.1],
 [      '러시아',	55.45,	37.35],
 [      '사우디아라비아',	24.41,	46.42],
  [     '스페인',	40.25,	-3.45],
 [      '스웨덴',	59.2,	18.03],
 [      '스위스',	46.57,	7.28],
 [      '태국',	13.45,	100.3],
 [      '터키',	39.57,	32.54],
  [     '아랍에미리트',	24.28,	54.22],
 [      '영국',	51.36,	-0.05],
 [      '미국',	39.91,	-77.02],
 [      '베네수엘라',	10.3,	-66.55],
 [      '베트남',	21.05,	105.5]

    ];

    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 1.4,
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
          
        }
      })(marker, i));
    }    
  }
    
    </script>
  </head>
  <body>

  <div id = "bound">
    <div id="map">
    	<div align="right">지도 위 마크를 클릭하시면 해당 국가의 코로나 발생 현황을 알 수 있습니다</div>
    </div>
  </div>
  
  <div id="myname"></div>
 
</body>
</html>
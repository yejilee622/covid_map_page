<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://kit.fontawesome.com/2e8e01c4a1.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
</head>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<script type="text/javascript">			
$(document).ready(function geoGet(){
	$.ajax({
		url:"https://api.openweathermap.org/data/2.5/onecall",
		method:"GET",
		data:{"lat":"37.525",
			"lon":"126.928",
			"lang":"kr",
			"units":"metric",
			"appid":"3bf49017d9d50f294c1795956f5e7e6b"},
		datatype:"JSON",
		success: function (geodata){
			var datahtml="";
			console.log(geodata);
			datahtml='<img src="http://openweathermap.org/img/wn/'+geodata.daily[0].weather[0].icon+'@2x.png" width="40px" height="40px" alt="">';
			document.getElementById("hi").innerHTML=datahtml;
			datahtml=geodata.current.weather[0].description;
			document.getElementById("des").innerHTML=datahtml;
			datahtml=Math.round(geodata.current.temp)+"°C";
			document.getElementById("now").innerHTML=datahtml;
			datahtml=Math.round(geodata.daily[0].temp.min)+"°C";
			document.getElementById("low").innerHTML=datahtml;
			datahtml=Math.round(geodata.daily[0].temp.max)+"°C";
			document.getElementById("high").innerHTML=datahtml;
			
		} 
	});
});

</script>
<div id="ta" class="tt" style="font-weight:bold; font-size:25px; color:gray;" align="center">코트맵</div>
<div id="title" class="tt" style="font-weight:bold; font-size:20px; color:gray;" align="center">Covid Travel Map</div>
    <div class="Container">
  <div class="item1">
    <i class="fas fa-plane-departure"></i>
  </div>
  <div class="item2" style="color: gray;
  font-weight: bold;
  transition: all 1s;
  cursor: pointer;">
    <li><a onclick="GoToNew();">코로나 현황</a></li>
    <li><a onclick="GoToNo()">격리 면제 확인</span></a></li>
    <li><a onclick="GoToOk()"><span class="red">해외여행 가능</span></a></li>
    <li><a onclick="GoToCity()">국내 지역별 현황</a></li>
    <li><a onclick="GoToWeather()">날씨 조회</a></li>
    <li><a onclick="GoToPlace()">관광지 정보</a></li>
    <li><a onclick="GoToFly()">항공권 예약</a></li>
  </div>
  <div class="item3">
    <i id="hi"></i>
    <span id="now"></span>
    <span id="des"></span>
    <br />
    <div class="hh">
    <span id="low" class="blue"></span>/
    <span id="high" class="red"></span>
    </div>
  </div>
  <div class="barmenu">
    <i class="fas fa-bars"></i>
  </div>
</div>
    <%
	Connection myConn = null; 
	Statement stmt=null;
	Statement stmt2=null;
	ResultSet myResultSet = null;
	ResultSet myResultSet2 = null;
	String mySQL = "";
	String mySQL2 = "";
	String test = "";
    String test2 = "";
	String dburl="jdbc:oracle:thin:@localhost:1521/xe";
	String user="db1610479"; String passwd="casiopea86";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	
	try{
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement();
		stmt2 = myConn.createStatement();
	} catch(SQLException ex) {
		System.err.println("SQLException: "+ex.getMessage());
	}
	mySQL="select COUN_NM from COUNTRY";
	mySQL2="select NATION_NM from OK_TRAVEL_2021_09";
try{
	myResultSet = stmt.executeQuery(mySQL);
	if(myResultSet != null) {
		%>
		<div align="center"><select class="form-control" style="font-family: 'GowunBatang-Regular'; font-size:17px;" name="countrynames" id="countrynames"> <%
		while(myResultSet.next()) {
			String c_nm = myResultSet.getString("COUN_NM");
			test += c_nm+",";
			%>
    		<option value="<%=c_nm %>"><%=c_nm%></option>
			<%
		}%>
		</select></div><br>
		<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
		<script type="text/javascript">
		var target
		function GoToNew() {
			target = $('#countrynames').val();
			location.href="GetNewCovid.jsp?nation_name="+encodeURI(target,"UTF-8");
		}
		function GoToNo() {
			target = $('#countrynames').val();
			location.href="GetNoTravel.jsp?nation_name="+encodeURI(target,"UTF-8");
		}
		function GoToOk() {
			target = $('#countrynames').val();
			location.href="GetOkCovid.jsp?nation_name="+encodeURI(target,"UTF-8");
		}
		function GoToCity() {
			location.href="CityCovid.jsp";
		}
		function GoToWeather() {
			target = $('#countrynames').val();
			location.href="Weather.jsp?nation_name="+encodeURI(target,"UTF-8");
		}
		function GoToPlace() {
			target = $('#countrynames').val();
			location.href="place_check.jsp?nation_name="+encodeURI(target,"UTF-8");
		}
		function GoToFly() {
			var url = "https://flyasiana.com/I/KR/KO/LowerPriceSearchList.do?menuId=CM201802220000728256&gclid=Cj0KCQjws4aKBhDPARIsAIWH0JVzLRj2YYOHk2klVkJKjRBA2yJGCuRwn3CdLbcw2c99MQtA0qtArDIaApnHEALw_wcB#none";
			var name = "아시아나 최저가 항공권 검색하기";
			var option = "width = 1100, height = 800, left = 80, top = 100, location = no"
			window.open(url, name, option);
		}
		</script><%
	}
	
	myResultSet2 = stmt2.executeQuery(mySQL2);
	
	if(myResultSet2 != null) {
		while(myResultSet2.next()) {
			String c_nm2 = myResultSet2.getString("NATION_NM");
			test2 += c_nm2+",";
		}
	}
	
} catch(SQLException ex) {
		System.err.println("SQLException: "+ex.getMessage()); 
	}
	stmt.close(); myConn.close();
%>
<div id="map" style="width:100%; height:100vh;"></div>

  <br>
  <p>
  
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

    .form-control{
    	width: 20%;
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
        
.blue {
  color: blue;
}
.gray {
  color: gray;
}
.red {
  color: red;
}
.tt{
  background-color : #D4BAB0;
}
a{
  text-decoration: none;
}
.Container {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}
.item1 {
  border-radius: 4px;
}
.item2 {
  display: flex;
  flex-direction: row;
  align-items: center;
}
.item2>li {
  padding: 12px;
}
.item2>li>a {
  color: gray;
  font-weight: bold;
  transition: all 1s;
  cursor: pointer;
}
.item2>li>a:hover{
  color: lightgray!important;
}
.item3 {
  padding: 15px;
}
li {
  list-style:none
}
.item1>i {
  font-size: 35px;
  padding: 32px;
}
.item3>i {
  padding-right: 10px;
}

.hh {
  padding-left: 30px;
}

.barmenu {
  display: none;
}
@media screen and (max-width:700px){
  .Container {
    display: flex;
    flex-direction: column;
  }
  .item2 {
    display: none;
    flex-direction: column;
  }
  .item3 {
    display: none;
  }
  .item2.active {
    display: flex;
  } 
  .barmenu {
    position: absolute;
  right: 20px;
  font-size: 24px;
  padding: 15px;
    display: block;
  }
}

    </style>
    
    
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLBoEc6SOFTtsotbLdVQg75x0IS3GzlGI&callback=initMap&libraries=&v=weekly"
      defer
    >
    </script>
    
  <script type="text/javascript">
  
	let countryStr = "<%=test%>";
	let countryList = countryStr.split(",");
	let countryStr2 = "<%=test2%>";
	let countryList2 = countryStr2.split(",");
  
  function initMap() {
      const myLatLng = {
        lat: 37.55902624,
        lng: 126.9749014
      };

 //     '<a href="GetNewCovid.jsp?nation_name=한국">한국</a>'
      
    var locations = [
      ['한국', 37.5546788, 126.9706069],
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
 [      '베트남',	21.05,	105.5],
 ['알제리', 27.81, -7.36],
 ['리비아', 26.09, 8.29],
      ['에티오피아', 9.13, 35.998],
      ['남아프리카공화국', -33.23, 9.11],
      ['탄자니아', -6.34, 30.48],
      ['수단', 15.62, 21.2],
      ['차드', 15.28, 9.68],
      ['앙골라', -11.05, 8.72]

    ];

    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 2.3,
      center: myLatLng,
    });

    var infowindow = new google.maps.InfoWindow();

    var marker, i;

    var image = new google.maps.MarkerImage('./img/gflagm.png');
    var image2 = new google.maps.MarkerImage('./img/rflagm.png');
    
    for (i = 0; i < locations.length; i++) {  
        for (var k=0; k<countryList2.length; k++) {
        	if(locations[i][0]==countryList2[k]) {
        		marker = new google.maps.Marker({
        	        position: new google.maps.LatLng(locations[i][1], locations[i][2]),
        	        map: map,
        			icon: image
        		})
        		break;
        	}
        }
        if (k>=countryList2.length) {
    		marker = new google.maps.Marker({
    	        position: new google.maps.LatLng(locations[i][1], locations[i][2]),
    	        map: map,
    			icon: image2
    		})
    	}
        
        google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
              infowindow.setContent(locations[i][0]);
              infowindow.open(map, marker);
            }
          })(marker, i));
        
	};

      
    }  
  
  
    
    </script>
  </head>
  <body>

  <div id = "bound">
    	<div align="center">초록색 깃발에 해당하는 나라는 현재 해외여행이 가능한 국가입니다</div>
  </div>
  
  <div id="myname"></div>
 
</body>
</html>
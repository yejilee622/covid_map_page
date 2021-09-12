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

<!-- xml to json xml을 json 형식으로 변경하기 위한 라이브러리를 추가 합니다. -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/fast-xml-parser/3.19.0/parser.min.js"></script>


<div id="map" style="width:40%; height:95vh; float:left; margin-right:10px"></div>
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
    
    
  <script>
  
  function initMap() {
      const myLatLng = {
        lat: 36.17,
        lng: 126.9
      };

    var locations = [
      ['<a href="GetNewCovid.jsp">대한민국</a>', 37.5546788, 126.9706069],
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
      zoom: 7,
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
          getCityCovid(locations[i][0]);
        }

      })(marker, i));
    }    
  }
  
  function getCityCovid(cityname){
		$.ajax({
			url: "http://localhost:8090/GetCityCovid",
			type: "get",
			dataType: "text",
			success: function (data) {
				var jsonData = parser.parse(data);
				var dataHtml="";
				
				// 국가별 코로나 현황 리스트
				var items = jsonData.response.body.items.item; 
				
				$.each(items, function(index, item){
					console.log(item.gubun);
						if(item.gubun==cityname) {
							dataHtml+="<table width='50%' border>"; 
							dataHtml+="<tr><td>시도명</td>";
							dataHtml+="<td><div id='City_a'>"+item.gubun+"</div></td>";
							dataHtml+="</tr>";
							dataHtml+="<tr>";
							dataHtml+="<td>사망자 수</td>";
							dataHtml+="<td><div id='City_b'>"+item.deathCnt+"</div></td>";
							dataHtml+="</tr>";
							dataHtml+="<tr>";
							dataHtml+="<td>전일대비 증감 수</td>";
							dataHtml+="<td><div id='City_c'>"+item.incDec+"</div></td>";
							dataHtml+="</tr>";
							dataHtml+="<tr>";
							dataHtml+="<td>격리 해제 수</td>";
							dataHtml+="<td><div id='City_d'>"+item.isolClearCnt+"</div></td>";
							dataHtml+="</tr>";
							dataHtml+="<tr>";
							dataHtml+="<td>10만명 당 발생률</td>";
							dataHtml+="<td><div id='City_e'>"+item.qurRate+"</div></td>";
							dataHtml+="</tr>";
							dataHtml+="<td>기준일시</td>";
							dataHtml+="<td><div id='City_f'>"+item.stdDay+"</div></td>";
							dataHtml+="</tr>";
							dataHtml+="<tr>";
							dataHtml+="<td>확진자 수</td>";
							dataHtml+="<td><div id='City_g'>"+item.defCnt+"</div></td>";
							dataHtml+="</tr>";
							dataHtml+="<tr>";
							dataHtml+="<td>격리중 환자 수</td>";
							dataHtml+="<td><div id='City_h'>"+item.isolIngCnt+"</div></td>";
							dataHtml+="</tr>";
							dataHtml+="<tr>";
							dataHtml+="<td>해외유입 수</td>";
							dataHtml+="<td><div id='City_i'>"+item.overFlowCnt+"</div></td>";
							dataHtml+="</tr>";
							dataHtml+="<tr>";
							dataHtml+="<td>지역발생 수</td>";
							dataHtml+="<td><div id='City_j'>"+item.localOccCnt+"</div></td>";
							dataHtml+="</tr>";
							dataHtml+="<tr>";
							dataHtml+="</table>";
							dataHtml+="<br>";
							dataHtml+="<br>";
						}
				});
				
				document.getElementById("CityData").innerHTML = dataHtml;
			},
			error: function (xhr, o, err){
				console.log(xhr.status + ":" +o+":"+err);
				console.log(xhr.responseText);
			}

		});
  }
    </script>
  </head>
  <body>
    <div id="map"> <div id="CityData"></div></div>
지도 위 마크를 클릭하시면 해당 지역의 코로나 발생 현황을 알 수 있습니다


<div id="City_a"></div>
<div id="City_b"></div>
<div id="City_c"></div>
<div id="City_d"></div>
<div id="City_e"></div>
<div id="City_f"></div>
<div id="City_g"></div>
<div id="City_h"></div>
<div id="City_i"></div>
<div id="City_j"></div>

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
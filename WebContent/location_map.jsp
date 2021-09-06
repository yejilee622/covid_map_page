<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Google Multiple Markers</title>

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
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}
</style>


<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBKdEHCI-Q7WgtM60yidkYxZoApQmbGz-E&callback=initMap&libraries=&v=weekly"
	defer>
    </script>

<!-- 소스자동정렬 : Ctrl + Shift + f -->
<script>
  
    function initMap() {
    	
    	// 표시해줄 위치를 지정
		const myLatLng = {
			lat: 37.55902624,
			lng: 126.9749014
		};
	 
    	// 마커를 표시할 리스트
		var locations = [
		  ['서울역', 37.5546788, 126.9706069],
		  ['서울특별시청', 37.5668260, 126.9786567],
		  ['을지로입구역', 37.5660373, 126.9821930],
		  ['덕수궁', 37.5655638, 126.974894],
		];
    
    	// 현재위치를 표시해봅시다!!!!!
	    // geolocation 객체가 존재하는 경우 위치 정보 서비스를 지원하는 것입니다
	    if('geolocation' in navigator) {
			// getCurrentPosition() 메서드를 호출해서 사용자의 현재 위치를 얻을 수 있습니다.
			const watchID = navigator.geolocation.getCurrentPosition((position) => {
				
				// 현재 위치로 변경 해줍니다.
				myLatLng.lat = position.coords.latitude;
				myLatLng.lng = position.coords.longitude;
				
				// 화면에 그려줍니다.
				drewMap(myLatLng, locations);	;
			});
	  	  
	  	  
	  	} else {
	  		// 서비스를 지원 하지 않는경우
	  		alert(" 현재 위치를 찾을수 없습니다.");
			drewMap(myLatLng, locations);	
	  	}
	}
  
    // 지도에 위치를 표시해줍니다.
	function drewMap(myLatLng){
		var map = new google.maps.Map(document.getElementById('map'), {
		    zoom: 14,
		    center: myLatLng,
		});
		
		// 현재위치를 마커로 표시 해줍니다.
		new google.maps.Marker({
		    position: myLatLng,
		    map,
		    title: "현재위치",
		  });
		
		
	}
    
    </script>
</head>
<body>
	<div id="bound">
		<div id="map"></div>
	</div>
</body>
</html>
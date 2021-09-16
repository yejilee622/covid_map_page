<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script async
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLBoEc6SOFTtsotbLdVQg75x0IS3GzlGI&libraries=localContext&v=beta&callback=initMap">
</script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script type="text/javascript">	
let map;

function initMap() {
  const localContextMapView = new google.maps.localContext.LocalContextMapView({
    element: document.getElementById("map"),
    placeTypePreferences: [
      { type: "restaurant" },
      { type: "tourist_attraction" },
    ],
    maxPlaceCount: 12,
    placeDetailsViewSetup: {hidesOnMapClick: false},
  	locationRestriction : null
  });
  
  map = localContextMapView.map;
  map.setOptions({
    center: { lat: 51.507307, lng: -0.08114 },
    zoom: 14,
  });
  localContextMapView.search();
}
  
</script>
<style>
#map {
  height: 100%;
}

/* Optional: Makes the sample page fill the window. */
html,
body {
  height: 100%;
  margin: 0;
  padding: 0;
</style>
<!DOCTYPE html>
<html>
  <head>
    <title>관광지 정보 알아보기</title>

  </head>
  <body>
    <div id="map"></div>

  </body>
</html>
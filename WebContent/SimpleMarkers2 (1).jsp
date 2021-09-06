<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Google Multiple Markers </title>

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
        height: 100%;
        margin: 0;
        padding: 0;
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
      ['<a href="a.html">서울역</a>', 37.5546788, 126.9706069],
      ['서울특별시청', 37.5668260, 126.9786567],
      ['을지로입구역', 37.5660373, 126.9821930],
      ['덕수궁', 37.5655638, 126.974894],
    ];

    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 14,
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
    <div id="map"></div>
  </div>
  </body>
</html>
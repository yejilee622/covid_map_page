<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script type="text/javascript">	
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
//This example requires the Places library. Include the libraries=places

function initMap() {
// Create the map.
const pyrmont = { lat: -33.866, lng: 151.196 };
const map = new google.maps.Map(document.getElementById("map"), {
 center: pyrmont,
 zoom: 17,
 mapId: "8d193001f940fde3",
});
// Create the places service.
const service = new google.maps.places.PlacesService(map);
let getNextPage;
const moreButton = document.getElementById("more");

moreButton.onclick = function () {
 moreButton.disabled = true;
 if (getNextPage) {
   getNextPage();
 }
};

// Perform a nearby search.
service.nearbySearch(
 { location: pyrmont, radius: 500, type: "store" },
 (results, status, pagination) => {
   if (status !== "OK" || !results) return;

   addPlaces(results, map);
   moreButton.disabled = !pagination || !pagination.hasNextPage;
   if (pagination && pagination.hasNextPage) {
     getNextPage = () => {
       // Note: nextPage will call the same handler function as the initial call
       pagination.nextPage();
     };
   }
 }
);
}

function addPlaces(places, map) {
const placesList = document.getElementById("places");

for (const place of places) {
 if (place.geometry && place.geometry.location) {
   const image = {
     url: place.icon,
     size: new google.maps.Size(71, 71),
     origin: new google.maps.Point(0, 0),
     anchor: new google.maps.Point(17, 34),
     scaledSize: new google.maps.Size(25, 25),
   };

   new google.maps.Marker({
     map,
     icon: image,
     title: place.name,
     position: place.geometry.location,
   });

   const li = document.createElement("li");

   li.textContent = place.name;
   placesList.appendChild(li);
   li.addEventListener("click", () => {
     map.setCenter(place.geometry.location);
   });
 }
}
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
    <title>Place Searches</title>

  </head>
  <body>
    <div id="map"></div>
    <div id="li"></div>

    <!-- Async script executes immediately and must be after any DOM elements used in callback. -->
    <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLBoEc6SOFTtsotbLdVQg75x0IS3GzlGI&callback=initMap&libraries=places&v=weekly"
      async
    ></script>
  </body>
</html>
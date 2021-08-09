<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>코로나 여행정보</title>

</head>
<body>
코로나 여행 정보
<br>
<div id="map" style="width:75%; height:75vh; float:left; margin-right:10px"></div>

<div style="float: left;">
국가를 선택해주세요
<br>
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
		<select name="countrynames"> <%
		while(myResultSet.next()) {
			String c_nm = myResultSet.getString("COUN_NM");
			%>
    		<option value="ctn"><%=c_nm %></option>
			<%
		}%>
		</select>
		</div><%
	} } catch(SQLException ex) {
		System.err.println("SQLException: "+ex.getMessage()); 
	}
	stmt.close(); myConn.close();
%>


  <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDT7sSTMO5sgyqu_1l0KuaIK_QAyv0U44c&callback=initMap&region=kr"></script>
  <script>
    function initMap() {
      var longlat = { lat: 37.5642135 ,lng: 127.0016985 };
      var seoul = { lat: 37.5642135 ,lng: 127.0016985 };
      var map = new google.maps.Map(
        document.getElementById('map'), {
          zoom: 2,
          center: seoul
                             
        });
      addMarker(longlat, map);
    
    };
      
      function addMarker(longlat, map) {
    	  new google.maps.Marker({
    	    position: longlat,
    	    map: map,
    	    icon: "http://localhost:8090/DatabaseProgramming/img/gflagm.png"
    	  });  
      };
      
  </script>
  
  <table>
  <tr>
  <td align="center"><b><a href="sub_covid_page.jsp">선택한 국가 탐색</b></td>
  </tr>
  </table>
 
</body>
</html>
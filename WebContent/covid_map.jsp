<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�ڷγ� ��������</title>

</head>
<body>

�ڷγ� ���� ����
<br>
<div id="map" style="width:75%; height:75vh; float:left; margin-right:10px"></div>

<div style="float: left;">
������ �������ּ���
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
		<br>
		<select name="countrynames" id="countrynames" onchange=SetBox()> <%
		while(myResultSet.next()) {
			String c_nm = myResultSet.getString("COUN_NM");
			%>
    		<option value="ctn"><%=c_nm %></option>
			<%
		}%>
		</select><br>
		<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
		<script type="text/javascript">
		function SetBox() {
		var target = document.getElementById("countrynames");
		}
		</script>
		<br>
		<a href="GetNewCovid.jsp">�ڷγ� ��Ȳ ����</b>
		<br><br>
		<a href="GetNewCovid.jsp">�ݸ����� �ش� Ȯ��</b>
		<br><br>
		<a href="GetNewCovid.jsp">���� ��ȸ�ϱ�</b>
		<br><br>
		<a href="GetNewCovid.jsp">������ �˾ƺ���</b>
		<br><br>
		<a href="GetNewCovid.jsp">���ڽü� �˻��ϱ�</b>
		</div><%
	} } catch(SQLException ex) {
		System.err.println("SQLException: "+ex.getMessage()); 
	}
	stmt.close(); myConn.close();
%>


  <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLBoEc6SOFTtsotbLdVQg75x0IS3GzlGI&callback=initMap&region=kr"></script>
  <script>
    function initMap() {
      var longlat = { lat: 37.5642135 ,lng: 127.0016985 }; //��¥ ����
      var seoul = { lat: 15, lng: 127.0016985 };
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
    	    icon: "http://localhost:8090/img/gflagm.png"
    	  });  
    	  
      };
      
  </script>
  <br>
  <p>

 
</body>
</html>
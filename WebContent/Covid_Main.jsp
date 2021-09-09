<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
</head>
<body>
<div id="title" style="font-weight:bold; font-size:25px; color:gray;" align="center">�ڷγ� �������� ����Ʈ </div>
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
		<input type=button class="button" id=gotonew value="�ش� ���� �ڷγ� ��Ȳ " style="font-family:GowunBatang-Regular" onclick="GoToNew();">
		<br><br>
		<input type=button class="button" id=gotonew value="�ݸ� ���� ���� Ȯ��" style="font-family:GowunBatang-Regular" onclick="GoToNo();">
		<br><br>
		<input type=button class="button" id=gotonew value="�ؿܿ��� ���� ����" style="font-family:GowunBatang-Regular" onclick="GoToOk();">
		<br><br>
		<input type=button class="button" id=gotonew value="���� ������ �ڷγ� ��Ȳ " style="font-family:GowunBatang-Regular" onclick="GoToCity();">
		<br><br>
		<input type=button class="button" id=gotonew value="���� ���� ��ȸ�ϱ�" style="font-family:GowunBatang-Regular" onclick="GoToNew();">
		<br><br>
		<input type=button class="button" id=gotonew value="������ �˾ƺ���" style="font-family:GowunBatang-Regular" onclick="GoToNew();">
		<br><br>
		<input type=button class="button" id=gotonew value="���ڽü� �˾ƺ���" style="font-family:GowunBatang-Regular" onclick="GoToNew();">
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
      ['<a href="GetNewCovid.jsp">�ѱ�</a>', 37.5546788, 126.9706069],
      ['�Ƹ���Ƽ��',	-36.3,	-60],
      ['ȣ��',	-35.15,	149.0],
      ['����Ʈ����',	48.12,	16.22],
   ['�����',	-15.47,	-47.55],
     [ 'į�����',	11.33,	104.5],
      [ 'ĳ����',	45.27,	-75.42],
    [ 'ĥ��',	-33.24,	-70.4],
   ['�߱�',	39.55,	116.2],
    [   '���',	23.08,	-82.22],
     [  'ü��',	50.05,	14.22],
     [  '���',	-4.2,	15.15],
    [   '����ũ',	55.41,	12.34],
     [  '����Ʈ',	30.01,	31.14],
     [   '����',	-18.06,	178.3],
     [  '�ɶ���',	60.15,	25.03],
    [   '������',	48.5,	2.2],
    [   '����',	52.30,	13.25],
     [  '����',	5.35,	-0.06],
   [    '�׸���',	37.58,	23.46],
    [   '�׸�����',	64.1,	-51.35],
     [  '�밡��',	47.29,	19.05],
     [  '�ε�',	28.37,	77.13],
     [  '�ε��׽þ�',	-6.09,	106.4],
    [   '���Ϸ���',	53.21,	-6.15],
     [  '�̽���',	31.71,	-35.1],
   [    '��Ż����',	41.54,	12.29],
    [   '�����', 17.58,	102.3],
   [    '����θ�ũ',	49.37,	6.09],
    [   '��ī��',	22.12,	113.3],
    [   '���ٰ���ī��',-18.55,	47.31],
  [     '���ɵ��Ͼ�',	42.01,	21.26],
  [     '�����̽þ�',	3.09,	101.4],
   [    '�����',	4, 73.28],
    [   '�߽���',	19.2,	-99.1],
   [    '�״�����',	52.23,	4.54],
   [    '��Į�����Ͼ�',	-22.17,	166.3],
   [    '��������',	-41.19,	174.4],
 [      '�븣����',	59.55,	10.45],
 [      '�ȶ��',	7.2,	134.2],
 [      '���',	-12,	-77],
 [      '�ʸ���',	14.4,	121],
 [      '������',	52.13,	21],
 [      '��������',	38.42,	-9.1],
 [      'īŸ��',	25.15,	51.35],
 [      '�縶�Ͼ�',	44.27,	26.1],
 [      '���þ�',	55.45,	37.35],
 [      '����ƶ���',	24.41,	46.42],
  [     '������',	40.25,	-3.45],
 [      '������',	59.2,	18.03],
 [      '������',	46.57,	7.28],
 [      '�±�',	13.45,	100.3],
 [      '��Ű',	39.57,	32.54],
  [     '�ƶ����̸�Ʈ',	24.28,	54.22],
 [      '����',	51.36,	-0.05],
 [      '�̱�',	39.91,	-77.02],
 [      '���׼�����',	10.3,	-66.55],
 [      '��Ʈ��',	21.05,	105.5]

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
    	<div align="right">���� �� ��ũ�� Ŭ���Ͻø� �ش� ������ �ڷγ� �߻� ��Ȳ�� �� �� �ֽ��ϴ�</div>
    </div>
  </div>
  
  <div id="myname"></div>
 
</body>
</html>
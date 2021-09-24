<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>격리 면제 제외 국가 탐색</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

</head>
<body>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<!-- xml to json xml을 json 형식으로 변경하기 위한 라이브러리를 추가 합니다. -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/fast-xml-parser/3.19.0/parser.min.js"></script>
<div align=center>
<br>
아래 해당 국가들은 2차 백신 접종 완료에도<br>
격리 면제가 적용되지 않는 국가들입니다 (2021.09 외교부 해외안전여행)<br>

</div>
<%
	String test = "";
	Connection myConn = null; Statement stmt=null;
	ResultSet myResultSet = null; String mySQL ="";
	String dburl="jdbc:oracle:thin:@localhost:1521/xe";
	String user="db1610479"; String passwd="casiopea86";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	
	try{
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement();
	} catch(SQLException ex) {
		System.err.println("SQLException: "+ex.getMessage());
	}
	mySQL="select COUN_NM from NO_TRAVLE_2021_09";
try{
	myResultSet = stmt.executeQuery(mySQL);
	if(myResultSet != null) {
		int i=0;
		while(myResultSet.next()) {
			String c_nm_no = myResultSet.getString("COUN_NM");
			String str[] = new String[200];
			test += c_nm_no+",";
			str[i]=c_nm_no;
			}%>
		<script type="text/javascript">		
			function getCovidData(){
				var countryStr = "<%=test%>";
				var countryList = countryStr.split(",");
				console.log(countryList, countryList);
				$.ajax({
					url: "http://localhost:8090/GetCovidData",
					type: "get",
					dataType: "text",
					success: function (data) {
						var jsonData = parser.parse(data);
						const element = document.getElementById("c_nm_new");
						var dataHtml="";
						
						var nation_name = "";
					
						var items = jsonData.response.body.items.item; 
						
						var getParameters = function (paramName) { 
						var returnValue; 
						var url = location.href; 
						var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&'); 
						for (var i = 0; i < parameters.length; i++) { 
							var varName = parameters[i].split('=')[0]; 
							if (varName.toUpperCase() == paramName.toUpperCase()) { returnValue = parameters[i].split('=')[1]; return decodeURIComponent(returnValue); } } };
						
						nation_name=getParameters('nation_name');
						
						// 국가별 코로나 현황 리스트
						var items = jsonData.response.body.items.item; 
						
						$.each(items, function(index, item){
							if(nation_name==item.nationNm) {
								dataHtml+='<div class="blinking">'+nation_name+'은(는) 격리면제 국가에 해당되지 않습니다</div><br>';
							}
						}) 
						
						$.each(items, function(index, item){
							$.each(countryList, function(i, countryname){
								if(countryname==item.nationNm) {
									dataHtml+='<table class="table-striped table-sm" width="50%">'; 
									dataHtml+="<tr><td>대륙명</td>";
									dataHtml+="<td><div id='data_Ar'>"+item.areaNm+"</div></td>";
									dataHtml+="</tr>";
									dataHtml+="<tr>";
									dataHtml+="<td>국가명</td>";
									dataHtml+="<td><div id='data_Nm'>"+item.nationNm+"</div></td>";
									dataHtml+="</tr>";
									dataHtml+="<tr>";
									dataHtml+="<td>총 사망자 수</td>";
									dataHtml+="<td><div id='data_Dt'>"+item.natDeathCnt+"</div></td>";
									dataHtml+="</tr>";
									dataHtml+="<tr>";
									dataHtml+="<td>총 확진자 수</td>";
									dataHtml+="<td><div id='data_Kt'>"+item.natDefCnt+"</div></td>";
									dataHtml+="</tr>";
									dataHtml+="<tr>";
									dataHtml+="<td>확진률 대비 사망률(백분율)</td>";
									dataHtml+="<td><div id='data_Br'>"+item.natDeathRate+"</div></td>";
									dataHtml+="</tr>";
									dataHtml+="</table>";
									dataHtml+="<br>";
									dataHtml+="<br>";
								}
							});
						});
						
						document.getElementById("NoTravel").innerHTML = dataHtml;
					},
					error: function (xhr, o, err){
						console.log(xhr.status + ":" +o+":"+err);
						console.log(xhr.responseText);
					}

				});
				
			}
			
			getCovidData();
			
			</script>
			<p> <%
		} 
	} catch(SQLException ex) {
		System.err.println("SQLException: "+ex.getMessage()); 
	}
	stmt.close(); myConn.close();
%>
<p>

<div id="NoTravel" width=700 height=700 align=center>
</div>

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
	    
    .blinking{ -webkit-animation:blink 1.5s ease-in-out infinite alternate; 
    -moz-animation:blink 1.5s ease-in-out infinite alternate; 
    animation:blink 1.5s ease-in-out infinite alternate; } 
    
    @-webkit-keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} } 
    
    @-moz-keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} } 
    
    @keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} }
    </style>

 
</body>
</html>
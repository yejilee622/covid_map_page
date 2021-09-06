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

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<!-- xml to json xml을 json 형식으로 변경하기 위한 라이브러리를 추가 합니다. -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/fast-xml-parser/3.19.0/parser.min.js"></script>

아래 해당 국가들은 격리 면제가 적용되지 않는 국가들입니다
<br>
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
	mySQL="select COUN_NM from NO_TRAVLE_2021_09";
try{
	myResultSet = stmt.executeQuery(mySQL);
	if(myResultSet != null) {
		int i=0;
		while(myResultSet.next()) {
			String c_nm_no = myResultSet.getString("COUN_NM");
			String str[] = new String[200];
			str[i]=c_nm_no; %>
			<div id=c_nm_new onchange=getCovidData() value><%=str[i++]%> </div>
			<%
			}%>
		<script type="text/javascript">		

			function getCovidData(){

				$.ajax({
					url: "http://localhost:8090/GetCovidData",
					type: "get",
					dataType: "text",
					success: function (data) {
						var jsonData = parser.parse(data);
						const element = document.getElementById("c_nm_new");
						
						// 국가별 코로나 현황 리스트
						var items = jsonData.response.body.items.item; 
						console.log(element.innerHTML);
						
						$.each(items, function(index, item){
							console.log(item.areaNm);
							if(item.nationNm == '가나'){
								var covid_data="";
								console.log(item.nationNm + '의 확진자 현황');
								document.getElementById("data_Nm").innerHTML=item.nationNm;
								console.log('대륙명: ' + item.areaNm);
								document.getElementById("data_Ar").innerHTML=item.areaNm;
								console.log('국가명: ' + item.nationNm);
								console.log('총 사망자 수: ' + item.natDeathCnt);
								document.getElementById("data_Dt").innerHTML=item.natDeathCnt;
								console.log('총 확진자 수: ' + item.natDefCnt);
								document.getElementById("data_Kt").innerHTML=item.natDefCnt;
								console.log('확진률 대비 사망률(백분율): ' + item.natDeathRate);
								document.getElementById("data_Br").innerHTML=item.natDeathRate;
							}
							
							
						});
					},
					error: function (xhr, o, err){
						console.log(xhr.status + ":" +o+":"+err);
						console.log(xhr.responseText);
					}

				});
				
			}

			</script>
			<p> <%
		} 
	} catch(SQLException ex) {
		System.err.println("SQLException: "+ex.getMessage()); 
	}
	stmt.close(); myConn.close();
%>
<p>

<input type='button'  onclick='getCovidData()' value="코로나 발생 현황 데이터 가지고 오기">

<br> <table width="75%" align="center" border> 
<tr><td>대륙명</td>
<td><div id="data_Ar"></div></td>
</tr>
<tr>
<td>국가명</td>
<td><div id="data_Nm"></div></td>
</tr>
<tr>
<td>총 사망자 수</td>
<td><div id="data_Dt"></div></td>
</tr>
<tr>
<td>총 확진자 수</td>
<td><div id="data_Kt"></div></td>
</tr>
<tr>
<td>확진률 대비 사망률(백분율)</td>
<td><div id="data_Br"></div></td>
</tr>
</table>

 
</body>
</html>
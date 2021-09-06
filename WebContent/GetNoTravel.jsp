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

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<!-- xml to json xml�� json �������� �����ϱ� ���� ���̺귯���� �߰� �մϴ�. -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/fast-xml-parser/3.19.0/parser.min.js"></script>

�Ʒ� �ش� �������� �ݸ� ������ ������� �ʴ� �������Դϴ�
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
						
						// ������ �ڷγ� ��Ȳ ����Ʈ
						var items = jsonData.response.body.items.item; 
						console.log(element.innerHTML);
						
						$.each(items, function(index, item){
							console.log(item.areaNm);
							if(item.nationNm == '����'){
								var covid_data="";
								console.log(item.nationNm + '�� Ȯ���� ��Ȳ');
								document.getElementById("data_Nm").innerHTML=item.nationNm;
								console.log('�����: ' + item.areaNm);
								document.getElementById("data_Ar").innerHTML=item.areaNm;
								console.log('������: ' + item.nationNm);
								console.log('�� ����� ��: ' + item.natDeathCnt);
								document.getElementById("data_Dt").innerHTML=item.natDeathCnt;
								console.log('�� Ȯ���� ��: ' + item.natDefCnt);
								document.getElementById("data_Kt").innerHTML=item.natDefCnt;
								console.log('Ȯ���� ��� �����(�����): ' + item.natDeathRate);
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

<input type='button'  onclick='getCovidData()' value="�ڷγ� �߻� ��Ȳ ������ ������ ����">

<br> <table width="75%" align="center" border> 
<tr><td>�����</td>
<td><div id="data_Ar"></div></td>
</tr>
<tr>
<td>������</td>
<td><div id="data_Nm"></div></td>
</tr>
<tr>
<td>�� ����� ��</td>
<td><div id="data_Dt"></div></td>
</tr>
<tr>
<td>�� Ȯ���� ��</td>
<td><div id="data_Kt"></div></td>
</tr>
<tr>
<td>Ȯ���� ��� �����(�����)</td>
<td><div id="data_Br"></div></td>
</tr>
</table>

 
</body>
</html>
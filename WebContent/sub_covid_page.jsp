<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>해당 국가 탐색 페이지
</title></head>
<body>
<table width="75%" align="center" border>
<tr><td><div align="center">해당 국가의 코로나 정보입니다
</div></td></table>
<table width="75%" align="center" border>
<form method="post" action="login_verify.jsp">
<tr>
<td><div align="center">국가명</div></td>
<td><div align="center">
<input type="text" name="userID">
</div></td>
</tr>
<tr>
<td><div align="center">국가 안전경보</div></td>
<td><div align="center">
<input type="password" name="userPassword">
</div></td></tr>
<tr>
<tr>
<td><div align="center">여행 가능 여부</div></td>
<td><div align="center">
<input type="text" name="userID">
</div></td>
</tr>
<tr>
<td><div align="center">일일 확진자 수</div></td>
<td><div align="center">
<input type="text" name="userID">
</div></td>
</tr>
<tr>
<td><div align="center">총 확진자 수</div></td>
<td><div align="center">
<input type="text" name="userID">
</div></td>
</tr>
<td colspan=2><div align="center">
<INPUT TYPE="RESET" VALUE="취소">
</div></td></tr>
</form>
</table>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>



<script type="text/javascript">
var userURL = "http://localhost:8090/";				
function fncGeoCode() {
	var url = userURL + "/AjaxRequest.jsp?getUrl=";
	
	var subURL = 'http://apis.data.go.kr/1262000/TravelAlarmService2/getTravelAlarmList2';
	var parm = '?serviceKey=sIr4LhoEDOY3RKChgZWZ27TK47a7Sj0TPQtFlVc3OHRpKBnC0ASXWOos9chDrrqOdUhS3Ss958zYZNtuZaAdQA==&pageNo=1&numOfRows=10';//&cond[country_nm::EQ]=가나&cond[country_iso_alp2::EQ]=GH';
	url += encodeURIComponent(subURL)+parm;
	
	var params = ""
	
	$.ajax({	
		"url" : url,
		"type" : "GET",
		"success" : function(result) {
		console.log(result);
		console.log(result.data[0].country_nm);
		$("#dataDiv").innerHTML = result.name;
		$('#res').text(result.data[0].country_nm);
		},
	
		"async" : "false",
		"dataType" : 'json',
		"error": function(x,o,e){
			alert(x.status + ":" +o+":"+e);	
		}
	});	
}
</script>



<p>
<input type='button'  onclick='fncGeoCode()' value="데이터 가지고 오기">
<br> 국가명:<table width="75%" align="center" border> <td><div id="res"></div></td></table>
</body>
</html>
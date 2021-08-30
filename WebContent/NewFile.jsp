<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<script>

function Button() {
	var xhr = new XMLHttpRequest();
	var url = 'http://apis.data.go.kr/1262000/TravelAlarmService2/getTravelAlarmList2'; /*URL*/
	var queryParams = '?' + encodeURIComponent('ServiceKey') + '='+'sIr4LhoEDOY3RKChgZWZ27TK47a7Sj0TPQtFlVc3OHRpKBnC0ASXWOos9chDrrqOdUhS3Ss958zYZNtuZaAdQA=='; /*Service Key*/
	queryParams += '&' + encodeURIComponent('returnType') + '=' + encodeURIComponent('JSON'); /**/
	queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); /**/
	queryParams += '&' + encodeURIComponent('cond[country_nm::EQ]') + '=' + encodeURIComponent('가나'); /**/
	queryParams += '&' + encodeURIComponent('cond[country_iso_alp2::EQ]') + '=' + encodeURIComponent('GH'); /**/
	queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
	xhr.open('GET', url + queryParams);
	xhr.onreadystatechange = function () {
	    if (this.readyState == 4) {
	        alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
	        var res = this.responseText;
	        var jsonstr = JSON.parse(this.responseText);  
			var dataHtml = '<br>resultCode : '+jsonstr.resultCode;
	        document.getElementById("getdata").innerHTML = dataHtml;
	        
	    } 
	};
	
	xhr.send('');
}
</script>

<input type='button'  onclick='Button()' value="데이터 가지고 오기">
<div id=getdata>

</div>
</body>
</html>
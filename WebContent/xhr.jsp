<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%response.setHeader("Access-Control-Allow-Origin","*"); %> 
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>해당 국가 탐색 페이지
</title></head>
<body>


<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>



<script type="text/javascript">			

// 샘플
// http://apis.result.data[i].go.kr/1262000/TravelAlarmService2/getTravelAlarmList2?serviceKey=sIr4LhoEDOY3RKChgZWZ27TK47a7Sj0TPQtFlVc3OHRpKBnC0ASXWOos9chDrrqOdUhS3Ss958zYZNtuZaAdQA==&pageNo=1&numOfRows=10&cond[country_nm::EQ]=%EA%B0%80%EB%82%98&cond[country_iso_alp2::EQ]=GH

	
function getDataAjax() {
	
	
	// 스크립트에서 타사이트 접속시 크로스도메인 오류 발생
	// 스크립트에서 내부 URL 을 호출하여 테이터를 가지고 오도록 수정
	var userURL = "http://localhost:8090/";
	var url = userURL + "/AjaxRequest.jsp?getUrl=";

	// 공공포털 API - 데이터 호출 URL
	var subURL = 'http://apis.data.go.kr/1262000/TravelAlarmService2/getTravelAlarmList2';

	// 공공포털 API - 데이터 호출 parm
	var parm = '';
	parm = '?serviceKey='+ document.getElementById('serviceKey').value; /* 발급받은 서비스키 */
	parm += '&pageNo=' + document.getElementById('pageNo').value;  /* 페이지 번호 */
	parm += '&numOfRows=' + document.getElementById('amount').value;  /*페이지당 게시물수*/
	// '[', ']' 는 URI에 유효하지 않은 문자로 인식 되므로 encodeURI 처리를 해줍니다 
	parm += encodeURI('&cond[country_nm::EQ]=' + document.getElementById('countryNm').value);  /*나라 (한글명)*/
	parm += encodeURI('&cond[country_iso_alp2::EQ]=' + document.getElementById('countryIso').value); /*iso 코드*/
	
	$.ajax({	
		"url" : url + subURL + parm,
		"type" : "GET",
		"success" : function(result) {
			console.log('result : ', result);
			
			var dataHtml = "";
			for(var i = 0; i < result.data.length; i++){
				dataHtml += 
					'result.data[i].alarm_lvl:' + result.data[i].alarm_lvl
					+'<br>result.data[i].continent_cd:'+ result.data[i].continent_cd
					+'<br>result.data[i].continent_eng_nm:'+ result.data[i].continent_eng_nm
					+'<br>result.data[i].continent_nm:'+ result.data[i].continent_nm
					+'<br>result.data[i].country_eng_nm:'+ result.data[i].country_eng_nm
					+'<br>result.data[i].country_iso_alp2:'+ result.data[i].country_iso_alp2
					+'<br>result.data[i].country_nm:'+ result.data[i].country_nm
					+'<br>result.data[i].dang_map_download_url:'+ result.data[i].dang_map_download_url
					+'<br>result.data[i].flag_download_url:'+ result.data[i].flag_download_url
					+'<br>result.data[i].map_download_url:'+ result.data[i].map_download_url
					+'<br>result.data[i].region_ty:'+ result.data[i].region_ty
					+'<br>result.data[i].remark:'+ result.data[i].remark
					+'<br>result.data[i].written_dt:'+ result.data[i].written_dt;

			}
			
		/*	document.getElementById("dataDiv").innerHTML = dataHtml;*/
			
			var dataHtml2 = "";
			
			dataHtml2="<table border=1>";
			dataHtml2+="<tr>";
			dataHtml2+="<td>국가명</td>";
			dataHtml2+="<td>"+result.data[0].country_eng_nm+"</td>";
			dataHtml2+="</tr>";
			dataHtml2+="</table>";
			document.getElementById("newtable").innerHTML = dataHtml2;
			
			dataHtml2 = result.data[0].country_nm;
			document.getElementById("nm").innerHTML = dataHtml2;
			dataHtml2 = result.data[0].country_eng_nm;
			document.getElementById("nm_e").innerHTML = dataHtml2;
			dataHtml2 = result.data[0].continent_nm;
			document.getElementById("nm_c").innerHTML = dataHtml2;
			dataHtml2 = result.data[0].continent_eng_nm;
			document.getElementById("nm_ce").innerHTML = dataHtml2;
			dataHtml2 = result.data[0].alarm_lvl;
			document.getElementById("alarm").innerHTML = dataHtml2;
			
		},
	
		"async" : "false",
		"dataType" : "json",
		"error": function(xhr, o, err){
			console.log(xhr.status + ":" +o+":"+err);
			console.log(xhr.responseText);
			// 메세지 처리
			var err = parseXmlToJson(xhr.responseText);
			console.log('err:' , err.OpenAPI_ServiceResponse.cmmMsgHeader.errMsg);
			console.log('err:' , err.OpenAPI_ServiceResponse.cmmMsgHeader.returnAuthMsg);
			
			document.getElementById("dataDiv").innerHTML = "오류가 발생 했습니다.<br>"+err.OpenAPI_ServiceResponse.cmmMsgHeader.errMsg+"<br>"+err.OpenAPI_ServiceResponse.cmmMsgHeader.returnAuthMsg;

		}
	});	
}

function getDataXHR(){
	
	// 스크립트에서 타사이트 접속시 크로스도메인 오류 발생
	// 스크립트에서 내부 URL 을 호출하여 테이터를 가지고 오도록 수정
	var userURL = "http://localhost:8090/";
	var url = userURL + "/AjaxRequest.jsp?getUrl=";

	// 공공포털 API - 데이터 호출 URL
	var subURL = 'http://apis.data.go.kr/1262000/TravelAlarmService2/getTravelAlarmList2';

	// 공공포털 API - 데이터 호출 parm
	var parm = '';
	parm = '?serviceKey='+document.getElementById('serviceKey').value; /* 발급받은 서비스키 */
	parm += '&pageNo=' + document.getElementById('pageNo').value;  /* 페이지 번호 */
	parm += '&numOfRows=' + document.getElementById('amount').value;  /*페이지당 게시물수*/
	// '[', ']' 는 URI에 유효하지 않은 문자로 인식 되므로 encodeURI 처리를 해줍니다 
	parm += encodeURI('&cond[country_nm::EQ]=' + document.getElementById('countryNm').value);  /*나라 (한글명)*/
	parm += encodeURI('&cond[country_iso_alp2::EQ]=' + document.getElementById('countryIso').value); /*iso 코드*/
		
	var xhr = new XMLHttpRequest();
	
	xhr.open('GET', url + subURL + parm);
	
	xhr.onreadystatechange = function() {
	    if (this.readyState == 4) {
	        console.log('Status: ', this.status);
	        console.log('nHeaders: ', JSON.stringify(this.getAllResponseHeaders()))
	        console.log('nBody: ', this.responseText);
	    }
	};

	xhr.send();
}

function parseXmlToJson(xml) {
    const json = {};
    for (const res of xml.matchAll(/(?:<(\w*)(?:\s[^>]*)*>)((?:(?!<\1).)*)(?:<\/\1>)|<(\w*)(?:\s*)*\/>/gm)) {
        const key = res[1] || res[3];
        const value = res[2] && parseXmlToJson(res[2]);
        json[key] = ((value && Object.keys(value).length) ? value : res[2]) || null;

    }
    return json;
}
</script>
<p>
<input type='button'  onclick='getDataAjax()' value="XMLHttpRequest 데이터 가지고 오기">
<input type='button'  onclick='getDataXHR()' value="jQuery ajax 데이터 가지고 오기">

<div id="newtable" width="100" height="75%">test</div>
<table width="75%" align="center" border>

<tr>
<td>서비스키</td>
<td>
<input type="text" id="serviceKey" value='sIr4LhoEDOY3RKChgZWZ27TK47a7Sj0TPQtFlVc3OHRpKBnC0ASXWOos9chDrrqOdUhS3Ss958zYZNtuZaAdQA=='>
</td>
</tr>

<tr>
<td>페이지 번호</td>
<td>
<input type="text" id="pageNo" value='1'>
</td>
</tr>

<tr>
<td>페이지당 게시글수</td>
<td>
<input type="text" id="amount" value='10'>
</td>
</tr>

<tr>
<td>한글 국가명</td>
<td>
<input type="text" id="countryNm" value='가나'>
</td>
</tr>

<tr>
<td>ISO 2자리 코드</td>
<td>
<input type="text" id="countryIso" value='GH'>
</td>
</tr>

</table>

<br> <table width="75%" align="center" border> 
<tr><td>국가명</td>
<td><div id="nm"></div></td>
</tr>
<tr>
<td>국가영문명</td>
<td><div id="nm_e"></div></td>
</tr>
<tr>
<td>대륙명</td>
<td><div id="nm_c"></div></td>
</tr>
<tr>
<td>대륙영문명</td>
<td><div id="nm_ce"></div></td>
</tr>
<tr>
<td>여행경보</td>
<td><div id="alarm"></div></td>
</tr>
</table>

</body>
</html>
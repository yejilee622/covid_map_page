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
function getDataAjax() {
	var userURL = "http://localhost:8090/";
	var url = userURL + "/AjaxRequest.jsp?getUrl=";
	var subURL = 'http://apis.data.go.kr/1262000/TravelAlarmService2/getTravelAlarmList2';
	var parm = '';
	
	parm = '?serviceKey='+ document.getElementById('serviceKey').value; /* 발급받은 서비스키 */
	parm += '&pageNo=' + document.getElementById('pageNo').value;  /* 페이지 번호 */
	parm += '&numOfRows=' + document.getElementById('amount').value;  /*페이지당 게시물수*/
	parm += encodeURI('&cond[country_nm::EQ]=' + document.getElementById('countryNm').value);  /*나라 (한글명)*/
	parm += encodeURI('&cond[country_iso_alp2::EQ]=' + document.getElementById('countryIso').value); /*iso 코드*/
	
	$.ajax({	
		"url" : url + subURL + parm,
		"type" : "GET",
		"success" : function(result) {
			console.log('result : ', result);
			
			var dataHtml = "";

			dataHtml += 
				'result.data[1].alarm_lvl:' + result.data[i].alarm_lvl
				+'<br>result.data[1].continent_cd:'+ result.data[i].continent_cd
				+'<br>result.data[1].continent_eng_nm:'+ result.data[i].continent_eng_nm
				+'<br>result.data[1].continent_nm:'+ result.data[i].continent_nm
				+'<br>result.data[1].country_eng_nm:'+ result.data[i].country_eng_nm
				+'<br>result.data[1].country_iso_alp2:'+ result.data[i].country_iso_alp2
				+'<br>result.data[1].country_nm:'+ result.data[i].country_nm
				+'<br>result.data[1].dang_map_download_url:'+ result.data[i].dang_map_download_url
				+'<br>result.data[1].flag_download_url:'+ result.data[i].flag_download_url
				+'<br>result.data[1].map_download_url:'+ result.data[i].map_download_url
				+'<br>result.data[1].region_ty:'+ result.data[i].region_ty
				+'<br>result.data[1].remark:'+ result.data[i].remark
				+'<br>result.data[1].written_dt:'+ result.data[i].written_dt;

			
			document.getElementById("dataDiv").innerHTML = dataHtml;
			
		},
	
		"async" : "false",
		"dataType" : "json",
		"error": function(xhr, o, err){
			console.log(xhr.status + ":" +o+":"+err);
			console.log(xhr.responseText);
			var err = parseXmlToJson(xhr.responseText);
			console.log('err:' , err.OpenAPI_ServiceResponse.cmmMsgHeader.errMsg);
			console.log('err:' , err.OpenAPI_ServiceResponse.cmmMsgHeader.returnAuthMsg);
			
			document.getElementById("dataDiv").innerHTML = "오류가 발생 했습니다.<br>"+err.OpenAPI_ServiceResponse.cmmMsgHeader.errMsg+"<br>"+err.OpenAPI_ServiceResponse.cmmMsgHeader.returnAuthMsg;

		}
	});	
}

</script>
<input type='button'  onclick='getDataAjax()' value="XMLHttpRequest 데이터 가지고 오기">
<div id="dataDiv">

</div>
</body>
</html>
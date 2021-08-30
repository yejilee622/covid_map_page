<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fast-xml-parser/3.19.0/parser.min.js"></script>


<script type="text/javascript">			

// 샘플
// http://apis.result.data[i].go.kr/1262000/TravelAlarmService2/getTravelAlarmList2?serviceKey=sIr4LhoEDOY3RKChgZWZ27TK47a7Sj0TPQtFlVc3OHRpKBnC0ASXWOos9chDrrqOdUhS3Ss958zYZNtuZaAdQA==&pageNo=1&numOfRows=10&cond[country_nm::EQ]=%EA%B0%80%EB%82%98&cond[country_iso_alp2::EQ]=GH

	
function getDataAjax() {
	
	
	// 스크립트에서 타사이트 접속시 크로스도메인 오류 발생
	// 스크립트에서 내부 URL 을 호출하여 테이터를 가지고 오도록 수정
	var url = "http://localhost:8090/GetCovidData";
	
	$.ajax({	
		"url" : url,
		"type" : "GET",
		"success" : function(result) {
			var jsonObj = parser.parse(result);
			console.log("result", jsonObj);
		},
	
		"async" : "false",
		"dataType" : "text",
		"error": function(xhr, o, err){
			console.log(xhr.status + ":" +o+":"+err);
			console.log(xhr.responseText);
		}
	});	
}


</script>
</body>

<input type='button'  onclick='getDataAjax()' value="XMLHttpRequest 데이터 가지고 오기">

</html>
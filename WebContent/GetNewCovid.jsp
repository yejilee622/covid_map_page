<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%response.setHeader("Access-Control-Allow-Origin","*"); %> 
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>해당 국가 탐색 페이지
</title></head>
<body>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<!-- xml to json xml을 json 형식으로 변경하기 위한 라이브러리를 추가 합니다. -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/fast-xml-parser/3.19.0/parser.min.js"></script>


<script type="text/javascript">			

// 샘플
// http://apis.result.data[i].go.kr/1262000/TravelAlarmService2/getTravelAlarmList2?serviceKey=sIr4LhoEDOY3RKChgZWZ27TK47a7Sj0TPQtFlVc3OHRpKBnC0ASXWOos9chDrrqOdUhS3Ss958zYZNtuZaAdQA==&pageNo=1&numOfRows=10&cond[country_nm::EQ]=%EA%B0%80%EB%82%98&cond[country_iso_alp2::EQ]=GH

// 코로나 발생 현황 데이터 가지고 오기
function getCovidData(){

	$.ajax({
		url: "http://localhost:8090/GetCovidData",
		type: "get",
		dataType: "text",
		success: function (data) {
			var jsonData = parser.parse(data);
			var nation_name = "";
			var img_url;
			
			// 국가별 코로나 현황 리스트
			var items = jsonData.response.body.items.item; 
			var getParameters = function (paramName) { 
			// 리턴값을 위한 변수 선언 
			var returnValue; 
			// 현재 URL 가져오기
			var url = location.href; 
			// get 파라미터 값을 가져올 수 있는 ? 를 기점으로 slice 한 후 split 으로 나눔
			var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&'); 
			// 나누어진 값의 비교를 통해 paramName 으로 요청된 데이터의 값만 return
			for (var i = 0; i < parameters.length; i++) { 
				var varName = parameters[i].split('=')[0]; 
				if (varName.toUpperCase() == paramName.toUpperCase()) { returnValue = parameters[i].split('=')[1]; return decodeURIComponent(returnValue); } } };
			
			nation_name=getParameters('nation_name');
			
			$.each(items, function(index, item){
				console.log(item.areaNm);
				if(item.nationNm == nation_name){
					var covid_data="";
					nation_name=item.nationNm;
					console.log(item.nationNm + '의 확진자 현황');
					document.getElementById("data_Nm").innerHTML=item.nationNm;
					document.getElementById("data_Ar").innerHTML=item.areaNm;
					document.getElementById("data_Dt").innerHTML=item.natDeathCnt;
					document.getElementById("data_Kt").innerHTML=item.natDefCnt;
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
getCovidData();
</script>

  <style type="text/css">

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
    </style>

==========================================<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/16/20201125_211131298.gif" width=60px height=60px></a>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
해당 국가의 코로나 발생 현황 입니다<a>
<br>
==========================================<br>
<a><img src="https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/maps/15/20201124_221534093.png" width=300px height=300px></a>
<br> <table width="35%" border> 
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
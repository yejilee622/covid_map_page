<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>

    <script>
    
 		// 해외여행 가능 국가들에 대한 텍스트 박스, 그에 따른 공항들만 텍스트박스 만들기
 		// 텍스트박스에서 공항 선택 후 예매하기 버튼 누르면 예매 페이지
    
      function ticketing() {
        var jsReqDataObj = new Object();

        document.ticketForm.hidRequestData.value = JSON.stringify({
        	
        });
        document.ticketForm.submit();
      }
    </script>
  </head>

  <body>
    <form
      name="ticketForm"
      action="https://flyasiana.com/I/KR/KO/LowerPriceSearchList.do?menuId=CM201802220000728256&gclid=Cj0KCQjws4aKBhDPARIsAIWH0JVzLRj2YYOHk2klVkJKjRBA2yJGCuRwn3CdLbcw2c99MQtA0qtArDIaApnHEALw_wcB#none"
      method="post"
    >
      <button onclick="ticketing()">예매하기</button>
      <input type="text" name="hidRequestData" value="bb" />
    </form>
  </body>
</html>

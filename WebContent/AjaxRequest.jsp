<%@ page language="java" import="java.io.*,java.net.*,java.util.*" 	contentType="text/json; charset=utf-8"  pageEncoding="utf-8"%>


<%

	/** 크로스도메인 처리
	
	SOP(same orgin Policy 동일근원정책) 이란?
	- javaScript 단에서 Ajax 사용시 사용문서와 동일한 도메인으로만 데이터 요청 및 전송이 가능하도록 하는 보안정책
	
	SOP를 회피하기 위해서는 스크립트단의 Ajax는 동일 도메인영역(AjaxRequest.jsp)과 통신을 하고 
	Ajax를 통해 전달된 parameter들은 서버간 통신을 통해 다른 서버와 전송 및 결과값을 획득한다. 

	
	getUrl : 요청URL
	
	*/
	
	
	// 파라메터 처리 추가
	Map<String, String[]> parms= request.getParameterMap();
	String addParm = "";
	for( String key : parms.keySet() ){
		if (!key.equals("getUrl") && !parms.get(key)[0].equals("")){
			if("cond[country_nm::EQ]".equals(key)){
				addParm += "&" + key +"="+ URLEncoder.encode(parms.get(key)[0],"UTF-8") ;
			} else {
				addParm += "&" + key +"="+ parms.get(key)[0] ;
			}
		} 
	}
	System.out.println( "###############  getUrl : " + request.getParameter("getUrl") );
	System.out.println( "###############  addParm : " + addParm );
	
	System.out.println( "###############  addParm" + request.getParameter("getUrl") + addParm );
	URL url = new URL(request.getParameter("getUrl") + addParm);
	System.out.println( "###############  url.query : " + url.getQuery() );
	
	URLConnection connection = url.openConnection();
	connection.setRequestProperty("CONTENT-TYPE","application/json"); 
    
	BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream(),"utf-8"));
    String inputLine;
    String buffer = "";
    while ((inputLine = in.readLine()) != null){
     	buffer += inputLine.trim();
    }
    System.out.println("buffer : " + buffer);
    in.close();
    
    
%><%=buffer%>

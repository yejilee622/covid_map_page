import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.catalina.filters.SetCharacterEncodingFilter;
/**
 * Servlet implementation class GetBoradingPass
 */
@WebServlet("/GetBoardingPass")
public class GetBoardingPass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetBoardingPass() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		 StringBuilder urlBuilder = new StringBuilder("http://openapi.airport.kr/openapi/service/StatusOfPassengerFlights/getPassengerArrivals"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=sIr4LhoEDOY3RKChgZWZ27TK47a7Sj0TPQtFlVc3OHRpKBnC0ASXWOos9chDrrqOdUhS3Ss958zYZNtuZaAdQA%3D%3D"); /*Service Key*/
	    //    urlBuilder.append("&" + URLEncoder.encode("from_time","UTF-8") + "=" + URLEncoder.encode("0000", "UTF-8")); /*페이지번호*/
	    //    urlBuilder.append("&" + URLEncoder.encode("to_time","UTF-8") + "=" + URLEncoder.encode("2400", "UTF-8")); /*한 페이지 결과 수*/
//	        urlBuilder.append("&" + URLEncoder.encode("airport","UTF-8") + "=" + URLEncoder.encode("HKG", "UTF-8")); /*검색할 생성일 범위의 시작*/
//	        urlBuilder.append("&" + URLEncoder.encode("flight_id","UTF-8") + "=" + URLEncoder.encode("KE846", "UTF-8")); /*검색할 생성일 범위의 종료*/
	   //     urlBuilder.append("&" + URLEncoder.encode("airline","UTF-8") + "=" + URLEncoder.encode("KE", "UTF-8"));
	 //       urlBuilder.append("&" + URLEncoder.encode("lang","UTF-8") + "=" + URLEncoder.encode("K", "UTF-8"));
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"utf-8"));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"utf-8"));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        System.out.println(sb.toString());
	    //  response.setCharacterEncoding("UTF-8");
	        response.getWriter().append(sb.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

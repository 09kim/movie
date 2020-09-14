package api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;


public class BoxofficeApi {

	public String getBoxOffice(String targetDt) throws IOException {
		String serviceKey = "4d549b0bc63467abbc7ffe4a1169333a";
//		Date today = new Date();
//		System.out.println(today);
		StringBuilder urlBuilder = new StringBuilder("http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key="
                + serviceKey + "&&itemPerPage=10");
		urlBuilder.append("&" + URLEncoder.encode("targetDt", "UTF-8") + "=" + targetDt); // serviceKey
		
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());
		
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line + "\n");
		}
		
		rd.close();
		conn.disconnect();
		

		return sb.toString();
	}
	
	

}

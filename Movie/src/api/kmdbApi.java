package api;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.IOException;

public class kmdbApi {

	public String getMovie(String name) throws IOException {

		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp?detail=Y&title="+name+"&listCount=20&query="+name
						+ "&collection=kmdb_new&ServiceKey=605841J368J95E2I93M1");
		/* URL */
//		urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + "605841J368J95E2I93M1"); /* Service Key */
//		urlBuilder.append(
//				"&" + URLEncoder.encode("val001", "UTF-8") + "=" + URLEncoder.encode("2019", "UTF-8")); /* 상영년도 */
//		urlBuilder
//				.append("&" + URLEncoder.encode("val002", "UTF-8") + "=" + URLEncoder.encode("01", "UTF-8")); /* 상영 월 */
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

	public String getMovieDetail(String movieSeq, String query) throws IOException {

		System.out.println("api:" + query);
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp?collection=kmdb_new&ServiceKey=605841J368J95E2I93M1");
		/* URL */
		urlBuilder.append("&" + URLEncoder.encode("movieSeq", "UTF-8") + "=" + movieSeq); /* Service Key */
		urlBuilder.append(
				"&" + URLEncoder.encode("query", "UTF-8") + "=" + URLEncoder.encode(query, "UTF-8")); /* 상영년도 */
//		urlBuilder
//				.append("&" + URLEncoder.encode("val002", "UTF-8") + "=" + URLEncoder.encode("01", "UTF-8")); /* 상영 월 */
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
		System.out.println(sb.toString());
		
		rd.close();
		conn.disconnect();


		return sb.toString();
	}

}
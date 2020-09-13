package api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class kmdbApi {

	public String getMovie(String title) throws IOException {
		
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp?detail=Y&title="+title+"&listCount=30"
						+"&collection=kmdb_new&ServiceKey=605841J368J95E2I93M1");
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

		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp?collection=kmdb_new&listCount=30&ServiceKey=605841J368J95E2I93M1");
		/* URL */
		urlBuilder.append("&" + URLEncoder.encode("movieSeq", "UTF-8") + "=" + movieSeq); /* Service Key */
		urlBuilder.append(
				"&" + URLEncoder.encode("title", "UTF-8") + "=" + URLEncoder.encode(query, "UTF-8")); /* 상영년도 */
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
	public String getMovieDetailByKeyword(String keyword) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp?listCount=30&collection=kmdb_new&ServiceKey=605841J368J95E2I93M1");
		urlBuilder.append("&" + URLEncoder.encode("keyword", "UTF-8") + "=" + URLEncoder.encode(keyword, "UTF-8")); 
//		urlBuilder.append(
//				"&" + URLEncoder.encode("query", "UTF-8") + "=" + URLEncoder.encode(keyword, "UTF-8"));
//		urlBuilder
//				.append("&" + URLEncoder.encode("val002", "UTF-8") + "=" + URLEncoder.encode("01", "UTF-8"));
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

	public String getMovieDetailByDirector(String director) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp?listCount=30&collection=kmdb_new&ServiceKey=605841J368J95E2I93M1");
		urlBuilder.append("&" + URLEncoder.encode("director", "UTF-8") + "=" + URLEncoder.encode(director, "UTF-8")); 
//		urlBuilder.append(
//				"&" + URLEncoder.encode("query", "UTF-8") + "=" + URLEncoder.encode(keyword, "UTF-8"));
//		urlBuilder
//				.append("&" + URLEncoder.encode("val002", "UTF-8") + "=" + URLEncoder.encode("01", "UTF-8"));
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
	
	public String getMovieDetailByActor(String actor) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp?listCount=30&collection=kmdb_new&ServiceKey=605841J368J95E2I93M1");
		
		urlBuilder.append("&" + URLEncoder.encode("actor", "UTF-8") + "=" + URLEncoder.encode(actor, "UTF-8")); 
//		urlBuilder.append(
//				"&" + URLEncoder.encode("query", "UTF-8") + "=" + URLEncoder.encode(keyword, "UTF-8"));
//		urlBuilder
//				.append("&" + URLEncoder.encode("val002", "UTF-8") + "=" + URLEncoder.encode("01", "UTF-8"));
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
	
	public String getActorByMovie(String movieSeq) throws IOException {
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp?listCount=30&collection=kmdb_new&ServiceKey=605841J368J95E2I93M1");
		urlBuilder.append("&" + URLEncoder.encode("movieSeq", "UTF-8") + "=" + URLEncoder.encode(movieSeq, "UTF-8")); 

//		urlBuilder.append(
//				"&" + URLEncoder.encode("query", "UTF-8") + "=" + URLEncoder.encode(keyword, "UTF-8"));
//		urlBuilder
//				.append("&" + URLEncoder.encode("val002", "UTF-8") + "=" + URLEncoder.encode("01", "UTF-8"));
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

	public String getMovieByGenre(String genre2,String genre,int startCount) throws IOException{
		System.out.println(startCount);
		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp?listCount=30&startCount="+startCount+"&collection=kmdb_new&ServiceKey=605841J368J95E2I93M1");
		urlBuilder.append("&" + URLEncoder.encode(genre2, "UTF-8") + "=" + URLEncoder.encode(genre, "UTF-8")); 
//		urlBuilder.append(
//				"&" + URLEncoder.encode("query", "UTF-8") + "=" + URLEncoder.encode(keyword, "UTF-8"));
//		urlBuilder
//				.append("&" + URLEncoder.encode("val002", "UTF-8") + "=" + URLEncoder.encode("01", "UTF-8"));
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

	public String getBoxoffice(String openDt, String movieNm) throws IOException {

		StringBuilder urlBuilder = new StringBuilder(
				"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json.jsp?collection=kmdb_new&listCount=30&ServiceKey=605841J368J95E2I93M1");
		/* URL */
		urlBuilder.append("&" + URLEncoder.encode("releaseDts", "UTF-8") + "=" + URLEncoder.encode(openDt, "UTF-8")); /* Service Key */
		urlBuilder.append(
				"&" + URLEncoder.encode("title", "UTF-8") + "=" + URLEncoder.encode(movieNm, "UTF-8")); /* 상영년도 */
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
		System.out.println(sb.toString());

		return sb.toString();
	}

}
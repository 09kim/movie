package movie.action;

import java.io.PrintWriter;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.sun.org.apache.xerces.internal.impl.xpath.regex.REUtil;

import action.Action;
import api.NaverMovieApi;
import api.kmdbApi;
import vo.ActionForward;

public class MovieGradeAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovieGradeAction");
		int num = 0;
		int genre = 0;
		int startNum = 0;
		
		Random rNum = new Random();
		System.out.println("랜덤");
		num = rNum.nextInt(26) + 1;
		while(num== 25 && num== 26) {
			num = rNum.nextInt(26) + 1;
		}
		genre = num;
		
		System.out.println(genre);

		startNum = rNum.nextInt(900) + 1;

		System.out.println(startNum);

		NaverMovieApi movie = new NaverMovieApi();
		String json = movie.getMovie(genre, startNum);
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(json);
		JsonArray arr = (JsonArray) jsonObject.get("item");

		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(arr);
		out.flush();

		return null;

	}
}

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

		Random random = new Random();
		int rNum = random.nextInt(14);
		StringBuffer sb = new StringBuffer();
		String genre = sb.append("코미디/느와르/범죄/드라마/로맨스/스릴러/로맨틱/전쟁/가족/판타지/액션/SF/애니메이션/다큐멘터리/공포").toString();

		String[] getGenre = genre.split("/");

		System.out.println(getGenre[rNum]);
		
		int startCount = random.nextInt(20484)+1;
		
		
		kmdbApi movie = new kmdbApi();
		String json = movie.getMovieByGenre("드라마",startCount);
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(json);
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonObject);
		out.flush();

		return null;

	}
}

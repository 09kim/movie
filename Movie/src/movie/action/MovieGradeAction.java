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
		String type = request.getParameter("type");
		
		
		Random random = new Random();
		int rNum = random.nextInt(13);// 장르 선택을 랜덤하게 선택하기위한 난수생성 메서드
		StringBuffer sb = new StringBuffer(); // 메모리 할당을 줄이기위한 Buffer 메서드
		String genre = sb.append("코메디/느와르/범죄/드라마/로맨스/스릴러/전쟁/가족/판타지/액션/SF/애니메이션/인물/공포").toString(); // 장르저장

		String[] getGenre = genre.split("/"); // 장르 스플릿
		
//		type = getGenre[rNum];
		
		if(type.equals("random")) {
			type = getGenre[rNum];
		}
		
//		int startCount = random.nextInt(28623)+1;
		int startCount = 0;
		
		switch (type) {
		case "코메디":
			startCount = random.nextInt(9465)+1;
			break;
		case "느와르":
			startCount = random.nextInt(106)+1;
			break;
		default:
			break;
		}
		

//		System.out.println(getGenre[rNum]); // 랜덤인덱스 접근
			
		
			kmdbApi movie = new kmdbApi();
			String json = movie.getMovieByGenre(type,startCount);
			JsonParser jsonParser = new JsonParser();
			JsonObject jsonObject = (JsonObject) jsonParser.parse(json);
			response.setContentType("application/json;charset=UTF-8");
			PrintWriter out = response.getWriter();
			System.out.println(jsonObject);
			out.print(jsonObject);
			out.flush();
		

		return null;

	}
}

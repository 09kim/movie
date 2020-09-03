package movie.action;

import java.io.PrintWriter;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import action.Action;
import api.kmdbApi;
import vo.ActionForward;

public class MovieActorProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 배우 검색을 담당하는 클래스
		String actor = request.getParameter("query");
		kmdbApi movie = new kmdbApi();
		String json = null;
		
		if (actor!=null) { // null 이 아닐때 검색함 
			json = movie.getMovieDetailByActor(actor);
		}

		System.out.println(json);

		JsonParser jsonParser = new JsonParser(); // Json 타입으로 변환하기 위한 JsonParser 객체 생성
		JsonObject jsonObject = (JsonObject) jsonParser.parse(json); // Json 타입 오브젝트로 파싱



		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonObject); // jsonObject 출력
		out.flush();
		
		
		

		return null; // 비동기 방식이기때문에 포워딩 안함
	}

}

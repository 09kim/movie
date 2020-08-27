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

public class MovieProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8");
		String name = request.getParameter("name");
		String movieSeq = request.getParameter("movieSeq");
		String query = request.getParameter("query");
		
//		movie movie = new movie();
//		String json = movie.getMovie(name);
//		JsonArray jsonArray = (JsonArray) jsonParser.parse(json);
		kmdbApi movie = new kmdbApi();
		String json = null;
		if(name!=null) {
			json = movie.getMovie(name);
		}
		if(movieSeq!=null && query!=null) {
			json = movie.getMovieDetail(movieSeq,query);
			
		}
		
		System.out.println(json);
		
		
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(json);
		
//		System.out.println(jsonObject);
		
		JsonArray ja = (JsonArray) jsonObject.get("Data"); // 이거안하면 나오는게 이상함
		
//		System.out.println(ja);
		
		
		
//		System.out.println(jsonObject);
		
//		System.out.println(ja);
		
		
//		System.out.println(jsonObject);
		
		
		
//		JsonElement je = mo.getAsJsonObject();
//		
//		System.out.println(je);
		
		
		
		
//		JsonElement je = mo.get();
		
		
		
//		JsonArray mo = (JsonArray) jsonObject.get("Data");
		
		
//		System.out.println(inf);
		
		
		
		
		
		
//		System.out.println(mo.toString());
//		System.out.println(mo);
		
//		for(int i = 0; i<mo.size(); i ++) {
//			JsonObject movieArray = (JsonObject) mo.get(i);
//			
//		}
		
		response.setContentType("application/json;charset=UTF-8");
		// Get the printwriter object from response to write the required json object to the output stream      
		PrintWriter out = response.getWriter();
		// Assuming your json object is **jsonObject**, perform the following, it will return your json object  
//		out.print("<script>location href='/movie1/test_list.jsp'</script>");
		out.print(jsonObject);
		out.flush();
		
		
		
//		ActionForward forward = new  ActionForward();
//		forward.setPath("/movie/test_list.jsp");
		return null;
	}
	
}

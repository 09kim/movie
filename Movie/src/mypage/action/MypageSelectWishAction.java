package mypage.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import action.Action;
import api.kmdbApi;
import mypage.svc.MypageSelectWishService;
import mypage.vo.MypageBean;
import vo.ActionForward;

public class MypageSelectWishAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		System.out.println("MypageWishAction 작동");
		
		HttpSession session = request.getSession();
		
		String nick = (String)session.getAttribute("nick");
		
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		
		ActionForward forward = null;
		
		MypageSelectWishService mypageSelectWishService = new MypageSelectWishService();
		
		MypageBean wishMovie = null;
		
		
		wishMovie = mypageSelectWishService.selectWish(nick,movieSeq);
		
		request.setAttribute("wishMovie", wishMovie);
		
		if (wishMovie==null) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("N");
			out.flush(); 

		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("Y");
			out.flush(); 

		}
		
//        forward = new ActionForward();
        
//		forward.setPath("/mypage/mypage_wish.jsp");
		
		return forward;
	}

}

package mypage.action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import action.Action;
import mypage.svc.MemberMypageService;
import mypage.vo.CategoryBean;
import mypage.vo.MypageGenerBean;
import vo.ActionForward;

public class MemberMypageGenerAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String nick = request.getParameter("nick");
		CategoryBean cb = new CategoryBean();
		StringBuffer genre = new StringBuffer("코메디/느와르/범죄/드라마/로맨스/스릴러/전쟁/가족/판타지/액션/SF/애니메이션/인물/공포/어드벤처");
		MemberMypageService mms = new MemberMypageService();
		ArrayList<MypageGenerBean> list = mms.getMypageGener(nick);
		String[] category = genre.toString().split("/");
		// Db에서 가져온 카테고리 수
		
		
		for(MypageGenerBean mgb : list) {
			String[] category2 = mgb.getGenre().split(",");
			//각장르 비교해서 카운트값을 장르마다 저장해줘야하는데 어떻게 하지?
			for(int i =0 ; i<category.length; i++) {
				for(String s : category2) {
					if(s.equals(category[i])) {
						switch (s) {
						case "코메디":
							cb.set코메디(cb.get코메디()+1);
							break;
						case "느와르":
							cb.set느와르(cb.get느와르()+1);
							break;
						case "드라마":
							cb.set드라마(cb.get드라마()+1);
							break;
						case "로맨스":
							cb.set스릴러(cb.get스릴러()+1);
							break;
						case "스릴러":
							cb.set스릴러(cb.get스릴러()+1);
							break;
						case "전쟁":
							cb.set전쟁(cb.get전쟁()+1);
							break;
						case "가족":
							cb.set가족(cb.get가족()+1);
							break;	
						case "판타지":
							cb.set판타지(cb.get판타지()+1);
							break;
						case "액션":
							cb.set액션(cb.get액션()+1);
							break;
						case "SF":
							cb.setSF(cb.getSF()+1);
							break;
						case "애니메이션":
							cb.set애니메이션(cb.get애니메이션()+1);
							break;
						case "인물":
							cb.set인물(cb.get인물()+1);
							break;
						case "공포":
							cb.set공포(cb.get공포()+1);
							break;	
						case "범죄":
							cb.set범죄(cb.get범죄()+1);
							break;	
						case "미스터리":
							cb.set미스터리(cb.get미스터리()+1);
							break;	
						case "어드벤처":
							cb.set어드벤처(cb.get어드벤처()+1);
							break;
						}
					}
					
				}
			}
		}
		
		
		
		Gson gson = new GsonBuilder().create();
		String Json = gson.toJson(cb);
		JsonParser jp = new JsonParser();
		JsonObject jo = (JsonObject) jp.parse(Json);
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(jo);
		out.flush();
		return null;
	}

}

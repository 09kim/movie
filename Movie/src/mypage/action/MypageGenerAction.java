package mypage.action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import action.Action;
import mypage.svc.MemberMypageService;
import mypage.vo.GenreBean;
import mypage.vo.GenreCountBean;
import mypage.vo.MarkGenreBean;
import mypage.vo.MypageGenreBean;
import vo.ActionForward;

public class MypageGenerAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String nick = request.getParameter("nick");
		StringBuffer sbGener = new StringBuffer("코메디/느와르/범죄/공포(호러)/드라마/로맨스/스릴러/전쟁/가족/판타지/액션/SF/애니메이션/인물/공포/어드벤처");
		MemberMypageService mms = new MemberMypageService();
		ArrayList<MypageGenreBean> list = mms.getMypageGener(nick);
		String[] category = sbGener.toString().split("/");
		// Db에서 가져온 카테고리 수
		GenreBean gener = new GenreBean();
		GenreCountBean count = new GenreCountBean();

		for (MypageGenreBean mgb : list) { // 저장한 영화 한개당 장르 및 점수 꺼냄
			String[] category2 = mgb.getGenre().split(","); // 장르 쪼갬
			for (int i = 0; i < category.length; i++) { // category 만큼 반복문 돌림
				for (String s : category2) { //
					if (s.equals(category[i])) {
						switch (s) {
						case "코메디":
							gener.set코메디(gener.get코메디() + 1);
							count.set코메디(count.get코메디() + mgb.getGrade());
							break;
						case "느와르":
							gener.set느와르(gener.get느와르() + 1);
							count.set느와르(count.get느와르() + mgb.getGrade());
							break;
						case "드라마":
							gener.set드라마(gener.get드라마() + 1);
							count.set드라마(count.get드라마() + mgb.getGrade());
							break;
						case "로맨스":
							gener.set스릴러(gener.get스릴러() + 1);
							count.set스릴러(count.get스릴러() + mgb.getGrade());
							break;
						case "스릴러":
							gener.set스릴러(gener.get스릴러() + 1);
							count.set스릴러(count.get스릴러() + mgb.getGrade());
							break;
						case "전쟁":
							gener.set전쟁(gener.get전쟁() + 1);
							count.set전쟁(count.get전쟁() + mgb.getGrade());
							break;
						case "가족":
							gener.set가족(gener.get가족() + 1);
							count.set가족(count.get가족() + mgb.getGrade());
							break;
						case "판타지":
							gener.set판타지(gener.get판타지() + 1);
							count.set판타지(count.get판타지() + mgb.getGrade());
							break;
						case "액션":
							gener.set액션(gener.get액션() + 1);
							count.set액션(count.get액션() + mgb.getGrade());
							break;
						case "SF":
							gener.setSF(gener.getSF() + 1);
							count.setSF(count.getSF() + mgb.getGrade());
							break;
						case "애니메이션":
							gener.set애니메이션(gener.get애니메이션() + 1);
							count.set애니메이션(count.get애니메이션() + mgb.getGrade());
							break;
						case "인물":
							gener.set인물(gener.get인물() + 1);
							count.set인물(count.get인물() + mgb.getGrade());
							break;
						case "공포(호러)":
							gener.set공포(gener.get공포() + 1);
							count.set공포(count.get공포() + mgb.getGrade());
							break;
						case "공포":
							gener.set공포(gener.get공포() + 1);
							count.set공포(count.get공포() + mgb.getGrade());
							break;
						case "범죄":
							gener.set범죄(gener.get범죄() + 1);
							count.set범죄(count.get범죄() + mgb.getGrade());
							break;
						case "미스터리":
							gener.set미스터리(gener.get미스터리() + 1);
							count.set미스터리(count.get미스터리() + mgb.getGrade());
							break;
						case "어드벤처":
							gener.set어드벤처(gener.get어드벤처() + 1);
							count.set어드벤처(count.get어드벤처() + mgb.getGrade());
							break;
						}
					}

				}
			}
		}

		ArrayList<MarkGenreBean> list2 = new ArrayList<MarkGenreBean>();
		list2.add(gener);
		list2.add(count);
		Gson gs = new Gson();
		String json = gs.toJson(list2);
		JsonParser jp = new JsonParser();
		JsonArray jo = (JsonArray) jp.parse(json);
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(jo);
		out.flush();
		return null;
	}

}

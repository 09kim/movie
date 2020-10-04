package mypage.action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

import action.Action;
import mypage.svc.MypagePreferedThings;
import mypage.svc.MypageServiceForMain;
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
		MypagePreferedThings mms = new MypagePreferedThings();
		ArrayList<MypageGenreBean> list = mms.getMypageGener(nick);
		String[] category = sbGener.toString().split("/");
		// Db에서 가져온 카테고리 수
		GenreBean genre = new GenreBean();
		GenreCountBean count = new GenreCountBean();

		for (MypageGenreBean mgb : list) { // 저장한 영화 한개당 장르 및 점수 꺼냄
			String[] category2 = mgb.getGenre().split(","); // 장르 쪼갬
			for (int i = 0; i < category.length; i++) { // category 만큼 반복문 돌림
				for (String s : category2) { //
					if (s.equals(category[i])) {
						switch (s) {
						case "코메디":
							genre.set코메디(genre.get코메디() + 1);
							count.set코메디(count.get코메디() + mgb.getGrade());
							break;
						case "느와르":
							genre.set느와르(genre.get느와르() + 1);
							count.set느와르(count.get느와르() + mgb.getGrade());
							break;
						case "드라마":
							genre.set드라마(genre.get드라마() + 1);
							count.set드라마(count.get드라마() + mgb.getGrade());
							break;
						case "로맨스":
							genre.set스릴러(genre.get스릴러() + 1);
							count.set스릴러(count.get스릴러() + mgb.getGrade());
							break;
						case "스릴러":
							genre.set스릴러(genre.get스릴러() + 1);
							count.set스릴러(count.get스릴러() + mgb.getGrade());
							break;
						case "전쟁":
							genre.set전쟁(genre.get전쟁() + 1);
							count.set전쟁(count.get전쟁() + mgb.getGrade());
							break;
						case "가족":
							genre.set가족(genre.get가족() + 1);
							count.set가족(count.get가족() + mgb.getGrade());
							break;
						case "판타지":
							genre.set판타지(genre.get판타지() + 1);
							count.set판타지(count.get판타지() + mgb.getGrade());
							break;
						case "액션":
							genre.set액션(genre.get액션() + 1);
							count.set액션(count.get액션() + mgb.getGrade());
							break;
						case "SF":
							genre.setSF(genre.getSF() + 1);
							count.setSF(count.getSF() + mgb.getGrade());
							break;
						case "애니메이션":
							genre.set애니메이션(genre.get애니메이션() + 1);
							count.set애니메이션(count.get애니메이션() + mgb.getGrade());
							break;
						case "인물":
							genre.set인물(genre.get인물() + 1);
							count.set인물(count.get인물() + mgb.getGrade());
							break;
						case "공포(호러)":
							genre.set공포(genre.get공포() + 1);
							count.set공포(count.get공포() + mgb.getGrade());
							break;
						case "공포":
							genre.set공포(genre.get공포() + 1);
							count.set공포(count.get공포() + mgb.getGrade());
							break;
						case "범죄":
							genre.set범죄(genre.get범죄() + 1);
							count.set범죄(count.get범죄() + mgb.getGrade());
							break;
						case "미스터리":
							genre.set미스터리(genre.get미스터리() + 1);
							count.set미스터리(count.get미스터리() + mgb.getGrade());
							break;
						case "어드벤처":
							genre.set어드벤처(genre.get어드벤처() + 1);
							count.set어드벤처(count.get어드벤처() + mgb.getGrade());
							break;
						}
					}

				}
			}
		}
		
				
		ArrayList<String> resultList = genre.getDESC();
		
		MypageServiceForMain mypageServiceForMain = new MypageServiceForMain();
		
		mypageServiceForMain.setMypage(nick,resultList,Mypage.genre); // 내림차순한 key 값을 list로 담음 (밸류는 필요없음)
		ArrayList<MarkGenreBean> list2 = new ArrayList<MarkGenreBean>();
		list2.add(genre);
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

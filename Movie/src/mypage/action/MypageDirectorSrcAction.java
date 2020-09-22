package mypage.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import action.Action;
import vo.ActionForward;

public class MypageDirectorSrcAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String director = request.getParameter("director");
		String url ="https://search.naver.com/search.naver?sm=top_hty&fbm=0&ie=utf8&query=영화감독+"+director;
		Document doc = Jsoup.connect(url).get();
		Elements element = doc.select("#people_info_z > div.cont_noline > div > div > a:nth-child(1) > img");
		response.setContentType("html/text;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(element);
		out.flush();
		return null;
	}

}

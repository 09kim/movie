package mypage.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mypage.svc.MypageChangeWishService;
import mypage.svc.MypageDeleteWishService;
import mypage.svc.MypageChangeWishService;
import mypage.vo.MypageBean;
import vo.ActionForward;

public class MypageChangeWishAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MypageChangeWishAction");
		
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nick");
		String title = request.getParameter("title");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String poster = request.getParameter("poster");
		String movieId = request.getParameter("movieId");
		String wish = request.getParameter("wish");
		
		MypageBean mypageBean = new MypageBean();
		mypageBean.setNick(nick);
		mypageBean.setPoster(poster);
		mypageBean.setTitle(title);
		mypageBean.setMovieSeq(movieSeq);
		mypageBean.setMovieId(movieId);
		mypageBean.setWish(wish);
		
		
		boolean isChange = false;

		MypageChangeWishService mypageChangeWishService = new MypageChangeWishService();
		isChange = mypageChangeWishService.changeWish(mypageBean);

		ActionForward forward = null;
		if (!isChange) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("N");
			out.flush(); 
		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("Y");
			out.flush(); 
//			forward = new ActionForward();
//			forward.setRedirect(true);
//			forward.setPath("MypageWish.mp");
		}
		return null;
	}

}

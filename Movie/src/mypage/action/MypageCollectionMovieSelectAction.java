package mypage.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mypage.svc.MypageCollectionMovieAddService;
import mypage.svc.MypageGradeService;
import mypage.vo.CollectionBean;
import mypage.vo.MypageBean;
import vo.ActionForward;

public class MypageCollectionMovieSelectAction implements Action{
	
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MypageCollectionMovieAdd 작동");
		String nick = request.getParameter("nick");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String title = request.getParameter("title");
		String poster = request.getParameter("poster");
		CollectionBean collectionBean = new CollectionBean();
		System.out.println("-------------------액션-----------------");
		System.out.println(nick);
		collectionBean.setNick(nick);
		collectionBean.setMovieSeq(movieSeq);
		collectionBean.setTitle(title);
		collectionBean.setPoster(poster);
		
		MypageCollectionMovieAddService service = new MypageCollectionMovieAddService();
		
		boolean isInsert = service.addCollectionMovie(collectionBean);
		if(isInsert) {
			
		}
		
		return null;
	}
}

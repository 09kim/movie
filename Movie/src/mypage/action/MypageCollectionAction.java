package mypage.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import vo.ActionForward;

public class MypageCollectionAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MypageCollectionAction!");
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nick");
		System.out.println(nick);
		
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/mypage/mypageCollection.jsp");
		
		System.out.println(forward.getPath());
		
		return forward; 
	}

}

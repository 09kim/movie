package mypage.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mypage.svc.MypageGradeService;
import mypage.vo.MypageBean;
import vo.ActionForward;

public class MypageCollectionAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MyPageGradeAction 작동");
		ActionForward forward = null;
		HttpSession session = request.getSession();
		String nick = (String)session.getAttribute("nick");
		
		forward = new ActionForward();
		forward.setPath("/mypage/mypage_collection.jsp");
		
		return forward;
	}

}

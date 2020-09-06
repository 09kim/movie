package mypage.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mypage.svc.MyPageGradeService;
import vo.ActionForward;

public class MyPageGradeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MyPageGradeAction ¿€µø");
		ActionForward forward = null;
		
		MyPageGradeService service = new MyPageGradeService();
		
		
		forward = new ActionForward();
		forward.setPath("/member/member_list.jsp");
		
		return forward;
	}

}

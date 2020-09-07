package mypage.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mypage.svc.MypageGradeService;
import vo.ActionForward;

public class MypageGradeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MyPageGradeAction ¿€µø");
		ActionForward forward = null;
		
		MypageGradeService service = new MypageGradeService();
		
		
		forward = new ActionForward();
		forward.setPath("/mypage/mypagegrade_list.jsp");
		
		return forward;
	}

}

package mypage.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mypage.svc.MypageGradeService;
import mypage.vo.MypageBean;
import vo.ActionForward;

public class MypageGradeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MyPageGradeAction 작동");
		ActionForward forward = null;
		
		MypageGradeService service = new MypageGradeService();
		
		int listCount = service.getGradeListCount();
		System.out.println("Action에서 받은 평가영화 개수 : " + listCount);
		
		ArrayList<MypageBean> gradeList = service.getGradeList();
		
		request.setAttribute("listCount", listCount);
		request.setAttribute("gradeList", gradeList);
		
		forward = new ActionForward();
		forward.setPath("/mypage/grade_list.jsp");
		
		return forward;
	}

}

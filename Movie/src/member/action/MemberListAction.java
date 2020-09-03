package member.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import member.svc.MemberListService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberListAction 작동");
		
		ActionForward forward = null;
		
		// 파라미터로 전달되는 항목이 하나라도 존재하면
		// getMemberList() 메서드에 파라미터를 전달하여 SELECT 구문의 조건을 설정하고
		// 파라미터가 없을 경우 SELECT 구문의 조건 설정 없이 기본 조회 수행
		String orderTarget = request.getParameter("orderTarget");
		String orderType = request.getParameter("orderType");
		
		MemberListService service = new MemberListService();
		ArrayList<MemberBean> memberList = service.getMemberList();
		
		if(orderTarget == null) {
			memberList = service.getMemberList();
		} else {
			memberList = service.getMemberList(orderTarget, orderType);
		}
		
		request.setAttribute("memberList", memberList);
		
		forward = new ActionForward();
		forward.setPath("/member/admin_member_list.jsp");
		
		return forward;
	}
	

}

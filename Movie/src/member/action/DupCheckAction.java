package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import member.svc.DupCheckService;
import vo.ActionForward;
import vo.MemberBean;

public class DupCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("DupCheckAction");
		
<<<<<<< HEAD
		
		String nick = request.getParameter("nick");		
		
		
		DupCheckService dupCheckService = new DupCheckService();
		boolean isDup = dupCheckService.dupCheck(nick);
		
		if(isDup) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("닉네임 중복");
			
		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("사용가능 닉네임");
		}
		
		return null;
=======
		ActionForward forward = null;
		
		String nick = request.getParameter("nick");		
		
		DupCheckService dupCheckService = new DupCheckService();
		boolean isDup = dupCheckService.dupCheck(nick);
		
		// 낙원(0902: if(isDup) -> if(!isDup)으로 변경함 DAO dupCheck()통합하면서 로직이 바뀜)
		if(!isDup) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("닉네임 중복");
			
		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("사용가능 닉네임");
		}
		
		return forward;
>>>>>>> refs/heads/낙원
	}

}

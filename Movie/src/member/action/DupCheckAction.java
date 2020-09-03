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

	}

}

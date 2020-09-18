package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import api.SendEmail;
import member.svc.DupCheckService;
import member.svc.MemberUpdatePasswordService;
import vo.ActionForward;


public class MemberUpdatePasswordAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberUpdatePasswordAction!");
		String email = request.getParameter("email");
		String pass = request.getParameter("pass");
		System.out.println("입력한email주소는 " + email);
		System.out.println("입력한 패스워드는 " + pass);
		ActionForward forward = null;
		MemberUpdatePasswordService memberUpdatePasswordService = new MemberUpdatePasswordService();
		boolean checkResult = memberUpdatePasswordService.updatePassword(email,pass);
		
		if(checkResult) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('패스워드 변경 완료')");
			out.println("</script>");
			forward = new ActionForward();
			forward.setPath("./");
		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('패스워드 변경 실패')");
			out.println("</script>");
		}
		
		return forward;
		
	}
	
}

















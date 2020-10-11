package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import api.SendEmail;
import member.svc.DupCheckService;
import member.svc.MemberUpdatePasswordService;
import member.svc.MemberUpdateService;
import member.vo.MemberBean;
import vo.ActionForward;


public class MemberUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String email = request.getParameter("email");
		String pass = request.getParameter("pass");
		String nick = request.getParameter("nick");
		String phone = request.getParameter("phoneNum");
		String introduce = request.getParameter("introduce");
		
		System.out.println(email);
		System.out.println(pass);
		System.out.println(nick);
		System.out.println(phone);
		System.out.println(introduce);
		MemberBean mb = new MemberBean();
		mb.setEmail(email);
		mb.setPass(pass);
		mb.setNick(nick);
		mb.setPhone(phone);
		mb.setIntroduce(introduce);
		ActionForward forward = null;
		
		
		MemberUpdateService memberUpdateService = new MemberUpdateService();
		boolean checkResult = memberUpdateService.updatePassword(mb);
		
		if(checkResult) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원정보 수정 완료')");
			out.println("</script>");
			forward = new ActionForward();
			forward.setPath("./");
		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원정보 수정 실패')");
			out.println("</script>");
		}
		
		return forward;
		
	}
	
}

















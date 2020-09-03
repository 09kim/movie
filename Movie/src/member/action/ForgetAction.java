package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;

import api.SendMail;
import member.svc.MemberMailService;
import vo.ActionForward;
import vo.MemberBean;
import vo.MessageBean;

public class ForgetAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberForgetAction!");
		
		ActionForward forward = null;
		
		String email = request.getParameter("email");
		
		
		System.out.println("받는 사람 email주소는 " + email);
		SendMail sendMail = SendMail.getInstance(email);
		
		
		MemberMailService memberMailService = new MemberMailService();
		boolean checkResult = memberMailService.dupCheck(email);
		
		if(checkResult) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('존재하지 않는 E-Mail입니다.')");
			out.println("</script>");
		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('사용할 수 있는 E-Mail 입니다.')");
			out.println("</script>");
			String certificationNum = sendMail.mailSend();
			out.println("인증 메세지가 전송되었습니다.");
			out.println("<input type='text' id='hiddenCnum_email' value=" + certificationNum + ">");
			System.out.println(certificationNum);
		}
		return forward;
	}

}

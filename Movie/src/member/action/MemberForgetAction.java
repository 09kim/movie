package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import api.SendMail;
import member.svc.DupCheckService;
import vo.ActionForward;

// 액션 삭제해도 될듯함(낙원:0917)
public class MemberForgetAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberForgetAction!");
		
		ActionForward forward = null;
		
		String email = request.getParameter("email");
		
		System.out.println("받는 사람 email주소는 " + email);
		SendMail sendMail = SendMail.getInstance(email);
		
		DupCheckService dupCheck = new DupCheckService();
		boolean checkResult = dupCheck.dupCheck(email,"email");
		
		if(checkResult) {
			response.setContentType("text/html;charset=UTF-8"); 
			PrintWriter out = response.getWriter(); 
			out.println("<script>"); 
			out.println("alert('존재하지 않는 이메일입니다.')"); 
			out.println("history.back()");
			out.println("</script>"); 
		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("</script>");
			String certificationNum = sendMail.mailSend();
			out.println("인증 메세지가 전송되었습니다.");
			out.println("<input type='text' id='hiddenCnum_email' value=" + certificationNum + ">");
			System.out.println(certificationNum);
		}
		return forward;
	}

}

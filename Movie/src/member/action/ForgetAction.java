package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
<<<<<<< HEAD
import api.SendEmail;
import api.SendEmailForget;
import member.svc.ForgetService;
import vo.ActionForward;
import vo.MemberBean;

public class ForgetAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		System.out.println("ForgetAction 작동");
		
		MemberBean memberBean = new MemberBean();
		
		// 비밀번호 찾고자 하는 email
		memberBean.setEmail(request.getParameter("email"));
		
		// ForgetService의 isEmailSame() 호출, 이메일 존재 여부 확인
		ForgetService forgetService = new ForgetService();
		boolean isEmailSame = forgetService.isEmailSame(memberBean);
		
		if(!isEmailSame) {
			response.setContentType("text/html;charset=UTF-8"); 
			PrintWriter out = response.getWriter(); 
			out.println("<script>"); 
			out.println("alert('존재하지 않는 이메일입니다.')"); 
			out.println("history.back()");
			out.println("</script>"); 
		} else {
			// 로그인 작업 수행 성공 시 세션 처리
			// HttpSession 객체를 request 객체로부터 전달받아 저장
			HttpSession session = request.getSession();
			session.setAttribute("email", memberBean.getEmail());
			SendEmailForget.gmailSend(memberBean.getEmail());
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("ForgetEmailChForm.me"); 
		}
		
=======
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
>>>>>>> refs/heads/낙원
		return forward;
	}

}

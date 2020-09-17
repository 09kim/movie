package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import api.SendMessage;
import member.svc.DupCheckService;
import member.svc.MemberForgetEmailService;
import vo.ActionForward;

public class MemberForgetEmailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		
		SendMessage sendMessage = new SendMessage();
		String phone = request.getParameter("phone");

		ActionForward forward = null;
		MemberForgetEmailService memberForgetEmailService = new MemberForgetEmailService();
		String email = memberForgetEmailService.getEmail(phone);

			if (email.equals("")) {
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.print("존재하지 않는 핸드폰 번호");
			} else {
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				String emailAddress = sendMessage.getCertificationNum(phone,email);
				out.print("인증 메세지가 전송되었습니다.");
				out.print("<input type='text' id='hiddenCnum' value=" + email + ">");
			}

		return forward;
	}

}

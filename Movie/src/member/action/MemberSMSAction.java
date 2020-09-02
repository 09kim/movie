package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import api.SendMail;
import api.SendSMS;
import api.SendMail;
import member.svc.MemberMailService;
import member.svc.MemberSMSService;
import vo.ActionForward;
// 낙원(0902:MessageAction=>MemberSMSAction으로 클래스명 변경)
public class MemberSMSAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		
		System.out.println("MessageAction!");
		
		ActionForward forward = null;
		
		String phone = request.getParameter("phone");
		
		System.out.println("받는 사람 핸드폰 번호는 " + phone);
		SendSMS sendSMS = SendSMS.getInstance(phone);

		MemberSMSService memberSMSService = new MemberSMSService();
		boolean checkResult = memberSMSService.dupCheck(phone);
		
		if(!checkResult) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('중복된 핸드폰 번호입니다.')");
			out.println("</script>");
		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('사용할 수 있는 핸드폰 번호 입니다.')");
			out.println("</script>");
			String certificationNum = sendSMS.smsSend();
			out.println("인증 메세지가 전송되었습니다.");
			out.println("<input type='text' id='hiddenCnum' value=" + certificationNum + ">");
			System.out.println(certificationNum);
		}
			
		return forward;
	}

}

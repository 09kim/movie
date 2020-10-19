package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import api.SendMessage;
import member.svc.DupCheckService;
import vo.ActionForward;

public class MemberMessageUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		
		SendMessage sendMessage = new SendMessage();
		String phone = request.getParameter("phone");
		String cNum = request.getParameter("cNum");

		System.out.println(cNum);

		DupCheckService dupCheck = new DupCheckService();
		boolean result = dupCheck.dupCheck(phone, "phone");
		// 회원정보수정시 DB에 핸드폰 번호 유무와 관계 없이 인증 번호를 전부 보내야하므로 핸드폰번호 유무 판별식 삭제 - 낙원 : 1012
		if (phone != null) {
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				String certificationNum = sendMessage.getCertificationNum(phone);
				out.print("인증 메세지가 전송되었습니다.");
				out.print("<input type='text' id='hiddenCnum' value=" + certificationNum + ">");
				System.out.println(certificationNum);
		}

		return null;
	}

}

package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import vo.ActionForward;

public class MemberLogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("MemberLogoutAction!!!!!!!!!!!!!!!!1");
		
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
		session.removeAttribute("email");
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		
		out.println("<script>");
		out.println("alert('로그아웃 되었습니다.')");
		out.println("location.href='./'");
		out.println("</script>");
		
		
		return forward;
	}

}

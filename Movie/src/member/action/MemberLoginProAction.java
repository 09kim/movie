package member.action;

import java.io.PrintWriter;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import member.svc.MemberLoginProService;
import member.vo.MemberBean;
import vo.ActionForward;

public class MemberLoginProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberLoginProAction!!");
		
		ActionForward forward = null;
		
		MemberBean member = new MemberBean();
		member.setEmail(request.getParameter("email"));
		member.setPass(request.getParameter("pass"));
		boolean isLogin = false;
		String result = "";
		String nick = "";
		MemberLoginProService memberLoginProService = new MemberLoginProService();
		try {
			nick = memberLoginProService.login(member);
			isLogin = true;
		} catch (Exception e) {
			result = e.getMessage();
		}

			
		if(!isLogin) {
			
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter(); 
				out.println("<script>");
				out.println("alert('" + result + "')");
				out.println("history.back()");
				out.println("</script>");	
			}else {
				
				forward = new ActionForward();
				forward.setRedirect(true);
				forward.setPath("./");
				HttpSession session = request.getSession();
				session.setAttribute("nick", nick);
			}
			
		return forward;
		
	}

}






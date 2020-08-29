package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import member.svc.MemberLoginProService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberLoginProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberLoginProAction!!");
		
		ActionForward forward = null;
		
		MemberBean member = new MemberBean();
		member.setEmail(request.getParameter("email"));
		member.setPass(request.getParameter("pass"));
		
		MemberLoginProService memberLoginProService = new MemberLoginProService();
		int isLogin = memberLoginProService.login(member);

			
		if(isLogin == 0 || isLogin == -1) {
			String resultStr = "";
			
			if(isLogin == 0) {
				resultStr = "이메일 없음";
			} else if(isLogin == -1) {
				resultStr = "패스워드 틀림";
			}
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter(); 
				out.println("<script>");
				out.println("alert('" + resultStr + "')");
				out.println("history.back()");
				out.println("</script>");
			}else {
				
				HttpSession session = request.getSession();
				forward = new ActionForward();
				forward.setRedirect(true);
				forward.setPath("./");
			}
			
		return forward;
		
	}

}



























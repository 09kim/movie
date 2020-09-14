package mypage.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mypage.svc.MypageDeleteWishService;
import mypage.vo.MypageBean;
import vo.ActionForward;

public class MypageDeleteWishAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MypageDeleteAction");
		
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nick");
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		MypageBean mypageBean = new MypageBean();
		mypageBean.setIdx(idx);
		mypageBean.setNick(nick);
		
		
		boolean isDelete = false;
		String resultMsg = "";

		MypageDeleteWishService mypageDeleteService = new MypageDeleteWishService();
		try {
			isDelete = mypageDeleteService.deleteWish(mypageBean);
		} catch (Exception e) {
			resultMsg = e.getMessage();
		}

		ActionForward forward = null;
		if (!isDelete) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('에러 입니다.');history.back();</script>");
		} else {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('작업을 완료 했습니다.');</script>");
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("MypageSelectWish.mp");
		}
		return forward;
	}

}

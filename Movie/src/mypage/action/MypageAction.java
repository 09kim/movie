package mypage.action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import member.vo.MemberBean;
import mypage.svc.MypageAddCollectionService;
import mypage.svc.MypageGradeService;
import mypage.svc.MypageSelectWishListService;
import mypage.svc.MypageService;
import mypage.vo.CollectionBean;
import mypage.vo.MypageBean;
import vo.ActionForward;

public class MypageAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String email = request.getParameter("email");
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nick");
//		String nick = request.getParameter("nick");
		
		MemberBean memberBean = new MemberBean();
		String resultMsg = "";
		
		MypageService mypageService = new MypageService();
		
		try {
			memberBean = mypageService.selectMypageinfo(nick);
			
		} catch (Exception e) {
			resultMsg = e.getMessage();
		}

		ActionForward forward = null;
		
		request.setAttribute("memberBean", memberBean);
		
		
		
		// 좋아요한 영화 페이지 객체 받는 코드 - 낙원  : 1006[S]
		
		MypageSelectWishListService mypageSelectWishListService = new MypageSelectWishListService();
		
		ArrayList<MypageBean> wishMovie = mypageSelectWishListService.selectWishList(nick);
		
		request.setAttribute("wishMovie", wishMovie);
		
		// 좋아요한 영화 페이지 객체 받는 코드 - 낙원  : 1006[E]
		
		
		// 평점 페이지 객체 받는 코드 - 낙원 : 1006[S]
		
		MypageGradeService service = new MypageGradeService();
		
		int listCount = service.getGradeListCount(nick);
//		System.out.println("Action에서 받은 평가영화 개수 : " + listCount);
		
		ArrayList<MypageBean> gradeList = service.getGradeList(nick);
		
		request.setAttribute("listCount", listCount);
		request.setAttribute("gradeList", gradeList);
		// 평점 페이지 객체 받는 코드 - 낙원 : 1006[E]		
		
		// 컬렉션 객체 받는 코드 - 낙원 : 1007[S]
		MypageAddCollectionService service1 = new MypageAddCollectionService();
		ArrayList<CollectionBean> collection = service1.selectCollection(nick);
		request.setAttribute("collection", collection);
		// 컬렉션 객체 받는 코드 - 낙원 : 1007[E]
		
		
		
		
		
		
		
		
		
		
		if (nick == null) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('" + resultMsg + "');history.back();</script>"); 
		} else {
			request.setAttribute("memberBean", memberBean);
			forward = new ActionForward();
			forward.setPath("/mypage/mypage.jsp");
		}
		
		
		
		
		
		
		

		return forward;
	}

}






















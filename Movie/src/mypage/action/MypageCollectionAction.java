package mypage.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mypage.svc.MypageAddCollectionService;
import mypage.svc.MypageGradeService;
import mypage.vo.CollectionBean;
import mypage.vo.MypageBean;
import vo.ActionForward;

public class MypageCollectionAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MyPageGradeAction 작동");
		ActionForward forward = null;
		HttpSession session = request.getSession();
		String nick = (String)session.getAttribute("nick");
		
		MypageAddCollectionService service = new MypageAddCollectionService();
		ArrayList<CollectionBean> collection = service.selectCollection(nick);
		request.setAttribute("collection", collection);
		forward = new ActionForward();
//		forward.setPath("/mypage/mypage_collection.jsp");
		forward.setPath("/mypage/mypage.jsp");
//		forward.setPath("Mypage.mp");
		
		return forward;
	}

}

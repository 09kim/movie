package mypage.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mypage.svc.MypageAddCollectionService;
import mypage.svc.MypageCollectionMovieAddService;
import mypage.svc.MypageGradeService;
import mypage.vo.CollectionBean;
import mypage.vo.MypageBean;
import vo.ActionForward;

public class MypageCollectionDeleteAction implements Action{
	
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MypageCollectionMovieAdd 작동");
		int idx = Integer.parseInt(request.getParameter("idx"));
		ActionForward forward = null;
		MypageAddCollectionService service = new MypageAddCollectionService();
		
		boolean isDelete = service.deleteCollection(idx);
		if(isDelete) {
			
		}
		
		forward = new ActionForward();
		forward.setPath("/mypage/mypage.jsp");
		
		return forward;
	}
}

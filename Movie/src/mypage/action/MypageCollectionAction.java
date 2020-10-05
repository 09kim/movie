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
//		ArrayList<String[]> test = new ArrayList<String[]>();
//		for(int i = 0; i < collection.size(); i++) {
//			String[] movieSeq = collection.get(i).getMovieSeq().split(",");
//			String[] poster = collection.get(i).getPoster().split(",");
//			String[] title = collection.get(i).getTitle().split(",");
//			test.add(movieSeq);
//			test.add(poster);
//			test.add(title);
//		}
//		String[] movieSeq = collection.get(1).getMovieSeq().split(",");
//		System.out.println("마이페이지 콜렉션 테슷트");
//		System.out.println(movieSeq[0]);
//		System.out.println(collection.get(0).getMovieSeq());
//		request.setAttribute("test", test);
		request.setAttribute("collection", collection);
		forward = new ActionForward();
		forward.setPath("/mypage/mypage_collection.jsp");
		
		return forward;
	}

}

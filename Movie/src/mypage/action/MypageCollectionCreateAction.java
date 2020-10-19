package mypage.action;

import java.io.PrintWriter;
import java.util.ArrayList;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.StringUtils;

import action.Action;
import mypage.svc.MypageAddCollectionService;
import mypage.svc.MypageGradeService;
import mypage.vo.CollectionBean;
import vo.ActionForward;

public class MypageCollectionCreateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("CollectionCreateAction 작동..제발");
		ActionForward forward = null;
		HttpSession session = request.getSession();
		String nick = (String)session.getAttribute("nick");
		String[] title = request.getParameterValues("title");
		String[] movieSeq = request.getParameterValues("movieSeq");
		String[] poster = request.getParameterValues("poster");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		System.out.println("콜렉션크리에이트 작동해라");
		System.out.println(title[0]);
		System.out.println(content);
		String joinTitle = String.join(",", title);
		String joinPoster = String.join(",", poster);
		String joinMovieSeq = String.join("," , movieSeq);
		
		
		int[] intArr = null;
		if( movieSeq != null ){
		intArr = new int[ movieSeq.length ];
		for( int i=0;i <movieSeq.length; i++ ) {
			intArr[i] = Integer.parseInt( movieSeq[i] );
			}
		}
		
		System.out.println(joinTitle + joinPoster + joinMovieSeq);
		CollectionBean collectionBean = new CollectionBean();
		collectionBean.setCollection_name(subject);
		collectionBean.setContent(content);
		collectionBean.setNick(nick);
		collectionBean.setPoster(joinPoster);
		collectionBean.setTitle(joinTitle);
		collectionBean.setMovieSeq(joinMovieSeq);
		
		MypageAddCollectionService mypageAddCollectionService = new MypageAddCollectionService();
		boolean isSuccess = mypageAddCollectionService.addCollection(collectionBean);
		
		if(isSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('등록되었습니다')");
//			out.println("window.location.href = 'MypageCollection.mp'");
			out.println("window.location.href = 'Mypage.mp'");
			out.println("</script>");
		}
		
//		collectionBean.setCollection_name(subject);
//		collectionBean.setNick(nick);
//		for(int i = 0; i < title.length; i++) {
//			title = title[i];
//		}
//		collectionBean.setTitle(title[1]);
		
		
		return forward;
	}
	

}



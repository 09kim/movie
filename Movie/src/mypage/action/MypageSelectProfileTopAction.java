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
import mypage.svc.MypageProfileService;
import mypage.svc.MypageSelectWishListService;
import mypage.svc.MypageService;
import mypage.vo.CollectionBean;
import mypage.vo.MypageBean;
import mypage.vo.ProfileBean;
import vo.ActionForward;

public class MypageSelectProfileTopAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nick");
		
		MemberBean memberBean = new MemberBean();
		String resultMsg = "";
		
        ActionForward forward = null;		
		
		// 프로필 사진 받는 코드 - 낙원 : 1015[S]
		MypageProfileService mypageProfileService = new MypageProfileService();
        ProfileBean profileBean = mypageProfileService.getProfile(nick);
        System.out.println("셀렉트로 가져온 파일이름 : " + profileBean.getUploadFileName());
        System.out.println("셀렉트로 가져온 파일경로 : " + profileBean.getSavePath());
        
        request.setAttribute("profileBean", profileBean);
		
		
		
//		forward = new ActionForward();
//		forward.setPath("/inc/top.jsp");
		
		
		
		
		
		
		

		return forward;
	}

}






















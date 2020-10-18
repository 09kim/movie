package mypage.action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import action.Action;
import mypage.svc.MypageAddCollectionService;
import mypage.svc.MypageGradeService;
import mypage.svc.MypageProfileService;
import mypage.vo.CollectionBean;
import mypage.vo.MypageBean;
import mypage.vo.ProfileBean;
import vo.ActionForward;

public class MypageModifyProfileAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberUpdateProfileAction!");
		HttpSession session = request.getSession();
		String nick = (String)session.getAttribute("nick");
		ActionForward forward = null;
	 	request.setCharacterEncoding("UTF-8");
	 
        // 파일 업로드를 하기 위해서 cos.jar 추가 및 객체 생성
        MultipartRequest multi = null;
 
        
        // 업로드 될 파일의 최대 사이즈 (50메가)
        int sizeLimit = 50 * 1024 * 1024;
 
        // 파일이 업로드될 실제 tomcat 폴더의 경로 (WebContent 기준)
        String savePath = request.getRealPath("/upload"); 
        // 
        try{
            multi=new MultipartRequest(
                    request
                    , savePath
                    , sizeLimit
                    , "UTF-8"
                    , new DefaultFileRenamePolicy()); 
 
         }catch (Exception e) {
                e.printStackTrace();
         } 
         
        //파일 이름 저장
        String uploadFileName = multi.getFilesystemName("input_file"); // 서버상에 추가된 이미지의 파일 경로를 받아오는 변수
        String orgFileName = multi.getOriginalFileName("input_file"); // 파일 목록에서 추가시 이미지의 파일 경로를 받아오는 변수
        ProfileBean profileBean = new ProfileBean();
        profileBean.setNick(nick);
        profileBean.setOrgFileName(orgFileName);
        profileBean.setUploadFileName(uploadFileName);
        profileBean.setSavePath(savePath);
        MypageProfileService mypageProfileService = new MypageProfileService();
        
        boolean selectSuccess = mypageProfileService.selectProfile(profileBean);
        System.out.println("셀렉트 결과 : " + selectSuccess);
        
        
        if(selectSuccess) {
        	boolean updateSuccess = mypageProfileService.updateProfile(profileBean);
        	if(updateSuccess) {
        		session.setAttribute("uploadFileName", uploadFileName);
    	        request.setAttribute("uploadFileName", uploadFileName);
    			response.setContentType("text/html;charset=UTF-8");
    			PrintWriter out = response.getWriter();
    			out.println("<script>");
    			out.println("alert('등록되었습니다')");
    			out.println("window.location.href = 'Mypage.mp'");
    			out.println("</script>");
    		} else {
    			response.setContentType("text/html;charset=UTF-8");
    			PrintWriter out = response.getWriter();
    			out.println("<script>");
    			out.println("alert('업데이트 실패')");
    			out.println("window.location.href = 'Mypage.mp'");
    			out.println("</script>");
    		}
        }else {
        	 boolean insertSuccess = mypageProfileService.insertProfile(profileBean);
             
             if(insertSuccess) {
     			response.setContentType("text/html;charset=UTF-8");
     			PrintWriter out = response.getWriter();
     			out.println("<script>");
     			out.println("alert('생성되었습니다')");
     			out.println("window.location.href = 'Mypage.mp'");
     			out.println("</script>");
     		} else {
     			response.setContentType("text/html;charset=UTF-8");
     			PrintWriter out = response.getWriter();
     			out.println("<script>");
     			out.println("alert('생성 실패')");
     			out.println("window.location.href = 'Mypage.mp'");
     			out.println("</script>");
     		}
        }
        
        
        
        
		
		
//		forward = new ActionForward();
//		forward.setPath("/mypage/mypage_collection.jsp");
//		forward.setPath("/mypage/mypage.jsp");
//		forward.setRedirect(true);
//		forward.setPath("Mypage.mp");
		
		return forward;
	}

}

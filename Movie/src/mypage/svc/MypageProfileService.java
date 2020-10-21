package mypage.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import mypage.dao.MypageDAO;
import mypage.vo.CollectionBean;
import mypage.vo.MypageBean;
import mypage.vo.ProfileBean;


public class MypageProfileService {
	public boolean updateProfile(ProfileBean profileBean){
		System.out.println("프로필사진 업데이트 서비스");
		boolean isSuccess = false;
		boolean isSelect = false;
		Connection con = getConnection();
		MypageDAO mypageDAO = MypageDAO.getInstance();
		mypageDAO.setConnection(con);
		isSelect = mypageDAO.selectProfile(profileBean);
		if(isSelect) {
			int isUpdate = mypageDAO.updateProfile(profileBean);
			if(isUpdate>0) {
				System.out.println("서비스 성공");
				isSuccess = true;
				commit(con);
			}else {
				System.out.println("서비스 실패");
				rollback(con);
			}
		}
		
		close(con);
		
		return isSuccess;
	}
	
	public boolean selectProfile(ProfileBean profileBean){
		System.out.println("프로필사진 셀렉트 서비스");
		boolean isSuccess = false;
		Connection con = getConnection();
		MypageDAO mypageDAO = MypageDAO.getInstance();
		mypageDAO.setConnection(con);
		isSuccess = mypageDAO.selectProfile(profileBean);
		close(con);
		
		return isSuccess;
	}
	
	public ProfileBean getProfile(String nick) {
		boolean isSuccess = false;
		Connection con = getConnection();
		ProfileBean profileBean = new ProfileBean();
		MypageDAO mypageDAO = MypageDAO.getInstance();
		mypageDAO.setConnection(con);
		profileBean = mypageDAO.getProfile(nick);
		close(con);
		return profileBean;
	}
	
	public boolean insertProfile(ProfileBean profileBean){
		System.out.println("프로필사진 업데이트 서비스");
		boolean isSuccess = false;
		boolean isSelect = false;
		Connection con = getConnection();
		MypageDAO mypageDAO = MypageDAO.getInstance();
		mypageDAO.setConnection(con);
		isSelect = mypageDAO.selectProfile(profileBean);
		if(!isSelect) {
			int isInsert = mypageDAO.insertProfile(profileBean);
			if(isInsert>0) {
				System.out.println("인서트서비스 성공");
				isSuccess = true;
				commit(con);
			}else {
				System.out.println("인서트서비스 실패");
				rollback(con);
			}
		}
		
		close(con);
		
		return isSuccess;
	}
	
//	public boolean updateCollection(CollectionBean collectionBean){
//		System.out.println("컬렉션 서비스");
//		boolean isSuccess = false;
//		Connection con = getConnection();
//		MypageDAO mypageDAO = MypageDAO.getInstance();
//		mypageDAO.setConnection(con);
//		int isUpdate = mypageDAO.updateCollection(collectionBean);
//		if(isUpdate>0) {
//			isSuccess = true;
//			commit(con);
//		}else {
//			rollback(con);
//		}
//		close(con);
//		
//		return isSuccess;
//	}
//	
//	public ArrayList<CollectionBean> selectCollection(String nick){
//		
//		System.out.println("MypageWishService - getWishMovie");
//		
//		ArrayList<CollectionBean> selectCollection = null;
//		Connection con = getConnection();
//		MypageDAO mypageDAO = MypageDAO.getInstance();
//		mypageDAO.setConnection(con);
//		
//		selectCollection = mypageDAO.selectCollection(nick);
//		
//		close(con);
//		
//		return selectCollection;
//		
//	}
//	
//	public boolean deleteCollection(int idx){
//		System.out.println("컬렉션 서비스");
//		boolean isSuccess = false;
//		Connection con = getConnection();
//		MypageDAO mypageDAO = MypageDAO.getInstance();
//		mypageDAO.setConnection(con);
//		int isDelete = mypageDAO.deleteCollection(idx);
//		if(isDelete>0) {
//			isSuccess = true;
//			commit(con);
//		}else {
//			rollback(con);
//		}
//		close(con);
//		
//		return isSuccess;
//	}
	
}

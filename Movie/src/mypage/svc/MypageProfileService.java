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
		Connection con = getConnection();
		MypageDAO mypageDAO = MypageDAO.getInstance();
		mypageDAO.setConnection(con);
		int isAdd = mypageDAO.updateProfile(profileBean);
		if(isAdd>0) {
			isSuccess = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return isSuccess;
	}
	
	public boolean updateCollection(CollectionBean collectionBean){
		System.out.println("컬렉션 서비스");
		boolean isSuccess = false;
		Connection con = getConnection();
		MypageDAO mypageDAO = MypageDAO.getInstance();
		mypageDAO.setConnection(con);
		int isUpdate = mypageDAO.updateCollection(collectionBean);
		if(isUpdate>0) {
			isSuccess = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return isSuccess;
	}
	
	public ArrayList<CollectionBean> selectCollection(String nick){
		
		System.out.println("MypageWishService - getWishMovie");
		
		ArrayList<CollectionBean> selectCollection = null;
		Connection con = getConnection();
		MypageDAO mypageDAO = MypageDAO.getInstance();
		mypageDAO.setConnection(con);
		
		selectCollection = mypageDAO.selectCollection(nick);
		
		close(con);
		
		return selectCollection;
		
	}
	
	public boolean deleteCollection(int idx){
		System.out.println("컬렉션 서비스");
		boolean isSuccess = false;
		Connection con = getConnection();
		MypageDAO mypageDAO = MypageDAO.getInstance();
		mypageDAO.setConnection(con);
		int isDelete = mypageDAO.deleteCollection(idx);
		if(isDelete>0) {
			isSuccess = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return isSuccess;
	}
	
}

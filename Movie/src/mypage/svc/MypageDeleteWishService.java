package mypage.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import mypage.dao.MypageDAO;
import mypage.vo.MypageBean;


public class MypageDeleteWishService {
	public boolean deleteWish(MypageBean mypageBean){
		System.out.println("MypageDeleteService");
		boolean isDelete =false;
		
		Connection con = getConnection();
		MypageDAO mypageDAO = MypageDAO.getInstance();
		mypageDAO.setConnection(con);
		int updateCount = mypageDAO.deleteWish(mypageBean);
		if(updateCount>0) {
			isDelete = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		return isDelete;
	}
}

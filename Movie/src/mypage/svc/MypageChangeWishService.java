package mypage.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import mypage.dao.MypageDAO;
import mypage.vo.MypageBean;


public class MypageChangeWishService {
	public boolean changeWish(MypageBean mypageBean){
		System.out.println("MypageChangeWishService");
		boolean isChange =false;
		
		Connection con = getConnection();
		MypageDAO mypageDAO = MypageDAO.getInstance();
		mypageDAO.setConnection(con);
		int updateCount = mypageDAO.changeWish(mypageBean);
		if(updateCount>0) {
			isChange = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		return isChange;
	}
}

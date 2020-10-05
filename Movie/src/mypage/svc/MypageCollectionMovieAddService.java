package mypage.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import mypage.dao.MypageDAO;
import mypage.vo.CollectionBean;
import mypage.vo.MypageBean;


public class MypageCollectionMovieAddService {
	public boolean addCollectionMovie(CollectionBean collectionBean){
		System.out.println("컬렉션 서비스");
		boolean isSuccess = false;
		Connection con = getConnection();
		MypageDAO mypageDAO = MypageDAO.getInstance();
		mypageDAO.setConnection(con);
		int isAdd = mypageDAO.addCollectionMovie(collectionBean);
		if(isAdd>0) {
			isSuccess = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		
		return isSuccess;
	}
}

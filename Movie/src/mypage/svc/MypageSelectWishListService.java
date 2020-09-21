package mypage.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import mypage.dao.MypageDAO;
import mypage.vo.MypageBean;

public class MypageSelectWishListService {

	public ArrayList<MypageBean> selectWishList(String nick) {
		System.out.println("MypageWishService - getWishMovie");
		
		ArrayList<MypageBean> wishMovie = null;
		Connection con = getConnection();
		MypageDAO mypageDAO = MypageDAO.getInstance();
		mypageDAO.setConnection(con);
		
		wishMovie = mypageDAO.selectWishList(nick);
		
		close(con);
		
		return wishMovie;
	}

}

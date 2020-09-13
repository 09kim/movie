package mypage.svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import mypage.dao.MypageDAO;
import mypage.vo.MypageBean;
import vo.MemberBean;

public class MypageSelectWishService {

	public ArrayList<MypageBean> selectWish(String nick) {
		System.out.println("MypageWishService - getWishMovie");
		
		ArrayList<MypageBean> wishMovie = null;
		Connection con = getConnection();
		MypageDAO mypageDAO = MypageDAO.getInstance();
		mypageDAO.setConnection(con);
		
		wishMovie = mypageDAO.selectWish(nick);
		
		close(con);
		
		return wishMovie;
	}

}

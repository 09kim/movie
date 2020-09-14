package mypage.svc;
import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import movie.vo.MovieBean;
import mypage.dao.MypageDAO;
import mypage.vo.MypageGenerBean;
public class MemberMypageService {

	public ArrayList<MypageGenerBean> getMypageGener(String nick) {
		Connection con = getConnection();
		MypageDAO dao = MypageDAO.getInstance();
		dao.setConnection(con);
		ArrayList<MypageGenerBean> list = dao.selectGener(nick);
		close(con);
		return list;
	}

	public ArrayList<MovieBean> getMypageTitle(String nick) {
		Connection con = getConnection();
		MypageDAO dao = MypageDAO.getInstance();
		dao.setConnection(con);
		ArrayList<MovieBean> list = dao.selectTitle(nick);
		close(con);
		return list;
	}

}

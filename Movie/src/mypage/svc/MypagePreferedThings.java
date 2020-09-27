package mypage.svc;
import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import com.google.gson.JsonObject;

import movie.vo.MovieBean;
import mypage.dao.MypageDAO;
import mypage.vo.MypageGenreBean;
public class MypagePreferedThings {

	public ArrayList<MypageGenreBean> getMypageGener(String nick) {
		Connection con = getConnection();
		MypageDAO dao = MypageDAO.getInstance();
		dao.setConnection(con);
		ArrayList<MypageGenreBean> list = dao.selectGener(nick);
		close(con);
		return list;
	}

	public JsonObject getMypageNation(String nick) {
		Connection con = getConnection();
		MypageDAO dao = MypageDAO.getInstance();
		dao.setConnection(con);
		JsonObject nation = dao.selectNation(nick);
		close(con);
		return nation;
	}

	public JsonObject getMypageDirector(String nick) {
		Connection con =getConnection();
		MypageDAO dao = MypageDAO.getInstance();
		dao.setConnection(con);
		JsonObject Director = dao.selectDirector(nick);
		close(con);
		return Director;
	}

}

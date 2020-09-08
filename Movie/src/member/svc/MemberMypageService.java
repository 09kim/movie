package member.svc;
import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import member.dao.MemberDAO;
import movie.vo.MovieBean;
public class MemberMypageService {

	public StringBuffer getMypageGener(String nick) {
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		StringBuffer sb = dao.selectGener(nick);
		close(con);
		return sb;
	}

	public ArrayList<MovieBean> getMypageTitle(String nick) {
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		ArrayList<MovieBean> list = dao.selectTitle(nick);
		close(con);
		return list;
	}

}

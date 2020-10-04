package movie.svc;

import movie.dao.MovieDAO;
import movie.vo.MovieBean;
import mypage.action.Mypage;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;
public class MovieGetService {

	public ArrayList<MovieBean> getMovie(String nick, Mypage type) {
		Connection con = getConnection();
		MovieDAO md = MovieDAO.getInstance();
		md.setConnection(con);
		ArrayList<MovieBean> list = md.getMovie(nick,type);
		
		if(list!=null) {
			close(con);
		}
		return list;
	}

}

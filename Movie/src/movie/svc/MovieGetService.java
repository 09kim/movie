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
		
		close(con);
		return list;
	}

	public ArrayList<MovieBean> getMovie() {
		Connection con = getConnection();
		MovieDAO md = MovieDAO.getInstance();
		md.setConnection(con);
		ArrayList<MovieBean> list = md.getMovieByChart();
		
		close(con);
		return list;
	}

}

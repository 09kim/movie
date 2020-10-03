package movie.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import movie.dao.MovieDAO;

public class MovieGetPosterForExpectationService {

	public String getPoster(String movieSeq) {
		Connection con = getConnection();
		MovieDAO mo = MovieDAO.getInstance();
		mo.setConnection(con);
		String poster = mo.getPoster(movieSeq);
		
		close(con);
		return poster;
	}

}

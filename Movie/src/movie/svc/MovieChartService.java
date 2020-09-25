package movie.svc;
import static db.JdbcUtil.*;

import java.sql.Connection;

import movie.dao.MovieDAO;
import movie.vo.MovieBean;

public class MovieChartService {

	public void setWordForChart(MovieBean mb) throws Exception{
		Connection con = getConnection();
		
		MovieDAO dao = MovieDAO.getInstance();
		dao.setConnection(con);
		
		int setResult = dao.setWordForChart(mb);
		
		if(setResult>0) {
			con.commit();
		}else {
			con.rollback();
		}
		
		close(con);
		
	}

}

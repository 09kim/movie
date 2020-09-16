package movie.svc;

import static db.JdbcUtil.*;


import java.sql.Connection;

import movie.dao.MovieDAO;
import movie.vo.ReviewBean;

public class MovieReviewService {
	public boolean isInsert(ReviewBean reviewBean){
		boolean isInsert =false;
		
		Connection con = getConnection();
		MovieDAO mo = MovieDAO.getInstance();
		mo.setConnection(con);
		int insertCount = mo.insertComment(reviewBean);
		
		if(insertCount>0) {
			isInsert = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		return isInsert;
	}
}

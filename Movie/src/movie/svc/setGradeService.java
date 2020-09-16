package movie.svc;

import static db.JdbcUtil.*;


import java.sql.Connection;

import movie.dao.MovieDAO;
import movie.vo.MovieBean;

public class setGradeService {

	public boolean isSetGrade(MovieBean movieBean){
		boolean isInsert =false;
		
		Connection con = getConnection();
		MovieDAO mo = MovieDAO.getInstance();
		mo.setConnection(con);
		int insertCount = mo.insertGrade(movieBean);
		
		if(insertCount>0 || insertCount == -1) {
			isInsert = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		return isInsert;
	}
	
	public int selectGrade(MovieBean movieBean){
		
		Connection con = getConnection();
		MovieDAO mo = MovieDAO.getInstance();
		mo.setConnection(con);
		int movieGrade = mo.selectGrade(movieBean);
		
		if(movieGrade > 0 ) {
			commit(con);
		}else {
			rollback(con);
			
		}
		close(con);
		return movieGrade;
	}

}

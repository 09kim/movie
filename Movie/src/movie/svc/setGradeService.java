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
		System.out.println("sve : " + insertCount);
		
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

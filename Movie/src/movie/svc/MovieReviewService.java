package movie.svc;

import static db.JdbcUtil.*;


import java.sql.Connection;

import movie.dao.MovieDAO;
import movie.vo.MovieBean;
import movie.vo.ReviewBean;

public class MovieReviewService {
	public boolean isInsert(ReviewBean reviewBean){
		boolean isInsert =false;
		
		Connection con = getConnection();
		MovieDAO mo = MovieDAO.getInstance();
		mo.setConnection(con);
		int insertCount = mo.insertReview(reviewBean);
		
		if(insertCount>0) {
			isInsert = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		return isInsert;
	}
	
	public boolean isDelete(ReviewBean reviewBean){
		boolean isDelete =false;
		
		Connection con = getConnection();
		MovieDAO mo = MovieDAO.getInstance();
		mo.setConnection(con);
		int insertCount = mo.deleteReview(reviewBean);
		
		if(insertCount>0) {
			isDelete = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		return isDelete;
	}
	
	public boolean isUpdate(ReviewBean reviewBean){
		boolean isUpdate =false;
		
		Connection con = getConnection();
		MovieDAO mo = MovieDAO.getInstance();
		mo.setConnection(con);
		int insertCount = mo.updateReview(reviewBean);
		
		if(insertCount>0) {
			isUpdate = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		return isUpdate;
	}
	
	public String getReview(MovieBean movieBean){
		
		
		Connection con = getConnection();
		MovieDAO mo = MovieDAO.getInstance();
		mo.setConnection(con);
		String review = mo.selectReview(movieBean);
		
		
		close(con);
		return review;
	}
	
	
}

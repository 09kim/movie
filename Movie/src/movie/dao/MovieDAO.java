package movie.dao;

import static db.JdbcUtil.close;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import movie.vo.MovieBean;


public class MovieDAO {
	private MovieDAO() {
	};

	private static MovieDAO instance;

	public static MovieDAO getInstance() {
		if (instance == null) {
			instance = new MovieDAO();
		}

		return instance;
	}

	Connection con ;

	public void setConnection(Connection con) {
		this.con = con;
	}
	
	PreparedStatement pstmt;
	ResultSet rs ;
	public int insertGrade(MovieBean movieBean) {
		int insertCount=0;
		String sql = "INSERT INTO grade values(idx,?,?,?,?,?,?,null) ";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movieBean.getNick());
			pstmt.setString(2, movieBean.getMovieGrade());
			pstmt.setString(3, movieBean.getMovieGenre());
			pstmt.setString(4, movieBean.getMovieSeq());
			pstmt.setString(5, movieBean.getMovieTitle());
			pstmt.setString(6, movieBean.getMovieRuntime());
			
			insertCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return insertCount;
	}
	

	

}

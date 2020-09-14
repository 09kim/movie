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
		
		try {
			
			String sql = "SELECT grade from grade where nick = ? and movieSeq = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movieBean.getNick());
			pstmt.setString(2, movieBean.getMovieSeq());
			rs= pstmt.executeQuery();
		
			if(rs.next()) {
				sql = "update grade set grade = ? where nick = ? and movieSeq = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, movieBean.getMovieGrade()); 
				pstmt.setString(2, movieBean.getNick());
				pstmt.setString(3, movieBean.getMovieSeq());
				insertCount = -1;
				pstmt.executeUpdate();
			} else {
				sql = "INSERT INTO grade values(idx,?,?,?,?,?,?,?,?,null) ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, movieBean.getNick());
				pstmt.setString(2, movieBean.getMovieGrade());
				pstmt.setString(3, movieBean.getMovieGenre());
				pstmt.setString(4, movieBean.getMovieSeq());
				pstmt.setString(5, movieBean.getMovieTitle());
				pstmt.setString(6, movieBean.getDirector());
				pstmt.setString(7, movieBean.getNation());
				pstmt.setString(8, movieBean.getMovieRuntime());
				
				insertCount = pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return insertCount;
	}
	
	public int selectGrade(MovieBean movieBean) {
		int grade=0;
		String sql = "SELECT grade from grade where nick = ? and movieSeq = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movieBean.getNick());
			pstmt.setString(2, movieBean.getMovieSeq());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				grade = rs.getInt("grade");
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return grade;
	}
	

	

}
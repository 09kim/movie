package movie.dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import movie.exception.MovieChartExeption;
import movie.vo.MovieBean;
import movie.vo.ReviewBean;

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

	Connection con;

	public void setConnection(Connection con) {
		this.con = con;
	}

	PreparedStatement pstmt;
	ResultSet rs;

	public int insertGrade(MovieBean movieBean) {
		int insertCount = 0;

		try {

			String sql = "SELECT grade from grade where nick = ? and movieSeq = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movieBean.getNick());
			pstmt.setInt(2, movieBean.getMovieSeq());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				sql = "update grade set grade = ? where nick = ? and movieSeq = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, movieBean.getMovieGrade());
				pstmt.setString(2, movieBean.getNick());
				pstmt.setInt(3, movieBean.getMovieSeq());
				insertCount = -1;
				pstmt.executeUpdate();
			} else {
				sql = "INSERT INTO grade values(idx,?,?,?,?,?,?,?,?,?) ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, movieBean.getNick());
				pstmt.setString(2, movieBean.getMovieGrade());
				pstmt.setString(3, movieBean.getMovieGenre());
				pstmt.setInt(4, movieBean.getMovieSeq());
				pstmt.setString(5, movieBean.getMovieTitle());
				pstmt.setString(6, movieBean.getDirector());
				pstmt.setString(7, movieBean.getNation());
				pstmt.setString(8, movieBean.getMovieRuntime());
				pstmt.setString(9, movieBean.getMoviePoster());

				insertCount = pstmt.executeUpdate();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return insertCount;
	}

	public int selectGrade(MovieBean movieBean) {
		int grade = 0;
		String sql = "SELECT grade from grade where nick = ? and movieSeq = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movieBean.getNick());
			pstmt.setInt(2, movieBean.getMovieSeq());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				grade = rs.getInt("grade");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return grade;
	}

	public String selectComment(MovieBean movieBean) {
		String comment = "";
		String sql = "SELECT content from review where nick = ? and movieSeq = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movieBean.getNick());
			pstmt.setInt(2, movieBean.getMovieSeq());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				comment = rs.getString("content");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return comment;
	}

	public int insertComment(ReviewBean reviewBean) {

		int insertCount = 0;

		try {

			String sql = "SELECT * from grade where nick =? and movieSeq =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reviewBean.getNick());
			pstmt.setInt(2, reviewBean.getMovieSeq());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				reviewBean.setGrade(rs.getInt("grade"));
				reviewBean.setGenre(rs.getString("genre"));
				reviewBean.setTitle(rs.getString("title"));
			}

			sql = "INSERT INTO review values(idx,?,?,?,?,?,?,?,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reviewBean.getNick());
			pstmt.setInt(2, reviewBean.getGrade());
			pstmt.setString(3, reviewBean.getGenre());
			pstmt.setInt(4, reviewBean.getMovieSeq());
			pstmt.setString(5, reviewBean.getTitle());
			pstmt.setString(6, reviewBean.getType());
			pstmt.setString(7, reviewBean.getContent());

			insertCount = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}

		return insertCount;
	}

	public int deleteComment(ReviewBean reviewBean) {

		int deleteCount = 0;

		try {

			String sql = "delete from review where nick = ? and movieSeq = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reviewBean.getNick());
			pstmt.setInt(2, reviewBean.getMovieSeq());
			deleteCount = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}

		return deleteCount;
	}

	public int updateComment(ReviewBean reviewBean) {
		int insertCount = 0;

		try {

			String sql = "update review set content = ? where nick =? and movieSeq = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reviewBean.getContent());
			pstmt.setString(2, reviewBean.getNick());
			pstmt.setInt(3, reviewBean.getMovieSeq());

			insertCount = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}

		return insertCount;
	}

	public int setWordForChart(MovieBean mb) {
		int resultCount = 0;

		try {
			String sql = "SELECT * from chart where title=? and nick=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getMovieTitle());
			pstmt.setString(2, mb.getNick());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				sql = "SELECT COUNT(*),title from chart c JOIN chart_nick cn ON c.idx = cn.chart_idx where c.nick =?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mb.getNick());
				rs = pstmt.executeQuery();
				while (rs.next()) {
//					if (rs.getString("title").equals(mb.getMovieTitle()) && rs.getInt("COUNT(*)") < 4) {
					if (rs.getString("title").equals(mb.getMovieTitle())) {
						sql = "UPDATE chart set count = count +1";
						pstmt = con.prepareStatement(sql);
						pstmt.executeUpdate();
					}
				}

			} else {
				sql = "INSERT INTO chart VALUES(null,?,?,?,?,?,now())";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, mb.getMovieSeq());
				pstmt.setString(2, mb.getMovieTitle());
				pstmt.setString(3, mb.getMoviePoster());
				pstmt.setInt(4, 1);
				pstmt.setString(5, mb.getNick());
				resultCount = pstmt.executeUpdate();

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}

		return resultCount;
	}

	public int setChartNickForChart(MovieBean mb) {
		System.out.println("setChartNickForChart");
		String sql = "SELECT * from chart where title=? and nick=?";
		int insertResult = 0;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getMovieTitle());
			pstmt.setString(2, mb.getNick());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				sql = "INSERT INTO chart_nick VALUES(null,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rs.getInt("idx"));
				insertResult = pstmt.executeUpdate();

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rs);
		}
		return insertResult;
	}

	public int setWeatherForChart(MovieBean mb) {
		System.out.println("setWeatherForChart");
		String sql = "SELECT * from chart where title=? and nick=?";
		int insertResult = 0;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getMovieTitle());
			pstmt.setString(2, mb.getNick());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				sql = "INSERT INTO chart_weather VALUES(null,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rs.getInt("idx"));
				pstmt.setString(2, mb.getWeather());
				pstmt.setInt(3, mb.getTemp());
				insertResult = pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rs);
		}
		return insertResult;
	}

}

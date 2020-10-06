package movie.dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import movie.vo.MovieBean;
import movie.vo.ReviewBean;
import mypage.action.Mypage;

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

	public String selectReview(MovieBean movieBean) {
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

	public int insertReview(ReviewBean reviewBean) {

		int insertCount = 0;
		System.out.println(reviewBean.getContent()+"여기는 DAO ~");
		try {

			String sql = "SELECT * from grade where nick =? and movieSeq =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reviewBean.getNick());
			pstmt.setInt(2, reviewBean.getMovieSeq());
			rs = pstmt.executeQuery();
			if (rs.next()) {
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

	public int deleteReview(ReviewBean reviewBean) {

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

	public int updateReview(ReviewBean reviewBean) {
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
			String sql = "INSERT INTO chart_before_1day SELECT * FROM chart WHERE date < date_sub(now(),interval 1 DAY)";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			sql = "delete from chart where date < date_sub(now(),interval 1 DAY)";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			
			sql = "SELECT * from chart where title=? and nick=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getMovieTitle());
			pstmt.setString(2, mb.getNick());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				sql = "SELECT title,count from chart c JOIN chart_nick cn ON c.idx = cn.chart_idx where c.nick =?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mb.getNick());
				rs = pstmt.executeQuery();
				while (rs.next()) {
//					if (rs.getString("title").equals(mb.getMovieTitle()) && rs.getInt("COUNT(*)") < 4) {
					if (rs.getString("title").equals(mb.getMovieTitle())) {
						sql = "UPDATE chart set count = count +1,date = now() where title = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, mb.getMovieTitle());
						pstmt.executeUpdate();
						resultCount = 2;
						return resultCount;
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

	public String getPoster(String movieSeq) {
		String sql = "SELECT poster from grade where movieSeq=?";
		String poster = "";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movieSeq);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				poster = rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return poster;
	}

	public ArrayList<MovieBean> getMovie(String nick, Mypage type) {
		String sql = "";
		ArrayList<MovieBean> list = new ArrayList<MovieBean>();
		switch (type) {
		case genre:
			sql = "SELECT genre FROM mypage where nick =?";
			break;
		case director:
			sql = "SELECT director FROM mypage where nick =?";
			break;
		case nation:
			sql = "SELECT nation FROM mypage where nick =?";
			break;
		}
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String result = rs.getString(1).substring(1, rs.getString(1).length()-1).replaceAll(",\\s", "|");
				System.out.println(result);
				switch (type) {
				case genre:
					sql = "SELECT * from grade where nick NOT like ? and title NOT IN (select title from grade where nick =?) and genre REGEXP ? group by title order by rand() limit 0,10";
					break;
				case director:
					sql = "SELECT * from grade where nick NOT like ? and title NOT IN (select title from grade where nick =?) and director REGEXP ? group by title order by rand() DESC limit 0,10";
					break;
				case nation:
					sql = "SELECT * from grade where nick NOT like ? and title NOT IN (select title from grade where nick =?) and nation REGEXP ? group by title order by rand() DESC limit 0,10";
					break;
				}
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, nick);
				pstmt.setString(2, nick);
				pstmt.setString(3, result);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					MovieBean mb = new MovieBean();
					mb.setMovieGenre(rs.getString("genre"));
					mb.setMovieSeq(rs.getInt("movieseq"));
					mb.setMovieTitle(rs.getString("title"));
					mb.setDirector(rs.getString("director"));
					mb.setNation(rs.getString("nation"));
					mb.setMoviePoster(rs.getString("poster"));
					list.add(mb);
				}
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

	public ArrayList<MovieBean> getMovieByChart() {
		
		
		ArrayList<MovieBean> list = new ArrayList<MovieBean>();
		String sql = "SELECT movieseq,title,sum(count),poster, count from chart  where date >= date_sub(now(),interval 1 DAY) group by title order by sum(count) desc limit 0,10";
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MovieBean mb = new MovieBean();
				mb.setMovieSeq(rs.getInt("movieseq"));
				mb.setMovieTitle(rs.getString("title"));
				mb.setMoviePoster(rs.getString("poster"));
				list.add(mb);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

	public ArrayList<MovieBean> getMovieByTemp(int temp) {
		ArrayList<MovieBean> list = new ArrayList<MovieBean>();
		String sql = "SELECT A.movieseq,A.title,A.poster,sum(A.count) from chart A JOIN chart_weather B ON A.idx = B.chart_idx and B.temperature between 19 and 21 group by A.title order by sum(A.count) desc limit 0,10;";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, temp-2);
			pstmt.setInt(2, temp+2);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MovieBean mb = new MovieBean();
				mb.setMovieSeq(rs.getInt("movieseq"));
				mb.setMovieTitle(rs.getString("title"));
				mb.setMoviePoster(rs.getString("poster"));
				list.add(mb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

}

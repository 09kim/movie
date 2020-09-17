package mypage.dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import member.vo.MemberBean;
import movie.vo.MovieBean;
import mypage.vo.MypageBean;
import mypage.vo.MypageGenreBean;

public class MypageDAO {

	private static MypageDAO instance;
	
	private MypageDAO() {}

	public static MypageDAO getInstance() {
		// 기존 MypageDAO 인스턴스가 없을 때만 생성하고, 있을 경우 생성하지 않음
		if(instance == null) {
			instance = new MypageDAO();
		}

		return instance;
	}
	 
	
	// --------------------------------------------------------------
	// Service 클래스로부터  JdbcUtil 에서 제공받은 Connection 객체를 전달받기
	Connection con;

	public void setConnection(Connection con) {
		this.con = con;
	}
	
	PreparedStatement pstmt;
	ResultSet rs;
	
	
	
	
	// 내 정보 조회 - 세은
	public MemberBean selectMypageinfo(String nick) {
		System.out.println("MypageDAO - getMypageInfo 도착");
		System.out.println(nick);
		
		MemberBean memberBean = new MemberBean();
		
		try {
			String sql = "SELECT * FROM member where nick=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				memberBean.setEmail(rs.getString("email"));
				memberBean.setNick(rs.getString("nick"));
				memberBean.setPhone(rs.getString("phone"));
			}
			
		} catch (SQLException e) {
			System.out.println("MemberDAO - getMypageInfo() 에러! " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return memberBean;
		
	}
	
	// 내 정보 수정 - 세은
	 public void updateMypage(MemberBean memberBean) {
//		PreparedStatement pstmt = null;

         try {
             String sql = "update member set email=?, pass=?, phone=? where nick=?";
             pstmt = con.prepareStatement(sql);
             
             pstmt.setString(1, memberBean.getEmail());
             pstmt.setString(2, memberBean.getPass());
             pstmt.setString(3, memberBean.getPhone());
             pstmt.setString(4, memberBean.getNick());
             
             pstmt.executeUpdate();
             
             
             
         } catch (Exception e) {
             e.printStackTrace();
         }
     }
	

	// 평가한 영화 개수 조회 메서드 - NHJ
	public int selectGradeListCount(String nick) {
		int listCount = 0;
		
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(*) FROM grade where nick =?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick);
			rs = pstmt.executeQuery();
			
			// 평가한 영화가 조회될 경우 (영화가 하나라도 존재할 경우)
			// => listCount 에 영화 수 저장
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("MypageDAO - selectGradeListCount() 에러!");
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}
	
	
	
	// 평가 영화 조회 메서드 - NHJ
	public ArrayList<MypageBean> selectGradeList(String nick) {
		ArrayList<MypageBean> gradeList = null;
		
		
		try {
			String sql = "SELECT * FROM grade where nick=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick);
			rs = pstmt.executeQuery();
			
			gradeList = new ArrayList<MypageBean>();
			while(rs.next()) {
				MypageBean list = new MypageBean();
				
				list.setIdx(rs.getInt("idx"));
				list.setGener(rs.getString("gener"));
				list.setGrade(rs.getInt("grade"));
				list.setMovieSeq(rs.getInt("movieSeq"));
				list.setNick(rs.getString("nick"));
				list.setRuntime(rs.getInt("runtime"));
				list.setTitle(rs.getString("title"));
				list.setWish(rs.getString("wish"));
				
				gradeList.add(list);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("MypageDAO - selectGradeList() 에러!");
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return gradeList;
	}
	
	// 좋아요(wish) 리스트 조회 메서드 - 낙원
	public ArrayList<MypageBean> selectWish(String nick) {
		System.out.println("MypageDAO - selectWishMovie()");
		ArrayList<MypageBean> wishMovie = null;
		
		try {
			String sql = "SELECT * FROM wish WHERE nick=? and wish='Y'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick);
			rs = pstmt.executeQuery();
			
			wishMovie = new ArrayList<MypageBean>();
			while(rs.next()) {
				MypageBean wishInfo = new MypageBean();
				wishInfo.setIdx(rs.getInt("idx"));
				wishInfo.setNick(rs.getString("nick"));
				wishInfo.setMovieSeq(rs.getInt("movieSeq"));
				wishInfo.setTitle(rs.getString("title"));
				wishInfo.setWish(rs.getString("wish"));
				wishInfo.setPoster(rs.getString("poster"));
				wishMovie.add(wishInfo);
			}
		} catch (SQLException e) {
			System.out.println("MypageDAO - selectWishMovie 에러!: " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return wishMovie;
	}



	// 좋아요(wish) 취소(삭제) 메서드 - 낙원
	public int deleteWish(MypageBean mypageBean) {
		int deleteCount=0;
		try {
			int idx = mypageBean.getIdx();
			String nick = mypageBean.getNick();
			String sql = "DELETE FROM wish where idx=? and nick=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, nick);
			deleteCount= pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return deleteCount;
	}
	
	// ------------------------------------------------------------------- 별점 용 메서드 태윤
		public ArrayList<MypageGenreBean> selectGener(String nick) {
			String sql = "SELECT grade,gener from grade where nick = ?";
			ArrayList<MypageGenreBean> list = new ArrayList<MypageGenreBean>();
			
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, nick);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					MypageGenreBean mgb = new MypageGenreBean();
					mgb.setGrade(rs.getInt("grade"));
					mgb.setGenre(rs.getString("gener"));
					list.add(mgb);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rs);
				close(pstmt);
			}
			return list;
		}


		public ArrayList<MovieBean> selectTitle(String nick) {
			String sql = "SELECT grade,title from grade where nick = ?";
			ArrayList<MovieBean> list = new ArrayList<MovieBean>();
			try {
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, nick);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					MovieBean mb = new MovieBean();
					mb.setMovieGrade(rs.getString("grade"));
					mb.setMovieTitle(rs.getString("title"));
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

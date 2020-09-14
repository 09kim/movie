package mypage.svc;

import java.sql.Connection;
import java.util.ArrayList;

import mypage.dao.MypageDAO;
import mypage.vo.MypageBean;

import static db.JdbcUtil.*;

public class MypageGradeService {

	public int getGradeListCount() {
		System.out.println("MypageGradeService - getGradeListCount() 작동");
		int listCount = 0;
		
		Connection con = getConnection();
		MypageDAO mypageDAO = MypageDAO.getInstance();
		mypageDAO.setConnection(con);
		
		listCount = mypageDAO.selectGradeListCount();
		
		close(con);
		
		System.out.println("평가영화 개수 : " + listCount);
		
		return listCount;
	}

	public ArrayList<MypageBean> getGradeList() {
		System.out.println("MypageGradeService - getGradeList() 작동");
		ArrayList<MypageBean> gradeList = null;
		
		Connection con = getConnection();
		MypageDAO mypageDAO = MypageDAO.getInstance();
		mypageDAO.setConnection(con);
		
		gradeList = mypageDAO.selectGradeList();
		
		close(con);
		
		return gradeList;
	}

}

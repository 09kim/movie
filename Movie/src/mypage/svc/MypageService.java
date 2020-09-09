package mypage.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import member.dao.MemberDAO;
import vo.MemberBean;

public class MypageService {

	public boolean selectMypage(MemberBean memberBean) {
		System.out.println("MypageService 도착!!");
		boolean isselect =false;
		
		Connection con = getConnection();
		MemberDAO  dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		int selectCount = dao.selectMypage(memberBean);
		System.out.println("MypageService : " + isselect);
		
		if(selectCount>0) {
			isselect = true;
			commit(con);
		}else {
			rollback(con);
			
		}
		close(con);
		return isselect;
		
		
	}



}

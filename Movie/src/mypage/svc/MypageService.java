package mypage.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import member.dao.MemberDAO;
import member.vo.MemberBEAN;

public class MypageService {

	public boolean mypageinsert(MemberBEAN memberBean) {
		System.out.println("MypageService 도착!!");
		boolean isInsert =false;
		
		Connection con = getConnection();
		MemberDAO  dao = MemberDAO.getInstance();
		dao.setConnection(con);
		int insertCount = dao.insertMember(memberBean);
		System.out.println("MypageService : " + insertCount);
		
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

package member.svc;

import member.dao.MemberDAO;
import static db.JdbcUtil.*;

import java.sql.Connection;

public class MemberEmailService {

	// 회원 중복 여부 확인 요청 작업을 수행하기 위한 dupCheckMember() 메서드 정의
	public boolean dupCheckEmail(String email) {
		
		boolean checkResult = true;
		
		Connection con = getConnection();
		
		MemberDAO memberDAO = MemberDAO.getInstance();
		
		memberDAO.setConnection(con);
		
		checkResult = memberDAO.dupCheckEmail(email);
		
		close(con);
		
		return checkResult;
	}
	

}















package member.svc;

import member.dao.MemberDAO;
import vo.MemberBean;

import static db.JdbcUtil.*;

import java.sql.Connection;

public class MemberMailService {
	// 낙원(0902:MemberMessageService를 기능별로 분류하여 MemberSMSService,
	// MemberMailService로 나눔)
	// email 중복 여부 확인 요청 작업을 수행하기 위한 dupCheck() 메서드 정의
	public boolean dupCheck(String email) {
		
		String checkType = "email";
		
		boolean checkResult = true;
		
		Connection con = getConnection();
		
		MemberDAO memberDAO = MemberDAO.getInstance();
		
		memberDAO.setConnection(con);
		
		checkResult = memberDAO.dupCheck(email,checkType);
		
		close(con);
		
		return checkResult;
	}
	

}















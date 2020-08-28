package member.svc;

import static db.JdbcUtil.*;


import java.sql.Connection;

import member.dao.MemberDAO;


public class MessageService {

	// 폰번호 중복 여부 확인 요청 작업을 수행하기 위한 dupCheckPhone() 메서드 정의
	public boolean dupCheckPhone(String phone) {
		boolean checkResult = false; 
		
		Connection con = getConnection();

		MemberDAO mdao = MemberDAO.getInstance();

		mdao.setConnection(con);
		checkResult = mdao.dupCheckPhone(phone); 
		
		return checkResult;
	}
	



}

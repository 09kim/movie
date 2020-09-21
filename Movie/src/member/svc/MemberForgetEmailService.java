package member.svc;

import java.sql.*;

import member.dao.*;

import static db.JdbcUtil.*;

public class MemberForgetEmailService {


	public String getEmail(String phone) {
		System.out.println("MemberForgetEmailService");
		
		String email = "";
		
		Connection con = getConnection();
		
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		email = memberDAO.getEmail(phone);
		
		
		close(con);
		
		return email;
	}

	

}

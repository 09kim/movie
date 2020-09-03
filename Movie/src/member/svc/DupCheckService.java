package member.svc;

import java.sql.*;

import member.dao.*;

import static db.JdbcUtil.*;

public class DupCheckService {


	public boolean dupCheck(String nick) {
		System.out.println("DupCheckService");
		
		boolean isDup = false;
		
		Connection con = getConnection();
		
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		isDup = memberDAO.dupCheck(nick);
		
		
		close(con);
		
		return isDup;
	}

}

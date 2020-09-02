package member.svc;

import java.sql.*;

import member.dao.*;

import static db.JdbcUtil.*;

public class DupCheckService {

<<<<<<< HEAD
	public boolean dupCheck(String nick) {
		System.out.println("DupCheckService");
		
		boolean isDup = false;
		
		Connection con = getConnection();
		
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		isDup = memberDAO.dupCheck(nick);
		
=======
public boolean dupCheck(String nick) {
		
		System.out.println("DupCheckService");
		
		String type="nick";
		
		boolean isDup = false;
		
		Connection con = getConnection();
		
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		isDup = memberDAO.dupCheck(nick,type);
>>>>>>> refs/heads/낙원
		
		close(con);
		
		return isDup;
	}

}

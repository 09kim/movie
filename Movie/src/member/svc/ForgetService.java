package member.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import member.dao.MemberDAO;
import vo.MemberBean;

public class ForgetService {

	public boolean isEmailSame(MemberBean memberBean) {
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		boolean isEmailSame = memberDAO.isEmailSame(memberBean);
		
		if(isEmailSame) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isEmailSame;
	}

}

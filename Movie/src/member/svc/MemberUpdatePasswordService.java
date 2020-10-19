package member.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import member.dao.MemberDAO;
import member.exception.MemberInsertException;
import member.vo.MemberBean;
public class MemberUpdatePasswordService {

	public boolean updatePassword(String email, String pass) {
		boolean isUpdate =false;
		
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		int updateCount = dao.updatePassword(email,pass);
		System.out.println("sve : " + updateCount);
		if(updateCount>0) {
			isUpdate = true;
			commit(con);
		}else {
			rollback(con);
		}
		close(con);
		return isUpdate;
	}
		

}

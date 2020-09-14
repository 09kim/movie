package member.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import member.dao.MemberDAO;
import member.exception.MemberInsertException;
import member.vo.MemberBean;
public class MemberJoinProService {

	public boolean insertMember(MemberBean mb) throws MemberInsertException {
		boolean isInsert =false;
		
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		int insertCount = dao.insertMember(mb);
		System.out.println("sve : " + insertCount);
		System.out.println(mb.getPhone());
		if(insertCount>0) {
			isInsert = true;
			commit(con);
		}else {
			rollback(con);
			throw new MemberInsertException("회원가입 오류");
			
		}
		close(con);
		return isInsert;
	}

}

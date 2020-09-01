package member.svc;

import static db.JdbcUtil.*;

import java.sql.Connection;

import member.dao.MemberDAO;
import member.exception.MemberInsertException;
import member.vo.MemberBEAN;
public class MemberJoinProService {

	public boolean insertMember(MemberBEAN mb) throws MemberInsertException {
		boolean isInsert =false;
		
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		int insertCount = dao.insertMember(mb);
		System.out.println("sve : " + insertCount);
		
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

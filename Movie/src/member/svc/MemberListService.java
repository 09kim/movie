package member.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import member.dao.MemberDAO;
import vo.MemberBean;

public class MemberListService {

	public ArrayList<MemberBean> getMemberList() {
		System.out.println("MemberListService - getMemberList");
		
		ArrayList<MemberBean> memberList = null;
		
		// jdbcUtil.getConnection
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		memberList = memberDAO.selectMemberList();
		
		close(con);
		
		return memberList;
	}
	
	public ArrayList<MemberBean> getMemberList(String orderTarget, String orderType) {
		System.out.println("MemberListService - getMemberList");
		
		ArrayList<MemberBean> memberList = null;
		
		// jdbcUtil.getConnection
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		memberList = memberDAO.selectMemberList(orderTarget, orderType);
		
		close(con);
		
		return memberList;
	}
	
	

}

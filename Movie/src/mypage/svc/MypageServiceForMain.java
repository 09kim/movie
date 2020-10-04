package mypage.svc;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Map;

import mypage.action.Mypage;
import mypage.dao.MypageDAO;

import static db.JdbcUtil.*;

public class MypageServiceForMain {

	public void setMypage(String nick, ArrayList<String> list, Mypage type) {
		Connection con = getConnection();
		MypageDAO md = MypageDAO.getInstance();
		md.setConnection(con);
		int result = md.setGenre(nick,list,type);
		
		if(result > 0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
	}

	public ArrayList<String> getInformation(String nick, Mypage type) {
		
		Connection con = getConnection();
		MypageDAO md = MypageDAO.getInstance();
		md.setConnection(con);
		ArrayList<String> list = md.getInformation(nick,type);
		
		close(con);
		return list;
	}


}

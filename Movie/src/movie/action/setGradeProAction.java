package movie.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import vo.ActionForward;

public class setGradeProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("setGradeProAction");
//		String id = request.getParameter("id");
		String grade = request.getParameter("grade");
		String data = request.getParameter("data");
		System.out.println(data);
		System.out.println(grade);
		String[] param = data.split("/");
		for(int i = 0; i<param.length; i++) {
			
			System.out.println(param[i]);
		}
//		System.out.println(id);
		return null;
	}

}

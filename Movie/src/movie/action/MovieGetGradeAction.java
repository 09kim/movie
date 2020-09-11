package movie.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import movie.svc.setGradeService;
import vo.ActionForward;

public class MovieGetGradeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("getGradeACtion");
		
		System.out.println("-----------------------------------");
		// Get the printwriter object from response to write the required json object to
		// the output stream
		String nick  = (String)request.getAttribute("nick");
		String movieSeq = request.getParameter("movieSeq");
		System.out.println(nick + movieSeq);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/movie1/movie_detail.jsp");
		
		return forward;
	}

}

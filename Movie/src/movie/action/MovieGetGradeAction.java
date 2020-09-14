package movie.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import movie.svc.setGradeService;
import movie.vo.MovieBean;
import vo.ActionForward;

public class MovieGetGradeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("getGradeAction");
		
		System.out.println("-----------------------------------");
		// Get the printwriter object from response to write the required json object to
		// the output stream
		HttpSession session = request.getSession();
		String nick = (String)session.getAttribute("nick");
		String movieSeq = request.getParameter("movieSeq");
		System.out.println(nick + movieSeq);
		MovieBean movieBean = new MovieBean();
		movieBean.setNick(nick);
		movieBean.setMovieSeq(movieSeq);
		setGradeService setGradeService = new setGradeService();
		int getGrade = setGradeService.selectGrade(movieBean);
		ActionForward forward = new ActionForward();
		String grade = "";
	      
	      if((getGrade%2.0) == 0.0) {
	         grade = (int)(getGrade/2)+"";
	      }else {
	         grade = getGrade/2.0 + "";
	      }
	      
	      request.setAttribute("getGrade", grade);
	      
	      
	      forward.setRedirect(false);
	      forward.setPath("/movie1/movie_detail.jsp");
	      
	      return forward;
	}

}

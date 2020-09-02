package movie.action;

import javax.servlet.http.HttpServletRequest;
<<<<<<< HEAD

import javax.servlet.http.HttpServletResponse;

import action.Action;
import movie.svc.setGradeService;
import movie.vo.MovieBean;
import vo.ActionForward;

public class setGradeProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("setGradeProAction");
//		String id = request.getParameter("id");
		String grade = request.getParameter("grade");
		String movieInfo = request.getParameter("data");
//		System.out.println(movieSeq);
//		System.out.println(grade);
		String[] param = movieInfo.split("/");
		for(int i = 0; i<param.length; i++) {
			System.out.println(param[i]);
		}  
		String movieTitle = param[0];
		String movieSeq = param[1];
		String movieRuntime = param[2];
		String movieGenre = param[3];
		String movieYear = param[4];
		MovieBean movieBean = new MovieBean();
		movieBean.setMovieGenre(movieGenre);
		movieBean.setMovieRuntime(movieRuntime);
		movieBean.setMovieSeq(movieSeq);
		movieBean.setMovieTitle(movieTitle);
		movieBean.setMovieYear(movieYear);
		movieBean.setMovieGrade(grade);
		System.out.println(grade);
		
		setGradeService setGradeService = new setGradeService();
		setGradeService.isSetGrade(movieBean);
		
=======
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
>>>>>>> refs/heads/낙원
//		System.out.println(id);
		return null;
	}

}

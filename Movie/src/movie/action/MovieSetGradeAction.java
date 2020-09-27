package movie.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import movie.svc.setGradeService;
import movie.vo.MovieBean;
import vo.ActionForward;

public class MovieSetGradeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("setGradeProAction");
		String nick = request.getParameter("nick");
		String grade = request.getParameter("grade");
		String movieInfo = request.getParameter("data");
		String moviePoster = request.getParameter("image");
		String[] param = movieInfo.split("/");
		for(int i = 0; i<param.length; i++) {
			System.out.println(param[i]);
		}
		String movieDircetor = param[0];
		String movieNation = param[1];
		String movieTitle = param[2];
		int movieSeq = Integer.parseInt(param[3]);
		String movieRuntime = param[4];
		String movieGenre = param[5];
		String movieYear = param[6]; // 나중에 테이블 나눌때 필요한 변수
		MovieBean movieBean = new MovieBean();
		movieBean.setDirector(movieDircetor);
		movieBean.setNation(movieNation);
		movieBean.setMovieGenre(movieGenre);
		movieBean.setMovieRuntime(movieRuntime);
		movieBean.setMovieSeq(movieSeq);
		movieBean.setMovieTitle(movieTitle);
		movieBean.setMovieYear(movieYear);
		movieBean.setMovieGrade(grade);
		movieBean.setNick(nick);
		movieBean.setMoviePoster(moviePoster);
		
		
		
		setGradeService setGradeService = new setGradeService();
		setGradeService.isSetGrade(movieBean);
		System.out.println(movieBean.getMovieGrade());
		int movieGrade = setGradeService.selectGrade(movieBean);
		System.out.println("-----------------------------------movieGrade");
		System.out.println(movieGrade);
		
		
		return null;
	}

}

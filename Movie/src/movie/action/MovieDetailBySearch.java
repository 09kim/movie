package movie.action;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import movie.svc.MovieChartService;
import movie.vo.MovieBean;
import vo.ActionForward;

public class MovieDetailBySearch implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nick");
		String movieSeq = request.getParameter("movieSeq");
		int movieSeqInt = Integer.parseInt(movieSeq);
		String movieTitle = request.getParameter("query");
		String moviePoster = request.getParameter("image");
		int temp = Integer.parseInt(request.getParameter("temp"));
		String weather = request.getParameter("weather");
		MovieBean mb = new MovieBean();
		mb.setNick(nick);
		mb.setMovieSeq(movieSeqInt);
		mb.setMovieTitle(movieTitle);
		mb.setMoviePoster(moviePoster);
		mb.setTemp(temp);
		mb.setWeather(weather);
		MovieChartService movieChartService = new MovieChartService();
		ActionForward forward = new ActionForward();
		
		
		if(nick!=null) {
			movieChartService.setChart(mb);
		}
		
		// int로 받으면 movieSeq가 0으로 시작하는 5자리 미만의 숫자의 0이 없어져서 검색 불가능한 부분 수정함 - 낙원 : 1003
		if((movieSeq+"").length()<5) { // movieSeq에 널스트링을 더해서 문자열로 변환 후 .length()로 문자열 길이를 판별함
			int movieSeqLength = (movieSeq+"").length()+1; // length는 실제로 +1임(앞에 없어진 0을 포함해야되기때문)
			String movieSeqFormat = "%0"+movieSeqLength+"d"; // String.format함수를 사용하기 위한 포맷 양식(%0자릿수d)
			String movieSeq1 = String.format(movieSeqFormat, movieSeq); // String.format 적용
			forward.setPath("MovieDetailPro.mo?movieSeq="+movieSeq1+"&query="+URLEncoder.encode(movieTitle, "UTF-8")); // URL 한글처리 해줘야함~!
		}else { // 5자리보다 큰 경우는 앞에 0이 안붙기 때문에 그냥 movieSeq 그대로 써도 무방함
			forward.setPath("MovieDetailPro.mo?movieSeq="+movieSeq+"&query="+URLEncoder.encode(movieTitle, "UTF-8")); // URL 한글처리 해줘야함~!
		}
		
		forward.setRedirect(true);

		return forward;
	}

}

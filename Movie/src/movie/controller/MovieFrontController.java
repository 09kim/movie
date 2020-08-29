package movie.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import movie.action.MovieDirectorProAction;
import movie.action.MovieKeywordProAction;
import movie.action.MovieQueryProAction;
import vo.ActionForward;

@WebServlet("*.mo")
public class MovieFrontController extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String command = request.getServletPath();

		Action action = null;
		ActionForward forward = null;
		if (command.equals("/MovieDetail.mo")) {
			action = new MovieQueryProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (command.equals("/MovieDetailPro.mo")) {
			forward = new ActionForward();
			forward.setPath("/movie1/movie_detail.jsp");
		} else if (command.equals("/MovieSearch.mo")) {
			forward = new ActionForward();
			forward.setPath("/movie1/movie_search.jsp");

		} else if (command.equals("/MovieSearchPro.mo")) {
			action = new MovieQueryProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MovieSearchKeyword.mo")) {
			forward = new ActionForward();
			forward.setPath("/movie1/movie_keyword_search.jsp");
			
		} else if (command.equals("/MovieSearchKeywordPro.mo")) {
			action = new MovieKeywordProAction();
			try {
				action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} else if (command.equals("/MovieSearchDirector.mo")) {
			forward = new ActionForward();
			forward.setPath("/movie1/movie_director_search.jsp");
			
		} else if (command.equals("/MovieSearchDirectorPro.mo")) {
			action = new MovieDirectorProAction();
			try {
				action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}

	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

}

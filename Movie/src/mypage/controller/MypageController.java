package mypage.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mypage.action.MypageAction;
import mypage.action.MypageChangeWishAction;
import mypage.action.MypageCollectionAction;
import mypage.action.MypageCollectionCreateAction;
import mypage.action.MypageCollectionMovieAddAction;
import mypage.action.MypageDirectorAction;
import mypage.action.MypageDirectorSrcAction;
import mypage.action.MypageGenerAction;
import mypage.action.MypageGradeAction;
import mypage.action.MypageNationAction;
import mypage.action.MypageProAction;
import mypage.action.MypageSelectWishAction;
import mypage.action.MypageSelectWishListAction;
import vo.ActionForward;

@WebServlet("*.mp")
public class MypageController extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String command = request.getServletPath();

		Action action = null;
		ActionForward forward = null;
		System.out.println(command);
		if (command.equals("/Mypage.mp")) {
			action = new MypageAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			} 
		} else if (command.equals("/MypageForm.mp")) {
			action = new MypageProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MypageUpdate.mp")) {
			action = new MypageAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MypageGrade.mp")) {
			action = new MypageGradeAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MypageWish.mp")) { // 액션이름을 바꾸는게 좋아보임! 헷갈려요!
			action = new MypageSelectWishListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (command.equals("/MypageSelectWish.mp")) {
			action = new MypageSelectWishAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (command.equals("/MypageChangeWish.mp")) {
			action = new MypageChangeWishAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MypageDirectorSrc.mp")) {
			action = new MypageDirectorSrcAction();
			try {
				action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MypageGener.mp")) {
			action = new MypageGenerAction();
			try {
				action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MypageNation.mp")) {
			action = new MypageNationAction();
			try {
				action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MypageDirector.mp")) {
			action = new MypageDirectorAction();
			try {
				action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MypageCollection.mp")) {
			action = new MypageCollectionAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MypageCollectionCreate.mp")) {
			action = new MypageCollectionCreateAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/CollectionMovieAdd.mp")) {
			action = new MypageCollectionMovieAddAction();
			try {
				action.execute(request, response);
			} catch (Exception e) {
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

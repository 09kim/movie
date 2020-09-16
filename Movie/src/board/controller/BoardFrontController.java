package board.controller;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.*;
import board.action.*;
import member.action.*;
import mypage.action.*;
import vo.*;

@WebServlet("*.bo")
public class BoardFrontController extends HttpServlet {
	
	 protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 System.out.println("BoardFrontController");
		 
	 	 request.setCharacterEncoding("UTF-8");
		 String command = request.getServletPath();
		 System.out.println(command);
		
		 Action action = null;
		 ActionForward forward = null;
		
		
		 if(command.equals("/BoardReviewWriteForm.bo")) {
			 forward = new ActionForward();
			 forward.setPath("/board/board_reviewWrite.jsp");
			 
		 } else if(command.equals("/BoardReviewWritePro.bo")) {
			 action = new BoardReviewWriteProAction();
			 try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		 } else if(command.equals("/BoardReviewList.bo")) {
			 action = new BoardReviewListAction();
			 try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		 } else if(command.equals("/BoardReviewDetail.bo")) {
			 action = new BoardReviewDetailAction();
			 try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		 }
		
		
		
		
		
		
		
		
		 if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		 }
		
	}

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}

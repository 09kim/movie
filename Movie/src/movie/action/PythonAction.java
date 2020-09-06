package movie.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;

import action.Action;
import vo.ActionForward;

public class PythonAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		System.out.println("hi");
		JsonObject json = (JsonObject) session.getAttribute("param");
		System.out.println("python"+ json);
		return null;
	}

}

package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;

@WebServlet("/cancelmyform")
public class CancelMyFormCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public CancelMyFormCtrl() {super();}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String code = request.getParameter("omcode");
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		String miid = loginInfo.getMi_id();
		String where = " where mi_id = '"+ miid +"'";
		
		CancelFormSvc cancelFormSvc = new CancelFormSvc();
		ArrayList<OrderMpInfo> orderMyCancelList = cancelFormSvc.getMyCancelOrderList(where, code);
		
		
		request.setAttribute("orderMyCancelList", orderMyCancelList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/front/cs/cancel_my_form.jsp");
		dispatcher.forward(request, response);
	}
}

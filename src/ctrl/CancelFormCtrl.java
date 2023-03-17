package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;


@WebServlet("/cancelform")
public class CancelFormCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public CancelFormCtrl() {super();}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		if(loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 사용하실 수 있습니다.');");
			out.println("location.replace('login_form.jsp?url=mypage_reserve')");
			out.println("</script>");
			out.close();
		}
		
		
		String code = request.getParameter("opcode");
		String miid = loginInfo.getMi_id();
		String where = " where mi_id = '"+ miid +"'";
		
		CancelFormSvc cancelFormSvc = new CancelFormSvc();
		ArrayList<OrderPaInfo> orderCancelList = cancelFormSvc.getCancelOrderList(where, code);		
		
		request.setAttribute("orderCancelList", orderCancelList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/front/cs/cancel_form.jsp");
		dispatcher.forward(request, response);
	}
}

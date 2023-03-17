package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;

@WebServlet("/cancel_complete")
public class CancelCompleteCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public CancelCompleteCtrl() {super();}

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
		
		
		String ctgr = request.getParameter("ctgr");
		String content = request.getParameter("content");
		String code = request.getParameter("code");
		int result = 0;
		
		String miid = loginInfo.getMi_id();	
		String where = " where mi_id = '"+ miid +"'";
		
		if(ctgr.equals("단순변심")) ctgr = "a";
		else if (ctgr.equals("업체 측 사유")) ctgr = "b";
		else if (ctgr.equals("여행 일정 변경")) ctgr = "c";
	
		CancelCompleteSvc cancelCompleteSvc = new CancelCompleteSvc();
		result = cancelCompleteSvc.insertPacancel(ctgr, content, code);
		
		//result = cancelCompleteSvc.updateStatus(ctgr, content, code);
		
		//request.setAttribute("pacancelList", pacancelList);
		
		if(result == 2) {
			response.sendRedirect("mypage_reserve");
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('요청이 정상적으로 작동하지 않았습니다. 다시 시도하세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		
//		RequestDispatcher dispatcher = request.getRequestDispatcher("mypage_reserve");
//		dispatcher.forward(request, response);
	}

}

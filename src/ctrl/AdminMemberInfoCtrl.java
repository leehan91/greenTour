package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;

@WebServlet("/member_info")
public class AdminMemberInfoCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminMemberInfoCtrl() {super();}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid");
		String pwd = request.getParameter("pwd");
		String url = request.getParameter("url").replace('$', '&');
		
		AdminLoginSvc adminLoginSvc = new AdminLoginSvc(); 
		AdminInfo adminLoginInfo = adminLoginSvc.getLoginInfo(uid, pwd);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if(adminLoginInfo != null) {		// 로그인 성공시
			HttpSession session = request.getSession();
			session.setAttribute("adminLoginInfo", adminLoginInfo);
			
			out.println("<script>");
			out.println("location.replace('" + url + "');");
			out.println("</script>");
			out.close();
			
		}else {		// 로그인 실패시 
			
			out.println("<script>");
			out.println("alert('아이디와 암호를 확인하세요');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}
}

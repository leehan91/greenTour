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
		
		if(adminLoginInfo != null) {		// �α��� ������
			HttpSession session = request.getSession();
			session.setAttribute("adminLoginInfo", adminLoginInfo);
			
			out.println("<script>");
			out.println("location.replace('" + url + "');");
			out.println("</script>");
			out.close();
			
		}else {		// �α��� ���н� 
			
			out.println("<script>");
			out.println("alert('���̵�� ��ȣ�� Ȯ���ϼ���');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}
}

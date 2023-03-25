package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;


@WebServlet("/mypackage_main")
public class MyPackageMainCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public MyPackageMainCtrl() { super(); }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		
		if(loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용하실 수 있습니다..');");
			out.println("location.replace('login_form.jsp?url=mypackage_main')");
			out.println("</script>");
			out.close();
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("front/mypackage/mypackage_main.jsp");
		dispatcher.forward(request, response);
		
		// ��Ű���� ���ܵ� 
//		Cookie[] cookies = request.getCookies();
//		if (cookies != null) { // ��Ű�� �Ѱ��� ������ ����
//	        for (int i = 0; i < cookies.length; i++) {
//	            cookies[i].setMaxAge(0); // ��ȿ�ð��� 0���� ����
//	            response.addCookie(cookies[i]); // ���信 �߰��Ͽ� �����Ű��.
//	        }
//	    }
		
		
	}
}

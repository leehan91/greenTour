package ctrl;

import java.io.*;
import java.net.URLEncoder;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/member_reserve_cancel")
public class AdminMemberReserveCancelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public AdminMemberReserveCancelCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String miid = request.getParameter("frmMiid");
		String code = request.getParameter("code");
		AdminMemberCancelSvc adminMemberCancelSvc = new AdminMemberCancelSvc();
		int result = adminMemberCancelSvc.memReserveUP(miid, code);
		
		if (result >= 1) {	// ���������� ���� ��ϵǾ�����
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println(result);
    	} else {	// �� ��� ����		
    		response.setContentType("text/html; charset=utf-8");
    		PrintWriter out = response.getWriter();
    		out.println("<script>");
    		out.println("alert('�۵�Ͽ� �����߽��ϴ�.\\n�ٽ� �õ��ϼ���.');");
    		out.println("history.back();");
    		out.println("</script>");
    		out.close();
    	}
	}

}

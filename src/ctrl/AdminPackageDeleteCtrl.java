package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;


@WebServlet("/package_delete")
public class AdminPackageDeleteCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminPackageDeleteCtrl() {super();}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String picode = request.getParameter("picode");
		
		AdminPackageDeleteSvc adminPackageDeleteSvc = new AdminPackageDeleteSvc();
		int result = adminPackageDeleteSvc.deletePackage(picode);
		
		if (result == 1) {		// ���������� �����Ǿ��� ���
			response.sendRedirect("admin_package_list");
		} else {		// ���������� �������� �ʾ��� ���
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('��Ű�� ������ �����Ͽ����ϴ�.\\n�ٽ� �õ��ϼ���.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

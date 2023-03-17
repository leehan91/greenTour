package ctrl;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.*;

@WebServlet("/member_correc")
public class AdminMemberCorrecCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminMemberCorrecCtrl() {super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String miid = request.getParameter("miid");
		String memStatus = request.getParameter("memStatus");
		
		AdminMemberInfoCorrecSvc adminMemberInfoCorrecSvc = new AdminMemberInfoCorrecSvc();
		int result = adminMemberInfoCorrecSvc.memberUp(miid, memStatus);
		
		if (result == 1) {		// ���������� ȸ�� ���� ������ �̷�� ������
			response.sendRedirect("member_list");
		} else {		// ���� ���� ����
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('���� ���忡 �����߽��ϴ�.\\n�ٽ� �õ��ϼ���.");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
	}

}

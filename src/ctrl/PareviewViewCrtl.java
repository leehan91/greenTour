package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/pareview_view")
public class PareviewViewCrtl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PareviewViewCrtl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpidx = Integer.parseInt(request.getParameter("cpidx"));
		
		PareviewViewSvc pareviewViewSvc = new PareviewViewSvc();
		int result = pareviewViewSvc.readUpdate(cpidx);			// ����ڰ� ������ �Խñ��� ��ȸ���� ������Ű�� �޼ҵ� ȣ��
		
		CsPareview cp = pareviewViewSvc.getPareviewInfo(cpidx);		// ����ڰ� ������ �Խñ��� ������� CsNotice�� �ν��Ͻ��� �޾ƿ�
		

		if (cp == null) {		// ������ �Խñ��� ������
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�߸��� ��η� �����̽��ϴ�.);");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		
		} else {		// ������ �Խñ��� ������
			request.setAttribute("cp", cp);
			RequestDispatcher dispatcher = request.getRequestDispatcher("front/review/pareview_view.jsp");
			dispatcher.forward(request, response);
		
		}		
	}

}

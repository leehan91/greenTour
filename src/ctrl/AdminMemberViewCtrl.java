package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;

@WebServlet("/member_view")
public class AdminMemberViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminMemberViewCtrl() {
        super();
      
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String miid = request.getParameter("miid");

		MemberInfoViewSvc memberInfoViewSvc = new MemberInfoViewSvc();
		AdminOrderPaViewSvc adminorderPaViewSvc = new  AdminOrderPaViewSvc();
		MemberInfo mi = memberInfoViewSvc.getMemberInfo(miid);
		ArrayList<OrderPaInfo> opList =  adminorderPaViewSvc.getOrderPaList(miid);
		
		if (mi == null) {		// ������ ȸ���� ������
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�߸��� ��η� �����̽��ϴ�.);");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		
		} else {		// ������ȸ���� ������
			request.setAttribute("mi", mi);
			request.setAttribute("opList", opList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("admin/member/member_view.jsp");
			dispatcher.forward(request, response);
		
		}		
		
		
		
		
	}

}

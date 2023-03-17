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
		
		if (mi == null) {		// 보여줄 회원이 없으면
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.);");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		
		} else {		// 보여줄회원이 있으면
			request.setAttribute("mi", mi);
			request.setAttribute("opList", opList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("admin/member/member_view.jsp");
			dispatcher.forward(request, response);
		
		}		
		
		
		
		
	}

}

package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;
import java.util.*;

@WebServlet("/paorder_end")
public class PackageOrderEndCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public PackageOrderEndCtrl() { super();}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String opCode = request.getParameter("opCode"); 
			
		HttpSession session = request.getSession();
		MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
		String miid = mi.getMi_id();  
		
		PaOrderEndSvc PaOrderEndSvc = new PaOrderEndSvc();
		OrderPaInfo orderPaInfo = PaOrderEndSvc.getOrderInfo(miid, opCode);
		
		
		if(orderPaInfo == null) {		// 주문정보가 없을 경우 
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("location.replace('/greenTourSite/index.jsp');");
			out.println("</script>");
			out.close();	
			
		}else {		// 주문 정보가 있을 경우 
			request.setAttribute("orderPaInfo", orderPaInfo);
			RequestDispatcher dispatcher = request.getRequestDispatcher("front/reserv/order_end.jsp");
			dispatcher.forward(request, response);
			
		}
		
		
	}

}

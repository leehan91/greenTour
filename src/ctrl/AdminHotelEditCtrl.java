package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/hotel_edit")
public class AdminHotelEditCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminHotelEditCtrl() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String hicode = request.getParameter("hicode");
		
		AdminHotelEditSvc adminHotelEditSvc = new AdminHotelEditSvc();
		
		HotelInfo hi = adminHotelEditSvc.getHotelInfo(hicode);		// ����ڰ� ������ �Խñ��� ������� BbsFree �� �ν��Ͻ��� �޾ƿ�
		/*if (hi == null) {		// ������ �Խñ��� ������
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�߸��� ��η� �����̽��ϴ�.);");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		
		} else {		// ������ �Խñ��� ������
*/			request.setAttribute("hi", hi);
			RequestDispatcher dispatcher = request.getRequestDispatcher("admin/hotel/hotel_edit.jsp");
			dispatcher.forward(request, response);
		
		}		
	}

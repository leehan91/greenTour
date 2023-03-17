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
		
		HotelInfo hi = adminHotelEditSvc.getHotelInfo(hicode);		// 사용자가 선택한 게시글의 내용들을 BbsFree 형 인스턴스로 받아옴
		/*if (hi == null) {		// 보여줄 게시글이 없으면
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.);");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		
		} else {		// 보여줄 게시글이 있으면
*/			request.setAttribute("hi", hi);
			RequestDispatcher dispatcher = request.getRequestDispatcher("admin/hotel/hotel_edit.jsp");
			dispatcher.forward(request, response);
		
		}		
	}

package ctrl;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.AdminHotelDelSvc;

@WebServlet("/hotel_del_ctrl")
public class AdminHotelDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminHotelDelCtrl() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String hicodeList = request.getParameter("hicodeList");

		AdminHotelDelSvc adminHotelDelSvc = new AdminHotelDelSvc();
		int result = adminHotelDelSvc.hotelDelete(hicodeList);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
	}
}

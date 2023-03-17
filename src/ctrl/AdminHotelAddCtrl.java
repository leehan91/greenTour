package ctrl;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.AdminHotelAddSvc;

@WebServlet("/hotel_add")
public class AdminHotelAddCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminHotelAddCtrl() {
		super();
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/hotel/hotel_add.jsp");
		dispatcher.forward(request, response);
	}
}

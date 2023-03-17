package ctrl;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import svc.AdminHotelAddSvc;
import svc.AdminHotelCodeSvc;

@WebServlet("/hotel_code")
public class AdminHotelCodeCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminHotelCodeCtrl() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		AdminHotelAddSvc adminHotelAddSvc = new AdminHotelAddSvc();
		int result = adminHotelAddSvc.getHotelAdd(request);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/hotel_list");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String ccid = request.getParameter("ccid");
		
		AdminHotelCodeSvc adminHotelAddSvc = new AdminHotelCodeSvc();

		JsonObject hotelUniqueId = adminHotelAddSvc.getHotelUniqueId(ccid);

		response.setContentType("application/json; charset=UTF-8;");
		PrintWriter out = response.getWriter();
		out.println(hotelUniqueId); // 장바구니 담기 기능을 호출했던 ajax를 사용한 곳으로 결과값을 리턴
	}
}

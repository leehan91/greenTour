package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/package_reserv")
public class PackageReservCtrl extends HttpServlet {
	// �����ϱ� ���� �ش� ��ǰ �� �ҷ�����
	private static final long serialVersionUID = 1L;
    public PackageReservCtrl() {        super();  
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String departure = request.getParameter("departure");
		String piCode = request.getParameter("piCode");
		
		PackageReservViewFormSvc packageReservViewFormSvc = new PackageReservViewFormSvc();  	
		PackageInfo pi = packageReservViewFormSvc.getViewList(piCode, departure);
		request.setAttribute("pi", pi);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("front/reserv/package_reservation.jsp");
		dispatcher.forward(request, response);
	}

}

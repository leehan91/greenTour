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
import svc.AdminHotelUpSvc;

@WebServlet("/hotel_up")
public class AdminHotelUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminHotelUpCtrl() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		AdminHotelUpSvc adminHotelUpSvc = new AdminHotelUpSvc();

		int result = adminHotelUpSvc.getHotelUpdate(request);

		if (result == 1) {		// ���������� ȸ�� ���� ������ �̷�� ������
			response.sendRedirect("hotel_list");
		} else {		// ���� ���� ����
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('���� ���忡 �����߽��ϴ�.\\n�ٽ� �õ��ϼ���.");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
	}

}

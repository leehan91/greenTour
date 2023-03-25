package ctrl;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;

import svc.PackageListSvc;
import vo.PackageDate;

@WebServlet("/package_list")
public class PackageListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PackageListCtrl() {
        super();

    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String picode = request.getParameter("picode");
		
		PackageListSvc packageListSvc = new PackageListSvc();
		ArrayList<PackageDate> pdList = packageListSvc.getPackageListCount(picode);
		request.setAttribute("pdList", pdList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/front/package/package_list.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String picode = request.getParameter("picode");
		String fiDeparture = request.getParameter("fiDeparture");
		// System.out.println("picode : "+picode+" / fiDeparture : "+fiDeparture);
		
		PackageListSvc packageListSvc = new PackageListSvc();

		JsonArray packageList = packageListSvc.getPackageDateList(picode, fiDeparture);

		response.setContentType("application/json; charset=UTF-8;");
		PrintWriter out = response.getWriter();
		out.println(packageList); // ��ٱ��� ��� ����� ȣ���ߴ� ajax�� ����� ������ ������� ����
	}
	
}

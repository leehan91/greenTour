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
import svc.PackageMainSvc;
import vo.PackageDate;
import vo.PackageInfo;

@WebServlet("/package_main")
public class PackageMainCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PackageMainCtrl() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
request.setCharacterEncoding("utf-8");
		
		String ccid = request.getParameter("ccid");

		
		PackageMainSvc packageMainSvc = new PackageMainSvc();
		
		ArrayList<PackageInfo> piList = packageMainSvc.getPackageSuggest(ccid);
		
		request.setAttribute("piList", piList);

		RequestDispatcher dispatcher = request.getRequestDispatcher("front/package/package_main.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
		
}

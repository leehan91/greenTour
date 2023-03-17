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

@WebServlet("/package_main")
public class PackageMainCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PackageMainCtrl() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		/*
		 * String picode = request.getParameter("picode"); System.out.println(picode);
		 * 
		 * PackageMainSvc PackageMainSvc = new PackageMainSvc(); ArrayList<PackageDate>
		 * pdList = PackageMainSvc.getPackageMainList("JPN"); //
		 * System.out.println(pdList.size()); request.setAttribute("pdList", pdList);
		 */
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("front/package/package_main.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String ccid = request.getParameter("ccid");
		String gbn = request.getParameter("gbn");
		// System.out.println(ccid);
		
		PackageMainSvc packageMainSvc = new PackageMainSvc();
		
		JsonArray packageMain = packageMainSvc.getPackageMainCount(ccid, gbn);
		
		//System.out.println("packageMain: " + packageMain);
		
		response.setContentType("application/json; charset=UTF-8;");
		PrintWriter out = response.getWriter();
		out.println(packageMain); // 장바구니 담기 기능을 호출했던 ajax를 사용한 곳으로 결과값을 리턴
	}
		
}

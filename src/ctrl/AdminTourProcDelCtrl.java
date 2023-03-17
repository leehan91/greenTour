package ctrl;

import java.io.*;
import java.net.URLEncoder;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/tour_proc_del")
public class AdminTourProcDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminTourProcDelCtrl() {super();}

	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		String ptcode = request.getParameter("ptcode");

		String where = "where ";
		if (ptcode.indexOf(',') > 0) {// 여러개의 상품을 삭제할 경우

			String[] arr = ptcode.split(",");
			for (int i = 0 ; i < arr.length; i++) {
				if (i == 0)  where += " (pt_code = '" + arr[i];
				else		 where += "' or pt_code = '" + arr[i];
			}
			where += "')";
		} else { // 한개의 상품을 삭제할 경우
			where += " pt_code = '" + ptcode + "' ";			
		}
		
		AdminTourDelSvc adminTourDelSvc = new AdminTourDelSvc();
		int result = adminTourDelSvc.tourDelete(where);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
	}

}

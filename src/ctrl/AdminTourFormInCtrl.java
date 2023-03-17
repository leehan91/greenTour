package ctrl;

import java.io.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;
@WebServlet("/tour_form_in")
public class AdminTourFormInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminTourFormInCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/product/tour_form_in.jsp");
		dispatcher.forward(request, response);
		
	}
	
}

package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;

@WebServlet("/hotel_list")
public class AdminHotelListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminHotelListCtrl() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
	
		if (request.getParameter("cpage") != null)		cpage = Integer.parseInt(request.getParameter("cpage")); 
		
		String schtype = request.getParameter("schtype");		// �˻� ����(����, ����, ���� + ����)
		String keyword = request.getParameter("keyword");		// �˻���
		String where = " where hi_isdel = 'n' ";		// �˻� ������ ���� ��� where ���� ������ ����
		
		if (schtype == null || keyword == null) {
			schtype = "";		keyword = "";
		} else if (!schtype.equals("") && !keyword.equals("")) {		// �ܼ��� null�� �ƴѰ� �ƴ϶� �� ���ڿ��� �Ÿ��� ���� �� ���ǹ� //
			URLEncoder.encode(keyword, "UTF-8");
			
			if("nation".equals(schtype) || "city".equals(schtype)){
				where += " AND UPPER(cc_id) LIKE UPPER('%" + keyword + "%')";;
			} else {
				where += " AND UPPER(hi_" + schtype + ") LIKE UPPER('%" + keyword + "%')";
			}
		}
		
		AdminHotelListSvc adminHotelListSvc = new AdminHotelListSvc();
		rcnt = adminHotelListSvc.getHotelListCount(where);		// �˻��� �Խñ��� �� ������ �Խñ� �Ϸù�ȣ ��°� ��ü ������ �� ����� ���� �ʿ�
		
		ArrayList<HotelInfo> hotelList = adminHotelListSvc.getHotelList(where, cpage, psize);
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setCpage(cpage);
		pageInfo.setPsize(psize);
		pageInfo.setBsize(bsize);
		pageInfo.setRcnt(rcnt);
		pageInfo.setPcnt(pcnt);
		pageInfo.setSpage(spage);
		pageInfo.setSchtype(schtype);
		pageInfo.setKeyword(keyword);
		// ����¡�� �˻��� �ʿ��� �������� PageInfo�� �ν��Ͻ��� ����
		
		request.setAttribute("hotelList", hotelList);
		request.setAttribute("pageInfo", pageInfo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/hotel/hotel_list.jsp");
		dispatcher.forward(request, response);
	}
}

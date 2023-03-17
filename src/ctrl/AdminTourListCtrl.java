package ctrl;

import java.io.*;
import java.net.URLEncoder;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/tour_list")
public class AdminTourListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminTourListCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String schtype, keyword;
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		// ���� ������ ��ȣ, ������ ũ��, ��� ũ��, ���ڵ�(�Խñ�) ����, ���� ������ ���� ������ ������
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		
		String where ="where pt_price >= 0 ";	// �˻������� ���� ��� where���� ������ ����
		if(request.getParameter("keyword") == null) keyword = "";
		else keyword = request.getParameter("keyword").toUpperCase();	// �˻���
		
		schtype = request.getParameter("schtype");	// �˻�����(����, ����, ����+����)
			if (schtype == null) {
				schtype = "";
				// ȭ����� �˻�� 'null'�� ������ �ʰ� �ϱ� ���� �� ���ڿ��� ä��
			} else if (!schtype.contentEquals("") && !keyword.contentEquals("")) {
			// �˻����ǰ� �˻�� ��� ���� ���
			URLEncoder.encode(keyword, "UTF-8");
			// ������Ʈ������ �ְ� �޴� �˻�� �ѱ��� ��� �������� ���� ������ �߻��� �� �����Ƿ� �����ڵ�� ��ȯ
			if (schtype.equals("code")) { // �˻� ������ '�ڵ�'�� ���0
				
				where += " and (cc_id like '%" + keyword + "%' )";
			} else if (schtype.equals("name")) {	// �˻� ������ '����'�� ��� 
				where += " and pt_name like '%" + keyword +"%' ";
			}
		}
		AdminTourListSvc tourListSvc = new AdminTourListSvc();
		rcnt = tourListSvc.getPareviewListCount(where);
		ArrayList<PackageTour> ptList = tourListSvc.getTourList(where,cpage,psize);
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize);			pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);				pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);				pageInfo.setSpage(spage);
		pageInfo.setSchtype(schtype);		pageInfo.setKeyword(keyword);

		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("ptList", ptList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/product/tour_list.jsp");
		dispatcher.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

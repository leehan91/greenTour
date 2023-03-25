package ctrl;

import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.*;
import vo.*;

@WebServlet("/pareview_list")
public class PareviewListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PareviewListCtrl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int cpage = 1, psize = 10, bsize = 10, rcnt = 0, pcnt = 0, spage = 0;
		// ���� ������ ��ȣ, ������ ũ��, ��� ũ��, ���ڵ�(�Խñ�) ����, ���� ������ ���� ������ ������
		if (request.getParameter("cpage") != null) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		String schtype = request.getParameter("schtype");	// �˻�����(����, ����, ����+����)
		String keyword = request.getParameter("keyword");	// �˻���
		String where = " where cp_isdel = 'n' ";	// �˻������� ���� ��� where���� ������ ����
		if (schtype == null || keyword == null) {
			schtype = "";			keyword = "";
			// ȭ����� �˻�� 'null'�� ������ �ʰ� �ϱ� ���� �� ���ڿ��� ä��
		} else if (!schtype.contentEquals("") && !keyword.contentEquals("")) {
			// �˻����ǰ� �˻�� ��� ���� ���
			URLEncoder.encode(keyword, "UTF-8");
			// ������Ʈ������ �ְ� �޴� �˻�� �ѱ��� ��� �������� ���� ������ �߻��� �� �����Ƿ� �����ڵ�� ��ȯ
			if (schtype.equals("tc")) { // �˻� ������ '����+����'�� ���
				where += " and (cp_title like '%" + keyword + "%' or cp_content like '%" + 
						keyword + "%')";
			} else {	// �˻� ������ '����'�̳� '����'�� ���
				where += "and cp_" + schtype + " like '%" + keyword +"%' ";
			}
		}
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setBsize(bsize);			pageInfo.setCpage(cpage);
		pageInfo.setPcnt(pcnt);				pageInfo.setPsize(psize);
		pageInfo.setRcnt(rcnt);				pageInfo.setSpage(spage);
		pageInfo.setSchtype(schtype);		pageInfo.setKeyword(keyword);
		// ����¡�� �˻��� �ʿ��� �������� PageInfo�� �ν��Ͻ��� ����

		PareviewListSvc pareviewListSvc = new PareviewListSvc();
		rcnt = pareviewListSvc.getPareviewListCount(where);
		
		ArrayList<CsPareview> csPareview = pareviewListSvc.getPareviewList(where,cpage,psize);
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("csPareview", csPareview);
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("front/review/pareview_list.jsp");
		dispatcher.forward(request, response);

		
	}

}

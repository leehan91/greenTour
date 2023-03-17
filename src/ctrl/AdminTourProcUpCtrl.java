package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;


@WebServlet("/tour_proc_up")
@MultipartConfig(
		fileSizeThreshold = 0,
		location = "E:/lsg/web/work/greenTourSite/WebContent/front/img"		
)
public class AdminTourProcUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdminTourProcUpCtrl() { super(); }    
    	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
    	
    	// 이미지 처리 --------------------------------------
    	
		
    		Part part = request.getPart("ptimg");						
    		
    		String contentDisposition = part.getHeader("content-disposition");
    		// EX) form-data; name="file1"; filename="업로드할파일명.확장자"
    		System.out.println("contentDisposition : "+ contentDisposition);
    		
    		String uploadFileName = getUploadFileName(contentDisposition);
    		
    		part.write(uploadFileName);
    		
    		String ptimg = uploadFileName; // 이미지 명 
    		
    		// --------------------------------------
    	
    	
    	int price;
    	String code = request.getParameter("code").toUpperCase();
    	String country = request.getParameter("country").toUpperCase();
    	String city = request.getParameter("city").toUpperCase();
    	String name = request.getParameter("name");
    	String img = ptimg;
    	String summary = request.getParameter("summary");
    	String desc = request.getParameter("desc");
    	if(request.getParameter("price") == null || request.getParameter("price") == "" )	 price = 0;
    	else 				price = Integer.parseInt(request.getParameter("price"));
    	String addr = request.getParameter("addr");
    	String page = request.getParameter("page");
    	/*
		System.out.println(code);
		System.out.println(country);
		System.out.println(city);
		System.out.println(name);
		System.out.println(img);
		System.out.println(summary);
		System.out.println(desc);
		System.out.println(addr);
		System.out.println(page);
		System.out.println(price);
    	 */	
    	PackageTour pt = new PackageTour();
    	pt.setCc_id(country+city+"");
    	pt.setPt_code(code);
    	pt.setPt_name(name);
    	pt.setPt_addr(addr);
    	pt.setPt_price(price);
    	pt.setPt_page(page);
    	pt.setPt_image(img);
    	pt.setPt_summary(summary);
    	pt.setPt_desc(desc);
    	
    	AdminTourProcInSvc tourProcInSvc = new AdminTourProcInSvc();
    	int result = tourProcInSvc.TourProcup(pt);
    	
    	if (result == 1) {	// 정상적으로 글이 등록되었으면
    		response.sendRedirect("tour_list");
    	} else {	// 글 등록 실패		
    		response.setContentType("text/html; charset=utf-8");
    		PrintWriter out = response.getWriter();
    		out.println("<script>");
    		out.println("alert('글등록에 실패했습니다.\\n다시 시도하세요.');");
    		out.println("history.back();");
    		out.println("</script>");
    		out.close();
    	}
    
    
		
	}
	
	private String getUploadFileName(String contentDisposition) {
		String uploadFileName = null;
		String[] contentSplitStr = contentDisposition.split(";");
		
		int fIdx = contentSplitStr[2].indexOf("\"");
		int sIdx = contentSplitStr[2].lastIndexOf("\"");
		
		uploadFileName = contentSplitStr[2].substring(fIdx + 1, sIdx);
		
		return uploadFileName;
	}
}

package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/admin_add_package_insert")
@MultipartConfig(
		fileSizeThreshold = 0,
		location = "E:/bhj/web/work/greenTourSite/WebContent/front/img"		
)
public class AdminAddPackageInsertCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public AdminAddPackageInsertCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		
		HttpSession session = request.getSession();
		AdminInfo adminLoginInfo = (AdminInfo)session.getAttribute("adminLoginInfo");
		if(adminLoginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 사용하실 수 있습니다.');");
			out.println("location.replace('admin/admin_index.jsp?url=admin_add_package_form')");
			out.println("</script>");
			out.close();
		}
		
		// 이미지 처리 
		
		String uploadFileNameList = ""; // 업로드할 파일 이름들을 저장할 변수
		
		for (Part part : request.getParts()) {
			
			if(part.getName().equals("piimg1") || part.getName().equals("piimg2") || part.getName().equals("piimg3")
					|| part.getName().equals("piimg4") || part.getName().equals("piimg5")) {
				//해당 이미지들 일때만 part로 작업, value로 얻는값이 아니라 컨트롤 자체의 이름을 "" 안에 적어야 함. 
				String cd = part.getHeader("content-disposition");
			
				String uploadFileName = getUploadFileName(cd);
				if(!uploadFileName.equals("")) {
					uploadFileNameList += ", " + uploadFileName;
					part.write(uploadFileName);
				}
			}
		}
		if(!uploadFileNameList.equals(""))
			uploadFileNameList = uploadFileNameList.substring(2);
		
		String[] arr = uploadFileNameList.split(", ");	//uploadFileNameList : piimg1,piimg2, ... ,piimg5 로 담겨있음 
		String piimg1 = arr[0];
		String piimg2 = arr[1];
		String piimg3 = arr[2];
		String piimg4 = arr[3];
		String piimg5 = arr[4];
		

		
		int date = 0;
		// picountry 처리
		String nation = "";
		int nationNum = Integer.parseInt(request.getParameter("nation"));
		if(nationNum==1) nation = "일본";
		else if(nationNum==2) nation="태국";
		else if(nationNum==3) nation="필리핀";
		else if(nationNum==4) nation="홍콩";
		else if(nationNum==5) nation="싱가포르";
		else if(nationNum==6) nation="베트남";
		else if(nationNum==7) nation="대만";
		
		// pitour 처리 // day1~7일이 다 들어오기 때문에 period를 이용해서 기간에 맞게 처리 비어있는 일차는 모두 "자유여행" 이 들어있음.
		String period = request.getParameter("period");
		System.out.println("period : " + period);
		
		try {
			date = Integer.parseInt(period.substring(2, 3));
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("여행기간 입력 오류 발생");
			return;
		}
		String picode = request.getParameter("picode");
		
		
		date = Integer.parseInt(period.substring(2, 3));
		
	
		String day1 = request.getParameter("day1");
		String day2 = request.getParameter("day2");
		String day3 = request.getParameter("day3");
		String day4 = request.getParameter("day4");
		String day5 = request.getParameter("day5");
		String day6 = request.getParameter("day6");
		String day7 = request.getParameter("day7");
		
		if(!day1.equals("자유여행"))day1 = day1.substring(day1.indexOf("/")+1, day1.lastIndexOf("/"));
		if(!day2.equals("자유여행"))day2 = day2.substring(day2.indexOf("/")+1, day2.lastIndexOf("/"));
		if(!day3.equals("자유여행"))day3 = day3.substring(day3.indexOf("/")+1, day3.lastIndexOf("/"));
		if(!day4.equals("자유여행"))day4 = day4.substring(day4.indexOf("/")+1, day4.lastIndexOf("/"));
		if(!day5.equals("자유여행"))day5 = day5.substring(day5.indexOf("/")+1, day5.lastIndexOf("/"));
		if(!day6.equals("자유여행"))day6 = day6.substring(day6.indexOf("/")+1, day6.lastIndexOf("/"));
		if(!day7.equals("자유여행"))day7 = day7.substring(day7.indexOf("/")+1, day7.lastIndexOf("/"));
		
		String tour = day1 + "/" +day2 + "/" +day3 + "/" +day4 + "/" +day5 + "/" +day6 + "/" +day7;
		//3박4일 = 4 
				
		String[] sarr = tour.split("/");
		String pitour ="";
		for(int i = 1; i < date-1; i++) {
			pitour += sarr[i] + "/";
		}
		pitour = pitour.substring(0, pitour.length()-1);

		PackageInfo pi = new PackageInfo();
		pi.setCc_id(request.getParameter("ccid"));
		pi.setPi_code(request.getParameter("picode"));
		pi.setPi_country(nation);
		pi.setHi_code(request.getParameter("hicode"));
		pi.setPn_idx(Integer.parseInt(request.getParameter("newpnidx")));	// 유의사항 생성일 경우만 동작하므로 생성시 만들어지는 newpnidx를 넣어줌
		//pi.setpn_idx(Integer.parseInt(request.getParameter("pnidx")))
		pi.setPi_name(request.getParameter("piname"));
		pi.setPi_period(request.getParameter("period"));
		pi.setPi_keyword(request.getParameter("keyword"));
		pi.setPi_img1(piimg1);
		pi.setPi_img2(piimg2);
		pi.setPi_img3(piimg3);
		pi.setPi_img4(piimg4);
		pi.setPi_img5(piimg5);
		pi.setPi_desc(request.getParameter("summary"));
		pi.setPi_special(request.getParameter("pispecial"));
		pi.setPi_tour(pitour);
		pi.setPi_food(request.getParameter("pifood"));
		pi.setPi_stock(Integer.parseInt(request.getParameter("pistock")));
		pi.setPi_price(Integer.parseInt(request.getParameter("piadult")));
		pi.setPi_adult(Integer.parseInt(request.getParameter("piadult")));
		pi.setPi_child(Integer.parseInt(request.getParameter("pichild")));
		pi.setPi_suggest(request.getParameter("pisuggest"));
		
		String adminId = adminLoginInfo.getAi_id();
		
		AdminAddPackageInsertSvc adminAddPackageInsertSvc = new AdminAddPackageInsertSvc();
		int result = adminAddPackageInsertSvc.insertPackage(pi);	// 인서트 
		int result2 = adminAddPackageInsertSvc.excuteProcedure(pi, adminId);	// 프로시저 
		System.out.println("프로시저 result2 : " + result2);
		
		if (result == 1 ) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('" + picode + " 패키지 추가에 성공했습니다.');");
			out.println("location.replace('/greenTourSite/admin_package_list');");		  
			out.println("</script>");
			out.close();			
			
		}else if(result == 0){
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('" + picode + " 패키지 추가에 실패했습니다.');");
			out.println("location.replace('/greenTourSite/admin_package_list');");		
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

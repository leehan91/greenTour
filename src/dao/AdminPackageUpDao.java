package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminPackageUpDao {
	private static AdminPackageUpDao adminPackageUpDao;
	private Connection conn;
	private AdminPackageUpDao() {}
	
	public static AdminPackageUpDao getInstance() {
		
		if (adminPackageUpDao == null)	adminPackageUpDao = new AdminPackageUpDao();
		
		return adminPackageUpDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public PackageInfo getPackageInfo(String picode) {
        Statement stmt = null;
        ResultSet rs = null;
        PackageInfo pi = null;
        ArrayList<PackageTour> tourList = new ArrayList<PackageTour>();
        
        
        try {
           String sql = "select a.*, b.*, c.*, d.*, e.* " + 
           		"from t_package_info a, t_ctgr_city b, t_hotel_info c, t_package_notice d, t_package_tour e " + 
           		"where a.cc_id = b.cc_id and a.hi_code = c.hi_code and a.pn_idx = d.pn_idx and a.cc_id = e.cc_id and " +
           		"pi_isview = 'y' and pi_code = '" + picode + "'";
           System.out.println(sql);
           stmt = conn.createStatement();
           rs = stmt.executeQuery(sql);
           
           if (rs.next()) {
              pi = new PackageInfo();
              pi.setPi_code(picode);
              pi.setCc_id(rs.getString("a.cc_id"));
              pi.setHi_code(rs.getString("a.hi_code"));
              pi.setPn_idx(rs.getInt("a.pn_idx"));
              pi.setPi_name(rs.getString("a.pi_name"));
              pi.setPi_period(rs.getString("a.pi_period"));
              pi.setPi_keyword(rs.getString("a.pi_keyword"));
              pi.setPi_img1(rs.getString("a.pi_img1"));
              pi.setPi_img2(rs.getString("a.pi_img2"));
              pi.setPi_img3(rs.getString("a.pi_img3"));
              pi.setPi_img4(rs.getString("a.pi_img4"));
              pi.setPi_img5(rs.getString("a.pi_img5"));
              pi.setPi_desc(rs.getString("a.pi_desc"));
              pi.setPi_special(rs.getString("a.pi_special"));
              pi.setPi_sale(rs.getInt("a.pi_sale"));
              pi.setPi_stock(rs.getInt("a.pi_stock"));
              pi.setPi_tour(rs.getString("a.pi_tour"));
              pi.setPi_food(rs.getString("a.pi_food"));
              pi.setPi_price(rs.getInt("a.pi_price"));
              pi.setPi_adult(rs.getInt("a.pi_adult"));
              pi.setPi_child(rs.getInt("a.pi_child"));
              pi.setPi_country(rs.getString("a.pi_country"));
              pi.setCc_name(rs.getString("b.cc_name"));
              pi.setHi_name(rs.getString("c.hi_name"));
              pi.setPn_insur(rs.getString("d.pn_insur"));
              pi.setPn_guide(rs.getString("d.pn_guide"));
              pi.setPn_include(rs.getString("d.pn_include"));
              pi.setPn_declude(rs.getString("d.pn_declude"));
              pi.setPn_warning(rs.getString("d.pn_warning"));
              pi.setPn_safe(rs.getString("d.pn_safe"));
              
              String[] arrtour = pi.getPi_tour().split("/");
              String where = "";
              for(int i = 0; i<arrtour.length; i++) {
            	  where += " or pt_code = '" + arrtour[i] + "' ";
              }
              where = where.substring(4);
           	  sql = "select * from t_package_tour where " + where;
           	  System.out.println(sql);
           	  rs = stmt.executeQuery(sql);
           	  PackageTour pt = null;
           	  int tmp = 0;
        	  while(rs.next()) {
        		  tmp++;
        		  System.out.println("tmp : " + tmp);
        		  pt = new PackageTour();
        		  pt.setPt_code(rs.getString("pt_code"));
        		  System.out.println(rs.getString("pt_code"));
        		  pt.setCc_id(rs.getString("cc_id"));
        		  pt.setPt_name(rs.getString("pt_name"));
        		  pt.setPt_addr(rs.getString("pt_addr"));
        		  pt.setPt_page(rs.getString("pt_page"));
        		  pt.setPt_summary(rs.getString("pt_summary"));
        		  pt.setPt_desc(rs.getString("pt_desc"));
        		  pt.setPt_image(rs.getString("pt_image"));
        		  pt.setPt_price(rs.getInt("pt_price"));
        		  tourList.add(pt); 
        	  }
              pi.setTourList(tourList);
           }   
           
        } catch (Exception e) {
           System.out.println("AdminPackageUpDao 클래스의 getPackageInfo() 메소드 오류");
        } finally {
           close(rs);       close(stmt);  
        }
        
        return pi;
     }
}

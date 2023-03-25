package dao;

import static db.JdbcUtil.close;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import vo.*;

public class PackageProcDao {
	private static PackageProcDao packageProcDao;
	private Connection conn;
	private PackageProcDao() {}
	public static PackageProcDao getInstance() {
		if (packageProcDao == null)	packageProcDao = new PackageProcDao();
		return packageProcDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public ArrayList<PackageInfo> getPackageSuggest(String ccid) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<PackageInfo> piList = new ArrayList<PackageInfo>();
		PackageInfo pi = null;
		try {
			String sql = "select a.cc_id, pi_code, pi_name, pi_img1, pi_period, format(pi_adult, 0) pi_adult "
					+ "from t_ctgr_city a join t_package_info b on a.cc_id = b.cc_id "
					+ "where pi_isview = 'y' and a.cc_id like '" + ccid + "%' and pi_suggest = 'n' order by rand() limit 4";

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				pi = new PackageInfo();
				pi.setCc_id(rs.getString("cc_id"));
				pi.setPi_code(rs.getString("pi_code"));
				pi.setPi_name(rs.getString("pi_name"));
				pi.setPi_img1(rs.getString("pi_img1"));
				pi.setPi_period(rs.getString("pi_period"));
				pi.setPi_adult(rs.getString("pi_adult"));
				piList.add(pi);
			}
			
		} catch (Exception e) {
			System.out.println("PackageProcDao 클래스의 getPackageSuggest() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return piList;
	}
	
	public JsonArray getPackageMainList(String ccid) {
		Statement stmt = null;
		ResultSet rs = null;
		JsonArray packageList = new JsonArray();
		
		try {
			String sql = "select a.cc_id, pi_code, pi_name, pi_img1, FORMAT(pi_adult, 0) as pi_adult from t_ctgr_city a join t_package_info b on a.cc_id = b.cc_id where a.cc_id like '" + ccid + "%'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				JsonObject piDataObject = new JsonObject();
				
				piDataObject.addProperty("cc_id", rs.getString("cc_id"));
				piDataObject.addProperty("pi_code", rs.getString("pi_code"));
				piDataObject.addProperty("pi_name", rs.getString("pi_name"));
				piDataObject.addProperty("pi_img1", rs.getString("pi_img1"));
				piDataObject.addProperty("pi_adult", rs.getString("pi_adult"));
				packageList.add(piDataObject);
				// System.out.println(piDataObject);
			}
			
		} catch (Exception e) {
			System.out.println("PackageProcDao Ŭ������ getPackageMainList() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return packageList;
	}
	
	public ArrayList<PackageDate> getPackageListCount(String picode) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<PackageDate> pdList = new ArrayList<PackageDate>();
		PackageDate pd = null;
		
		try {
			String sql = "select a.pi_code, a.pi_name, a.pi_img1, format(a.pi_adult, 0) pi_adult, "
					+ "date_format(b.fi_departure, '%Y-%m-%d') as fi_departure " + 
					"from t_package_info a, t_flight_info b " + 
					"where a.cc_id = b.cc_id and a.pi_code = '" + picode + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				pd = new PackageDate();		
				pd.setPi_code(rs.getString("pi_code"));
				pd.setPi_name(rs.getString("pi_name"));
				pd.setPi_img1(rs.getString("pi_img1"));
				pd.setPi_adult(rs.getString("pi_adult"));
				pd.setFi_departure(rs.getString("fi_departure"));
				pdList.add(pd);
			}
			
		} catch (Exception e) {
			System.out.println("PackageProcDao 클래스의 getPackageListCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return pdList;
	} 
	
	public JsonArray getPackageDateList(String picode, String fiDeparture) {
		Statement stmt = null;
		ResultSet rs = null;
		JsonArray packageList = new JsonArray();
		
		try {
			String sql = "select a.pi_code, b.fi_entry, b.fi_departure, b.fi_cityleave, c.fr_img, c.fr_name, d.pi_period, "
					+ "d.pi_name, FORMAT(d.pi_price, 0) as pi_price, d.pi_stock, d.pi_sale "
					+ " from t_package_date a "
					+ " join t_flight_info b on a.fi_code = b.fi_code "
					+ " join t_flight_realprice c on b.cc_id = c.cc_id "
					+ " join t_package_info d on a.pi_code = d.pi_code "
					+ " where c.fr_grade = 'a' "
					+ " and a.pi_code = '"+picode+"'"
					+ " and date_format(b.fi_departure, '%Y-%m-%d') = '"+fiDeparture+"'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				JsonObject piDataObject = new JsonObject();
				
				piDataObject.addProperty("pi_code", rs.getString("pi_code"));
				piDataObject.addProperty("fi_departure", rs.getString("fi_departure"));
				piDataObject.addProperty("fi_cityleave", rs.getString("fi_cityleave"));
				piDataObject.addProperty("fr_name", rs.getString("fr_name"));
				piDataObject.addProperty("pi_period", rs.getString("pi_period"));
				piDataObject.addProperty("pi_name", rs.getString("pi_name"));
				piDataObject.addProperty("pi_price", rs.getString("pi_price"));
				piDataObject.addProperty("pi_stock", rs.getString("pi_stock"));
				piDataObject.addProperty("pi_sale", rs.getString("pi_sale"));
				piDataObject.addProperty("fi_entry", rs.getString("fi_entry"));
				piDataObject.addProperty("fr_img", rs.getString("fr_img"));
				
				packageList.add(piDataObject);
				// System.out.println(piDataObject);
			}
			
		} catch (Exception e) {
			System.out.println("PackageProcDao Ŭ������ getPackageDateList() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return packageList;
	}
	
	public PackageInfo getDetailInfo(String picode) {
        Statement stmt = null;
        ResultSet rs = null;
        PackageInfo pi = null;
        ArrayList<PackageTour> tourList = new ArrayList<PackageTour>();
        
        
        try {
           String sql = "select a.*, b.cc_name, c.*, d.*, e.* " + 
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
              pi.setPi_adult(rs.getString("a.pi_adult"));
              pi.setPi_child(rs.getInt("a.pi_child"));
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
           System.out.println("PackageProcDao Ŭ������ getDetailInfo() �޼ҵ� ����");
        } finally {
           close(rs);       close(stmt);  
        }
        
        return pi;
     }
	
	public FlightInfo getFlightInfo(String picode, String fideparture, String fientry, String frname) {
		
		Statement stmt = null;
		ResultSet rs = null;
		FlightInfo fi = null;
		
		try {
			String sql = "select distinct a.*, c.fr_name from t_flight_info a, t_package_info b, t_flight_realprice c " +
						" where a.cc_id = b.cc_id and a.cc_id = c.cc_id " + 
						" and a.fi_departure = '"+ fideparture +"' " + 
						" and a.fi_entry = '"+ fientry +"' and b.pi_code = '"+ picode +"' and c.fr_name = '"+ frname +"'";
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				fi = new FlightInfo();
				fi.setFi_departure(rs.getString("fi_departure"));
				System.out.println(rs.getString("fi_departure"));
				fi.setFi_entry(rs.getString("fi_entry"));
				fi.setFr_name(rs.getString("fr_name"));
				fi.setFi_cityarrive(rs.getString("fi_cityarrive"));
				fi.setFi_cityleave(rs.getString("fi_cityleave"));
			}
			
		} catch (Exception e) {
			
	        System.out.println("PackageProcDao Ŭ������ getFlightInfo() �޼ҵ� ����");
	    } finally {
	        close(rs);       close(stmt);  
	    }
		
		return fi;
	}
}

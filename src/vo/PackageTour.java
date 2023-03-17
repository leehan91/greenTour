package vo;

public class PackageTour {
   // 패키지 관광 상품
   private String pt_code, cc_id, pt_name, pt_addr, pt_page, pt_summary, pt_desc, pt_image, pt_date, pt_isdel;
   private int pt_price;
   
   
   
   
   public String getPt_date() {
	return pt_date;
   	}
	public void setPt_date(String pt_date) {
		this.pt_date = pt_date;
	}
	public String getPt_isdel() {
		return pt_isdel;
	}
	public void setPt_isdel(String pt_isdel) {
		this.pt_isdel = pt_isdel;
	}
	public String getPt_code() {
      return pt_code;
   }
   public void setPt_code(String pt_code) {
      this.pt_code = pt_code;
   }
   public String getCc_id() {
      return cc_id;
   }
   public void setCc_id(String cc_id) {
      this.cc_id = cc_id;
   }
   public String getPt_name() {
      return pt_name;
   }
   public void setPt_name(String pt_name) {
      this.pt_name = pt_name;
   }
   public String getPt_addr() {
      return pt_addr;
   }
   public void setPt_addr(String pt_addr) {
      this.pt_addr = pt_addr;
   }
   public String getPt_page() {
      return pt_page;
   }
   public void setPt_page(String pt_page) {
      this.pt_page = pt_page;
   }
   public String getPt_summary() {
      return pt_summary;
   }
   public void setPt_summary(String pt_summary) {
      this.pt_summary = pt_summary;
   }
   public String getPt_desc() {
      return pt_desc;
   }
   public void setPt_desc(String pt_desc) {
      this.pt_desc = pt_desc;
   }
   public String getPt_image() {
      return pt_image;
   }
   public void setPt_image(String pt_image) {
      this.pt_image = pt_image;
   }
   public int getPt_price() {
      return pt_price;
   }
   public void setPt_price(int pt_price) {
      this.pt_price = pt_price;
   }
}
package vo;

import java.util.*;

public class PackageInfo {
	String pi_code, cc_id, hi_code, pi_name, pi_period, pi_keyword, pi_img1, pi_img2, pi_img3, pi_img4, pi_img5, pi_desc, pi_special;
	String pi_tour, pi_food, pi_isview, pi_date, pi_last, pi_suggest, pi_country, fi_code, fi_departure, ai_id, pi_adult;
	int pn_idx, pi_dc, pi_stock, pi_sale, pi_read, pi_review, pi_price, pi_child;
	float pi_score;
	String cc_name, pn_insur, pn_guide, pn_include, pn_declude, pn_warning, pn_safe, hi_name;
	private ArrayList<PackageTour> tourList;
	

	
	
	public String getPi_country() {
		return pi_country;
	}



	public void setPi_country(String pi_country) {
		this.pi_country = pi_country;
	}



	public String getPi_code() {
		return pi_code;
	}



	public void setPi_code(String pi_code) {
		this.pi_code = pi_code;
	}



	public String getCc_id() {
		return cc_id;
	}



	public void setCc_id(String cc_id) {
		this.cc_id = cc_id;
	}



	public String getHi_code() {
		return hi_code;
	}



	public void setHi_code(String hi_code) {
		this.hi_code = hi_code;
	}



	public String getPi_name() {
		return pi_name;
	}



	public void setPi_name(String pi_name) {
		this.pi_name = pi_name;
	}



	public String getPi_period() {
		return pi_period;
	}



	public void setPi_period(String pi_period) {
		this.pi_period = pi_period;
	}



	public String getPi_keyword() {
		return pi_keyword;
	}



	public void setPi_keyword(String pi_keyword) {
		this.pi_keyword = pi_keyword;
	}



	public String getPi_img1() {
		return pi_img1;
	}



	public void setPi_img1(String pi_img1) {
		this.pi_img1 = pi_img1;
	}



	public String getPi_img2() {
		return pi_img2;
	}



	public void setPi_img2(String pi_img2) {
		this.pi_img2 = pi_img2;
	}



	public String getPi_img3() {
		return pi_img3;
	}



	public void setPi_img3(String pi_img3) {
		this.pi_img3 = pi_img3;
	}



	public String getPi_img4() {
		return pi_img4;
	}



	public void setPi_img4(String pi_img4) {
		this.pi_img4 = pi_img4;
	}



	public String getPi_img5() {
		return pi_img5;
	}



	public void setPi_img5(String pi_img5) {
		this.pi_img5 = pi_img5;
	}



	public String getPi_desc() {
		return pi_desc;
	}



	public void setPi_desc(String pi_desc) {
		this.pi_desc = pi_desc;
	}



	public String getPi_special() {
		return pi_special;
	}



	public void setPi_special(String pi_special) {
		this.pi_special = pi_special;
	}



	public String getPi_tour() {
		return pi_tour;
	}



	public void setPi_tour(String pi_tour) {
		this.pi_tour = pi_tour;
	}



	public String getPi_food() {
		return pi_food;
	}



	public void setPi_food(String pi_food) {
		this.pi_food = pi_food;
	}



	public String getPi_isview() {
		return pi_isview;
	}



	public void setPi_isview(String pi_isview) {
		this.pi_isview = pi_isview;
	}



	public String getPi_date() {
		return pi_date;
	}



	public void setPi_date(String pi_date) {
		this.pi_date = pi_date;
	}



	public String getPi_last() {
		return pi_last;
	}



	public void setPi_last(String pi_last) {
		this.pi_last = pi_last;
	}



	public String getPi_suggest() {
		return pi_suggest;
	}



	public void setPi_suggest(String pi_suggest) {
		this.pi_suggest = pi_suggest;
	}



	public int getPn_idx() {
		return pn_idx;
	}



	public void setPn_idx(int pn_idx) {
		this.pn_idx = pn_idx;
	}



	public int getPi_dc() {
		return pi_dc;
	}



	public void setPi_dc(int pi_dc) {
		this.pi_dc = pi_dc;
	}



	public int getPi_stock() {
		return pi_stock;
	}



	public void setPi_stock(int pi_stock) {
		this.pi_stock = pi_stock;
	}



	public int getPi_sale() {
		return pi_sale;
	}



	public void setPi_sale(int pi_sale) {
		this.pi_sale = pi_sale;
	}



	public int getPi_read() {
		return pi_read;
	}



	public void setPi_read(int pi_read) {
		this.pi_read = pi_read;
	}



	public int getPi_review() {
		return pi_review;
	}



	public void setPi_review(int pi_review) {
		this.pi_review = pi_review;
	}



	public int getPi_price() {
		return pi_price;
	}



	public void setPi_price(int pi_price) {
		this.pi_price = pi_price;
	}



	public String getPi_adult() {
		return pi_adult;
	}



	public void setPi_adult(String pi_adult) {
		this.pi_adult = pi_adult;
	}



	public int getPi_child() {
		return pi_child;
	}



	public void setPi_child(int pi_child) {
		this.pi_child = pi_child;
	}



	public float getPi_score() {
		return pi_score;
	}



	public void setPi_score(float pi_score) {
		this.pi_score = pi_score;
	}



	public String getCc_name() {
		return cc_name;
	}



	public void setCc_name(String cc_name) {
		this.cc_name = cc_name;
	}



	public String getPn_insur() {
		return pn_insur;
	}



	public void setPn_insur(String pn_insur) {
		this.pn_insur = pn_insur;
	}



	public String getPn_guide() {
		return pn_guide;
	}



	public void setPn_guide(String pn_guide) {
		this.pn_guide = pn_guide;
	}



	public String getPn_include() {
		return pn_include;
	}



	public void setPn_include(String pn_include) {
		this.pn_include = pn_include;
	}



	public String getPn_declude() {
		return pn_declude;
	}



	public void setPn_declude(String pn_declude) {
		this.pn_declude = pn_declude;
	}



	public String getPn_warning() {
		return pn_warning;
	}



	public void setPn_warning(String pn_warning) {
		this.pn_warning = pn_warning;
	}



	public String getHi_name() {
		return hi_name;
	}



	public void setHi_name(String hi_name) {
		this.hi_name = hi_name;
	}



	public String getPn_safe() {
		return pn_safe;
	}



	public void setPn_safe(String pn_safe) {
		this.pn_safe = pn_safe;
	}



	public ArrayList<PackageTour> getTourList() {
		return tourList;
	}



	public void setTourList(ArrayList<PackageTour> tourList) {
		this.tourList = tourList;
	}



	public String getFi_code() {
		return fi_code;
	}



	public void setFi_code(String fi_code) {
		this.fi_code = fi_code;
	}




	public String getFi_departure() {
		return fi_departure;
	}



	public void setFi_departure(String fi_departure) {
		this.fi_departure = fi_departure;
	}



	@Override
	public String toString() {
		return "PackageInfo [pi_code=" + pi_code + ", cc_id=" + cc_id + ", hi_code=" + hi_code + ", pi_name=" + pi_name
				+ ", pi_keyword=" + pi_keyword + ", pi_img1=" + pi_img1 + ", pi_img2=" + pi_img2 + ", pi_img3="
				+ pi_img3 + ", pi_img4=" + pi_img4 + ", pi_img5=" + pi_img5 + ", pi_desc=" + pi_desc + ", pi_special="
				+ pi_special + ", pi_tour=" + pi_tour + ", pi_food=" + pi_food + ", pi_isview=" + pi_isview
				+ ", pi_date=" + pi_date + ", pi_last=" + pi_last + ", pi_suggest=" + pi_suggest + ", pn_idx=" + pn_idx
				+ ", pi_dc=" + pi_dc + ", pi_stock=" + pi_stock + ", pi_sale=" + pi_sale + ", pi_read=" + pi_read
				+ ", pi_review=" + pi_review + ", pi_price=" + pi_price + ", pi_adult=" + pi_adult + ", pi_child="
				+ pi_child + ", pi_score=" + pi_score + "]";
	}
	
	
}

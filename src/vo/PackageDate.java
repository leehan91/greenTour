package vo;

public class PackageDate extends PackageInfo {
	private int pd_idx;
	private String pi_code, fi_code, fi_entry;
	public int getPd_idx() {
		return pd_idx;
	}
	public void setPd_idx(int pd_idx) {
		this.pd_idx = pd_idx;
	}
	public String getPi_code() {
		return pi_code;
	}
	public void setPi_code(String pi_code) {
		this.pi_code = pi_code;
	}
	public String getFi_code() {
		return fi_code;
	}
	public void setFi_code(String fi_code) {
		this.fi_code = fi_code;
	}
	public String getFi_entry() {
		return fi_entry;
	}
	public void setFi_entry(String fi_entry) {
		this.fi_entry = fi_entry;
	}
	
}

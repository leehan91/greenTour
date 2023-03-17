package vo;

import java.util.*;

public class FlightInfo {
	String fi_code,	cc_id, fi_origin, fi_departure, fi_cityarrive, fi_cityleave, fi_entry, fr_name, cc_name;
	int fi_passenger;
	ArrayList<FlightRealPrice> flightRealPriceList;
	
	
	
	public String getCc_name() {
		return cc_name;
	}
	public void setCc_name(String cc_name) {
		this.cc_name = cc_name;
	}
	public ArrayList<FlightRealPrice> getFlightRealPriceList() {
		return flightRealPriceList;
	}
	public void setFlightRealPriceList(ArrayList<FlightRealPrice> flightRealPriceList) {
		this.flightRealPriceList = flightRealPriceList;
	}
	public String getFi_code() {
		return fi_code;
	}
	public void setFi_code(String fi_code) {
		this.fi_code = fi_code;
	}
	public String getCc_id() {
		return cc_id;
	}
	public void setCc_id(String cc_id) {
		this.cc_id = cc_id;
	}
	public String getFi_origin() {
		return fi_origin;
	}
	public void setFi_origin(String fi_origin) {
		this.fi_origin = fi_origin;
	}
	public String getFi_departure() {
		return fi_departure;
	}
	public void setFi_departure(String fi_departure) {
		this.fi_departure = fi_departure;
	}
	public String getFi_cityarrive() {
		return fi_cityarrive;
	}
	public void setFi_cityarrive(String fi_cityarrive) {
		this.fi_cityarrive = fi_cityarrive;
	}
	public String getFi_cityleave() {
		return fi_cityleave;
	}
	public void setFi_cityleave(String fi_cityleave) {
		this.fi_cityleave = fi_cityleave;
	}
	public String getFi_entry() {
		return fi_entry;
	}
	public void setFi_entry(String fi_entry) {
		this.fi_entry = fi_entry;
	}
	public int getFi_passenger() {
		return fi_passenger;
	}
	public void setFi_passenger(int fi_passenger) {
		this.fi_passenger = fi_passenger;
	}
	public String getFr_name() {
		return fr_name;
	}
	public void setFr_name(String fr_name) {
		this.fr_name = fr_name;
	}
}

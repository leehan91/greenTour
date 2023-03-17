package vo;

import java.util.*;
public class StatInfo {
	// 통계 정보(통계에서 보여줄 정보)
	// 나라, 
	// 총 판매액, 패키지 판매량, 패키지 판매액, 나만의패키지 판매량, 나만의패키지 판매액, 회원수, 정상회원 수, 휴면회원수, 탈퇴회원수, 
	// 총 문의글 수, 답변 미완료 문의, 답변 완료 문의
	private String si_paDate, si_mpDate, si_paRate, si_mpRate, si_hkg, si_jpn, si_phl, si_sgp, si_tha, si_twn, si_vnm; 
	private int si_totalAmount, si_paAmount, si_mpAmount, si_member, si_memberA, si_memberB, si_memberD;
	private int si_TotalReq, si_NoReq, si_YesReq, si_ccPaAmount, si_ccMpAmount, si_pNum, si_mNum;
	public String getSi_paDate() {
		return si_paDate;
	}
	public void setSi_paDate(String si_paDate) {
		this.si_paDate = si_paDate;
	}
	public String getSi_mpDate() {
		return si_mpDate;
	}
	public void setSi_mpDate(String si_mpDate) {
		this.si_mpDate = si_mpDate;
	}
	public String getSi_paRate() {
		return si_paRate;
	}
	public void setSi_paRate(String si_paRate) {
		this.si_paRate = si_paRate;
	}
	public String getSi_mpRate() {
		return si_mpRate;
	}
	public void setSi_mpRate(String si_mpRate) {
		this.si_mpRate = si_mpRate;
	}
	public int getSi_totalAmount() {
		return si_totalAmount;
	}
	public void setSi_totalAmount(int si_totalAmount) {
		this.si_totalAmount = si_totalAmount;
	}
	public int getSi_paAmount() {
		return si_paAmount;
	}
	public void setSi_paAmount(int si_paAmount) {
		this.si_paAmount = si_paAmount;
	}
	public int getSi_mpAmount() {
		return si_mpAmount;
	}
	public void setSi_mpAmount(int si_mpAmount) {
		this.si_mpAmount = si_mpAmount;
	}
	public int getSi_member() {
		return si_member;
	}
	public void setSi_member(int si_member) {
		this.si_member = si_member;
	}
	public int getSi_memberA() {
		return si_memberA;
	}
	public void setSi_memberA(int si_memberA) {
		this.si_memberA = si_memberA;
	}
	public int getSi_memberB() {
		return si_memberB;
	}
	public void setSi_memberB(int si_memberB) {
		this.si_memberB = si_memberB;
	}
	public int getSi_memberD() {
		return si_memberD;
	}
	public void setSi_memberD(int si_memberD) {
		this.si_memberD = si_memberD;
	}
	public int getSi_TotalReq() {
		return si_TotalReq;
	}
	public void setSi_TotalReq(int si_TotalReq) {
		this.si_TotalReq = si_TotalReq;
	}
	public int getSi_NoReq() {
		return si_NoReq;
	}
	public void setSi_NoReq(int si_NoReq) {
		this.si_NoReq = si_NoReq;
	}
	public int getSi_YesReq() {
		return si_YesReq;
	}
	public void setSi_YesReq(int si_YesReq) {
		this.si_YesReq = si_YesReq;
	}
	public int getSi_ccPaAmount() {
		return si_ccPaAmount;
	}
	public void setSi_ccPaAmount(int si_ccPaAmount) {
		this.si_ccPaAmount = si_ccPaAmount;
	}
	public int getSi_ccMpAmount() {
		return si_ccMpAmount;
	}
	public void setSi_ccMpAmount(int si_ccMpAmount) {
		this.si_ccMpAmount = si_ccMpAmount;
	}
	public int getSi_pNum() {
		return si_pNum;
	}
	public void setSi_pNum(int si_pNum) {
		this.si_pNum = si_pNum;
	}
	public int getSi_mNum() {
		return si_mNum;
	}
	public void setSi_mNum(int si_mNum) {
		this.si_mNum = si_mNum;
	}
	public String getSi_hkg() {
		return si_hkg;
	}
	public void setSi_hkg(String si_hkg) {
		this.si_hkg = si_hkg;
	}
	public String getSi_jpn() {
		return si_jpn;
	}
	public void setSi_jpn(String si_jpn) {
		this.si_jpn = si_jpn;
	}
	public String getSi_phl() {
		return si_phl;
	}
	public void setSi_phl(String si_phl) {
		this.si_phl = si_phl;
	}
	public String getSi_sgp() {
		return si_sgp;
	}
	public void setSi_sgp(String si_sgp) {
		this.si_sgp = si_sgp;
	}
	public String getSi_tha() {
		return si_tha;
	}
	public void setSi_tha(String si_tha) {
		this.si_tha = si_tha;
	}
	public String getSi_twn() {
		return si_twn;
	}
	public void setSi_twn(String si_twn) {
		this.si_twn = si_twn;
	}
	public String getSi_vnm() {
		return si_vnm;
	}
	public void setSi_vnm(String si_vnm) {
		this.si_vnm = si_vnm;
	}
	
	
}

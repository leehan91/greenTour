package vo;


// ���� ������ �޷� ��¿� �ʿ��� �������� �����ϴ� Ŭ����
public class CalendarInfo {
	private int cYear, cMonth, cDay, sYear, sMonth, sDay, lastDay;
			// ���� ����, ���� ��, ���� ��, �˻� ����, �˻� ��, �˻� ��

	public int getcYear() {
		return cYear;
	}

	public void setcYear(int cYear) {
		this.cYear = cYear;
	}

	public int getcMonth() {
		return cMonth;
	}

	public void setcMonth(int cMonth) {
		this.cMonth = cMonth;
	}

	public int getcDay() {
		return cDay;
	}

	public void setcDay(int cDay) {
		this.cDay = cDay;
	}

	public int getsYear() {
		return sYear;
	}

	public void setsYear(int sYear) {
		this.sYear = sYear;
	}

	public int getsMonth() {
		return sMonth;
	}

	public void setsMonth(int sMonth) {
		this.sMonth = sMonth;
	}

	public int getsDay() {
		return sDay;
	}

	public void setsDay(int sDay) {
		this.sDay = sDay;
	}
	
	public int getLastDay() {
		return lastDay;
	}

	public void setLastDay(int lastDay) {
		this.lastDay = lastDay;
	}
	
}

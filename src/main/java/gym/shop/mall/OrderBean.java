package gym.shop.mall;

public class OrderBean {
	private int ono; 		//주문번호
	private int cno; 		//카트번호
	private String pimage; 	//상품이미지
	private String pname; 	// 상품이름
	private String ouserid; 	//고객 아이디
	private String odate; 	//주문일자
	private String ousername; 	//수령자
	private String ophone1; 	//수령자 연락처1
	private String ophone2; 	//수령자 연락처2
	private String ophone3; 	//수령자 연락처3
	private String oemail; 	//수령자 이메일
	private String opostaddr; //우편번호
	private String oroadaddr; //도로명주소
	private String ojibunaddr; //지번주소
	private String odetailaddr; //상세주소
	private String oexaddr; //참고항목
	private String orequests; //배송 요청사항
	private int oqty;		//주문 수량
	private String poption; //상품 옵션
	private String payment; //결제수단
	private int totalreserves; //총 적립금
	private int amount;		//결제 금액
	//orderseq
	
	
	public int getOno() {
		return ono;
	}
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public void setOno(int ono) {
		this.ono = ono;
	}
	public String getPimage() {
		return pimage;
	}
	public void setPimage(String pimage) {
		this.pimage = pimage;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getOuserid() {
		return ouserid;
	}
	public void setOuserid(String ouserid) {
		this.ouserid = ouserid;
	}
	public String getOdate() {
		return odate;
	}
	public void setOdate(String odate) {
		this.odate = odate;
	}
	public String getOusername() {
		return ousername;
	}
	public void setOusername(String ousername) {
		this.ousername = ousername;
	}
	public String getOphone1() {
		return ophone1;
	}
	public void setOphone1(String ophone1) {
		this.ophone1 = ophone1;
	}
	public String getOphone2() {
		return ophone2;
	}
	public void setOphone2(String ophone2) {
		this.ophone2 = ophone2;
	}
	public String getOphone3() {
		return ophone3;
	}
	public void setOphone3(String ophone3) {
		this.ophone3 = ophone3;
	}
	public String getOemail() {
		return oemail;
	}
	public void setOemail(String oemail) {
		this.oemail = oemail;
	}
	public String getOpostaddr() {
		return opostaddr;
	}
	public void setOpostaddr(String opostaddr) {
		this.opostaddr = opostaddr;
	}
	public String getOroadaddr() {
		return oroadaddr;
	}
	public void setOroadaddr(String oroadaddr) {
		this.oroadaddr = oroadaddr;
	}
	public String getOjibunaddr() {
		return ojibunaddr;
	}
	public void setOjibunaddr(String ojibunaddr) {
		this.ojibunaddr = ojibunaddr;
	}
	public String getOdetailaddr() {
		return odetailaddr;
	}
	public void setOdetailaddr(String odetailaddr) {
		this.odetailaddr = odetailaddr;
	}
	public String getOexaddr() {
		return oexaddr;
	}
	public void setOexaddr(String oexaddr) {
		this.oexaddr = oexaddr;
	}
	public String getOrequests() {
		return orequests;
	}
	public void setOrequests(String orequests) {
		this.orequests = orequests;
	}
	public int getOqty() {
		return oqty;
	}
	public void setOqty(int oqty) {
		this.oqty = oqty;
	}
	public String getPoption() {
		return poption;
	}
	public void setPoption(String poption) {
		this.poption = poption;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public int getTotalreserves() {
		return totalreserves;
	}
	public void setTotalreserves(int totalreserves) {
		this.totalreserves = totalreserves;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	
	

}

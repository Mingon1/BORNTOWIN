package gym.shop.mall;

public class CartBean {
	private int cno; 		//장바구니번호
	private String userid; 	//유저id
	private int pno; 		//상품번호
	private String pimage; 	//상품 이미지
	private String pname;  	//상품이름
	private String poption; //상품옵션
	private int cqty; 		//담은 수량
	private int creserves; 	//적립금
	private int delivery; 	//배송비
	private int price; 		//총 상품 금액
	
	
	public int getCreserves() {
		return creserves;
	}
	public void setCreserves(int creserves) {
		this.creserves = creserves;
	}
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
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
	public String getPoption() {
		return poption;
	}
	public void setPoption(String poption) {
		this.poption = poption;
	}
	public int getCqty() {
		return cqty;
	}
	public void setCqty(int cqty) {
		this.cqty = cqty;
	}
	public int getDelivery() {
		return delivery;
	}
	public void setDelivery(int delivery) {
		this.delivery = delivery;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
	

}

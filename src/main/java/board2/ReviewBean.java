package board2;

public class ReviewBean {

	private int rno;			//후기 번호
	private int pno;			//상품 번호
	private String rpasswd;		//비밀번호
	private String rtitle; 		//리뷰 제목
	private String rimage; 		//리뷰 이미지
	private String ruserid; 	//사용자 아이디
	private String rwriter; 	//작성자
	private String rcontent; 	//내용
	private String regdate; 	//작성일
	private String rcomment; 	//후기 댓글
	private int readcount;
	private int ref;
	private int re_step;
	private int re_level;
	
	
	
	
	public String getRpasswd() {
		return rpasswd;
	}
	public void setRpasswd(String rpasswd) {
		this.rpasswd = rpasswd;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public int getRe_level() {
		return re_level;
	}
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	public String getRtitle() {
		return rtitle;
	}
	public void setRtitle(String rtitle) {
		this.rtitle = rtitle;
	}
	public String getRimage() {
		return rimage;
	}
	public void setRimage(String rimage) {
		this.rimage = rimage;
	}
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getRuserid() {
		return ruserid;
	}
	public void setRuserid(String ruserid) {
		this.ruserid = ruserid;
	}
	public String getRwriter() {
		return rwriter;
	}
	public void setRwriter(String rwriter) {
		this.rwriter = rwriter;
	}
	public String getRcontent() {
		return rcontent;
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getRcomment() {
		return rcomment;
	}
	public void setRcomment(String rcomment) {
		this.rcomment = rcomment;
	}
	
	
}

package gym.admin;

public class NoticeBean {
	private int no;			//공지 번호
	private String ntitle;	//공지 제목
	private String nimage;	//공지 이미지
	private String nuserid;	//사용자 아이디
	private String ncontent;//내용
	private String regdate;	//작성일
	private int readcount;	// 조회수
	
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getNtitle() {
		return ntitle;
	}
	public void setNtitle(String ntitle) {
		this.ntitle = ntitle;
	}
	public String getNimage() {
		return nimage;
	}
	public void setNimage(String nimage) {
		this.nimage = nimage;
	}
	public String getNuserid() {
		return nuserid;
	}
	public void setNuserid(String nuserid) {
		this.nuserid = nuserid;
	}
	public String getNcontent() {
		return ncontent;
	}
	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	
	
	
}

package gym.admin;

public class ReviewCommentsBean {
	private int rvno; 			//--댓글 번호
	private int rno;			//--게시글 번호
	private String cocontent; 	//--내용
	private String coreg_date;  //--작성일
	
	
	public int getRvno() {
		return rvno;
	}
	public void setRvno(int rvno) {
		this.rvno = rvno;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getCocontent() {
		return cocontent;
	}
	public void setCocontent(String cocontent) {
		this.cocontent = cocontent;
	}
	public String getCoreg_date() {
		return coreg_date;
	}
	public void setCoreg_date(String coreg_date) {
		this.coreg_date = coreg_date;
	}
	
	
}

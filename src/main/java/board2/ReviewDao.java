package board2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;

public class ReviewDao {
	Connection conn = null;
	PreparedStatement ps =null;
	ResultSet rs = null;
	
	private static ReviewDao instance;
	public static ReviewDao getInstance() {
		if(instance==null) {
			instance = new ReviewDao();
		}
		return instance;
	}
	
	private ReviewDao() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
			conn = ds.getConnection();
		}catch (NamingException e) {
			e.printStackTrace();
		}catch (SQLException e) {
			e.printStackTrace();
		}
	}//ReviewDao
	
	public int insertReview(MultipartRequest mr) {
		int cnt = -1;
		String sql="insert into review(rno, pno, rpasswd ,rtitle, rimage, ruserid, rwriter, rcontent, regdate, readcount, ref, re_step, re_level) values(review_seq.nextval,?,?,?,?,?,?,?,sysdate,0,review_seq.currval,0,0)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,mr.getParameter("pno"));
			ps.setString(2,mr.getParameter("rpasswd"));
			ps.setString(3,mr.getParameter("rtitle"));
			ps.setString(4,mr.getOriginalFileName("rimage"));
			ps.setString(5,mr.getParameter("ruserid"));
			ps.setString(6,mr.getParameter("rwriter"));
			ps.setString(7,mr.getParameter("rcontent"));
			
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if (rs!=null) {
					rs.close();
				}
				if (ps!=null) {
					ps.close();
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		return cnt;
	}
	
	public int getArticleCount() {
		int cnt = 0;
		String sql = "select count(*) as cnt from review";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("cnt"); 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if (rs!=null) {
					rs.close();
				}
				if (ps!=null) {
					ps.close();
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		return cnt;
	}
	
	public ArrayList<ReviewBean> getArticles(int start, int end){
		ArrayList<ReviewBean> lists = new ArrayList<ReviewBean>();
		String sql = "select rno, pno, rpasswd ,rtitle, rimage, ruserid, rwriter, rcontent, regdate, rcomment ,readcount, ref, re_step, re_level ";
		sql += "from (select rownum as rank, rno, pno, rpasswd ,rtitle, rimage, ruserid, rwriter, rcontent, regdate, rcomment,readcount, ref, re_step, re_level ";
		sql += "from (select rno, pno, rpasswd ,rtitle, rimage, ruserid, rwriter, rcontent, regdate, rcomment,readcount, ref, re_step, re_level ";
		sql += "from review ";
		sql += "order by ref desc, re_step asc)) "; 
		sql += "where rank between ? and ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			while(rs.next()) {
				ReviewBean rb = new ReviewBean();
				rb.setRno(rs.getInt("rno"));
				rb.setPno(rs.getInt("pno"));
				rb.setRpasswd(rs.getString("rpasswd"));
				rb.setRtitle(rs.getString("rtitle"));
				rb.setRimage(rs.getString("rimage"));
				rb.setRuserid(rs.getString("ruserid"));
				rb.setRwriter(rs.getString("rwriter"));
				rb.setRcontent(rs.getString("rcontent"));
				rb.setRegdate(rs.getString("regdate"));
				rb.setRcomment(rs.getString("rcomment"));
				rb.setReadcount(rs.getInt("readcount"));
				rb.setRef(rs.getInt("ref"));
				rb.setRe_step(rs.getInt("re_step"));
				rb.setRe_level(rs.getInt("re_level"));
				
				lists.add(rb);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if (rs!=null) {
					rs.close();
				}
				if (ps!=null) {
					ps.close();
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		return lists;
		
	}
	
	public ReviewBean getArticle(String rno) {
		ReviewBean rb = null;
		String sql = "select * from review where rno=?";
		try {
			String sql2 = "update review set readcount = readcount+1 where rno=?";
			ps = conn.prepareStatement(sql2);
			ps.setString(1, rno);
			ps.executeUpdate();
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, rno);
			rs = ps.executeQuery();
			if(rs.next()) {
				rb= new ReviewBean();

				rb.setRno(rs.getInt("rno"));
				rb.setPno(rs.getInt("pno"));
				rb.setRpasswd(rs.getString("rpasswd"));
				rb.setRtitle(rs.getString("rtitle"));
				rb.setRimage(rs.getString("rimage"));
				rb.setRuserid(rs.getString("ruserid"));
				rb.setRwriter(rs.getString("rwriter"));
				rb.setRcontent(rs.getString("rcontent"));
				rb.setRegdate(rs.getString("regdate"));
				rb.setRcomment(rs.getString("rcomment"));
				rb.setReadcount(rs.getInt("readcount"));
				rb.setRef(rs.getInt("ref"));
				rb.setRe_step(rs.getInt("re_step"));
				rb.setRe_level(rs.getInt("re_level"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
				if(rs != null)
					rs.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rb;
	}
	
	public int deleteReview(String rno, String rpasswd) {
		int cnt=-1;
		String sql ="delete from review where rno=? and rpasswd=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, rno);
			ps.setString(2, rpasswd);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
				if(rs != null)
					rs.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return cnt;
	}
	
	public int updateReview(MultipartRequest mr, String img) {
		int cnt=-1;
		String sql="update review set rtitle=?, rimage=?, rcontent=? where rno=? and rpasswd=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,mr.getParameter("rtitle"));
			ps.setString(2,img);
			ps.setString(3,mr.getParameter("content"));
			ps.setString(4,mr.getParameter("rno"));
			ps.setString(5,mr.getParameter("rpasswd"));
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
				if(rs != null)
					rs.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return cnt;
		
	}
	
	public ArrayList<ReviewBean> getArticlesByPno(String pno){
		ArrayList<ReviewBean> lists = new ArrayList<ReviewBean>();
		String sql="select * from review where pno=?";
		try {
			ps=conn.prepareStatement(sql);
			//System.out.println("리뷰다오pno:"+pno);
			ps.setString(1, pno);
			rs = ps.executeQuery();
			while(rs.next()) {
				ReviewBean rb = new ReviewBean();
				rb.setRno(rs.getInt("rno"));
				rb.setPno(rs.getInt("pno"));
				rb.setRpasswd(rs.getString("rpasswd"));
				rb.setRtitle(rs.getString("rtitle"));
				rb.setRimage(rs.getString("rimage"));
				rb.setRuserid(rs.getString("ruserid"));
				rb.setRwriter(rs.getString("rwriter"));
				rb.setRcontent(rs.getString("rcontent"));
				rb.setRegdate(rs.getString("regdate"));
				rb.setRcomment(rs.getString("rcomment"));
				rb.setReadcount(rs.getInt("readcount"));
				rb.setRef(rs.getInt("ref"));
				rb.setRe_step(rs.getInt("re_step"));
				rb.setRe_level(rs.getInt("re_level"));
				
				lists.add(rb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
				if(rs != null)
					rs.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return lists;
		
	}
	
	public ArrayList<ReviewBean> getArticlesByRuserid(String ruserid){
		ArrayList<ReviewBean> lists = new ArrayList<ReviewBean>();
		String sql="select * from review where ruserid like ?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, ruserid+"%");
			rs = ps.executeQuery();
			while(rs.next()) {
				ReviewBean rb = new ReviewBean();
				rb.setRno(rs.getInt("rno"));
				rb.setPno(rs.getInt("pno"));
				rb.setRpasswd(rs.getString("rpasswd"));
				rb.setRtitle(rs.getString("rtitle"));
				rb.setRimage(rs.getString("rimage"));
				rb.setRuserid(rs.getString("ruserid"));
				rb.setRwriter(rs.getString("rwriter"));
				rb.setRcontent(rs.getString("rcontent"));
				rb.setRegdate(rs.getString("regdate"));
				rb.setRcomment(rs.getString("rcomment"));
				rb.setReadcount(rs.getInt("readcount"));
				rb.setRef(rs.getInt("ref"));
				rb.setRe_step(rs.getInt("re_step"));
				rb.setRe_level(rs.getInt("re_level"));
				
				lists.add(rb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
				if(rs != null)
					rs.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return lists;
		
	}
	
	public int deleteMyReview(String rno, String rpasswd) {
		int cnt = -1;
		String sql= "delete from review where rno=? and rpasswd=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, rno);
			ps.setString(2, rpasswd);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
				if(rs != null)
					rs.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public int updateMyReview(MultipartRequest mr, String img) {
		int cnt = -1;
		String sql ="update review set rimage =? , ruserid=?, rwriter=?, rtitle=?, rcontent=? where rno=? and rpasswd=? ";
		try {
			ps =conn.prepareStatement(sql);
			ps.setString(1, img);
			ps.setString(2, mr.getParameter("ruserid"));
			ps.setString(3, mr.getParameter("rwriter"));
			ps.setString(4, mr.getParameter("rtitle"));
			ps.setString(5, mr.getParameter("rcontent"));
			ps.setString(6, mr.getParameter("rno"));
			ps.setString(7, mr.getParameter("rpasswd"));
			
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
				if(rs != null)
					rs.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
		
	}

	
	
}

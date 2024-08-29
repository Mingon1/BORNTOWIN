package gym.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class ReviewCommentsDao {
	
	
	Connection conn = null;
	PreparedStatement ps =null;
	ResultSet rs = null;
	
	private static ReviewCommentsDao instance;
	public static ReviewCommentsDao getInstance() {
		if(instance==null) {
			instance = new ReviewCommentsDao();
		}
		return instance;
	}
	
	private ReviewCommentsDao() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
			conn = ds.getConnection();
			System.out.println("conn:" + conn);
		}catch (NamingException e) {
			e.printStackTrace();
		}catch (SQLException e) {
			e.printStackTrace();
		}
	}//ReviewCommentsDao
	
	
	
	

	
	public int insertReviewComments(String cocontent, String rno) {
		int cnt=-1;
		String sql="insert into reviewcomments values(reviewcomments_seq.nextval,?,?,sysdate)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, rno);
			ps.setString(2, cocontent);
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
	
	public ArrayList<ReviewCommentsBean> getcoList(String rno){
		ArrayList<ReviewCommentsBean> lists = new ArrayList<ReviewCommentsBean>();
		String sql ="select * from reviewcomments where rno=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, rno);
			rs = ps.executeQuery();
			while(rs.next()) {
				ReviewCommentsBean rcb = new ReviewCommentsBean();
				rcb.setRvno(rs.getInt("rvno"));
				rcb.setCocontent(rs.getString("cocontent"));
				rcb.setCoreg_date(rs.getString("coreg_date"));
				
				lists.add(rcb);
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
	
	public int deletecomments(String rvno) {
		int cnt = -1;
		String sql ="delete from reviewcomments where rvno=?";
		System.out.println(rvno);
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, rvno);
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

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

public class CommentsDao {
		Connection conn = null;
		PreparedStatement ps =null;
		ResultSet rs = null;
		
		private static CommentsDao instance;
		public static CommentsDao getInstance() {
			if(instance==null) {
				instance = new CommentsDao();
			}
			return instance;
		}
		
		private CommentsDao() {
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
		}//CommentsDao
		
		
		public int insertComments(String cowriter, String cocontent, String bno) {
			int cnt=-1;
			String sql="insert into comments values(comments_seq.nextval,?,?,?,sysdate)";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, bno);
				ps.setString(2, cowriter);
				ps.setString(3, cocontent);
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
		
		public ArrayList<CommentsBean> getcoList(String bno){
			ArrayList<CommentsBean> lists = new ArrayList<CommentsBean>();
			String sql ="select * from comments where bno=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, bno);
				rs = ps.executeQuery();
				while(rs.next()) {
					CommentsBean cb = new CommentsBean();
					cb.setCono(rs.getInt("cono"));
					cb.setCowriter(rs.getString("cowriter"));
					cb.setCocontent(rs.getString("cocontent"));
					cb.setCoreg_date(rs.getString("coreg_date"));
					
					lists.add(cb);
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
		
		public int deletecomments(String cono) {
			int cnt = -1;
			String sql ="delete from comments where cono=?";
			System.out.println(cono);
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, cono);
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

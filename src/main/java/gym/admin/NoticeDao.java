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

import com.oreilly.servlet.MultipartRequest;

import board2.ReviewBean;
import gym.user.UserDao;

public class NoticeDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	private static NoticeDao instance;
	public static NoticeDao getInstance() {
		if(instance == null) {
			instance = new NoticeDao();
		}
		return instance;
	}

	private NoticeDao() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
			conn = ds.getConnection();
			//System.out.println("conn:" + conn);
		}catch (NamingException e) {
			e.printStackTrace();
		}catch (SQLException e) {
			e.printStackTrace();
		}
	}//NoticeDao
	
	public int insertNotice(MultipartRequest mr) {
		int cnt = -1;
		String sql="insert into notice values(notice_seq.nextval,?,?,?,?,sysdate,0)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,mr.getParameter("ntitle"));
			ps.setString(2,mr.getOriginalFileName("nimage"));
			ps.setString(3,mr.getParameter("nuserid"));
			ps.setString(4,mr.getParameter("ncontent"));
			
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
		String sql = "select count(*) as cnt from notice";
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
	
	public ArrayList<NoticeBean> getArticles(int start, int end) {
	    ArrayList<NoticeBean> lists = new ArrayList<NoticeBean>();
	    String sql = "SELECT no, ntitle , nimage , nuserid, ncontent, regdate, readcount " +
	                 "FROM (SELECT rownum AS rank, no, ntitle , nimage , nuserid, ncontent, regdate, readcount " +
	                 "      FROM (SELECT no, ntitle , nimage , nuserid, ncontent, regdate, readcount " +
	                 "            FROM notice)) " +
	                 "WHERE rank BETWEEN ? AND ?";
	    try {
	        ps = conn.prepareStatement(sql);
	        ps.setInt(1, start);
	        ps.setInt(2, end);
	        rs = ps.executeQuery();
	        while (rs.next()) {
	            NoticeBean nb = new NoticeBean();
	            nb.setNo(rs.getInt("no"));
	            nb.setNtitle(rs.getString("ntitle"));
	            nb.setNimage(rs.getString("nimage"));
	            nb.setNuserid(rs.getString("nuserid"));
	            nb.setNcontent(rs.getString("ncontent"));
	            nb.setRegdate(rs.getString("regdate"));
	            nb.setReadcount(rs.getInt("readcount"));

	            lists.add(nb);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) {
	                rs.close();
	            }
	            if (ps != null) {
	                ps.close();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return lists;
	}
	
	public NoticeBean getArticle(String no) {
		NoticeBean nb = null;
		String sql = "select * from notice where no=?";
		try {
			String sql2 = "update notice set readcount = readcount+1 where no=?";
			ps = conn.prepareStatement(sql2);
			ps.setString(1, no);
			ps.executeUpdate();
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, no);
			rs = ps.executeQuery();
			if(rs.next()) {
				nb= new NoticeBean();
				nb.setNo(rs.getInt("no"));
				nb.setNtitle(rs.getString("ntitle"));
				nb.setNimage(rs.getString("nimage"));
				nb.setNuserid(rs.getString("nuserid"));
				nb.setNcontent(rs.getString("ncontent"));
				nb.setRegdate(rs.getString("regdate"));
				nb.setReadcount(rs.getInt("readcount"));
				

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
		return nb;
	}
	
	public int deleteNotice(String no) {
		int cnt=-1;
		String sql ="delete from notice where no=? ";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, no);
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

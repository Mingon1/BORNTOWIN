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


public class BoardDao {
	
	
	Connection conn = null;
	PreparedStatement ps =null;
	ResultSet rs = null;
	
	private static BoardDao instance;
	public static BoardDao getInstance() {
		if(instance==null) {
			instance = new BoardDao();
		}
		return instance;
	}
	
	private BoardDao() {
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
	}//BoardDao
	
	public int getArticleCount() {
		int cnt = 0;
		String sql = "select count(*) as cnt from board";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("cnt"); // count(*)별칭cnt의 갯수를 cnt변수에 넣어준다
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
	
	public ArrayList<BoardBean> getArticles(int start, int end){
		ArrayList<BoardBean> lists = new ArrayList<BoardBean>();
		String sql = "select bno, writer, bid, pimage, passwd, title, content, secret, reg_date, readcount, ref, re_step, re_level ";
		sql += "from (select rownum as rank, bno, writer, bid, pimage, passwd, title, content, secret, reg_date, readcount, ref, re_step, re_level ";
		sql += "from (select bno, writer, bid, pimage, passwd, title, content, secret, reg_date, readcount, ref, re_step, re_level ";
		sql += "from board ";
		sql += "order by ref desc, re_step asc)) "; // 누락된 우괄호 추가
		sql += "where rank between ? and ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			
			lists = makeList(rs);
			
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
	
	public ArrayList<BoardBean> makeList(ResultSet rs) throws SQLException{
		ArrayList<BoardBean> lists = new ArrayList<BoardBean>();
		
		while(rs.next()) {
			BoardBean bb = new BoardBean();
			bb.setBno(rs.getInt("bno"));
			bb.setWriter(rs.getString("writer"));
			bb.setBid(rs.getString("bid"));
			bb.setPimage(rs.getString("pimage"));
			bb.setPasswd(rs.getString("passwd"));
			bb.setTitle(rs.getString("title"));
			bb.setContent(rs.getString("content"));
			bb.setSecret(rs.getString("secret"));
			bb.setReg_date(rs.getString("reg_date"));
			bb.setReadcount(rs.getInt("readcount"));
			bb.setRef(rs.getInt("ref"));
			bb.setRe_step(rs.getInt("re_step"));
			bb.setRe_level(rs.getInt("re_level"));
			lists.add(bb);
			//System.out.println("데이터:"+rs.getTimestamp("reg_date"));
		}
		return lists;
		
	}
	
	
	
	public int insertBoard(MultipartRequest mr, BoardBean bb) {
		int cnt = -1;
		String sql ="insert into board values(board_seq.nextval,?,?,?,?,?,?,?,sysdate, 0, board_seq.currval , 0, 0)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,mr.getParameter("writer"));
			ps.setString(2,mr.getParameter("bid"));
			ps.setString(3,mr.getOriginalFileName("pimage"));
			ps.setString(4,mr.getParameter("passwd"));
			ps.setString(5,mr.getParameter("title"));
			ps.setString(6,mr.getParameter("content"));
			ps.setString(7,mr.getParameter("secret"));
			
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
	
	public BoardBean getCheckpw(String bno, String passwd) {
		BoardBean bb= null;
		String sql="select * from board where bno=? and passwd=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, bno);
			ps.setString(2, passwd);
			rs = ps.executeQuery();
			System.out.println("daobno:"+bno+"pw:"+passwd);
			if(rs.next()) {
				bb= new BoardBean();

				bb.setBno(rs.getInt("bno"));
				bb.setWriter(rs.getString("writer"));
				bb.setBid(rs.getString("Bid"));
				bb.setPimage(rs.getString("pimage"));
				bb.setPasswd(rs.getString("passwd"));
				bb.setTitle(rs.getString("title"));
				bb.setContent(rs.getString("content"));
				bb.setSecret(rs.getString("secret"));
				bb.setReg_date(rs.getString("reg_date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRef(rs.getInt("ref"));
				bb.setRe_step(rs.getInt("re_step"));
				bb.setRe_level(rs.getInt("re_level"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bb;
		
	}
	
	public BoardBean getArticle(String bno) {
		BoardBean bb = null;
		String sql = "select * from board where bno=?";
		try {
			String sql2 = "update board set readcount = readcount+1 where bno=?";
			ps = conn.prepareStatement(sql2);
			ps.setString(1, bno);
			ps.executeUpdate();
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, bno);
			rs = ps.executeQuery();
			if(rs.next()) {
				bb= new BoardBean();

				bb.setBno(rs.getInt("bno"));
				bb.setWriter(rs.getString("writer"));
				bb.setBid(rs.getString("Bid"));
				bb.setPimage(rs.getString("pimage"));
				bb.setPasswd(rs.getString("passwd"));
				bb.setTitle(rs.getString("title"));
				//System.out.println("제목:"+bb.getTitle());
				bb.setContent(rs.getString("content"));
				bb.setSecret(rs.getString("secret"));
				bb.setReg_date(rs.getString("reg_date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRef(rs.getInt("ref"));
				bb.setRe_step(rs.getInt("re_step"));
				bb.setRe_level(rs.getInt("re_level"));

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
		return bb;
	}
	
	public int deleteBoard(String bno) {
		int cnt=-1;
		String sql ="delete from board where bno=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, bno);
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
	
	public int updateBoard(MultipartRequest mr, String img) {
		int cnt=-1;
		String sql="update board set  writer=?, bid=?, pimage=?, title=?, content=?, passwd=?, secret=? where bno=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,mr.getParameter("writer"));
			ps.setString(2,mr.getParameter("bid"));
			ps.setString(3,img);
			ps.setString(4,mr.getParameter("title"));
			ps.setString(5,mr.getParameter("content"));
			ps.setString(6,mr.getParameter("passwd"));
			ps.setString(7,mr.getParameter("secret"));
			ps.setString(8,mr.getParameter("bno"));
			
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
	
	public int replyArticle(BoardBean bb) {
		int updatecnt = -1;
		int insertcnt = -1;
		try {
			String updateSql = "update board set re_step = re_step + 1 where ref = ? and re_step >  ?";
			String insertSql = "insert into board (bno, writer, bid, passwd, title, content , secret , ref, re_step, re_level) "
					+ "values (board_seq.nextval, ?, ?, ?, ?,  ? , ?, ?, ?, ?)";
			ps = conn.prepareStatement(updateSql);
			ps.setInt(1, bb.getRef());
			ps.setInt(2, bb.getRe_step());

			updatecnt = ps.executeUpdate();
			if(updatecnt >= 0) {
				ps = conn.prepareStatement(insertSql);
				ps.setString(1, bb.getWriter());
				ps.setString(2, bb.getBid());
				ps.setString(3, bb.getPasswd());
				ps.setString(4, bb.getTitle());
				ps.setString(5, bb.getContent());
				ps.setString(6, bb.getSecret());
				ps.setInt(7, bb.getRef());
				ps.setInt(8, bb.getRe_step()+1);
				ps.setInt(9, bb.getRe_level()+1);

				insertcnt = ps.executeUpdate();
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}//finally
		
		return insertcnt;
	}
		
}
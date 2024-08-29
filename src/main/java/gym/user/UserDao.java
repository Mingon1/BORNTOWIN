package gym.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import gym.shop.mall.OrderBean;

public class UserDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	private static UserDao instance;
	public static UserDao getInstance() {
		if(instance == null) {
			instance = new UserDao();
		}
		return instance;
	}

	private UserDao() {
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
	}//userDao
	
	public UserBean getUserBean(ResultSet rs) throws SQLException {
		UserBean ub = new UserBean();
		
		ub.setNo(rs.getInt("no"));
		ub.setName(rs.getString("name"));
		ub.setId(rs.getString("id"));
		ub.setPasswd(rs.getString("passwd"));
		ub.setGender(rs.getString("gender"));
		ub.setYear(rs.getString("year"));
		ub.setMonth(rs.getString("month"));
		ub.setDay(rs.getString("day"));
		ub.setEmail(rs.getString("email"));
		ub.setPostaddr(rs.getString("postaddr"));
		ub.setRoadaddr(rs.getString("roadaddr"));
		ub.setJibunaddr(rs.getString("jibunaddr"));
		ub.setDetailaddr(rs.getString("detailaddr"));
		ub.setExaddr(rs.getString("exaddr"));
		ub.setPhone1(rs.getString("phone1"));
		ub.setPhone2(rs.getString("phone2"));
		ub.setPhone3(rs.getString("phone3"));
		ub.setReserves(rs.getInt("reserves"));
		ub.setJoindate(rs.getString("joindate"));
		return ub;
	}
	
	public UserBean fifndId(String name, String phone1,String phone2,String phone3) {
		UserBean ub = null;
		String sql ="select * from users where name=? and phone1=? and phone2=? and phone3=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, phone1);
			ps.setString(3, phone2);
			ps.setString(4, phone3);
			rs = ps.executeQuery();
			if(rs.next()) {
				ub = getUserBean(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
			}catch(SQLException e) {
			}
		}
		
		return ub;
		
	}
	
	public UserBean findPw(String name, String id) {
		UserBean ub = null;
		String sql ="select * from users where name=? and upper(id)=upper(?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, id);
			rs = ps.executeQuery();
			if(rs.next()) {
				ub = getUserBean(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
			}catch(SQLException e) {
			}
		}
		
		return ub;
		
	}
	
	public int InsertUser(UserBean ub) {
		int cnt = -1;
		String sql ="insert into users(no,name,id,passwd,gender,year,month,day,email,postaddr,roadaddr,jibunaddr,detailaddr,exaddr,phone1,phone2,phone3)"
				+ " values(userseq.nextval,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, ub.getName());
			ps.setString(2, ub.getId());
			ps.setString(3, ub.getPasswd());
			ps.setString(4, ub.getGender());
			ps.setString(5, ub.getYear());
			ps.setString(6, ub.getMonth());
			ps.setString(7, ub.getDay());
			ps.setString(8, ub.getEmail());
			ps.setString(9, ub.getPostaddr());
			ps.setString(10, ub.getRoadaddr());
			ps.setString(11, ub.getJibunaddr());
			ps.setString(12, ub.getDetailaddr());
			ps.setString(13, ub.getExaddr());
			ps.setString(14, ub.getPhone1());
			ps.setString(15, ub.getPhone2());
			ps.setString(16, ub.getPhone3());
			
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
			}catch(SQLException e) {
			}
		}
		return cnt;
	}
	
	public UserBean login(String id, String passwd) {
		UserBean ub = null;
		String sql ="select * from users where upper(id)=upper(?) and passwd=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, passwd);
			rs = ps.executeQuery();
			if(rs.next()) {
				ub = getUserBean(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
			}catch(SQLException e) {
			}
		}
		return ub;
	}
	public boolean searchId(String userid) {
		boolean flag = false;
		try {
			String sql = "select * from users where id = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			rs = ps.executeQuery();

			while(rs.next()) {
				flag = true;
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null)
					rs.close();
				if(ps != null)
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}//searchId
	
	public UserBean getAllUser(String userid){
		UserBean ub = null;
		String sql ="select * from users where id like ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+userid);
			
			rs= ps.executeQuery();
			if(rs.next()) {
			ub = getUserBean(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null)
					rs.close();
				if(ps != null)
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ub;
			
	}
	
	public int updateInfo(UserBean ub) {
		int cnt =-1;
		System.out.println("업데이트유저:"+ub.getId());
		String sql="update users set name=?, phone1=?, phone2=?, phone3=?,year=?, month=?, day=?, gender=?, email=?, postaddr=?, roadaddr=?,jibunaddr=?,detailaddr=?,exaddr=? where id like ? ";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, ub.getName());
			ps.setString(2, ub.getPhone1());
			ps.setString(3, ub.getPhone2());
			ps.setString(4, ub.getPhone3());
			ps.setString(5, ub.getYear());
			ps.setString(6, ub.getMonth());
			ps.setString(7, ub.getDay());
			ps.setString(8, ub.getGender());
			ps.setString(9, ub.getEmail());
			ps.setString(10, ub.getPostaddr());
			ps.setString(11, ub.getRoadaddr());
			ps.setString(12, ub.getJibunaddr());
			ps.setString(13, ub.getDetailaddr());
			ps.setString(14, ub.getExaddr());
			ps.setString(15, ub.getId()+"%");
			
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null)
					rs.close();
				if(ps != null)
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public int deleteAccount(String id) {
		int cnt = -1;
		String sql = "delete from users where id like ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id+"%");
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null)
					rs.close();
				if(ps != null)
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return cnt;
	}
	public int changePw(String passwd, String id) {
		int cnt=-1;
		String sql = "update users set passwd=? where id like ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, passwd);
			ps.setString(2, id+"%");
			cnt = ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null)
					rs.close();
				if(ps != null)
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return cnt;
	}
	
	public ArrayList<UserBean> getAllUserInfo(){
		ArrayList<UserBean> lists = new ArrayList<UserBean>();
		
		String sql ="select * from users";
		try {
			ps = conn.prepareStatement(sql);
			rs= ps.executeQuery();
			while(rs.next()) {
				UserBean ub = new UserBean();
				//ub = updateReserves();
				ub.setNo(rs.getInt("no"));
				ub.setName(rs.getString("name"));
				ub.setId(rs.getString("id"));
				ub.setPasswd(rs.getString("passwd"));
				ub.setGender(rs.getString("gender"));
				ub.setYear(rs.getString("year"));
				ub.setMonth(rs.getString("month"));
				ub.setDay(rs.getString("day"));
				ub.setEmail(rs.getString("email"));
				ub.setPostaddr(rs.getString("postaddr"));
				ub.setRoadaddr(rs.getString("roadaddr"));
				ub.setJibunaddr(rs.getString("jibunaddr"));
				ub.setDetailaddr(rs.getString("detailaddr"));
				ub.setExaddr(rs.getString("exaddr"));
				ub.setPhone1(rs.getString("phone1"));
				ub.setPhone2(rs.getString("phone2"));
				ub.setPhone3(rs.getString("phone3"));
				ub.setReserves(rs.getInt("reserves"));
				ub.setJoindate(rs.getString("joindate"));
				
				lists.add(ub);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null)
					rs.close();
				if(ps != null)
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return lists;
			
	}
	
	public int updateReserves(String reserves, String id) {
		int cnt=-1;
		String sql="update users set reserves=? where id like ? ";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(reserves));
			ps.setString(2, id+"%");
			//System.out.println("유저다오업데이트적립금:"+reserves+id);
			
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null)
					rs.close();
				if(ps != null)
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
}

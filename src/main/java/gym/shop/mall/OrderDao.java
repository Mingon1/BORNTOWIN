package gym.shop.mall;

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

public class OrderDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	private static OrderDao instance;
	public static OrderDao getInstance() {
		if(instance == null) {
			instance = new OrderDao();
		}
		return instance;
	}

	private OrderDao() {
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
	}//OrderDao
	
	
	public int insertOrder(OrderBean ob) {
		int cnt = -1;
		String sql="insert into orders values(orderseq.nextval,?,?,?,?,sysdate,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ob.getCno());
			ps.setString(2, ob.getPimage());
			ps.setString(3, ob.getPname());
			ps.setString(4, ob.getOuserid());
			//System.out.println("오더다오"+ob.getOuserid());
			//System.out.println("오더다오"+ob.getOusername());
			//System.out.println("오더다오"+ob.getAmount());
			ps.setString(5, ob.getOusername());
			ps.setString(6, ob.getOphone1());
			ps.setString(7, ob.getOphone2());
			ps.setString(8, ob.getOphone3());
			ps.setString(9, ob.getOemail());
			ps.setString(10, ob.getOpostaddr());
			ps.setString(11, ob.getOroadaddr());
			ps.setString(12, ob.getOjibunaddr());
			ps.setString(13, ob.getOdetailaddr());
			ps.setString(14, ob.getOexaddr());
			ps.setString(15, ob.getOrequests());
			ps.setInt(16, ob.getOqty());
			ps.setString(17, ob.getPoption());
			ps.setString(18, ob.getPayment());
			ps.setInt(19, ob.getTotalreserves());
			System.out.println("오더다오적립금"+ob.getTotalreserves());
			ps.setInt(20, ob.getAmount());
			
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
	
	
	
	public OrderBean getOrderByOno(String ouserid, String cno){
		OrderBean ob = new OrderBean();
		String sql ="select * from orders where ouserid like ? and cno =?";
		try {
			ps= conn.prepareStatement(sql);
			ps.setString(1, ouserid+"%");
			ps.setString(2, cno);
			rs = ps.executeQuery();
			while(rs.next()) {
				ob.setOno(rs.getInt("ono"));
				ob.setCno(rs.getInt("cno"));
				ob.setPimage(rs.getString("pimage"));
				ob.setPname(rs.getString("pname"));
				ob.setOuserid(rs.getString("ouserid"));
				ob.setOdate(rs.getString("odate"));
				ob.setOusername(rs.getString("ousername"));
				ob.setOphone1(rs.getString("ophone1"));
				ob.setOphone2(rs.getString("ophone2"));
				ob.setOphone3(rs.getString("ophone3"));
				ob.setOemail(rs.getString("oemail"));
				ob.setOpostaddr(rs.getString("opostaddr"));
				ob.setOroadaddr(rs.getString("oroadaddr"));
				ob.setOjibunaddr(rs.getString("ojibunaddr"));
				ob.setOdetailaddr(rs.getString("odetailaddr"));
				ob.setOexaddr(rs.getString("oexaddr"));
				ob.setOrequests(rs.getString("orequests"));
				ob.setOqty(rs.getInt("oqty"));
				ob.setPoption(rs.getString("poption"));
				ob.setPayment(rs.getString("payment"));
				ob.setTotalreserves(rs.getInt("totalreserves"));
				ob.setAmount(rs.getInt("amount"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return ob;
		
	}
	
	public OrderBean getOrderByPno(String ouserid, String pno){
		OrderBean ob = new OrderBean();
		String sql ="select * from orders where ouserid like ? and pno =?";
		try {
			ps= conn.prepareStatement(sql);
			ps.setString(1, ouserid+"%");
			ps.setString(2, pno);
			rs = ps.executeQuery();
			while(rs.next()) {
				ob.setOno(rs.getInt("ono"));
				ob.setCno(rs.getInt("cno"));
				ob.setPimage(rs.getString("pimage"));
				ob.setPname(rs.getString("pname"));
				ob.setOuserid(rs.getString("ouserid"));
				ob.setOdate(rs.getString("odate"));
				ob.setOusername(rs.getString("ousername"));
				ob.setOphone1(rs.getString("ophone1"));
				ob.setOphone2(rs.getString("ophone2"));
				ob.setOphone3(rs.getString("ophone3"));
				ob.setOemail(rs.getString("oemail"));
				ob.setOpostaddr(rs.getString("opostaddr"));
				ob.setOroadaddr(rs.getString("oroadaddr"));
				ob.setOjibunaddr(rs.getString("ojibunaddr"));
				ob.setOdetailaddr(rs.getString("odetailaddr"));
				ob.setOexaddr(rs.getString("oexaddr"));
				ob.setOrequests(rs.getString("orequests"));
				ob.setOqty(rs.getInt("oqty"));
				ob.setPoption(rs.getString("poption"));
				ob.setPayment(rs.getString("payment"));
				ob.setTotalreserves(rs.getInt("totalreserves"));
				ob.setAmount(rs.getInt("amount"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return ob;
		
	}
	
	public ArrayList<OrderBean> getAllOrders(){
		ArrayList<OrderBean> lists = new ArrayList<OrderBean>();
		String sql ="select * from orders order by ono desc";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				OrderBean ob = new OrderBean();
				ob.setOno(rs.getInt("ono"));
				ob.setCno(rs.getInt("cno"));
				ob.setPimage(rs.getString("pimage"));
				ob.setPname(rs.getString("pname"));
				ob.setOuserid(rs.getString("ouserid"));
				ob.setOdate(rs.getString("odate"));
				ob.setOusername(rs.getString("ousername"));
				ob.setOphone1(rs.getString("ophone1"));
				ob.setOphone2(rs.getString("ophone2"));
				ob.setOphone3(rs.getString("ophone3"));
				ob.setOemail(rs.getString("oemail"));
				ob.setOpostaddr(rs.getString("opostaddr"));
				ob.setOroadaddr(rs.getString("oroadaddr"));
				ob.setOjibunaddr(rs.getString("ojibunaddr"));
				ob.setOdetailaddr(rs.getString("odetailaddr"));
				ob.setOexaddr(rs.getString("oexaddr"));
				ob.setOrequests(rs.getString("orequests"));
				ob.setOqty(rs.getInt("oqty"));
				ob.setPoption(rs.getString("poption"));
				ob.setPayment(rs.getString("payment"));
				ob.setTotalreserves(rs.getInt("totalreserves"));
				ob.setAmount(rs.getInt("amount"));
				
				lists.add(ob);
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
	
	
	public ArrayList<OrderBean> getAllOrdersByid(String ouserid){
		ArrayList<OrderBean> lists = new ArrayList<OrderBean>();
		String sql ="select * from orders where ouserid like ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+ouserid);
			rs = ps.executeQuery();
			while(rs.next()) {
				OrderBean ob = new OrderBean();
				ob.setOno(rs.getInt("ono"));
				ob.setCno(rs.getInt("cno"));
				ob.setPimage(rs.getString("pimage"));
				ob.setPname(rs.getString("pname"));
				ob.setOuserid(rs.getString("ouserid"));
				ob.setOdate(rs.getString("odate"));
				ob.setOusername(rs.getString("ousername"));
				ob.setOphone1(rs.getString("ophone1"));
				ob.setOphone2(rs.getString("ophone2"));
				ob.setOphone3(rs.getString("ophone3"));
				ob.setOemail(rs.getString("oemail"));
				ob.setOpostaddr(rs.getString("opostaddr"));
				ob.setOroadaddr(rs.getString("oroadaddr"));
				ob.setOjibunaddr(rs.getString("ojibunaddr"));
				ob.setOdetailaddr(rs.getString("odetailaddr"));
				ob.setOexaddr(rs.getString("oexaddr"));
				ob.setOrequests(rs.getString("orequests"));
				ob.setOqty(rs.getInt("oqty"));
				//System.out.println("오더다오 겟올"+rs.getInt("oqty"));
				ob.setPoption(rs.getString("poption"));
				ob.setPayment(rs.getString("payment"));
				ob.setTotalreserves(rs.getInt("totalreserves"));
				ob.setAmount(rs.getInt("amount"));
				
				lists.add(ob);
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
}
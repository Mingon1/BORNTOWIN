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


public class CartDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	private static CartDao instance;
	public static CartDao getInstance() {
		if(instance == null) {
			instance = new CartDao();
		}
		return instance;
	}

	private CartDao() {
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
	}//CartDao

	public int insertCart(CartBean cb) {
	    int cnt = 0;
	    int pno = cb.getPno();
	    String userid = cb.getUserid();
	    int cqty = cb.getCqty();
	    String poption = cb.getPoption();

	    // 이미 장바구니에 해당 상품이 있는지 확인
	    ArrayList<CartBean> cartList = getAllCartListById(userid);
	    boolean flag = false;
	    for (CartBean cb1 : cartList) {
	        if (cb1.getPno() == pno && cb1.getPoption().equals(poption)) { // 상품 번호와 옵션이 같은 경우에만
	            flag = true;
	            // 해당 상품이 이미 장바구니에 있을 경우, 수량과 금액 업데이트
	            int updatedQty = cb1.getCqty() + cqty;
	            int updatedAmount = updatedQty * cb.getPrice();
	            // 업데이트된 수량과 금액을 DB에 반영
	            updateCartCqty(String.valueOf(updatedQty), String.valueOf(cb.getCno()), userid);
	            break;
	        }
	    }

	    // 장바구니에 해당 상품이 없을 경우에는 새로 추가
	    if (!flag) {
	        String sql = "insert into cart values(cartseq.nextval,?,?,?,?,?,?,?,?,?)";
	        try {
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setString(1, userid);
	            ps.setInt(2, pno);
	            ps.setString(3, cb.getPimage());
	            ps.setString(4, cb.getPname());
	            ps.setString(5, poption); // 상품 옵션 추가
	            ps.setInt(6, cqty);
	            ps.setInt(7, cb.getCreserves());

	            int totalprice = cb.getPrice() * cqty;
	            int amount = totalprice;
	            int delivery = amount >= 60000 ? 0 : 3000; // 상품 가격이 60,000원 이상이면 배송비를 0으로 설정
	            ps.setInt(8, delivery);
	            ps.setInt(9, cb.getPrice());

	            cnt = ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    return cnt;
	}


	
	public ArrayList<CartBean> getAllCartListById(String userid){
		ArrayList<CartBean> lists = new ArrayList<CartBean>();
		String sql = "select * from cart where userid like ?";

		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid+"%");
			rs = ps.executeQuery();
			while(rs.next()) {
				CartBean cb = new CartBean();
				cb.setCno(rs.getInt("cno"));
				cb.setUserid(rs.getString("userid"));
				cb.setPno(rs.getInt("pno"));
				cb.setPimage(rs.getString("pimage"));
				cb.setPname(rs.getString("pname"));
				cb.setPoption(rs.getString("poption"));
				cb.setCqty(rs.getInt("cqty"));
				cb.setCreserves(rs.getInt("creserves"));
				cb.setDelivery(rs.getInt("delivery"));
				cb.setPrice(rs.getInt("price"));
				
				
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
	
	public ArrayList<CartBean> getAllCartListByPno(String userid, String pno){
		ArrayList<CartBean> lists = new ArrayList<CartBean>();
		String sql = "select * from cart where userid like ? and pno=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid+"%");
			ps.setInt(2, Integer.parseInt(pno));
			rs = ps.executeQuery();
			while(rs.next()) {
				CartBean cb = new CartBean();
				cb.setCno(rs.getInt("cno"));
				cb.setUserid(rs.getString("userid"));
				cb.setPno(rs.getInt("pno"));
				cb.setPimage(rs.getString("pimage"));
				cb.setPname(rs.getString("pname"));
				cb.setPoption(rs.getString("poption"));
				cb.setCqty(rs.getInt("cqty"));
				cb.setCreserves(rs.getInt("creserves"));
				cb.setDelivery(rs.getInt("delivery"));
				cb.setPrice(rs.getInt("price"));
				
				
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
	
	public int getCartListCount(String userid) {
		int cnt = 0;
		String sql = "select count(*) as cnt from cart where userid like ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("cnt");
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
		return cnt;
	}
	
	public int deleteCartList(String cno, String userid) {//그냥 삭제
		int cnt =-1;
		String sql ="delete from cart where cno=? and userid like ?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, cno);
			ps.setString(2, userid+"%");
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
	
	public int selectDeleteCartList(String [] rc, String userid) { //선택한 장바구니상품 삭제
		int cnt =-1;
		String sql="delete from cart where (cno=?";
		for(int i=0; i<rc.length-1; i++) {
			sql += " or cno=?";
		}
			sql +=  " )and userid like ?";
			try {
		        ps = conn.prepareStatement(sql);
		        int index = 1;
		        for (int i = 0; i < rc.length; i++) {
		            ps.setInt(index++, Integer.parseInt(rc[i]));
		        }
		        ps.setString(index, userid + "%"); 
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
	
	public int deleteAllCartList(String userid) {//장바구니 비우기
		int cnt =-1;
		String sql ="delete from cart where userid like ?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, userid+"%");
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
	
	public int deleteCartListByCno(String userid, String cno) {//장바구니 비우기
		int cnt =-1;
		String sql ="delete from cart where userid like ? and cno=?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, userid+"%");
			ps.setString(2, cno);
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
	public int updateCartCqty(String cqty, String cno ,String userid) {
		int cnt =-1;
		String sql ="update cart set cqty = ? where cno=? and userid like ?";
		try {
			ps=conn.prepareStatement(sql);
			
			ps.setString(1, cqty);
			ps.setString(2, cno);
			ps.setString(3, userid+"%");
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

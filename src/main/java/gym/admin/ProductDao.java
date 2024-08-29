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

import board2.BoardBean;



public class ProductDao {
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	private static ProductDao instance;
	public static ProductDao getInstance() {
		if(instance == null) {
			instance = new ProductDao();
		}
		return instance;
	}

	private ProductDao() {
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
	}//ProductDao
	
	
	public int insertProduct(MultipartRequest mr, String psize) {
		int cnt = -1;
		String sql ="insert into product values(prod.nextval,?,?,?,?,?,?,?,?,?,?,sysdate)";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1,mr.getParameter("pcode"));
			ps.setString(2, mr.getParameter("price"));
			ps.setString(3, mr.getParameter("pname"));
			ps.setString(4, mr.getParameter("pcategory"));
			ps.setString(5, mr.getParameter("pcompany"));
			ps.setString(6, mr.getOriginalFileName("pimage"));
			ps.setString(7, psize);
			ps.setString(8, mr.getParameter("pqty"));
			ps.setString(9, mr.getParameter("pcontents"));
			
			String reser = mr.getParameter("reserves");
			int reserves = (reser != null) ? 0 : 0;
			reserves += (Integer.parseInt(mr.getParameter("price"))*0.05);
			//System.out.println(mr.getParameter("price"));
			//System.out.println("적립금:"+reserves);
			
			ps.setInt(10, reserves);
			
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
		
	}
	
	public ArrayList<ProductBean> getAllProduct(){
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		String sql = "select * from product order by pno";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
				lists = makeArrayList(rs);
				//System.out.println("어레이"+lists.size());
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return lists;
		
	}
	
	public ArrayList<ProductBean> getAllRandomProduct(){
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		String sql = "select * from product order by dbms_random.value";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
				lists = makeArrayList(rs);
				//System.out.println("어레이"+lists.size());
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return lists;
		
	}
	
	public ArrayList<ProductBean> makeArrayList(ResultSet rs) throws SQLException {
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		while(rs.next()) {
			ProductBean pb = new ProductBean();
			pb.setPno(rs.getInt("pno"));
			pb.setPcode(rs.getInt("pcode"));
			pb.setPrice(rs.getInt("price"));
			pb.setPname(rs.getString("pname"));
			pb.setPcategory(rs.getString("pcategory"));
			pb.setPcompany(rs.getString("pcompany"));
			pb.setPimage(rs.getString("pimage"));
			pb.setPsize(rs.getString("psize"));
			pb.setPqty(rs.getInt("pqty"));
			pb.setPcontents(rs.getString("pcontents"));
			pb.setReserves(rs.getInt("reserves"));
			pb.setPinputdate(rs.getString("pinputdate"));
			lists.add(pb);

		}
		return lists;
		
	}
	
	public int selectDelete(String [] sc) {
		int cnt = -1;
		String sql = "delete from product where pno =?";
		for(int i=0; i<sc.length-1; i++) {
			sql += " or pno=?";
		}
		try {
			ps = conn.prepareStatement(sql);
			for(int i=0; i<sc.length; i++) {
			ps.setInt(i+1, Integer.parseInt(sc[i]));
			}
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public int updateProduct(MultipartRequest mr, String img, String psize) {
		int cnt = -1;
		String sql ="update product set pcode=? , price=?, pname=?, pcategory=?, pcompany=?, pimage=?, psize=?, pqty=?, pcontents=? , reserves=? where pno=?";
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1,mr.getParameter("pcode"));
			ps.setString(2,mr.getParameter("price"));
			ps.setString(3, mr.getParameter("pname"));
			ps.setString(4, mr.getParameter("pcategory"));
			ps.setString(5, mr.getParameter("pcompany"));
			ps.setString(6, img);
			ps.setString(7, psize);
			ps.setInt(8, Integer.parseInt(mr.getParameter("pqty")));
			ps.setString(9, mr.getParameter("pcontents"));
			//System.out.println(mr.getParameter("price")+"수량"+(mr.getParameter("pqty")));
			String reser = mr.getParameter("reserves");
			int reserves = (reser != null) ? 0 : 0;
			reserves += (Integer.parseInt(mr.getParameter("price")) * 0.05);
			
			ps.setInt(10, reserves);
			//System.out.println(reserves);
			ps.setInt(11, Integer.parseInt(mr.getParameter("pno")));
			//System.out.println("번호"+mr.getParameter("pno"));
			
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null)
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public ProductBean getProductByPno(String pno) {
		String sql = "select * from product where pno = ?"; 
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		try {
			ps = conn.prepareStatement(sql);
			//System.out.println("getbypno:"+pno);
			ps.setString(1, pno);
			rs = ps.executeQuery();
			
			lists = makeArrayList(rs);

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
		//System.out.println("getProductByPno lists.size():" + lists.size());
		return lists.get(0);
	}
	
	public int getproductCount() {
		int cnt = 0;
		String sql = "select count(*) as cnt from product";
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
	
	public int getproductCountByKeyword(String keyword) {
		int cnt = 0;
		String sql = "select count(*) as cnt from product where pcontents like ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+keyword+"%");
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
	
	public ArrayList<ProductBean> getArticles(int start, int end){
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		String sql = "select pno, pcode, price, pname, pcategory, pcompany, pimage, psize, pqty, pcontents, reserves, pinputdate ";
		sql += "from (select rownum as rank, pno, pcode,  price, pname, pcategory, pcompany, pimage, psize, pqty, pcontents, reserves, pinputdate ";
		sql += "from (select pno, pcode, price, pname, pcategory, pcompany, pimage, psize, pqty, pcontents, reserves, pinputdate ";
		sql += "from product ";
		sql += "order by pno desc)) ";
		sql += "where rank between ? and ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			
			lists = makeArrayList(rs);
			
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
	
	public ArrayList<ProductBean> getSearchArticles(int start, int end, String keyword){
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		String sql = "select pno, pcode, price, pname, pcategory, pcompany, pimage, psize, pqty, pcontents, reserves, pinputdate ";
		sql += "from (select rownum as rank, pno, pcode,  price, pname, pcategory, pcompany, pimage, psize, pqty, pcontents, reserves, pinputdate ";
		sql += "from (select pno, pcode, price, pname, pcategory, pcompany, pimage, psize, pqty, pcontents, reserves, pinputdate ";
		sql += "from product ";
		sql += "where pcontents like ? ";
		sql += "order by pno desc)) ";
		sql += "where rank between ? and ?";
		try {
			ps = conn.prepareStatement(sql);
	        ps.setString(1, "%" + keyword + "%");
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs = ps.executeQuery();
			
			lists = makeArrayList(rs);
			
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
	
	
	public int getproductByCategoryCount(String pcategory) {
		int cnt = 0;
		String sql = "select count(*) as cnt from product where upper(pcategory) like upper(?)";
		try {
			ps = conn.prepareStatement(sql);
			//System.out.println("dao:"+pcategory);
			ps.setString(1, pcategory+"%");
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
	
	public ArrayList<ProductBean> getArticlesByCategory(int start, int end, String pcategory) {
	    ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
	    String sql = "select pno, pcode, price, pname, pcategory, pcompany, pimage, psize, pqty, pcontents, reserves, pinputdate " +
	                 "from (select rownum as rank, pno, pcode, price, pname, pcategory, pcompany, pimage, psize, pqty, pcontents, reserves, pinputdate " +
	                       "from (select pno, pcode, price, pname, pcategory, pcompany, pimage, psize, pqty, pcontents, reserves, pinputdate " +
	                             "from product " +
	                             "where upper(pcategory) like upper(?) " +
	                             "order by pno desc)) " +
	                 "where rank between ? and ?";
	    try {
	        ps = conn.prepareStatement(sql);
	        ps.setString(1, "%"+pcategory+"%");
	        ps.setInt(2, start);
	        ps.setInt(3, end);
	        rs = ps.executeQuery();
	        
	        lists = makeArrayList(rs);
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
}

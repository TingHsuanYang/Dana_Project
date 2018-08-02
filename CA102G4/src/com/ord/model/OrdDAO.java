
package com.ord.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class OrdDAO implements OrdDAO_interface {
	private static DataSource ds = null;
	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA102G4");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final long serialVersionUID = 1L;
	
	
	private static final String INSERT_STMT = 
			"INSERT INTO ORD (ORDER_ID,BUYER_MEM_ID,SELLER_MEM_ID,ORDER_ADDRESS,PAYMENT_STATUS,PAYMENT_METHOD,SHIPMENT_STATUS"
			+ ",ORDER_DATE,ORDER_STATUS,ORDER_TOTAL,ORDER_ITEM,SHIPMENT_METHOD,ORD_STORE_711_NAME)"
			+ " VALUES (to_char(sysdate,'yyyymmdd')||'_'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
	private static final String UPDATE_STMT = 
			"UPDATE ORD set PAYMENT_STATUS=?,SHIPMENT_STATUS=?,ORDER_STATUS=?,CANCEL_REASON=?,STOB_RATING=?,STOB_RATING_DESCR=?,"
			+ "BTOS_RATING=?,BTOS_RATING_DESCR=?,SHIPMENT_ID=? where ORDER_ID = ?";
	
	private static final String FIND_BY_PK =
			"SELECT ORDER_ID,BUYER_MEM_ID,SELLER_MEM_ID,ORDER_ADDRESS,PAYMENT_STATUS,PAYMENT_METHOD,"
			+ "SHIPMENT_STATUS,ORDER_DATE,ORDER_STATUS,ORDER_TOTAL,ORDER_ITEM,CANCEL_REASON,STOB_RATING,"
			+ "STOB_RATING_DESCR,BTOS_RATING,BTOS_RATING_DESCR,SHIPMENT_ID,SHIPMENT_METHOD,ORD_STORE_711_NAME"
			+ " FROM ORD where ORDER_ID = ?";
	
	private static final String GET_ALL_STMT = 
			"SELECT ORDER_ID,BUYER_MEM_ID,SELLER_MEM_ID,ORDER_ADDRESS,PAYMENT_STATUS,PAYMENT_METHOD,"
			+ "SHIPMENT_STATUS,ORDER_DATE,ORDER_STATUS,ORDER_TOTAL,ORDER_ITEM,CANCEL_REASON,STOB_RATING,"
			+ "STOB_RATING_DESCR,BTOS_RATING,BTOS_RATING_DESCR,SHIPMENT_ID,SHIPMENT_METHOD,ORD_STORE_711_NAME"
			+ " FROM ORD order by ORDER_ID";
	
	
	private static final String GET_ONE_ALL_BUY =
			"SELECT ORDER_ID,BUYER_MEM_ID,SELLER_MEM_ID,ORDER_ADDRESS,PAYMENT_STATUS,PAYMENT_METHOD,"
			+ "SHIPMENT_STATUS,ORDER_DATE,ORDER_STATUS,ORDER_TOTAL,ORDER_ITEM,CANCEL_REASON,STOB_RATING,"
			+ "STOB_RATING_DESCR,BTOS_RATING,BTOS_RATING_DESCR,SHIPMENT_ID,SHIPMENT_METHOD,ORD_STORE_711_NAME"
			+ " FROM ORD where BUYER_MEM_ID = ? order by ORDER_ID";
	
	
	private static final String GET_ONE_ALL_SELL = 
			"SELECT ORDER_ID,BUYER_MEM_ID,SELLER_MEM_ID,ORDER_ADDRESS,PAYMENT_STATUS,PAYMENT_METHOD,"
			+ "SHIPMENT_STATUS,ORDER_DATE,ORDER_STATUS,ORDER_TOTAL,ORDER_ITEM,CANCEL_REASON,STOB_RATING,"
			+ "STOB_RATING_DESCR,BTOS_RATING,BTOS_RATING_DESCR,SHIPMENT_ID,SHIPMENT_METHOD,ORD_STORE_711_NAME"
			+ " FROM ORD where SELLER_MEM_ID = ? order by ORDER_ID";
	
	public static void setIntOrNull(PreparedStatement ps, int column, Integer value) {
		if (value != null) {
	        try {
				ps.setInt(column, value);
			} catch (SQLException e) {
				throw new RuntimeException("A database error occured. "
						+ e.getMessage());
			}
	    } else {
	        try {
				ps.setNull(column, java.sql.Types.INTEGER);
			} catch (SQLException e) {
				throw new RuntimeException("A database error occured. "
						+ e.getMessage());
			}
	    }
	}
	
	@Override
	public void insert(OrdVO ordVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			
			pstmt.setString(1, ordVO.getBuyer_mem_id());
			pstmt.setString(2, ordVO.getSeller_mem_id());
			pstmt.setString(3, ordVO.getOrder_address());
			pstmt.setInt(4, ordVO.getPayment_status());
			pstmt.setInt(5, ordVO.getPayment_method());
			pstmt.setInt(6, ordVO.getShipment_status());
			pstmt.setTimestamp(7, ordVO.getOrder_date());
			pstmt.setInt(8, ordVO.getOrder_status());
			pstmt.setInt(9, ordVO.getOrder_total());
			pstmt.setInt(10, ordVO.getOrder_item());
			pstmt.setInt(11, ordVO.getShipment_method());
			pstmt.setString(12, ordVO.getOrd_store_711_name());

			pstmt.executeUpdate();
			
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public void update(OrdVO ordVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);
			
			pstmt.setInt(1, ordVO.getPayment_status());
			pstmt.setInt(2, ordVO.getShipment_status());
			pstmt.setInt(3, ordVO.getOrder_status());
			setIntOrNull(pstmt, 4, ordVO.getCancel_reason());
			setIntOrNull(pstmt,5, ordVO.getStob_rating());
			pstmt.setString(6, ordVO.getStob_rating_descr());
			setIntOrNull(pstmt,7, ordVO.getBtos_rating());
			pstmt.setString(8, ordVO.getBtos_rating_descr());
			pstmt.setString(9, ordVO.getShipment_id());
			pstmt.setString(10, ordVO.getOrder_id());

			pstmt.executeUpdate();

			// Handle any driver errors
		}  catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public OrdVO findByPK(String order_id) {
		OrdVO ordVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_PK);

			pstmt.setString(1, order_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				ordVO = new OrdVO();
				
				ordVO.setOrder_id(rs.getString("ORDER_ID"));
				ordVO.setBuyer_mem_id(rs.getString("BUYER_MEM_ID"));
				ordVO.setSeller_mem_id(rs.getString("SELLER_MEM_ID"));
				ordVO.setOrder_address(rs.getString("ORDER_ADDRESS"));
				ordVO.setPayment_status(rs.getInt("PAYMENT_STATUS"));
				ordVO.setPayment_method(rs.getInt("PAYMENT_METHOD"));
				ordVO.setShipment_status(rs.getInt("SHIPMENT_STATUS"));
				ordVO.setOrder_date(rs.getTimestamp("ORDER_DATE"));
				ordVO.setOrder_status(rs.getInt("ORDER_STATUS"));
				ordVO.setOrder_total(rs.getInt("ORDER_TOTAL"));
				ordVO.setOrder_item(rs.getInt("ORDER_ITEM"));
				ordVO.setCancel_reason(rs.getInt("CANCEL_REASON"));
				ordVO.setStob_rating(rs.getInt("STOB_RATING"));
				ordVO.setStob_rating_descr(rs.getString("STOB_RATING_DESCR"));
				ordVO.setBtos_rating(rs.getInt("BTOS_RATING"));
				ordVO.setBtos_rating_descr(rs.getString("BTOS_RATING_DESCR"));
				ordVO.setShipment_id(rs.getString("SHIPMENT_ID"));
				ordVO.setShipment_method(rs.getInt("SHIPMENT_METHOD"));
				ordVO.setOrd_store_711_name(rs.getString("ORD_STORE_711_NAME"));
			}

			// Handle any driver errors
		}  catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		}finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return ordVO;
	}
	

	@Override
	public List<OrdVO> getAll() {
		List<OrdVO> listAll = new ArrayList<OrdVO>();
		OrdVO ordVO = null;
			
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				ordVO = new OrdVO();
				ordVO.setOrder_id(rs.getString("ORDER_ID"));
				ordVO.setBuyer_mem_id(rs.getString("BUYER_MEM_ID"));
				ordVO.setSeller_mem_id(rs.getString("SELLER_MEM_ID"));
				ordVO.setOrder_address(rs.getString("ORDER_ADDRESS"));
				ordVO.setPayment_status(rs.getInt("PAYMENT_STATUS"));
				ordVO.setPayment_method(rs.getInt("PAYMENT_METHOD"));
				ordVO.setShipment_status(rs.getInt("SHIPMENT_STATUS"));
				ordVO.setOrder_date(rs.getTimestamp("ORDER_DATE"));
				ordVO.setOrder_status(rs.getInt("ORDER_STATUS"));
				ordVO.setOrder_total(rs.getInt("ORDER_TOTAL"));
				ordVO.setOrder_item(rs.getInt("ORDER_ITEM"));
				ordVO.setCancel_reason(rs.getInt("CANCEL_REASON"));
				ordVO.setStob_rating(rs.getInt("STOB_RATING"));
				ordVO.setStob_rating_descr(rs.getString("STOB_RATING_DESCR"));
				ordVO.setBtos_rating(rs.getInt("BTOS_RATING"));
				ordVO.setBtos_rating_descr(rs.getString("BTOS_RATING_DESCR"));
				ordVO.setShipment_id(rs.getString("SHIPMENT_ID"));
				ordVO.setShipment_method(rs.getInt("SHIPMENT_METHOD"));
				ordVO.setOrd_store_711_name(rs.getString("ORD_STORE_711_NAME"));
							
				listAll.add(ordVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		}finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return listAll;
	}

	@Override
	public List<OrdVO> getOneForAllBuy(String buyer_mem_id) {
		List<OrdVO> listAllBuy = new ArrayList<OrdVO>();
		OrdVO ordVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(GET_ONE_ALL_BUY);
		
			pstmt.setString(1,buyer_mem_id);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				ordVO = new OrdVO();
				ordVO.setOrder_id(rs.getString("ORDER_ID"));
				ordVO.setBuyer_mem_id(rs.getString("BUYER_MEM_ID"));
				ordVO.setSeller_mem_id(rs.getString("SELLER_MEM_ID"));
				ordVO.setOrder_address(rs.getString("ORDER_ADDRESS"));
				ordVO.setPayment_status(rs.getInt("PAYMENT_STATUS"));
				ordVO.setPayment_method(rs.getInt("PAYMENT_METHOD"));
				ordVO.setShipment_status(rs.getInt("SHIPMENT_STATUS"));
				ordVO.setOrder_date(rs.getTimestamp("ORDER_DATE"));
				ordVO.setOrder_status(rs.getInt("ORDER_STATUS"));
				ordVO.setOrder_total(rs.getInt("ORDER_TOTAL"));
				ordVO.setOrder_item(rs.getInt("ORDER_ITEM"));
				ordVO.setCancel_reason(rs.getInt("CANCEL_REASON"));
				ordVO.setStob_rating(rs.getInt("STOB_RATING"));
				ordVO.setStob_rating_descr(rs.getString("STOB_RATING_DESCR"));
				ordVO.setBtos_rating(rs.getInt("BTOS_RATING"));
				ordVO.setBtos_rating_descr(rs.getString("BTOS_RATING_DESCR"));
				ordVO.setShipment_id(rs.getString("SHIPMENT_ID"));
				ordVO.setShipment_method(rs.getInt("SHIPMENT_METHOD"));
				ordVO.setOrd_store_711_name(rs.getString("ORD_STORE_711_NAME"));
							
				listAllBuy.add(ordVO); // Store the row in the list
				
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		}finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		return listAllBuy;
		
	}

	@Override
	public List<OrdVO> getOneForAllSell(String seller_mem_id) {
		List<OrdVO> listAllSell = new ArrayList<OrdVO>();
		OrdVO ordVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(GET_ONE_ALL_SELL);
		
			pstmt.setString(1,seller_mem_id);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				ordVO = new OrdVO();
				ordVO.setOrder_id(rs.getString("ORDER_ID"));
				ordVO.setBuyer_mem_id(rs.getString("BUYER_MEM_ID"));
				ordVO.setSeller_mem_id(rs.getString("SELLER_MEM_ID"));
				ordVO.setOrder_address(rs.getString("ORDER_ADDRESS"));
				ordVO.setPayment_status(rs.getInt("PAYMENT_STATUS"));
				ordVO.setPayment_method(rs.getInt("PAYMENT_METHOD"));
				ordVO.setShipment_status(rs.getInt("SHIPMENT_STATUS"));
				ordVO.setOrder_date(rs.getTimestamp("ORDER_DATE"));
				ordVO.setOrder_status(rs.getInt("ORDER_STATUS"));
				ordVO.setOrder_total(rs.getInt("ORDER_TOTAL"));
				ordVO.setOrder_item(rs.getInt("ORDER_ITEM"));
				ordVO.setCancel_reason(rs.getInt("CANCEL_REASON"));
				ordVO.setStob_rating(rs.getInt("STOB_RATING"));
				ordVO.setStob_rating_descr(rs.getString("STOB_RATING_DESCR"));
				ordVO.setBtos_rating(rs.getInt("BTOS_RATING"));
				ordVO.setBtos_rating_descr(rs.getString("BTOS_RATING_DESCR"));
				ordVO.setShipment_id(rs.getString("SHIPMENT_ID"));
				ordVO.setShipment_method(rs.getInt("SHIPMENT_METHOD"));
				ordVO.setOrd_store_711_name(rs.getString("ORD_STORE_711_NAME"));
				
				listAllSell.add(ordVO); // Store the row in the list
				
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		}finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		return listAllSell;
	}

}

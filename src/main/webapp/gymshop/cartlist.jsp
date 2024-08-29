<%@page import="gym.shop.mall.CartBean"%>
<%@page import="gym.shop.mall.CartDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <script type="text/javascript" src="<%=request.getContextPath()%>/gymshop/gymscript.js"></script>
    
<%@include file="prod_top.jsp"%>


<style>

        h3.page-title {
            margin-top: 0;
            padding-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ccc;
        }

        table {
            width: 100%;
            margin-top: 20px;
            padding: 40px;
            
        }

        th {
            padding: 8px;
            text-align: center;
            border: 1px solid #ddd;
        }
        td{
            padding: 8px;
            text-align: center;
        }



        img {
            display: block;
            margin: auto;
        }

        input[type="checkbox"] {
            transform: scale(1.5);
        }

        input[type="button"] {
            padding: 8px;
            background-color: #dcdcdc; 
            color: #000;
            border: none;
            border-radius: 1px;
            cursor: pointer;
        }

        input[type="button"]:hover {
            background-color: #c8c8c8; 
        }

        
		.button-group {
        	text-align: center; 
        	padding-left: 40px;
        	padding-right: 40px;
    	}
    	.info {
       	 	margin: auto;
        	text-align: left;
        	padding-left: 40px;
        
    	}

    	.info strong {
        	color: #555;
    	}

    	.info p {
        	font-size: 12px;
        	color: #777;
        	line-height: 1.6;
    	}
		.button-container {
    		text-align: center;
		}

		.action-button {
    		display: inline-block;
    		padding: 8px;
    		background-color: #dcdcdc;
    		color: #000;
    		text-decoration: none;
    		border: none;
    		margin: 5px;
		}

		.action-button:hover {
    		background-color: #c8c8c8;
		}
		.shopping-btn {
        	float: right;
    	}
		.cartclean {
        	float: right;
    	}

    </style>   


<%
//detail pno=>
String pno =request.getParameter("pno");
System.out.println("넘어온 상품번호"+pno); //상품 수정갯수때문에 받아준다.
ProductDao pdao = ProductDao.getInstance();
ProductBean pb = pdao.getProductByPno(pno);

clists = cdao.getAllCartListById(userid);
//System.out.println("카트리스트:"+clists.size());


DecimalFormat df = new DecimalFormat("###,###");
int totalAmount = 0;
int totalDeliveryFee = 0; 
int reserves =0;

%>
    <div style="padding:40px">
    <h4><b>Cart</b></h4>
    
    <hr>
    <form name="delform" method="post" action="selectCartDeleteProc.jsp?pno=<%=pno%>&userid=<%=userid%>">
    <table>
        <tr>
            <th><input type="checkbox" name="allcheck" onclick="allCheck(this)"></th>
            <th>이미지</th>
            <th>상품정보</th>
            <th>수량</th>
            <th>상품구매금액</th>
            <th>적립금</th>
            <th>배송비</th>
            <th>선택</th>
        </tr>
        
        
        <%if(clists.size()==0){%>
            <tr><td colspan ="8">장바구니가 비었습니다</td></tr>
        <%}%>
        <%for(CartBean cb : clists){
        String requestDir = request.getContextPath()+"/clothes";
        System.out.println(requestDir+"/"+cb.getPimage());
        int amount = cb.getCqty() * cb.getPrice();
        totalAmount += amount;
        totalDeliveryFee = totalAmount > 60000 ? 0 : 3000; // 총 배송비 업데이트
        reserves = cb.getCqty() * cb.getCreserves();
        //System.out.println(request.getContextPath());
        %>
        <tr>
            <td>
                <input type="checkbox" name="rowcheck" value="<%=cb.getCno()%>">
            </td>
            <td>
                <p style="width: 150px;"><img src="<%=requestDir + "/" + cb.getPimage() %>" width= "20%" height="150px"></p>
            </td>
            <td style="width: 200px;">
                <%=cb.getPname()%><br>
                [옵션:<%=cb.getPoption()%>]
            </td>
            <td>
                <input type="number" id="cqtyInput_<%=cb.getCno()%>" name="cqty" min="1" max="<%=pb.getPqty()%>" value="<%=cb.getCqty()%>">
                <a href="javascript:void(0);" onclick="updateQty('<%=cb.getCno()%>', '<%=userid%>', '<%=cb.getPno()%>')">변경</a>
            </td>

        <script>
            function updateQty(cno, userid, pno) {
                var cqtyValue = document.getElementById("cqtyInput_" + cno).value;
                var url = "updateCartQtyProc.jsp?cno=" + cno + "&userid=" + userid + "&pno=" + pno + "&cqty=" + cqtyValue;
                window.location.href = url;
            }
            
            function confirmDelete() {
                return confirm("정말로 삭제하시겠습니까?");
            }
            
            function confirmCart() {
                return confirm("장바구니를 비우시겠습니까?");
            }
            

            function orderAllItems() {
                var clistsSize = <%= clists.size() %>;
                if (clistsSize == 0) {
                    alert("상품을 먼저 담아주세요.");
                    return false;
                } else {
                    document.orderform.submit();
                    return true;
                }
            }

            function idcheck(){
            	if(<%=userid%>==null){
            		alert("로그인 후 사용해주세요");
            		return false;
            	}
            	return true;
            }
        </script>

            <td>₩<%=df.format(amount)%></td>
            <td>₩<%=df.format(reserves)%></td>
            <td>
                 <% if (totalAmount > 60000) { 
                 %>
                   무료
                <% } else { %>
                    ₩<%= cb.getDelivery() %>
                <% } 
                //System.out.print("cno:"+cb.getCno()+",");%>
            </td>
            <td>
    <div class="button-container">
        <a href="orderForm2.jsp?pno=<%=pb.getPno()%>&cno=<%=cb.getCno()%>&userid=<%=userid%>" class="action-button" onclick="return idcheck()">주문하기</a>
        <br>
        <a href="deletecartproc.jsp?cno=<%=cb.getCno()%>&userid=<%=userid%>&pno=<%=cb.getPno()%>" class="action-button" onclick="return confirmDelete()">✖ 삭제</a>
    </div>
   
</td>
        </tr>
            
            <%
            
            }// for

            %>
    </table>
    
        <hr>
                <span>
                    선택상품을&nbsp;<input type="button" value="✖ 삭제" onclick="selectCartDelete()">
					<a href="allCartDeleteProc.jsp?pno=<%=pno%>&userid=<%=userid%>" class="btn btn-warning cartclean" onclick="return confirmCart()">장바구니 비우기</a>
                </span>
                </form>
    <table>
        <tr>
            <th>총 상품금액</th>
            <th>배송비</th>
            <th>결제예정금액</th>
        </tr>   
        <tr>
            <td>₩<%= df.format(totalAmount) %></td>
            <td>₩<%= totalDeliveryFee %></td>
            <td>₩<%= df.format(totalAmount + totalDeliveryFee) %></td>
        </tr>   
    </table>
        <hr>
        </div>
        
        <div class="button-group">
        <hr>
        <form name="orderform" method="post" action="allorderForm.jsp?pno=<%=pno%>">
        	<%for(CartBean cb : clists){%>
        	<input type="hidden" name="cno" value="<%=cb.getCno()%>">
        	<%}%>
    	<input type="button" class="btn btn-dark" value="전체상품주문" onclick="orderAllItems()">
        <input type="button" class="btn btn-secondary" value="선택상품주문" onclick="orderSelectedItems()">
        <input type="button" class="btn btn-success shopping-btn" value="쇼핑계속하기" onclick="location='<%=request.getContextPath()%>/main.jsp'">
        </form>
    <br><br>
    <h4><span style="float: left"><b>이용안내</b></span></h4>
    <br>
    <hr>
        </div>


    <span class="info">
<div style="width: 40%;  padding-left: 40px;">
<strong>장바구니 이용안내</strong>
<p style="font-size:12px">
해외배송 상품과 국내배송 상품은 함께 결제하실 수 없으니 장바구니 별로 따로 결제해 주시기 바랍니다.
해외배송 가능 상품의 경우 국내배송 장바구니에 담았다가 해외배송 장바구니로 이동하여 결제하실 수 있습니다.
선택하신 상품의 수량을 변경하시려면 수량변경 후 [변경] 버튼을 누르시면 됩니다.
[쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속 하실 수 있습니다.
장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.
파일첨부 옵션은 동일상품을 장바구니에 추가할 경우 마지막에 업로드 한 파일로 교체됩니다.
</p>
<strong>무이자할부 이용안내</strong>
<p style="font-size:12px">
상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제 하시면 됩니다.
[전체 상품 주문] 버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가 이루어집니다.
단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.
무이자할부 상품은 장바구니에서 별도 무이자할부 상품 영역에 표시되어, 무이자할부 상품 기준으로 배송비가 표시됩니다.
실제 배송비는 함께 주문하는 상품에 따라 적용되오니 주문서 하단의 배송비 정보를 참고해주시기 바랍니다.
    </p>
</div>
    </span>

<%@include file="prod_bottom.jsp"%>
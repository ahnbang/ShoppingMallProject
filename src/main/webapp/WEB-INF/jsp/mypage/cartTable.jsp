<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous">
</script>


<div class="card mb-4">
    <div class="card-header">
        <i class="fa-solid fa-cart-shopping"></i>
        장바구니
    </div>
    <div class="card-body">
        <table class="table">
            <thead>
                <tr>
                    <th scope="col" style="text-align: center">상품정보</th>
                    <th scope="col">수량</th>
                    <th scope="col">사이즈</th>
                    <th scope="col">판매가</th>
                    <th scope="col">주문 금액</th>

                </tr>
            </thead>
            <tbody>
                <c:forEach var="cartItem" items="${cartTableDTO.getCartItemList()}" varStatus="status">
                    <c:set var="cartProduct" value="${cartTableDTO.getProductListFromCartItem()[status.index]}"></c:set>

                    <tr>
                        <td>
                        <a style="text-decoration-line : none" href="/productDetail/${cartProduct.getItem().getId()}">
                        <img src="${cartProduct.getThumnail()}" class="img-thumbnail" style="height: 150px;">
                            ${cartProduct.getItem().getName()}
                        </td>
                        <td class="align-middle">${cartItem.getCount()}개</td>
                        <td class="align-middle">${cartItem.getSize()}</td>
                        <td class="align-middle">${cartProduct.getItem().getPrice()}원</td>
                        <td class="align-middle">${cartItem.getCount()*cartProduct.getItem().getPrice()}원</td>
                            
                        <td class="align-middle">
                            <button type="button" class="orderOne-Btn btn btn-success" data-itemid-info="${cartProduct.getItem().getId()}" data-ordercount-info="${cartItem.getCount()}"
                            data-cartitemid-info="${cartItem.getId()}">
                            <i class="fa-sharp fa-solid fa-file-pen"></i> 주문</button>
                            
                        </td>
                        <td class="align-middle"><button type="button" class="deleteCartItemOne-Btn btn btn-danger" data-caritemid-info="${cartItem.getId()}">
                            <i class="fa-sharp fa-solid fa-trash"></i> 삭제</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
            
        </table>
        <button type="button" class="orderAll-Btn btn btn-success" data-cartitemlist-info="${cartTableDTO.getCartItemList()}"><i class="fa-sharp fa-solid fa-file-pen"></i> 전체주문</button>
        
        <button type="button" class="deleteCartItemAll-Btn btn btn-danger"  data-cartitemlist-info="${cartTableDTO.getCartItemList()}"><i class="fa-sharp fa-solid fa-trash"></i> 전체삭제</button>

        <form class="orderAll" id ="orderAllForm" action="/order/orderCheck" method="post">
            <c:forEach var="cartItem" items="${cartTableDTO.getCartItemList()}" varStatus="status">
                <c:set var="cartProduct" value="${cartTableDTO.getProductListFromCartItem()[status.index]}"></c:set>
                <input type="hidden" name="itemId" value="${cartProduct.getItem().getId()}">
                <input type="hidden" name="orderCount" value="${cartItem.getCount()}">
                <input type="hidden" name="cartItemId" value="${cartItem.getId()}">
            </c:forEach>
        </form>

    </div>
</div>

<script>
    $(document).ready(function () {

        $('.deleteCartItemOne-Btn').on('click', function() {
            let cartItemId = $(this).data('caritemid-info');
            $.ajax({
			type:"post"
			, url:"/cart/deleteCartItemOne"
			, data:{
                "cartItemId":cartItemId,
                }
			, success:function(result) {
				if (result.status == "SUCCESS") {
                    alert(result.message);
					location.reload();
				} else {
					alert("해당상품을 장바구니에서 삭제했습니다.");
				}
			}
			, error:function(e) {
				alert("관리자에게 문의해주세요.");
			}
		});

        });   

        $('.orderOne-Btn').on('click', function() {

            let newForm = document.createElement("form");
            newForm.setAttribute("method", "POST");
            newForm.setAttribute("action", "/order/orderCheck")

            var itemIdInput = document.createElement("input");
            itemIdInput.setAttribute("type", "hidden");
            itemIdInput.setAttribute("name", "itemId");
            itemIdInput.setAttribute("value", $(this).data('itemid-info'));
            newForm.appendChild(itemIdInput);
            
            var orderCountInput = document.createElement("input");
            orderCountInput.setAttribute("type", "hidden");
            orderCountInput.setAttribute("name", "orderCount");
            orderCountInput.setAttribute("value", $(this).data('ordercount-info'));
            newForm.appendChild(orderCountInput);
            
            var cartItemId = document.createElement("input");
            cartItemId.setAttribute("type", "hidden");
            cartItemId.setAttribute("name", "cartItemId");
            cartItemId.setAttribute("value", $(this).data('cartitemid-info'));
            newForm.appendChild(cartItemId);

            document.body.appendChild(newForm);
            newForm.submit();

            

        });
    
        $('.deleteCartItemAll-Btn').on('click', function() {
            let cartItemListLen = $(this).data('cartitemlist-info');
           if(cartItemListLen.length == 0){
                alert("장바구니에 삭제할 상품이 존재 하지 않습니다.");
                return;
           };
  

            var cartItemIdList = new Array();
            <c:forEach items="${cartTableDTO.getCartItemList()}" var="cartItem">
                cartItemIdList.push("${cartItem.getId()}");
            </c:forEach>


            $.ajax({
			type:"post"
			, url:"/cart/deleteCartItemAll"
            ,traditional: true
			, data:{
                "cartItemIdList": cartItemIdList,
                }
			, success:function(result) {
				if (result.status == "SUCCESS") {
                    alert(result.message);
					location.reload();
				} else {
					alert("해당상품을 장바구니에서 삭제했습니다.");
				}
			}
			, error:function(e) {
				alert("관리자에게 문의해주세요.");
			}
		});

        });
    
        $('.orderAll-Btn').on('click', function() {
           
           let cartItemListLen = $(this).data('cartitemlist-info');
           if(cartItemListLen.length == 0){
                alert("장바구니에 주문가능한 상품이 존재 하지 않습니다.");
                return;
           };
  
           
           $('#orderAllForm').submit()
    
            


        });

    });

</script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<!--주문내역 테이블-->
<div class="card mb-4">
    <div class="card-header">
        <i class="fas fa-table me-1"></i>
        주문내역
    </div>
    <div class="card-body">
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">상품이미지</th>
                    <th scope="col">상품 이름</th>
                    <th scope="col">주문금액</th>
                    <th scope="col">주문수량</th>
                    <th scope="col">주문일자</th>
                    <th scope="col">주문번호</th>
                    <th scope="col">주문상태</th>
                    <th scope="col">주문취소</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="orderTableDTO" items="${orderTableDTOList}" varStatus="status">
                    <c:set var="productList" value="${orderTableDTO.getProduct()}"></c:set>
                    <c:set var="orderItem" value="${orderTableDTO.getOrderItem()}"></c:set>    
                    <tr>
                        <c:forEach var="product" items="${productList}" varStatus="status">
                            <tr> 
                                <td>
                                    <a style="text-decoration-line : none" href="/productDetail/${product.getItem().getId()}">
                                    <img src="${product.getThumnail()}" class="img-thumbnail" style="height: 150px;">
                                    </a>
                                </td>
                                <td class="align-middle">${product.getItem().getName()}</td>
                                <td class="align-middle">${orderItem[status.index].getOrderPrice()}원</td>
                                <td class="align-middle">${orderItem[status.index].getOrderCount()}개</td>
                                <td class="align-middle"><fmt:formatDate value="${orderTableDTO.getOrders().getCreatedAt()}" pattern="yyyy-MM-dd"/></td>
                                <td class="align-middle">${orderTableDTO.getOrders().getId()}</td>
                                <td class="align-middle">
                                    <c:choose>
                                        <c:when test="${orderTableDTO.getOrders().getStatus()  eq 'ORDER'}">
                                            <div><i class="fa-solid fa-check"></i> 주문완료</div>
                                            <c:choose>
                                                <c:when test="${orderTableDTO.getDelivery().getStatus() eq 'READY'}">
                                                    <i class="fa-solid fa-truck-ramp-box"></i> 배송준비중 
                                                    <td class="align-middle">
                                                        <button type="button" class="deleteOrder-Btn btn btn-danger" data-orderitem-info="${orderItem[status.index].getId()}" data-orders-info="${orderTableDTO.getOrders().getId()}" data-delivery-info="${orderTableDTO.getDelivery().getId()}">
                                                        <i class="fa-sharp fa-solid fa-trash"></i> 주문취소</button>
                                                    </td>
                                                </c:when>
                                                <c:when test="${orderTableDTO.getDelivery().getStatus() eq 'ONWAY'}">
                                                    <i class="fa-solid fa-truck-arrow-right"></i> 배송중
                                                    <td class="align-middle">
                                                        주문취소불가
                                                    </td>
                                                </c:when>
                                                <c:when test="${orderTableDTO.getDelivery().getStatus() eq 'COMPLETE'}">
                                                    <i class="fa-solid fa-check"></i> 배송완료
                                                    <td class="align-middle">
                                                        주문취소불가
                                                    </td>        
                                                </c:when>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-solid fa-xmark"></i> 주문취소됨
                                            <td class="align-middle">
                                                <i class="fa-solid fa-xmark"></i> 주문취소됨</li>
                                            </td>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tr>
                </c:forEach>        
            </tbody>
        </table>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('.deleteOrder-Btn').on('click', function() {
            if(window.confirm("주문을 정말 취소하시겠습니까?")){
                let orderItemId = $(this).data('orderitem-info');
                let ordersId = $(this).data('orders-info');
                let deliveryId = $(this).data('delivery-info');
                $.ajax({
                type:"post"
                , url:"/order/cancelOrder"
                , data:{
                    "orderItemId":orderItemId,
                    "ordersId":ordersId,
                    "deliveryId":deliveryId
                    }
                , success:function(result) {
                    if (result.status == "SUCCESS") {
                        alert(result.message);
                        location.reload();
                    } else {
                        alert("상품취소에 실패했습니다");
                    }
                }
                , error:function(e) {
                    alert("관리자에게 문의해주세요.");
                }
                });
            }
        });
    });
</script>
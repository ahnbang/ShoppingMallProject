<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
    <head>
        <%@ include file="/WEB-INF/jsp/main/layouts/head.jsp" %>
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="/static/css/productDetail.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
        <script src="/static/js/productDetail.js"></script>
        <!-- Slider -->
        <script>
            $(document).ready(function(){
            $('.slider').bxSlider();
            });
        </script>
    </head>
    <body>
        <!--Navigation-->    
        <%@ include file="/WEB-INF/jsp/main/layouts/nav.jsp" %>
        <!-- Product section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="row gx-4 gx-lg-5 align-items-center">
                    <div class="col-md-6  ">
                        <div class="slider">
                            <c:forEach var="imageList" items="${product.getImages()}">
                                <img class ="card-img-top mb-5 mb-md-0" src="${imageList.getSaveName()}" alt="...">
                            </c:forEach>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <c:set var="Item" value="${product.getItem()}"></c:set>
                        <c:set var="discountRatio" value="${loginMember.getRole().getDiscountRatio()}"></c:set>
                        <div class="small mb-1">SKU: ${Item.getId()}</div>
                        <h1 class="display-5 fw-bolder">${Item.getName()}</h1>
                        <div class="fs-5 mb-5">

                            <c:set var="price" value="${Item.getPrice()}"></c:set>
                            <c:set var="discountedPrice" value="${price - (price*discountRatio)}"></c:set>
                            <c:choose>
                                <c:when  test="${not empty loginMember}">
                                <span class="text-decoration-line-through"><fmt:formatNumber value="${price}"/> 원<br></span>
                                <span><fmt:formatNumber value="${discountedPrice}"/> 원</span>
                                </c:when>
                                <c:otherwise>
                                    <span><fmt:formatNumber value="${price}"/> 원<br></span>
                                </c:otherwise>
                            </c:choose>
                        </div>










                        <p class="lead">${Item.getContent()}</p>
                        <div class="d-flex">

                            <form class="order" id = "orderForm" action="/stockCheck" method="post">
                                <input class="form-control text-center me-3" id="orderCount" name="orderCount" type="num" value="1" style="max-width: 3rem" />
                               
                                <input type="hidden" name="itemId" id="itemId" value="${product.getItem().getId()}">
 
                                    <button class="btn btn-outline-dark flex-shrink-0" id="orderButton" type="submit">
                                        <i class="bi-cart-fill me-1"></i>
                                            바로 구매
                                    </button>
                            </form>

                        <script>

                            $(document).ready(function() {
                                $('#orderButton').on('click', function(e) {
                                    e.preventDefault(); 
                                    var orderCount = $('input[name=orderCount]').val().trim();
                                    if (orderCount <= 0 || orderCount ==""){
                                        alert("주문수량을 확인해 주세요");
                                        return;
                                    }

                                    var loginState = '<c:out value="${loginMember}"/>';
                                    if (loginState == ""){
                                        alert("로그인 이후 사용해주세요");
                                        return;
                                    }
                                    
                                    var orderCountLen = $("input[name=orderCount]").length;
                                    var orderCountList = new Array(orderCountLen);
                                    var itemIdList = new Array(orderCountLen);
        
		                            for(var i=0; i<orderCountLen; i++){                          
                                        orderCountList[i] = $("input[name=orderCount]").eq(i).val();
                                        itemIdList[i] = $("input[name=itemId]").eq(i).val();
                                        };

                                    
                                    $.ajax({
                                        url: "/stockCheck",
                                        traditional: true,
                                        data: {"itemIdList": itemIdList,
                                               "orderCountList": orderCountList},
                                        success: function(data) {
                                            if (data.status == "SUCCESS") {
                                                location.href="/orderCheck"; 
                                            } else {
                                                alert(data.data);

                                            }
                                        }
                                    }); 
                                });

                            });

                        </script>
                        
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Related items section-->
        <section class="py-5 bg-light">
            <div class="container px-4 px-lg-5 mt-5">
                <h2 class="fw-bolder mb-4">관련 제품</h2>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Fancy Product</h5>
                                    <!-- Product price-->
                                    $40.00 - $80.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">View options</a></div>
                            </div>
                        </div>
                    </div>
        </section>
        <!--Footer-->
        <%@ include file="/WEB-INF/jsp/main/layouts/footer.jsp" %>
    </body>
</html>

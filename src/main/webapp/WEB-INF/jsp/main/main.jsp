<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
    <head>
        <%@ include file="/WEB-INF/jsp/main/layouts/head.jsp" %>
    </head>
    <body>
        <!--Navigation-->    
        <%@ include file="/WEB-INF/jsp/main/layouts/nav.jsp" %>
        <!--Header-->
        <%@ include file="/WEB-INF/jsp/main/layouts/header.jsp" %>
        <!--Section-->
        
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <c:forEach var="product" items="${allProdcuts}">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="${product.getThumnail()}" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">${product.getItem().getName()}</h5>
                                    <!-- Product price-->
                                    ${product.getItem().getPrice()}&#8361;
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="/productDetail/${product.getItem().getId()}">상세보기</a></div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
               </div>    
            </div>
        </section>
        <!--Footer-->
        <%@ include file="/WEB-INF/jsp/main/layouts/footer.jsp" %>
    </body>
</html>

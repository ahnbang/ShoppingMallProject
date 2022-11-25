<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<div class="container-fluid px-4">
    <h1 class="mt-4">${loginMember.getName()}</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item active">${loginMember.getRole()}</li>
    </ol>
    <div class="row">
        <div class="col-xl-3 col-md-6">
            <div class="card bg-primary text-white mb-4">
                <div class="card-body">Primary Card</div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                    <a class="small text-white stretched-link" href="#">View Details</a>
                    <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card bg-warning text-white mb-4">
                <div class="card-body">Warning Card</div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                    <a class="small text-white stretched-link" href="#">View Details</a>
                    <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card bg-success text-white mb-4">
                <div class="card-body">Success Card</div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                    <a class="small text-white stretched-link" href="#">View Details</a>
                    <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card bg-danger text-white mb-4">
                <div class="card-body">Danger Card</div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                    <a class="small text-white stretched-link" href="#">View Details</a>
                    <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                </div>
            </div>
        </div>
    </div>





    <div class="card mb-4">
        <div class="card-header">
            <i class="fas fa-table me-1"></i>
            주문내역 조회
        </div>
        <div class="card-body">
            <table class="table">
                <thead>
                  <tr>
                    <th scope="col">상품정보</th>
                    <th scope="col">주문일자</th>
                    <th scope="col">주문번호</th>
                    <th scope="col">주문금액</th>
                    <th scope="col">주문수량</th>
                    <th scope="col">주문상태</th>
                    <th scope="col">주문취소</th>
                  </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <c:forEach var="orderitem" items="${orderItem[order.getId()]}">

                                <tr>
                                
                                <%-- 상품정보 --%>
                                <td>
                                    <table class="table table-borderless">
                                        <thead>
                                            <tr>
                                                <th scope="col"></th>
                                                <th scope="col"></th>
                                            </tr>
                                            <td><img src="${product[orderitem.getId()].getThumnail()}" class="img-thumbnail" alt="..." style="height: 100px;"></td>
                                            <td class="align-middle">${product[orderitem.getId()].getItem().getName()}</td>
                                            
                                        </thead>
                                    </table>
                                </td>

                                <td class="align-middle">${order.getCreatedAt()}</td>
                                <td class="align-middle">${order.getId()}</td>
                                <td class="align-middle">@test</td>
                                <td class="align-middle">@test</td>
                                <td class="align-middle">@test</td>
                                <td class="align-middle">@test</td>


                                </tr>

                        </c:forEach>
                    </c:forEach>
                </tbody>
              </table>
           
            
        </div>
    </div>
</div>
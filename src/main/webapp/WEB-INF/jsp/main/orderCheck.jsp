<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <!DOCTYPE html>

        <head>
          <%@ include file="/WEB-INF/jsp/main/layouts/head.jsp" %>
            <!-- Core theme CSS (includes Bootstrap)-->
            <link href="/static/css/orderCheck.css" rel="stylesheet" />
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
            <script src="/static/js/productDetail.js"></script>
            <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
            <script>
              window.onload = function () {
                document.getElementById("addressKakao").addEventListener("click", function () { //주소입력칸을 클릭하면
                  //카카오 지도 발생
                  new daum.Postcode({
                    oncomplete: function (data) { //선택시 입력값 세팅
                      document.getElementById("addressKakao").value = data.address; // 주소 넣기
                      document.querySelector("input[name=addressDetail]").focus(); //상세입력 포커싱
                    }
                  }).open();
                });
              }
            </script>
        </head>
        <div class="container">
          <div class="title">
            <h2>주문서 작성</h2>
          </div>
          <div class="d-flex">
            <form id="orderForm" name="orderForm">
              <div>
                <span class="fname">수령인 </span>
                <span style="margin: 130px ;">${loginMember.getName()} </span>
              </div>
              <div>
                <span class="fname">연락처 </span>
                <span style="margin: 130px ;">${loginMember.getEmail()} </span>
              </div>
              <label>
                <span class="fname">배송지 주소 <span class="required">*</span></span>
                <input type="text" id="addressKakao" name="address" value="${loginMember.getAddress()}">
              </label>
              <label>
                <span class="fname">상세 주소 <span class="required">*</span></span>
                <input type="text" id="addressDetail" name="addressDetail">
                <c:forEach var="itemId" items="${itemIdList}">
                  <input type="hidden" name="itemId" value="${itemId}">
                </c:forEach>
                <c:forEach var="orderCount" items="${orderCountList}">
                  <input type="hidden" name="orderCount" value="${orderCount}">
                </c:forEach>
                <c:forEach var="cartItemId" items="${cartItemId}">
                  <input type="hidden" name="cartItemIdList" value="${cartItemId}">
                </c:forEach>
                
              </label>
            </form>
            <div class="Yorder">
              <table>
                <tr>
                  <th colspan="2">주문 내역</th>
                </tr>
                <c:forEach var="product" items="${productList}" varStatus="status">
                  <tr>
                    <td>${product.getItem().getName()} x ${orderCountList[status.index]}(개)</td>
                    <td>
                      <fmt:formatNumber value="${product.getItem().getPrice() * orderCountList[status.index]}" /> 원
                    </td>
                  </tr>
                </c:forEach>
                <tr>
                  <td>주문금액</td>
                  <td>
                    <fmt:formatNumber value="${totalPrice}" /> 원
                  </td>
                </tr>
              </table><br>
              <div>
                <td>결제 방식 선택</td>
              </div>
              <div>
                <input type="radio" name="dbt" value="dbt" checked> 무통장 입금
              </div>
              <p>
                무통장 입금시 원활한 배송을 위해 송금인에 로그인 아이디를 기재해주시길 바랍니다.
              </p>
              <div>
                <input type="radio" name="dbt" value="cd"> Paypal <span>
                  <img src="https://www.logolynx.com/images/logolynx/c3/c36093ca9fb6c250f74d319550acac4d.jpeg" alt=""
                    width="50">
                </span>
              </div>
              <button id="orderButton" name="orderButton">주문하기</button>
              <script>
                $(document).ready(function () {
                  $('#orderButton').on('click', function (e) {

                    e.preventDefault();
                    var itemIdListLen = '<c:out value="${fn:length(itemIdList)}"/>';
                    var orderCountList = new Array(itemIdListLen);
                    var itemIdList = new Array(itemIdListLen);
                    var cartItemIdList = new Array(itemIdListLen);

                    for (var i = 0; i < itemIdListLen; i++) {
                      orderCountList[i] = $("input[name=orderCount]").eq(i).val();
                      itemIdList[i] = $("input[name=itemId]").eq(i).val();
                      cartItemIdList[i] = $("input[name=cartItemIdList]").eq(i).val();
                    };
                    
                    var address = $('input[name=address]').val()
                    var addressDetail = $('input[name=addressDetail]').val()
                   
    
                    
  
                    $.ajax({
                      url: "/order/createOrder",
                      type: "post",
                      traditional: true,
                      data: {
                        "itemIdList": itemIdList,
                        "orderCountList": orderCountList,
                        "address": address,
                        "addressDetail": addressDetail,
                        "cartItemIdList":cartItemIdList

                      },
                      success: function (data) {
                        if (data.status == "SUCCESS") {
                          alert(data.message);
                          location.href="/main"; 
                        } else {
                          alert(data.data);

                        }
                      }
                    });
                  });

                });
              </script>
            </div><!-- Yorder -->
          </div>
        </div>
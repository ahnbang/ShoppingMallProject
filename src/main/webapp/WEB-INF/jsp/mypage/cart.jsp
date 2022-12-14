<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
  <%@ include file="/WEB-INF/jsp/mypage/layouts/head.jsp" %>
</head>

<body class="sb-nav-fixed">
  <%@ include file="/WEB-INF/jsp/mypage/layouts/nav.jsp" %>
  <main>
    <div class="container-fluid px-4">
        <h1 class="mt-4">${loginMember.getName()}님</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item active">${loginMember.getRole()}</li>
        </ol>
        <!-- 장바구니 테이블 -->
        <%@ include file="/WEB-INF/jsp/mypage/cartTable.jsp" %>

    </div>
  </main>
  <footer class="py-4 bg-light mt-auto">
    <%@ include file="/WEB-INF/jsp/mypage/layouts/footer.jsp" %>
  </footer>
</body>
</html>       
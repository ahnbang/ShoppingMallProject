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
    <%@ include file="/WEB-INF/jsp/mypage/mainContent.jsp" %>
  </main>
  <footer class="py-4 bg-light mt-auto">
    <%@ include file="/WEB-INF/jsp/mypage/layouts/footer.jsp" %>
  </footer>
</body>
</html>       
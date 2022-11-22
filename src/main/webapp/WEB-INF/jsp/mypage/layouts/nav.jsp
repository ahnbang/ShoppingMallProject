<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="sb-topnav navbar navbar-expand navbar-light bg-light">
    <!-- Sidebar Toggle Button-->
    <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
    <!-- Navbar-->
    <div class="container px-4 px-lg-5">
      <a class="navbar-brand" href="/main">TerzoBang</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
              <li class="nav-item"><a class="nav-link active" aria-current="page" href="#!">About</a></li>
              <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Shop</a>
                  <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                      <li><a class="dropdown-item" href="#!">All Products</a></li>
                      <li><hr class="dropdown-divider" /></li>
                      <li><a class="dropdown-item" href="#!">Popular Items</a></li>
                      <li><a class="dropdown-item" href="#!"></a></li>
                  </ul>
              </li>
              <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Man</a>
                  <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                      <li><a class="dropdown-item" href="#!">All Product</a></li>
                      <li><hr class="dropdown-divider" /></li>
                      <li><a class="dropdown-item" href="#!">cloth</a></li>
                      <li><a class="dropdown-item" href="#!">shoes</a></li>
                      <li><a class="dropdown-item" href="#!">bag</a></li>
                      <li><a class="dropdown-item" href="#!"></a></li>
                  </ul>
              </li>
              <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Female</a>
                  <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                      <li><a class="dropdown-item" href="#!">All Product</a></li>
                      <li><hr class="dropdown-divider" /></li>
                      <li><a class="dropdown-item" href="#!">cloth</a></li>
                      <li><a class="dropdown-item" href="#!">shoes</a></li>
                      <li><a class="dropdown-item" href="#!">bag</a></li>
                      <li><a class="dropdown-item" href="#!"></a></li>
                  </ul>
              </li>
          </ul>  
          
          <!-- 우측 버튼 그룹 -->
          <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
              
              <!-- 비회원 접속 -->
              <c:if test = "${empty loginMember}">

                  <button type="button" class="btn btn-outline-dark" onclick="location.href='/member/signInView'">
                      <i class="fa-solid fa-solid fa-right-to-bracket  fa-fade" style="--fa-animation-duration: 2s; --fa-fade-opacity: 0.6;" ></i>
                      로그인/회원가입
                  </button>
                  
              </c:if>

              <!-- 회원 접속 -->
              <c:if test = "${not empty loginMember and loginMember.getRole() == 'USER'}">                
                  <button type="button" class="btn btn-outline-dark dropdown-toggle" data-bs-toggle="dropdown" data-bs-auto-close="true" aria-expanded="true">
                      <i class="bi bi-person-circle"></i>
                      <c:out value="${loginMember.getName()}"></c:out>
                      <span class="visually-hidden">Toggle Dropdown</span>
                  </button>
                      <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="#"><i class="fa-solid fa-address-card"></i>
                      마이페이지</a></li>
                  <li><a class="dropdown-item" href="#"><i class="fa-solid fa-user-gear"></i>
                      회원정보 수정</a></li>
                  <li><a class="dropdown-item" href="#"><i class="bi-cart-fill me-1"></i>
                      장바구니
                      <span class="text-black "></span></a></li>
                  <li><hr class="dropdown-divider"></li>
                  <li><a class="dropdown-item" href="/member/signOut"><i class="fa-solid fa-person-through-window fa-fade" style="--fa-animation-duration: 2s; --fa-fade-opacity: 0.6;" ></i>
                      LogOut</a></li>
                  </ul>
              </c:if>

              <!-- 관리자 접속 --> 
              <c:if test = "${not empty loginMember and loginMember.getRole() == 'ADMIN'}">       
                  <button type="button" class="btn btn-outline-dark dropdown-toggle" data-bs-toggle="dropdown" data-bs-auto-close="true" aria-expanded="true">
                      <i class="bi bi-person-badge"></i>
                      <c:out value="${loginMember.getName()}"></c:out>
                      <span class="visually-hidden">Toggle Dropdown</span>
                  </button>
                  <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="/admin/main"><i class="fa-solid fa-cog fa-spin"></i>
                      관리자 페이지</a></li>
                  <li><a class="dropdown-item" href="#"><i class="fa-solid fa-circle-plus"></i>
                      상품 등록 - 개발용 기능</a></li>
                  <li><hr class="dropdown-divider"></li>
                  <li><a class="dropdown-item" href="/member/signOut"><i class="fa-solid fa-person-through-window fa-fade" style="--fa-animation-duration: 2s; --fa-fade-opacity: 0.6;" ></i>
                      LogOut</a></li>
                  </ul>
              </c:if>
          </div>  
      </div>
  </div>
    
</nav>

<div id="layoutSidenav">
    <div id="layoutSidenav_nav">
        <nav class="sb-sidenav accordion sb-sidenav-light" id="sidenavAccordion">
            <div class="sb-sidenav-menu">
                <div class="nav">
                    
                    <a class="nav-link" href="charts.jsp">
                        <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                        주문내역
                    </a>

                    <a class="nav-link" href="tables.jsp">
                        <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                        Tables
                    </a>







                </div>
            </div>
            <div class="sb-sidenav-footer">
                <div class="small">Logged in as:</div>
                Start Bootstrap
            </div>
        </nav>
    </div>
    <div id="layoutSidenav_content">
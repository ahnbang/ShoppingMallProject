<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
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
          
          <!-- ?????? ?????? ?????? -->
          <div class="btn-group" role="group" aria-label="Button group with nested dropdown">
              
              <!-- ????????? ?????? -->
              <c:if test = "${empty loginMember}">

                  <button type="button" class="btn btn-outline-dark" onclick="location.href='/member/signInView'">
                      <i class="fa-solid fa-solid fa-right-to-bracket  fa-fade" style="--fa-animation-duration: 2s; --fa-fade-opacity: 0.6;" ></i>
                      ?????????/????????????
                  </button>
                  
              </c:if>

              <!-- ?????? ?????? -->
              <c:if test = "${not empty loginMember and loginMember.getRole() == 'USER'}">                
                  <button type="button" class="btn btn-outline-dark dropdown-toggle" data-bs-toggle="dropdown" data-bs-auto-close="true" aria-expanded="true">
                      <i class="bi bi-person-circle"></i>
                      <c:out value="${loginMember.getName()}"></c:out>
                      <span class="visually-hidden">Toggle Dropdown</span>
                  </button>
                      <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="/mypage/main"><i class="fa-solid fa-address-card"></i>
                      ???????????????</a></li>
                  <li><a class="dropdown-item" href="#"><i class="fa-solid fa-user-gear"></i>
                      ???????????? ??????</a></li>
                  <li><a class="dropdown-item" href="/mypage/cart"><i class="fa-solid fa-cart-shopping"></i>
                      ????????????
                      <span class="text-black "></span></a></li>
                    <li><a class="dropdown-item" href="/mypage/cart"><i class="fas fa-table me-1"></i>
                      ????????????
                    <span class="text-black "></span></a></li>  
                  <li><hr class="dropdown-divider"></li>
                  <li><a class="dropdown-item" href="/member/signOut"><i class="fa-solid fa-person-through-window fa-fade" style="--fa-animation-duration: 2s; --fa-fade-opacity: 0.6;" ></i>
                      LogOut</a></li>
                  </ul>
              </c:if>

              <!-- ????????? ?????? --> 
              <c:if test = "${not empty loginMember and loginMember.getRole() == 'ADMIN'}">       
                  <button type="button" class="btn btn-outline-dark dropdown-toggle" data-bs-toggle="dropdown" data-bs-auto-close="true" aria-expanded="true">
                      <i class="bi bi-person-badge"></i>
                      <c:out value="${loginMember.getName()}"></c:out>
                      <span class="visually-hidden">Toggle Dropdown</span>
                  </button>
                  <ul class="dropdown-menu">
                  <li><a class="dropdown-item" href="/admin/main"><i class="fa-solid fa-cog fa-spin"></i>
                      ????????? ?????????</a></li>
                  <li><a class="dropdown-item" href="#"><i class="fa-solid fa-circle-plus"></i>
                      ?????? ?????? - ????????? ??????</a></li>
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

                    <a class="nav-link" href="/mypage/main">
                        <div class="sb-nav-link-icon"><i class="fa-solid fa-rotate-left"></i></div>
                        ???????????????  
                    </a>

                    <a class="nav-link" href="/mypage/orderhistory">
                        <div class="sb-nav-link-icon"><i class="fas fa-table me-1"></i></div>
                        ?????? ?????? ??????
                    </a>

                    <a class="nav-link" href="/mypage/cart">
                        <div class="sb-nav-link-icon"><i class="fa-solid fa-cart-shopping"></i></div>
                        ????????????
                    </a>
                    
                    <a class="nav-link" href="/mypage/memberUpdateView">
                        <div class="sb-nav-link-icon"><i class="fa-solid fa-user-pen"></i></div>
                        ???????????? ??????
                    </a>

                    <a class="nav-link" href="/mypage/claimView">
                        <div class="sb-nav-link-icon"><i class="fa-solid fa-circle-exclamation"></i></div>
                        ????????????
                    </a>
                </div>
            </div>
            <div class="sb-sidenav-footer">
                <div class="small">?????? ??????:</div>
                ahn.bangplo@gmail.com
            </div>
        </nav>
    </div>
    <div id="layoutSidenav_content">
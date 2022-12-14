<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
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
                    <li><a class="dropdown-item" href=""><i class="fa-solid fa-user-gear"></i>
                        ???????????? ??????</a></li>
                    <li><a class="dropdown-item" href="#"><i class="bi-cart-fill me-1"></i>
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
                    <li><a class="dropdown-item" href="/admin/createProductView"><i class="fa-solid fa-circle-plus"></i>
                        ?????? ??????</a></li>
                    <li><a class="dropdown-item" href="/admin/readProductView"><i class="fa-solid fa-magnifying-glass"></i>
                        ?????? ??????</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="/member/signOut"><i class="fa-solid fa-person-through-window fa-fade" style="--fa-animation-duration: 2s; --fa-fade-opacity: 0.6;" ></i>
                        LogOut</a></li>
                    </ul>
                </c:if>
            </div>  
        </div>
    </div>
</nav>

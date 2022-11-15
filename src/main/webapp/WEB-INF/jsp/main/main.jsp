<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Shop Homepage - Start Bootstrap Template</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="/static/assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="/static/css/main.css" rel="stylesheet" />
        <script src="https://kit.fontawesome.com/ed1d3e2a99.js" crossorigin="anonymous"></script>
    </head>

    <body>    

        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="/main">TerzoBang</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="#!">test</a></li>
                        <li class="nav-item"><a class="nav-link" href="#!">About</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Shop</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="#!">All Products</a></li>
                                <li><hr class="dropdown-divider" /></li>
                                <li><a class="dropdown-item" href="#!">Popular Items</a></li>
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
                                로그인
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
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">Shop in style</h1>
                    <p class="lead fw-normal text-white-50 mb-0">With this shop hompeage template</p>
                </div>
            </div>
        </header>
        <!-- Section-->
        
            
            
            
        
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

         
        
        <!-- Footer-->
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2022</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="/static/js/main.js"></script>
    </body>
</html>

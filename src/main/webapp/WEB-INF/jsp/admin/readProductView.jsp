<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/admin/layouts/head.jsp" %>
<%@ include file="/WEB-INF/jsp/admin/layouts/nav.jsp" %>
<!-- 상품성별, item's sex enum 사용하기 위해 java에서 직접 import  -->
<%@ page import="com.terzobang.product.model.*" %>
<!DOCTYPE html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
    integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<script>
    $(document).ready(function () {
        $('.btn-check').on('click', function() {
            $('#tableBody').empty();
            var chekedValue = $('.btn-check:checked').val(); 
            $.ajax({
                url: "/admin/readProductView/selectCategoryAjax",
                type: "POST",
                data: {category : chekedValue},
                success: function(result){
                    $("#productViewTable").html(result)
                }
            });
        });   
    });      
</script>
<script>
    $(document).ready(function () {$('#btnradio1').click()});
</script>
<main>
    <div class="container-fluid px-4">
        <h1 class="mt-4">상품 조회</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item active">
                Access Member : <i class="fa-solid fa-id-badge"></i> ${loginMember.getName()}</li>
        </ol>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fa-solid fa-magnifying-glass"></i>
                상품조회
            </div>
            
            <div class="card-body">
            
                <div class="btn-group d-grid gap-2 d-md-flex justify-content-md-end" role="group" aria-label="Basic radio toggle button group">
                    <input type="radio" class="btn-check" name="chekedValue" id="btnradio1" value="ALL" autocomplete="off">
                    <label class="btn btn-outline-primary" for="btnradio1"><i class="fa-sharp fa-solid fa-border-all"></i> 전체 상품 조회</label>
                  
                    <input type="radio" class="btn-check" name="chekedValue" id="btnradio2" value="CLOTH" autocomplete="off">
                    <label class="btn btn-outline-primary" for="btnradio2">카테고리 : <i class="fa-solid fa-shirt"></i> (옷)</label>
                  
                    <input type="radio" class="btn-check" name="chekedValue" id="btnradio3" value="SHOES" autocomplete="off">
                    <label class="btn btn-outline-primary" for="btnradio3">카테고리 : <i class="fa-solid fa-shoe-prints"></i> (신발)</label>
                    

                    <input type="radio" class="btn-check" name="chekedValue" id="btnradio4" value="BAG" autocomplete="off">
                    <label class="btn btn-outline-primary" for="btnradio4">카테고리 : <i class="fa-solid fa-bag-shopping"></i> (가방)</label>
                </div>
    
                <hr>
                <div id="productViewTable">
                </div>
            </div>
        </div>
    </div>
</main>


<%@ include file="/WEB-INF/jsp/admin/layouts/footer.jsp" %>
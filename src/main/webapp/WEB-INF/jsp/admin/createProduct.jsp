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
<link rel="stylesheet" href="/static/css/imageUpload.css">

<main>
    <div class="container-fluid px-4">
        <h1 class="mt-4">상품 등록</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item active">
                Access Member : <i class="fa-solid fa-id-badge"></i> ${loginMember.getName()}</li>
        </ol>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fa-solid fa-upload"></i>
                상품등록
            </div>
            <div class="card-body">
                <form id="addProductForm" name="addProductForm" class="form-horizontal" action="/admin/addProduct"
                    method="post" enctype="multipart/form-data">
                    <!-- 상품 성별  -->
                    <div class="form-group m-3">
                        <label class="col-sm-1 control-label"><i class="fa-regular fa-square"> <b>상품
                                    성별</b></i></label>

                        <label class="radio-inline">
                            <input type="radio" name="sex" id="genderOptionMale" value="${ItemSex.MALE}"> 남성
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="sex" id="genderOptionFemale" value="${ItemSex.FEMALE}"> 여성
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="sex" id="genderOptionUnisex" value="${ItemSex.UNISEX}"> 남녀공용
                        </label>

                    </div>
                    <!-- 상품 카테고리  -->
                    <div class="form-group m-3">
                        <label class="col-sm-3 control-label"><i class="fa-regular fa-square"> <b>상품
                                    카테고리</b></i></label>
                        <div class="col-sm-3">
                            <select class="form-control" name="category">
                                <option value="${ItemCategory.CLOTH}">옷</option>
                                <option value="${ItemCategory.SHOES}">신발</option>
                                <option value="${ItemCategory.BAG}">가방</option>
                            </select>
                        </div>
                    </div>

                    <!-- 상품 제목  -->
                    <div class="form-group m-3">
                        <label class="col-sm-1 control-label"><i class="fa-regular fa-square">
                                <b>상품명</b></i></label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="name" id="name" placeholder="상품명">
                        </div>
                    </div>

                    <!-- 상품 사이즈  -->
                    <div class="form-group m-3">
                        <label class="col-sm-3 control-label"><i class="fa-regular fa-square"> <b>상품
                                    사이즈</b></i></label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="size" name="size"
                                placeholder="사이즈가 여러개면 ',' 구분하여 띄어쓰기 없이 입력하세요">
                        </div>
                    </div>

                    <!-- 상품 카테고리 -->
                    <div class="form-group m-3">
                        <label class="col-sm-3 control-label"><i class="fa-regular fa-square"> <b>상품
                                    설명</b></i></label>
                        <div class="col-sm-9">
                            <textarea class="form-control" type="text" id="content" name="content"></textarea>
                        </div>
                    </div>

                    <!-- 상품 가격 -->
                    <div class="form-group m-3">
                        <label class="col-sm-3 control-label"><i class="fa-regular fa-square">
                                <b>판매가격</b></i></label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="price" id="price"
                                placeholder="판매할 상품의 가격을 입력하세요">
                        </div>
                    </div>

                    <!-- 상품 재고 -->
                    <div class="form-group m-3">
                        <label class="col-sm-3 control-label"><i class="fa-regular fa-square"> <b>상품
                                    재고</b></i></label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="stock" id="stock"
                                placeholder="판매할 상품의 재고를 입력하세요">
                        </div>
                    </div>

                    <div class="form-group m-3">
                        <label for="name" class="col-sm-3 control-label"><i class="fa-regular fa-square">
                                <b>상품이미지</b></i></label>
                        <div class="col-sm-3">
                            <div>
                                <label class="control-label small">이미지는 최대 6장 까지 업로드 가능합니다.</label>
                            </div>
                            <div>
                                <label class="control-label small">이미가 여러개면 첫번째 이미지가 썸네일로
                                    지정됩니다.</label>
                            </div>
                            <label class="control-label small">업로드 가능 유형</label>
                            (jpg/png):</label> <input type="file" class="form-control" id="images" name="images"
                                multiple='multiple'>
                        </div>
                        <hr>
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-9">
                                <button id="addProductBtn" name="addProductBtn" class="btn btn-primary">상품 등록</button>
                            </div>
                        </div>
                </form>
            </div>
        </div>
    </div>
</main>
<!--이미지 업로드 스크립트-->>
<script>
    function getImageFiles(e) {
        const uploadFiles = [];
        const files = e.currentTarget.files;
        const imagePreview = document.querySelector('.image-preview');
        const docFrag = new DocumentFragment();

        if ([...files].length >= 7) {
            alert('이미지는 최대 6개 까지 업로드가 가능합니다.');
            return;
        }

        // 파일 타입 검사
        [...files].forEach(file => {
            if (!file.type.match("image/.*")) {
                alert('이미지 파일만 업로드가 가능합니다.');
                return
            }

            // 파일 갯수 검사
            if ([...files].length < 7) {
                uploadFiles.push(file);
                const reader = new FileReader();
                reader.onload = (e) => {
                    const preview = createElement(e, file);
                    imagePreview.appendChild(preview);
                };
                reader.readAsDataURL(file);
            }
        });
    }

    function createElement(e, file) {
        const li = document.createElement('li');
        const img = document.createElement('img');
        img.setAttribute('src', e.target.result);
        img.setAttribute('data-file', file.name);
        li.appendChild(img);

        return li;
    }

    const realUpload = document.querySelector('.real-upload');
    const upload = document.querySelector('.upload');

</script>

<!--Empty Vaildatoin-->>
<script>
    $(document).ready(function () {
        $('#addProductBtn').on('click', function (e) {
            e.preventDefault();
            //상품명 공백 확인

            var radioCheck = $('input:radio[name=sex]').is(':checked');
            if(radioCheck == false){
                alert("상품 성별을 선택해주세요")
                return;
            }
           
            var name = $('input[name=name]').val().trim();
            if (name == '') {
                alert("상품명을 입력하세요");
                return;
            }
            // 상품 사이즈 공백확인
            var size = $('input[name=size]').val().trim();
            if (size == '') {
                alert("상품 사이즈를 입력하세요");
                return;
            }
            // 상품 내용 공백 확인
            var content = $('textarea[name=content]').val().trim();
            if (content == '') {
                alert("상품 내용을 입력하세요");
                return;
            }

            // 상품 가격 공백 확인
            var price = $('input[name=price]').val().trim();
            if (price == '') {
                alert("상품 가경을 입력하세요.");
                return;
            }
            // 상품 재고 공백 확인
            var stock = $('input[name=stock]').val().trim();
            if (stock == '') {
                alert("상품 재고를 입력하세요");
                return;
            }
            // 상세 이미지 업로드 확인
            var images = $('input[name=images]').val().trim();
            if (images == '') {
                alert("상품 이미지를 등록하세요");
                return;
            }

            $('#addProductForm').submit();


        })
    });
</script>

<%@ include file="/WEB-INF/jsp/admin/layouts/footer.jsp" %>
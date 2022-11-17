<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/jsp/admin/layouts/head.jsp" %>
<%@ include file="/WEB-INF/jsp/admin/layouts/nav.jsp" %>
<%@ page import="com.terzobang.product.model.*" %>
<link rel="stylesheet" href="/static/css/imageUpload.css">

<main>

        
    
    <div class="jumbotron">
            <div class="container">
                <h1 class="display-3">
                    상품 등록
                </h1>
            </div>
    </div>
        
        <div class="container">
            
            <form name="newProduct" action="/admin/addProduct" class="form-horizontal" method="post" 
            enctype="multipart/form-data">
            
                
                <div class="form-group row">
                    <label class="col-sm-2">상품 제목</label>
                    <div class="com-sm-3">
                        <input type="text" id="productId" name="name" class="form-control">
                    </div>
                </div>
                
                <div class="form-group row">
                    <label class="col-sm-2">상품 설명</label>
                    <div class="com-sm-3">
                        <input type="text" id="name" name="content" class="form-control">
                    </div>
                </div>

             
                
                <div class="form-group row">
                    <label class="col-sm-2"></label>
                    <div class="com-sm-3">
                        <select name="category"><br>

                           
                            
                            <option value= "${ItemCategory.CLOTH}">옷</option>
                            <option value= "${ItemCategory.SHOES}">신발</option>
                            <option value= "${ItemCategory.BAG}">가방</option>
                            

                        </select>
                    </div>
                </div>
                
                <div class="form-group row">
                    <label class="col-sm-2">판매 대상 성별</label>
                    <div class="com-sm-5">
                        <select name="sex"><br>
                            <option value="${ItemSex.MALE}">남자</option>
                            <option value="${ItemSex.FEMALE}">여자</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group row">
                    <label class="col-sm-2">사이즈</label>
                    <div class="com-sm-3">
                        <input type="text" name="size" class="form-control">
                    </div>
                </div>
                
                <div class="form-group row">
                    <label class="col-sm-2">가격</label>
                    <div class="com-sm-3">
                        <input type="text" name="price" class="form-control">
                    </div>
                </div>
                
                <div class="form-group row">
                    <label class="col-sm-2">재고 수</label>
                    <div class="com-sm-3">
                        <input type="text" id="unitsInStock" name="stock" class="form-control">
                    </div>
                </div>
                
                
                
                <input type="file" name="images" multiple='multiple'>

                    
                <div class="form-group row">
                    <div class="col-sm-offset-2 col-sm-10">
                        <input type="submit" class="btn btn-primary" value="등록" onclick="CheckAddProduct()">
                    </div>
                </div>
                
    
        
        </div>

    </form>


</main>
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

    upload.addEventListener('click', () => realUpload.click());

    realUpload.addEventListener('change', getImageFiles);
  </script>

<%@ include file="/WEB-INF/jsp/admin/layouts/footer.jsp" %>
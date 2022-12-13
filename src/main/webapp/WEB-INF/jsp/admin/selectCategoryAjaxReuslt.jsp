<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.terzobang.product.model.*" %>
<!DOCTYPE html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
    integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    


<div class="card-body">
    <table class="table">
        <thead>
            <tr>
                <th scope="col">상품 이미지</th>
                <th scope="col">상품ID</th>
                <th scope="col">상품명</th>
                <th scope="col">상품가격</th>
                <th scope="col">상품재고 </th>
                <th scope="col">상품카테고리</th>
                <th scope="col">상품성별</th>
                <th scope="col">상품사이즈</th>
                <th scope="col">상품수정</th>
                <th scope="col">상품삭제</th>

                
            </tr>
        </thead>
        <tbody id="tBody">
            <c:forEach var="product" items="${productList}" varStatus="status">
                <c:set var="item" value="${product.getItem()}"></c:set>
            
                <tr>
                    <td>
                        <table class="table table-borderless">
                            <thead>
                                <tr>
                                    <th scope="col"></th>
                                    <th scope="col"></th>
                                </tr>
                                <td><img src="${product.getThumnail()}" class="img-thumbnail" alt="..." style="height: 200px;">
                                </td>
                                <td class="align-middle">
                                    </td>
                            </thead>
                        </table>
                    </td>
    
                        <td class="align-middle">${item.getId()}</td>
                        <td id="tdName" class="align-middle">${product.getItem().getName()}</td>
                        <td class="align-middle">${item.getPrice()}</td>
                        <td class="align-middle">${item.getStock()}</td>
                        <td class="align-middle">${item.getCategory()}</td>
                        <td class="align-middle">${item.getSex()}</td>
                        <td class="align-middle">${item.getSize()}</td>
                        <td class="align-middle"><button type="button" id="updateButton${status.index}" name="updateButton" class="btn btn-success" data-bs-toggle="modal"
                             data-bs-target="#editmodal${status.index}"> <i class="fa-sharp fa-solid fa-file-pen"></i> 수정</button></td>
                        <td class="align-middle"><button type="button" id="deleteButton${status.index}" name="deleteButton"
                             class="btn btn-danger" value="${item.getId()}"> <i class="fa-sharp fa-solid fa-trash"></i> 삭제</button></td>

                </tr>


                <div class="modal fade" id="editModal${status.index}" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-fullscreen">
                      <div class="modal-content">
                        <div class="modal-header">
                          <h1 class="modal-title fs-5" id="editModalLabel">${item.getName()}</h1>
                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="card-body">

                            
                                    <!-- 상품 성별  -->
                                    <div class="form-group m-3">
                                        <label class="col-sm-3 control-label"><i class="fa-regular fa-square"> <b>상품 성별</b></i></label>
                                    
                                                <label class="radio-inline">
                                                    <input type="radio" name="sex" id="maleGenderOptionMale${status.index}" value="${ItemSex.MALE}"> 남성
                                                </label>
                                                <label class="radio-inline">
                                                    <input type="radio" name="sex" id="maleGenderOptionFemale${status.index}" value="${ItemSex.FEMALE}"> 여성
                                                </label>
                                                <label class="radio-inline">
                                                    <input type="radio" name="sex" id="maleGenderOptionUnisex${status.index}" value="${ItemSex.UNISEX}"> 남녀공용
                                                </label>
                                                
                                    </div>
                                    <!-- 상품 카테고리  -->
                                    <div class="form-group m-3">
                                        <label class="col-sm-3 control-label"><i class="fa-regular fa-square"> <b>상품
                                                    카테고리</b></i></label>
                                        <div class="col-sm-3">
                                            <select class="form-control" name="category" id="category${status.index}">
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
                                            <input type="text" class="form-control" name="name" id="name${status.index}" placeholder="상품명" value="${item.getName()}">
                                        </div>
                                    </div>
                
                                    <!-- 상품 사이즈  -->
                                    <div class="form-group m-3">
                                        <label class="col-sm-3 control-label"><i class="fa-regular fa-square"> <b>상품
                                                    사이즈</b></i></label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" id="size${status.index}" name="size"
                                                placeholder="사이즈가 여러개면 ',' 구분하여 띄어쓰기 없이 입력하세요" value="${item.getSize()}">
                                        </div>
                                    </div>
                
                                    <!-- 상품 내용 -->
                                    <div class="form-group m-3">
                                        <label class="col-sm-3 control-label"><i class="fa-regular fa-square"> <b>상품
                                                    설명</b></i></label>
                                        <div class="col-sm-9">
                                            <textarea class="form-control" type="text" id="content${status.index}" name="content">${item.getContent()}</textarea>
                                        </div>
                                    </div>
                
                                    <!-- 상품 가격 -->
                                    <div class="form-group m-3">
                                        <label class="col-sm-3 control-label"><i class="fa-regular fa-square">
                                                <b>판매가격</b></i></label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" name="price" id="price${status.index}"
                                                placeholder="판매할 상품의 가격을 입력하세요" value="${item.getPrice()}">
                                        </div>
                                    </div>
                
                                    <!-- 상품 재고 -->
                                    <div class="form-group m-3">
                                        <label class="col-sm-3 control-label"><i class="fa-regular fa-square"> <b>상품
                                                    재고</b></i></label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" name="stock" id="stock${status.index}"
                                                placeholder="판매할 상품의 재고를 입력하세요" value="${item.getStock()}">
                                        </div>
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="button" id="modalSubmitButton${status.index}" class="btn btn-primary" value="${item.getId()}">Save changes</button>
                                    </div>

                            </div>
                        </div>
                
                      </div>
                    </div>
                </div>
    
                
            </c:forEach>
            
        </tbody>
    </table>

</div>



<script>
    $(document).ready(function () {
        $("button[id^='deleteButton']").on('click', function() {
            var value = $(this).val();
            alert(value);
            if (window.confirm("해당 상품의 데이터를 삭제하겠습니까?")){
            $.ajax({
                url: "/admin/deleteProduct/",
                type: "POST",
                data: {itemId : value},
                success: function(result){
                   alert(result.message)
                   if(result.status =="SUCCESS"){
                    location.reload();
                   }


                }
            });
        }
        else{
            return;
        }
        });
        
        $("button[id^='modalSubmitButton']").on('click', function() {
            var idValue = $(this).val();
            var modalIndex = $(this).attr("id").replace("modalSubmitButton",'');


            if($("input" +"[id=maleGenderOptionMale"+ modalIndex +"]:checked").val()){
                var sex = $("input" +"[id=maleGenderOptionMale"+ modalIndex +"]").val();
            }
            else if($("input" +"[id=maleGenderOptionFemale"+ modalIndex +"]:checked").val()){
                var sex = $("input" +"[id=maleGenderOptionFemale"+ modalIndex +"]").val();
            }
            else if($("input" +"[id=maleGenderOptionUnisex"+ modalIndex +"]:checked").val()){
                var sex = $("input" +"[id=maleGenderOptionUnisex"+ modalIndex +"]").val();
            }
            var stock = $("input" +"[id=stock"+ modalIndex +"]").val();
            var price = $("input" +"[id=price"+ modalIndex +"]").val();
            var content = $("textarea" +"[id=content"+ modalIndex +"]").val();
            var size = $("input" +"[id=size"+ modalIndex +"]").val();
            var name = $("input" +"[id=name"+ modalIndex +"]").val();
            var category = $("select" +"[id=category"+ modalIndex +"]").val();
            console.log(category);
            
            $.ajax({
                url: "/admin/updateProduct",
                type: "POST",
                data: {
                    itemId : idValue,
                    sex : sex,
                    stock : stock,
                    price : price,
                    content : content,
                    size : size,
                    name : name,
                    category : category
                },
                success: function(result){
                    alert(result.message);
                }
            });
            
            
        });
        
    });      
</script>
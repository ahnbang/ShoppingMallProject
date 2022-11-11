<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/static/css/signUpIn.css">
  <link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <title>sign_up</title>
</head>
 
<body>
  <div class="container">
    <div class="form">
      <div class="btn">
        <button class="signUpBtn">회원가입</button>
        <button class="loginBtn">로그인</button>
      </div>

      <%-- 회원가입 폼 --%>
      <form class = "signUpForm" id = "signUpForm" action="/member/signUp" method="post">

        <div class="formGroup">
          <input type="text"  placeholder="아이디" id="loginId" name="loginId" oninput="loginIdCheck()" required autocomplete="on">
        </div>
        <%-- 아이디 체크 결과 --%>
        <span id = "idCheckOk" class = "idCheckOk d-none"> 사용가능한 아이디 입니다.</span>
        <span id = "idCheckDuplicated" class = "idCheckDuplicated d-none">이미 사용중인 아이디입니다.</span>
        <span id = "idCheckLength" class = "idCheckLength d-none">아이디를 4자 이상 입력해주세요 </span>

        <div class="formGroup">
          <input type="password"  placeholder="비밀번호" name="password" required autocomplete="off">
        </div>
        <div class="formGroup">
          <input type="password"  placeholder="비밀번호 확인" name="confirmPassword" required autocomplete="off">
        </div>
        <div class="formGroup">
          <input type="text"  placeholder="이름" name="name" required autocomplete="on">
        </div>
        <div class="formGroup">
          <input type="email" placeholder="이메일" name="email" required autocomplete="on">
        </div>
        <div class="formGroup">
          <input type="text" placeholder="주소" id = "addressKakao" name="addressStreet" required autocomplete="on">
        </div>
        <div class="formGroup">
          <input type="text" placeholder="상세주소"  name="addressDetail" required autocomplete="on">
        </div>

        <div class="checkBox">
          <input type="checkbox" name="checkbox" id="checkbox">
          <span class="text">I agree with term & conditions</span>
        </div>

        <div class="formGroup">
          <button type="button" id="submitbtn" class="btn2">REGISTER</button>
        </div>
 
      </form>
        
      <%-- 로그인 폼 --%>
      <form class="login"  id = "logInForm"  action="/member/signIn" method="post">

        <div class="formGroup">
          <input type="text" placeholder="ID" name="loginIdForLogin" required autocomplete="on">
        </div>

        <div class="formGroup">
          <input type="password" name="passwordForLogin" placeholder="Password" required autocomplete="on">
        
        </div>
        <div class="checkBox">
          <input type="checkbox" name="checkbox" id="checkbox">
          <span class="text">Keep me signed in on this device</span>
        </div>

        <div class="formGroup">
          <button type="submit" id = "loginbtn2"  class="btn2">Login</button>
        </div>

       </form>
 
    </div>
  </div>

  <script>
  //회원가입, 로그인 SWAP
  $('.loginBtn').click(function(){
    $('.login').show();
    $('.signUpForm').hide();
    $('.loginBtn').css({'border-bottom' : '2px solid #ff4141'});
    $('.signUpBtn').css({'border-style' : 'none'});
  });
  //회원가입, 로그인 SWAP
  $('.signUpBtn').click(function(){
    $('.login').hide();
    $('.signUpForm').show();
    $('.signUpBtn').css({'border-bottom' : '2px solid #ff4141'});
    $('.loginBtn').css({'border-style' : 'none'});
  });
 
  // real-time 검증
  function loginIdCheck(){

    // 아이디 길이 검증
		var loginId = $('#loginId').val().trim();

    if (loginId.length < 4){
      $('.idCheckLength').css("display","inline-block").removeClass('d-none');
      $('.idCheckDuplicated').css("display", "none").addClass('d-none');
      $('.idCheckOk').css("display", "none").addClass('d-none');
      return;
    }
    else {
      $('.idCheckLength').css("display","none").removeClass('d-none');
      $('.idCheckDuplicated').css("display", "none").removeClass('d-none');
      $('.idCheckOk').css("display", "none").removeClass('d-none');
    }
		
    // 아이디 중복 검증
		$.ajax({
			url: "/member/vaildateDuplicateLoginId",
			data: {"loginId": loginId},
			success: function(data) {
				if (data.status == "FAIL") { // 중복인 경우
          $('.idCheckDuplicated').css("display","inline-block");
          $('.idCheckOk').css("display", "none");
          $('.idCheckLength').css("display","none");
          $('#loginId').val('');
				} else {
          $('.idCheckOk').css("display","inline-block"); 
          $('.idCheckDuplicated').css("display", "none");
          $('.idCheckLength').css("display","none");
				}
			},
			error: function(error) {
				alert("아이디 중복확인에 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
	};

// 제출 검증
$(document).ready(function() {

	$('#submitbtn').on('click', function(e) {
		e.preventDefault(); 

		// 아이디 공백 확인
		var loginId = $('input[name=loginId]').val().trim();
		if (loginId == '') {
			alert("아이디를 입력하세요.");
			return;
		}

    // 비밀번호 공백 확인
		var password = $('input[name=password]').val().trim();
		var confirmPassword = $('input[name=confirmPassword]').val().trim();
		
    if (password == '' || confirmPassword == '') {
			alert("비밀번호를 입력하세요.");
			return;
		}
	
    // 비밀번호 일치 확인 
		if (password != confirmPassword) {
			  alert("비밀번호가 일치하지 않습니다. 다시 입력하세요.");
			  $('#password').val(''); 
			  $('#confirmPassword').val(''); //초기화가 안됨.... 해결해야함...
			return;
		}

    // 이름 공백 확인
		var name = $('input[name=name]').val().trim();
		if (name == '') {
			alert("이름을 입력하세요.");
			return;
		}

    // 이메일 공백 확인
		var email = $('input[name=email]').val().trim();
		if (email == '') {
			alert("이메일 주소를 입력하세요.");
			return;
		}

    // 주소 공백 확인
		var addressStreet = $('input[name=addressStreet]').val().trim();
		if (addressStreet == '') {
			alert("주소를 입력하세요");
			return;
		}
    // 상세 주소 공백 확인
		var addressDetail = $('input[name=addressDetail]').val().trim();
		if (addressDetail == '') {
			alert("상세 주소를 입력하세요");
			return;
		}

    // 반례 처리
    if ($('#idCheckOk').hasClass('d-none') == true) {
			alert("아이디 확인을 다시 해주세요.");
			return;
		}

		var url = $('#signUpForm').attr("action");   
		var data = $('#signUpForm').serialize(); 
		$.post(url, data)
		.done(function(data) {
			if (data.status == "SUCCESS") {
				alert(data.message);			
				location.href="/member/signInView";
			} else {
				alert(data.message);
			}
		}); 
	})

  $('#loginbtn2').on('click',function(e) {
    e.preventDefault();
		
		var loginIdForLogin = $('input[name=loginIdForLogin]').val().trim();
		if (loginIdForLogin == '') {
			alert("아이디를 입력해주세요.");
			return;
		}
		
		var passwordForLogin = $('input[name=passwordForLogin]').val();
		if (passwordForLogin == '') {
			alert("비밀번호를 입력해주세요.");
			return;
		}
		
		// AJAX로 서브밋
		var url = $(logInForm).attr("action");
		var data = $(logInForm).serialize(); // form의 name 속성으로 data를 구성한다.
		$.post(url, data)
		.done(function(data) {
			if (data.status == "SUCCESS") {
				location.href="/main"; 
			} else {
				alert(data.message);

			}
		}); 
	});

});


</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
  window.onload = function(){
      document.getElementById("addressKakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
          //카카오 지도 발생
          new daum.Postcode({
              oncomplete: function(data) { //선택시 입력값 세팅
                  document.getElementById("addressKakao").value = data.address; // 주소 넣기
                  document.querySelector("input[name=addressDetail]").focus(); //상세입력 포커싱
              }
          }).open();
      });
  }
  </script>
</body>
</html>
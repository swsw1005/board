<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
// 여기는 자바 부분입니다.
System.out.println("------------- writeForm.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>

<!-- Bootstrap + jQuery 라이브러리 등록 -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function(){
	// 취소 버튼 이벤트 처리 -> 이전 페이지로 이동
	$(".cancelBtn").click(function(){
		history.back();
	});
	
	$("#title").keyup(function(){
		// alert("title - keyup");
		// 맨 앞글자가 공백문자인지 확인해보자.
		var title = $(this).val();
		if(title.indexOf(" ") == 0)
			$(this).val($.trim(title));
	});
	
	$("#writeForm").submit(function(){
		var title = $.trim($("#title").val());
		$("#title").val(title);
		if(title.length < 4){
			alert("맨 앞뒤 공백을 제외한 글자가 4자이상여야 합니다.");
			// 제목 입력란에 커서를 위치 시킨다.
			$("#title").focus();
			// submit() 이벤트처리에서 submit()을 취소 시킨다.
			return false;
		}
	});
	
});
</script>

</head>
<body>
<div class="container">
<h2>게시판 글쓰기</h2>
<form action="write.jsp" method="post" id="writeForm">
	<!-- 제목입력 -->
	<div class="form-group">
	  <label for="title">제목</label>
	  <!-- 정규 표현식으로 데이터 유효성 검사 : pattern속성으로 설정
	  	정규표현식
	  	. : 모든 문자(공백문자 포함) 한개
	  	^ : 맨앞에 사용해야 하며 시작되는 문자를 뒤에 표기한다.
	  	[]: 안에 있는 한글자 선택 : [ㄱ-힣] , [a-zA-Z0-9]
	  	[]안에서 사용되는 ^ : not을 의미한다. [^0-9] 숫자 불가, [^_] : 공백문자 불가.
	  	{n,m} : 앞에 한문자를 반복 표시해야하는 경우. [a-z]{4, 10} : 소문자 영문자를 4~10자
	  	$ : 맨 끝에 사용해야 하며 마지막으로 표시되는 문자를 바로 앞에 표기한다.
	   -->
	  <input type="text" class="form-control" id="title" name="title"
	   required="required" pattern="^[^ .].{3,99}$" maxlength="100"
	   title="제목을 4자이상 100자이내로 작성하셔야 합니다. 맨 앞과 맨뒤는 공백문자 불가">
	</div>
	<!-- 내용입력 -->
	<div class="form-group">
	  <label for="content">내용</label>
	  <textarea class="form-control" rows="5" id="content" name="content"
	   required="required"></textarea>
	</div> 
	<!-- 작성자 입력 -->
	<div class="form-group">
	  <label for="writer">작성자</label>
	  <input type="text" class="form-control" id="writer" name="writer"
	   required="required">
	</div>
	<!-- 비밀번호 입력 -->
	<div class="form-group">
	  <label for="pw">비밀번호</label>
	  <input type="text" class="form-control" id="pw" name="pw"
	   required="required">
	</div>
	<div class="btn-group">
	   <button class="btn btn-default">쓰기</button>
	   <button type="reset" class="btn btn-default">새로입력</button>
	   <button type="button" class="btn btn-default cancelBtn">취소</button>
	</div> 
</form>
</div>
</body>
</html>
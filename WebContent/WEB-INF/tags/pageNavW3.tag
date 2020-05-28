<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="page" required="true" type="java.lang.Integer"%>
<%@ attribute name="startPage" required="true" type="java.lang.Integer"%>
<%@ attribute name="endPage" required="true" type="java.lang.Integer"%>
<%@ attribute name="totalPage" required="true" type="java.lang.Integer"%>

<div class="w3-bar">
	<a data-page=1 href="list.jsp?page=1&perPageNum=10" class="w3-button"> &lt;&lt; </a>
	<c:if test="${startPage > 1 }">
		<a data-page=${startPage -1 } href="list.jsp?page=${startPage - 1 }&perPageNum=10" class="w3-button">&lt;</a>
	</c:if>
	<c:forEach begin="${startPage }" end="${endPage }" var="cnt">
		<a ${(page == cnt)?"class=\"w3-green w3-button\"":"class=\"w3-button\"" } data-page=${cnt } href="list.jsp?page=${cnt }&perPageNum=10">${cnt}</a>
	</c:forEach>
	<c:if test="${endPage < totalPage }">
		<a data-page=${endPage + 1 } href="list.jsp?page=${endPage + 1 }" class="w3-button">&gt;</a>
	</c:if>
	<a data-page=${totalPage } href="list.jsp?page=${totalPage }" class="w3-button">&gt;&gt;</a>
</div>
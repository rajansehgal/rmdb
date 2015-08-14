<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/WEB-INF/javascriptsjQuery.js">
</script>

<div id="cssmenu">
	<ul>
		<li class='active'><a href='index.html'>Home</a></li>

	</ul>
	<c:forEach var="category" items="${categories}">
		<ul>


			<li class='has-sub'><a href='#'><c:out value="${category}" /></a></li>


		</ul>
	</c:forEach>
</div>

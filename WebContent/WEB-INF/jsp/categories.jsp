<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 	<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script> --%>
<%-- <script type="text/javascript" src="<c:url value="/resources/javascripts/script.js" />"></script> --%>
	<script type="text/javascript" src="<c:url value="/resources/javascripts/jquery-latest.min.js" />"></script>
	


<script>
$(document).ready(function(){
    $("#cssmenu li.has-sub>a").click(function(){
        $(this).removeAttr('href');
		var element = $(this).parent('li');
		if (element.hasClass('open')) {
			element.removeClass('open');
			element.find('li').removeClass('open');
			element.find('ul').slideUp();
		}
		else {
			element.addClass('open');
			element.children('ul').slideDown();
			element.siblings('li').children('ul').slideUp();
			element.siblings('li').removeClass('open');
			element.siblings('li').find('li').removeClass('open');
			element.siblings('li').find('ul').slideUp();
		}
    });
});
</script>

<div id="leftmenu">
<div id="cssmenu">
	<ul>
		<li class='active'><a href='/MoviesDBatRS/moviesdb/userHome'>Home</a></li>
	</ul>
	<c:forEach var="category" items="${categories}">
		<ul>
			<li class='has-sub'><a href="#"><c:out value="${category.key}" /></a>
				<c:forEach var="subcategory" items="${category.value}">
					<ul>
						<li><a href="#"><c:out value="${subcategory}" /></a>
					</ul>
				</c:forEach>
				</li>
		</ul>
	</c:forEach>
</div>
</div>

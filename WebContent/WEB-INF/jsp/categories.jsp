<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 	<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script> --%>
<%-- <script type="text/javascript" src="<c:url value="/resources/javascripts/script.js" />"></script> --%>
<script type="text/javascript"
	src="<c:url value="/resources/javascripts/jquery-latest.min.js" />"></script>



<script>
	$(document).ready(function() {
		$("#cssmenu li.has-sub>a").click(function() {
			$(this).removeAttr('href');
			var element = $(this).parent('li');
			if (element.hasClass('open')) {
				element.removeClass('open');
				element.find('li').removeClass('open');
				element.find('ul').slideUp();
			} else {
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

<script>
	function getMedia(name) {
		var fullurl = "http://localhost:8080/MoviesDBatRS/moviesdb/userHome/getMediaDetails";
		//Creating a new XMLHttpRequest object
		var xmlhttp;
		if (window.XMLHttpRequest) {
			xmlhttp = new XMLHttpRequest(); //for IE7+, Firefox, Chrome, Opera, Safari
		} else {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); //for IE6, IE5
		}
		//Create a asynchronous GET request

		xmlhttp.open("GET", fullurl, true);
		xmlhttp.setRequestHeader("mediaName", name);

		//When readyState is 4 then get the server output
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {
					alert('All is Well');
				} else {
					alert('Something is wrong !!' + xmlhttp.readyState
							+ xmlhttp.getAllResponseHeaders());
				}
			}
		};

		xmlhttp.send(null);
	}
</script>
<script>
	function getMedia2(name) {
		$
				.ajax({
					type : 'GET',
					url : 'http://localhost:8080/MoviesDBatRS/moviesdb/userHome/getMediaDetails',
					data : {
						'mediaName' : name
					},
					headers : {
						Accept : 'application/json'
					},
					dataType : 'json',

					success : function(data) {
						alert('It Worked' + data);

						var rowHeader='<tr><th>File Name</th><th>Parent Directory</th><th>Subtitles(Y/N)</th><th>File Size(Mb)</th></tr>';
						$('table').append(rowHeader);
						$.each(data, function(index, val) {
							var rowData = '';
							rowData += '<tr><td>' + val.fileName + '</td><td>'
									+ val.parentDir + '</td><td>'
									+ val.hasSubtitles + '</td></tr>'
									+ val.fileSize + '</td><td>';
							$('table').append(rowData);

						});

					},

					error : function(data) {
						alert('It failed');
					}
				});
	}
</script>

<div class="leftmenu">
	<div id="cssmenu">
		<ul>
			<li class='active'><a href='/MoviesDBatRS/moviesdb/userHome'>Home</a></li>
		</ul>
		<c:forEach var="category" items="${categories}">
			<ul>
				<li class='has-sub'><a href="#"><c:out
							value="${category.key}" /></a> <c:forEach var="subcategory"
						items="${category.value}">
						<ul>
							<li><a href="#" onclick='getMedia2("${subcategory}")'><c:out
										value="${subcategory}" /></a>
						</ul>
					</c:forEach></li>
			</ul>
		</c:forEach>
	</div>
</div>
<div class="centrepanel">
	<table>
	
	</table>
</div>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 	<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script> --%>
<%-- <script type="text/javascript" src="<c:url value="/resources/javascripts/script.js" />"></script> --%>
<script type="text/javascript"
	src="<c:url value="/resources/javascripts/jquery-latest.min.js" />"></script>

<script type="text/javascript"
	src="<c:url value="/resources/javascripts/jquery.dataTables.min.js" />"></script>

<script>
	$(document).ready(function() {
		$(".rightmenu li.has-sub>a").click(function() {
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


	$(document)
			.ready(
					function() {
						$("#user_approval")
								.click(
										function() {
											
											$('#abc').empty();
											$
													.ajax({
														type : 'GET',
														url : location.origin
																+ "${pageContext.request.contextPath}"
																+ '/moviesdb/admin/disabledUsers',
														headers : {
															Accept : 'application/json'
														},
														dataType : 'json',

														success : function(data) {
															var tableHolder = '<table id="myTable" class="display"><thead><tr><th>Username</th><th>Full name</th><th>Email</th><th>Select</th></tr></thead><tbody>';

															$
																	.each(
																			data,
																			function(
																					index,
																					val) {
																				tableHolder += '<tr><td>'
																						+ val.username
																						+ '</td><td>'
																						+ val.fullName
																						+ '</td><td>'
																						+ val.email
																						+ '</td><td>'
																						+ '<input type="radio" id="userRow" name="u_select" value="'+val.id+'"></td></tr>';

																			});
															tableHolder += '</tbody></table>';
														$('#abc')
																.append(
																	tableHolder);

															$('#myTable')
																	.DataTable(
																			{
																				scrollY : 200,
																				"scrollCollapse" : true,
																				"scrollX" : false,
																				paging : false,
																				searching : false
																			});
															$('#abc')
																	.css(
																			"background-color",
																			"white");
															
												
															       
															

														},

														error : function(data) {
															alert('It failed');
														}
													});

										});
					});
	

	$('input:radio[name="u_select"]').change(function() {
		if ($(this).is(':checked')) {
			alert($(this).val());
		}
	});	
</script>

<div class="rightmenu">
	<ul>
		<li><a href='#'><span>My Profile</span></a></li>
		<li class='active has-sub'><a href='#'><span>Administration</span></a>
			<ul>
				<li><a href='#'><span>Sync HD</span></a></li>
				<li><a href='#'><span>Sync Db</span></a></li>
			</ul></li>
		<li class='active has-sub'><a href='#'><span>User
					Management</span></a>
			<ul>
				<li><a href='#' id="user_approval">Pending Approval</a></li>
				<li><a href='#'><span>Modify Enabled A/Cs</span></a></li>
			</ul></li>

		<li class='last'><a href='${pageContext.request.contextPath}'><span>Logout</span></a></li>
	</ul>
</div>
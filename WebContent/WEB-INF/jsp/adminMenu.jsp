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
	
	function enableSelected(rowSelected){
		alert('Calling for '+rowSelected);
		$
		.ajax({
			type : 'GET',
			url : location.origin
					+ "${pageContext.request.contextPath}"
					+ '/moviesdb/admin/enableUsers',
			data: {userList : rowSelected},
			headers : {
				Accept : 'application/json'
			},
			dataType : 'json',

			success : function(data) {
			alert(data);
			$('#abc').empty();
			displayDisabledUsers();
			},

			error : function(data) {
				alert('It failed');
			}
		});


	}

	function displayDisabledUsers() {

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
				var tableHolder = '<table id="myTable" class="display select"><thead><tr><th><input name="select_all" value="1" id="example-select-all" type="checkbox" class="dt-body-center"></th><th>Username</th><th>Full name</th><th>Email</th><th>Role</th></tr></thead><tbody>';

				$
						.each(
								data,
								function(
										index,
										val) {
									tableHolder += '<tr><td><input type="checkbox" id="userRow" name="u_select" class="dt-body-center" value="'+val.id+'"></td><td>'
											+ val.username
											+ '</td><td>'
											+ val.fullName
											+ '</td><td>'
											+ val.email
											+ '</td><td><select id="user_role" class="user_role"><option value="USER" selected="selected">USER</option><option value="ADMIN">ADMIN</option></select></td></tr>';

								});
				tableHolder += '</tbody></table>';
				var approveButton = '<input type="submit" id="appButton" value="Approve"/>';

				$('#abc')
						.append(
								tableHolder);
				$('#abc')
						.append(
								approveButton);

				var table = $(
						'#myTable')
						.DataTable(
								{
									scrollY : 200,
									"scrollCollapse" : true,
									"scrollX" : false,
									paging : false,
									searching : false,
									"ordering" : false
								});
				// Handle click on "Select all" control
				$(
						'#example-select-all')
						.click(
								function() {
									// Get all rows with search applied
									var rows = table
											.rows()
											.nodes();
									// Check/uncheck checkboxes for all rows in the table
									$(
											'input[type="checkbox"]',
											rows)
											.prop(
													'checked',
													this.checked);

								});

				// Handle click on checkbox to set state of "Select all" control
				$('#myTable tbody')
						.on(
								'change',
								'input[type="checkbox"]',
								function() {
									// If checkbox is not checked

									if (!this.checked) {
										var el = $(
												'#example-select-all')
												.get(
														0);
										// If "Select all" control is checked and has 'indeterminate' property
										if (el
												&& el.checked
												&& ('indeterminate' in el)) {
											// Set visual state of "Select all" control 
											// as 'indeterminate'
											el.indeterminate = true;
										}
									}
								});

				$('#appButton')
						.click(
								function() {
									var rowSelected = [];
									var row = '';

									// Iterate over all checkboxes in the table
									table
											.$(
													'input[type="checkbox"]:checked')
											.each(
													function() {
														row = $(
																this)
																.parent()
																.parent();
														rowSelected
																.push(this.value
																		+ ' : '
																		+ row
																				.find(
																						'td:eq(4) option:selected')
																				.val());
														

													});

									enableSelected(rowSelected);
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

	}
	
	function displayAllUsers() {

		$
		.ajax({
			type : 'GET',
			url : location.origin
					+ "${pageContext.request.contextPath}"
					+ '/moviesdb/admin/AllUsers',
			headers : {
				Accept : 'application/json'
			},
			dataType : 'json',

			success : function(data) {
				var tableHolder = '<table id="myTable" class="display select"><thead><tr><th>Select</th><th>Username</th><th>Full name</th><th>Email</th><th>Role</th><th>Status</th></tr></thead><tbody>';

				$
						.each(
								data,
								function(
										index,
										val) {
									var status=(val.approved==true)?'Enabled':'Disabled';
									tableHolder += '<tr><td><input type="radio" id="userRow" name="u_select" class="dt-body-center" value="'+val.id+'"></td><td>'
											+ val.username
											+ '</td><td>'
											+ val.fullName
											+ '</td><td>'
											+ val.email
											+ '</td><td>'+val.role+'</td><td>'+status+'</td></tr>';

								});
				tableHolder += '</tbody></table>';
				var editButton = '<input type="submit" id="appButton" value="Edit"/>';
				var deleteButton = '<input type="submit" id="appButton" value="Delete"/>';
				var disableButton = '<input type="submit" id="appButton" value="Disable"/>';

				$('#abc')
						.append(
								tableHolder);
				$('#abc')
						.append(
								editButton);
				$('#abc')
				.append("\t\t\t");
				$('#abc')
				.append("\t\t\t");
				$('#abc')
				.append(
						deleteButton);
				$('#abc')
				.append("\t\t\t");
				$('#abc')
				.append("\t\t\t");
				$('#abc')
				.append(
						disableButton);

				var table = $(
						'#myTable')
						.DataTable(
								{
									scrollY : 200,
									"scrollCollapse" : true,
									"scrollX" : false,
									paging : false,
									searching : false,
									"ordering" : false
								});

				$('#appButton')
						.click(
								function() {
									var rowSelected = [];
									var row = '';

									// Iterate over all checkboxes in the table
									table
											.$(
													'input[type="checkbox"]:checked')
											.each(
													function() {
														row = $(
																this)
																.parent()
																.parent();
														rowSelected
																.push(this.value
																		+ ' : '
																		+ row
																				.find(
																						'td:eq(4) option:selected')
																				.val());
														

													});

									enableSelected(rowSelected);
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

	}


	$(document)
			.ready(
					function() {
						$("#user_approval")
								.click(
										function() {

											$('#abc').empty();
											displayDisabledUsers();
											
										});
					});
	$(document)
	.ready(
			function() {
				$("#user_crud")
						.click(
								function() {

									$('#abc').empty();
									displayAllUsers();
									
								});
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
				<li><a href='#' id="user_approval">Approve Pending</a></li>
				<li><a href='#' id="user_crud"><span>View/Edit</span></a></li>
			</ul></li>

		<li class='last'><a href='${pageContext.request.contextPath}'><span>Logout</span></a></li>
	</ul>
</div>
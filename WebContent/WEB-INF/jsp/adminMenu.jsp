<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

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

	function enableSelected(rowSelected) {
		alert('Calling for ' + rowSelected);
		$.ajax({
			type : 'GET',
			url : location.origin + "${pageContext.request.contextPath}"
					+ '/moviesdb/admin/enableUsers',
			data : {
				userList : rowSelected
			},
			headers : {
				Accept : 'application/json'
			},
			dataType : 'json',

			success : function(data) {
				alert(data);
				$('#abc').empty();
				$('#abc').append('<a class="progressbar"><a>');
				displayDisabledUsers();
			},

			error : function(data) {
				alert('It failed');
			}
		});

	}

	function updateSelected(rowSelected, actionType) {
		alert('Calling for ' + rowSelected + ' and ' + actionType);
		$('#abc').empty();
		$('#abc').append('<a class="progressbar"><a>');
		$.ajax({
			type : 'GET',
			url : location.origin + "${pageContext.request.contextPath}"
					+ '/moviesdb/admin/updateUser',
			data : {
				userSelected : rowSelected,
				userAction : actionType
			},
			headers : {
				Accept : 'application/json'
			},
			dataType : 'json',

			success : function(data) {
				alert(data);
				$('#abc').empty();
				$('#abc').append('<a class="progressbar"><a>');
				displayAllUsers();
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
										function(index, val) {
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
						$('#abc').empty();

						$('#abc').append(tableHolder);
						$('#abc').append(approveButton);

						var table = $('#myTable').DataTable({
							scrollY : 200,
							"scrollCollapse" : true,
							"scrollX" : false,
							paging : false,
							searching : false,
							"ordering" : false
						});
						// Handle click on "Select all" control
						$('#example-select-all').click(
								function() {
									// Get all rows with search applied
									var rows = table.rows().nodes();
									// Check/uncheck checkboxes for all rows in the table
									$('input[type="checkbox"]', rows).prop(
											'checked', this.checked);

								});

						// Handle click on checkbox to set state of "Select all" control
						$('#myTable tbody').on(
								'change',
								'input[type="checkbox"]',
								function() {
									// If checkbox is not checked

									if (!this.checked) {
										var el = $('#example-select-all')
												.get(0);
										// If "Select all" control is checked and has 'indeterminate' property
										if (el && el.checked
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
																row = $(this)
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

											if (rowSelected == '') {
												alert('Please Select at least one Row to Enable');
											} else {

												enableSelected(rowSelected);
											}
										});

						$('#abc').css("background-color", "white");

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
										function(index, val) {
											var status = (val.approved == true) ? 'Enabled'
													: 'Disabled';

											if (val.role == 'ROLE_USER') {
												tableHolder += '<tr><td><input type="radio" id="userRow" name="u_select" class="dt-body-center" value="'+val.id+'"></td><td>'
														+ val.username
														+ '</td><td>'
														+ val.fullName
														+ '</td><td>'
														+ val.email
														+ '</td><td><select id="user_role" class="user_role"><option value="USER" selected="selected">USER</option><option value="ADMIN">ADMIN</option></select></td><td>'
														+ status + '</td></tr>';

											} else {
												tableHolder += '<tr><td><input type="radio" id="userRow" name="u_select" class="dt-body-center" value="'+val.id+'"></td><td>'
														+ val.username
														+ '</td><td>'
														+ val.fullName
														+ '</td><td>'
														+ val.email
														+ '</td><td><select id="user_role" class="user_role"><option value="ADMIN" selected="selected">ADMIN</option><option value="USER" >USER</option></select></td><td>'
														+ status + '</td></tr>';

											}

										});
						tableHolder += '</tbody></table>';
						var editButton = '<input type="submit" id="updateButton" value="Update Role"/>';
						var deleteButton = '<input type="submit" id="deleteButton" value="Delete"/>';
						var disableButton = '<input type="submit" id="disableButton" value="Disable"/>';

						$('#abc').empty();
						$('#abc').append(tableHolder);
						$('#abc').append(editButton);
						$('#abc').append("\t\t\t");
						$('#abc').append("\t\t\t");
						$('#abc').append(deleteButton);
						$('#abc').append("\t\t\t");
						$('#abc').append("\t\t\t");
						$('#abc').append(disableButton);

						var table = $('#myTable').DataTable({
							scrollY : 200,
							"scrollCollapse" : true,
							"scrollX" : false,
							paging : false,
							searching : false,
							"ordering" : false
						});

						$('#updateButton')
								.click(
										function() {
											var rowSelected = '';
											var row = '';
											var actionType = this.value;

											table
													.$(
															'input[type="radio"]:checked')
													.each(
															function() {
																row = $(this)
																		.parent()
																		.parent();
																rowSelected = this.value
																		+ ' : '
																		+ row
																				.find(
																						'td:eq(4) option:selected')
																				.html();
															});
											if (rowSelected == '') {
												alert('Please Select a Row to '
														+ actionType);
											} else {

												updateSelected(rowSelected,
														actionType);
											}
										});

						$('#deleteButton')
								.click(
										function() {
											var rowSelected = '';
											var actionType = this.value;

											table
													.$(
															'input[type="radio"]:checked')
													.each(
															function() {
																rowSelected = this.value;
															});
											if (rowSelected == '') {
												alert('Please Select a Row to '
														+ actionType);
											} else {

												updateSelected(rowSelected,
														actionType);
											}
										});

						$('#disableButton')
								.click(
										function() {
											var rowSelected = '';
											var actionType = this.value;

											table
													.$(
															'input[type="radio"]:checked')
													.each(
															function() {
																rowSelected = this.value;
															});

											if (rowSelected == '') {
												alert('Please Select a Row to '
														+ actionType);
											} else {

												updateSelected(rowSelected,
														actionType);
											}
										});

						$('#abc').css("background-color", "white");

					},

					error : function(data) {
						alert('It failed');
					}
				});

	}

	function updateDb() {
		$.ajax({
			type : 'GET',
			url : location.origin + "${pageContext.request.contextPath}"
					+ '/moviesdb/admin/syncDbwithHD',
			headers : {
				Accept : 'application/json'
			},
			dataType : 'json',

			success : function(data) {
				alert(data);
				$('#abc').empty();
				// 			$('#abc')
				// 			.append(data);
			},

			error : function(data) {
				alert('It failed');
			}
		});

	}

	function updateUser(userId,userData) {
		$.ajax({
			type : 'GET',
			url : location.origin + "${pageContext.request.contextPath}"
					+ '/moviesdb/userHome/updateUserInfo',
			data : {	userSelected : userId,
						userData : userData
					},
			headers : {
				Accept : 'application/json'
			},
			dataType : 'json',

			success : function(data) {
				alert(data);
				clearMpanelFormatting();
				displayUserEditForm();
			},

			error : function(data) {
				alert('It failed');
				clearMpanelFormatting();
			}
		});		
	}

	function clearMpanelFormatting(){
		$('#abc').empty();
		$('#abc').css("background-color", "#FFF4F8");
	}
	
	function displayUserEditForm(){
		$('#abc').empty();
		
		$('#abc').css("background-color", "#0ca3d2");
		
		var fullName="${user.fullName}";
		var status = ("${user.approved}" == "true")?'Approved':'Pending Approval';
	    var email = "${user.email}";
	    var emailPref = "${user.updateByEmail}";
		var userId= "${user.id}";
		
		
		
		var formHolder = '<div class="c-container">'+
		'<fieldset class="editForm" style="margin-top:20%;height:auto;">'+
		'<p><label for="user_full_name">Full Name: </label><input type="text" size="15" id="user_full_name" value="'+fullName+'"/></p>'+
		'<p><label for="user_screen_name">Username (read only): </label><input type="text" disabled="true" size="15" id="user_screen_name" value="'+"${user.username}"+'"/></p>'+
		'<p><input type="hidden" size="15" id="user_id" type="hidden" value="'+"${user.id}"+'"/></p>'+
		'<p><label for="user_email">Email: </label><input type="text" size="30" id="user_email" value="'+email+'"/></p>'+
		'<p><label for="user_role">Role (read only): </label><input type="text" disabled="true" size="15" maxlength="15" id="user_role" value="'+"${user.role}"+'"/></p>'+
		'<p><label for="user_status">Status (read only): </label><input type="text" disabled="true" size="15" maxlength="15" id="user_status" value="'+status+'"/></p>'+
		'<p><label for="user_pref">Subscribe For Newsletter: </label><input type="checkbox"  maxlength="15" id="user_pref" value="'+emailPref+'"/></p>'+
		'<p class="submit"><input name="commit" id="user_update" type="submit" value="Update" href="#"/>   <input name="commit" id="user_cancel" type="submit" value="Cancel"  href="#"/></p>'+
		'</fieldset></div>';
		$('#abc').append(formHolder);
		
		var changeFlag = false;
		var newName = fullName;
		var newEmail = email;
		var newChoice = emailPref;
		
//			$('#user_full_name').on('input', function() {
//			    alert('Text1 changed!');
//			});
		
		$("#user_full_name").change(function() {
			newName = this.value;
			if (newName != fullName) {
				alert('Full Name is changed to: '+newName);
				changeFlag = true;
			}
		});
		
		$("#user_email").change(function() {
			newEmail = this.value;
			if (newEmail != email) {
				alert('Email is changed to: '+newEmail);
				changeFlag = true;
			}
		});
		
		$("#user_pref").change(function() {
			newChoice = $(this).is(':checked');
			if (newChoice != emailPref) {
				alert('New Preference is changed to: '+newChoice);
				changeFlag = true;
			}
		});
		
		
	
		$("#user_update").click(function() {
		
			if (changeFlag) {
				var userData = newName+':'+newEmail+':'+newChoice;
				alert('Will call Database for '+userId+' with Data as--> '+userData);
				updateUser(userId,userData);
			} else {
				alert('No Change in Data Detected, Please click cancel if you have changed Your Mind');
			}

		});
		
		$("#user_cancel").click(function() {
			clearMpanelFormatting();
		});


	}
	
	
	function updateUserPwd(userId,newPwd){
		$.ajax({
			type : 'GET',
			url : location.origin + "${pageContext.request.contextPath}"
					+ '/moviesdb/userHome/updateUserPwd',
			data : {	userSelected : userId,
						userData : newPwd
					},
			headers : {
				Accept : 'application/json'
			},
			dataType : 'json',

			success : function(data) {
				alert(data);
				clearMpanelFormatting();
			},

			error : function(data) {
				alert('It failed');
				clearMpanelFormatting();
			}
		});		
	}
	

	$(document).ready(function() {
		$("#user_crud").click(function() {

			$('#abc').empty();
			$('#abc').append('<a class="progressbar"><a>');
			displayAllUsers();

		});
	});

	$(document).ready(function() {
		$("#syncHD").click(function() {

			$('#abc').empty();
			$('#abc').append('<a class="progressbar"><a>');
			updateDb();

		});
	});

	$(document).ready(function() {
		$("#user_approval").click(function() {

			$('#abc').empty();
			$('#abc').append('<a class="progressbar"><a>');
			displayDisabledUsers();

		});
	});

	$(document).ready(function() {
		$("#userProfile").click(function() {

			displayUserEditForm();
					});
	});
	
	$(document).ready(function() {
		$("#changePwd").click(function() {

			var origpwd = "${user.password}";
			var userId = "${user.id}";
			var currPwd = '';
			var newPwd = '';
			var chgPwdFlag = true;
			$('#abc').empty();
			
// 			$('#abc').css("background-color", "white");
			var formHolder = '<div class="c-container">'+
			'<fieldset class="editForm" style="margin-top:20%;height:auto;"><input type="password" size="15" id="current_pwd" placeholder="Current Password" style="margin-top:.5cm;margin-bottom:.5cm;"/></p>'+
			'<input type="password" size="15" id="new_pwd" placeholder="New Password" style="margin-bottom:.5cm;"/></p>'+
			'<input type="password" size="15" id="new_pwd_re" placeholder="Re-enter New Password" style="margin-bottom:1cm;"/></p>'+
			'<input name="commit" id="user_update" type="submit" value="Update" href="#"/>   <input name="commit" id="user_cancel" type="submit" value="Cancel"  href="#"/></fieldset></div>';
			$('#abc').append(formHolder);
			
			
		

			$("#user_update").click(function() {
				newPwd = $('#new_pwd').val();
				currPwd = $('#current_pwd').val();
				
				if ( currPwd != origpwd){
					chgPwdFlag = false;
					alert('Current Password enetered is incorrect');
				}
				
				if ( newPwd != $('#new_pwd_re').val()){
					chgPwdFlag = false;
					alert('Passwords do not match');
				}
				
				if ( newPwd == currPwd){
					chgPwdFlag = false;
					alert('There is no point in Password update whilst New and Current Passwords are same');
				}
				
				
					alert('Password Changed from: '+origpwd+' to '+newPwd+' for User Id: '+userId);
					updateUserPwd(userId,newPwd);
				
				
			});
			
			$("#user_cancel").click(function() {
				clearMpanelFormatting();
			});

		});
	});
</script>

<div class="rightmenu">
	<ul> 
		<li class='active has-sub'><a href='#'><span>Profile</span></a>
			<ul>
				<li><a href='#' id="userProfile"><span>View/Edit</span></a></li>
				<li><a href='#' id="changePwd"><span>Change Password</span></a></li>
			</ul></li>
		<li class='active has-sub'><a href='#'><span>Data
					Management</span></a>
			<ul>
				<li><a href='#' id="syncHD"><span>HD to Local Db</span></a></li>
				<li><a href='#'><span>Imdb to Local Db</span></a></li>
				<li><a href='#'><span>Cleanup HD</span></a></li>
			</ul></li>
		<li class='active has-sub'><a href='#'><span>User
					Management</span></a>
			<ul>
				<li><a href='#' id="user_approval">Pending Approval</a></li>
				<li><a href='#' id="user_crud"><span>Manage/Delete</span></a></li>
			</ul></li>

		<li class='last'><a href='${pageContext.request.contextPath}'><span>Logout</span></a></li>
	</ul>
</div>
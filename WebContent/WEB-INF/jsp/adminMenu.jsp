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
				clearMpanelFormatting();
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
				clearMpanelFormatting();
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
						var cancelButton = '<input name="commit" id="user_cancel" type="submit" value="Not Now, Later!" onclick="clearMpanelFormatting()"  href="#"/>';
						$('#abc').empty();

						$('#abc').append(tableHolder);
						$('#abc').append('</br>');
						$('#abc').append(approveButton);
						$('#abc').append("\t\t\t");
						$('#abc').append(cancelButton);
						

						var table = $('#myTable').DataTable({
							scrollY : 200,
							"scrollCollapse" : true,
							"scrollX" : false,
							paging : false,
							searching : false,
							"ordering" : false,
							"columnDefs": [
							               {
							                   "targets": [ 0 ],
							                   "width": "1cm"
							               }]
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
						clearMpanelFormatting();
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
						var cancelButton = '<input id="user_cancel" type="submit" value="Cancel" onclick="clearMpanelFormatting()" href="#"/>';

						$('#abc').empty();
						$('#abc').append(tableHolder);
						$('#abc').append('</br>');
						$('#abc').append(editButton);
						$('#abc').append("\t\t\t");
						$('#abc').append("\t\t\t");
						$('#abc').append(deleteButton);
						$('#abc').append("\t\t\t");
						$('#abc').append("\t\t\t");
						$('#abc').append(disableButton);
						$('#abc').append("\t\t\t");
						$('#abc').append(cancelButton);

						var table = $('#myTable').DataTable({
							scrollY : 200,
							"scrollCollapse" : true,
							"scrollX" : false,
							paging : false,
							searching : false,
							"ordering" : false,
							"columnDefs": [
							               {
							                   "targets": [ 0 ],
							                   "width": "1cm"
							               }]
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
						clearMpanelFormatting();
					}
				});

	}

// 	For updating Local Db with data from HArd Disk
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
				clearMpanelFormatting();
			}
		});

	}
	
// 	For removing Junk Data from Hard Disk
	function cleanUpHd(rowSelected) {
		$.ajax({
			type : 'POST',
			url : location.origin + "${pageContext.request.contextPath}"
					+ '/moviesdb/admin/cleanupHd',
					data : {
						filesSelected : rowSelected
					},
			headers : {
				Accept : 'application/json'
			},
			dataType : 'json',

			success : function(data) {
				alert(data);
				displayJunkData();
			},

			error : function(data) {
				alert('It failed');
				clearMpanelFormatting();
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
				prepareMpanelFormatting();
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
	
function prepareMpanelFormatting(){
		
	$('#abc').empty();
	$('#abc').css("background-color", "white");
	$('#abc').append('<a class="progressbar"><a>');
	}
	

	
function displayUserEditForm(){
		
		$.ajax({
			type : 'GET',
			url : location.origin + "${pageContext.request.contextPath}"
					+ '/moviesdb/userHome/CurrentUserInfo',
			headers : {
				Accept : 'application/json'
			},
			dataType : 'json',

			success : function(data) {
							
				clearMpanelFormatting();
				var fullName=data.fullName;
				var status = (data.approved == true)?'Approved':'Pending Approval';
			    var email = data.email;
			    var emailPref = data.updateByEmail;
				var userId= data.id;
				var checkBox='';
				if (emailPref) {
					checkBox = '<p><label for="user_pref">Subscribe For Newsletter: </label><input type="checkbox"  maxlength="15" id="user_pref" checked="checked"/></p>';	
				} else {
					checkBox = '<p><label for="user_pref">Subscribe For Newsletter: </label><input type="checkbox"  maxlength="15" id="user_pref" /></p>';
				}
				
				
				var formHolder = '<div class="c-container">'+
				'<fieldset class="editForm" style="margin-top:20%;height:auto;">'+
				'<p><label for="user_full_name">Full Name: </label><input type="text" size="15" id="user_full_name" value="'+fullName+'"/></p>'+
				'<p><label for="user_screen_name">Username (read only): </label><input type="text" disabled="true" size="15" id="user_screen_name" value="'+data.username+'"/></p>'+
				'<p><label for="user_email">Email: </label><input type="text" size="30" id="user_email" value="'+email+'"/></p>'+
				'<p><label for="user_role">Role (read only): </label><input type="text" disabled="true" size="15" maxlength="15" id="user_role" value="'+data.role+'"/></p>'+
				'<p><label for="user_status">Status (read only): </label><input type="text" disabled="true" size="15" maxlength="15" id="user_status" value="'+status+'"/></p>'+checkBox+
				'<p class="submit"><input name="commit" id="user_update" type="submit" value="Update" href="#"/>   <input name="commit" id="user_cancel" type="submit" value="Not Now, Later!" onclick="clearMpanelFormatting()"  href="#"/></p>'+
				'</fieldset></div>';
				$('#abc').append(formHolder);
				
				var changeFlag = false;
				var newName = fullName;
				var newEmail = email;
				var newChoice = emailPref;
				
//					$('#user_full_name').on('input', function() {
//					    alert('Text1 changed!');
//					});
				
				
				$("#user_full_name").change(function() {
					newName = this.value;
					if (newName != fullName) {
						alert('Full Name is changed to: '+newName);
						if (newName.length > 3 && newName.length < 20) {
							changeFlag=true;
						} else {
							alert('Full Name must be between 3 and 20 characters');
						}
					}
				});
				
				$("#user_email").change(function() {
					newEmail = this.value;
					if (newEmail != email) {
						alert('Email is changed to: '+newEmail);
						var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
						if (re.test(newEmail)){
							changeFlag = true;
						} else {
							alert('Invalid Email Address');
						}
					}
				});
				
				$("#user_pref").change(function() {
					newChoice = $(this).is(':checked');
					if (newChoice) {
						$("#user_pref").prop('checked', true);
					} else {
						$("#user_pref").prop('checked', false);
					}
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

			},

			error : function(data) {
				alert('It failed');
				clearMpanelFormatting();
			}
		});
		
		
		
		

	}
	
function displayPwdChgForm(){
	
	$.ajax({
		type : 'GET',
		url : location.origin + "${pageContext.request.contextPath}"
				+ '/moviesdb/userHome/CurrentUserInfo',
		headers : {
			Accept : 'application/json'
		},
		dataType : 'json',

		success : function(data) {
						
			clearMpanelFormatting();
			var origpwd = data.password;
			var userId = data.id;
			var currPwd = '';
			var newPwd = '';
			var chgPwdFlag = true;
			
			var formHolder = '<div class="c-container">'+
			'<fieldset class="editForm" style="margin-top:20%;height:auto;"><input type="password" size="15" id="current_pwd" placeholder="Current Password" style="margin-top:.5cm;margin-bottom:.5cm;"/></p>'+
			'<input type="password" size="15" id="new_pwd" placeholder="New Password" style="margin-bottom:.5cm;"/></p>'+
			'<input type="password" size="15" id="new_pwd_re" placeholder="Re-enter New Password" style="margin-bottom:1cm;"/></p>'+
			'<input name="commit" id="user_update" type="submit" value="Update" href="#"/>   <input name="commit" id="user_cancel" type="submit" value="Not Now, Later!" onclick="clearMpanelFormatting()"  href="#"/></fieldset></div>';
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
				
				
				if (chgPwdFlag) {
					alert('Password Changed from: '+origpwd+' to '+newPwd+' for User Id: '+userId);
					updateUserPwd(userId,newPwd);
				} 
					
				
			});
			
			$("#user_cancel").click(function() {
				clearMpanelFormatting();
			});


		},

		error : function(data) {
			alert('It failed');
			clearMpanelFormatting();
		}
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
	
	function displayJunkData(){
		$.ajax({
			 type : 'GET',
					url : location.origin+"${pageContext.request.contextPath}"+'/moviesdb/media/getNonMediaDetails',
					headers : {
						Accept : 'application/json'
					},
					dataType : 'json',

					success : function(data) {
						var tableHolder = '<table id="myTable" class="display"><thead><tr><th><input name="select_all" value="1" id="example-select-all" type="checkbox" class="dt-body-center"></th><th>Display Name</th><th>File Size(bytes)</th><th>File Path</th></tr></thead><tbody>';

						$.each(data, function(index, val) {
							tableHolder += '<tr><td><input type="checkbox" id="userRow" name="u_select" class="dt-body-center" value="'+val.id+'"></td><td>'+ val.displayName
									+ '</td><td>'
									+ val.fileSizeOrig +'</td><td>'
								+ val.filePath + '</td></tr>';

						});
						tableHolder += '</tbody></table>';
					
						var submitButton = '<input type="submit" id="updateButton" value="Delete From Hard Disk"/>';
						var cancelButton = '<input type="submit" id="cancelButton" value="Not Now, Later!" onclick="clearMpanelFormatting()"/>';
						
						$('#abc').empty();
						$('#abc').append(tableHolder);
						$('#abc').append('<br/>');
						$('#abc').append(submitButton);
						$('#abc').append("\t\t\t");
						$('#abc').append("\t\t\t");
						$('#abc').append(cancelButton);
						$('#abc').append('<br/>');
						
						var table = $('#myTable').DataTable({
							scrollY: 290,
							"scrollCollapse": true,
							"scrollX": false,
							"lengthMenu": [[ 10, 25, 50, 75, 100, -1 ],[ 10, 25, 50, 75, 100, "All" ]],
							"pagingType": "full_numbers",
							"columnDefs": [
							               {
							                   "targets": [ 0 ],
							                   "width": "1cm"
							               }]
						});
						
						$('#abc').css("background-color","white");
						// Handle click on "Select all" control
						$('#example-select-all').click(
								function() {
									// Get all rows with search applied
									var rows = table.rows( {page:'current'} ).nodes();
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
						
						$('#updateButton').click(
								function() {
									var rowSelected = [];

									
									var row = '';
									
								
									// Iterate over all checkboxes in the table
									table.$('input[type="checkbox"]:checked').each(function() {
										row = $(this)
										.parent()
										.parent();
														rowSelected
																.push(this.value+ '##'+ row.find('td:eq(3)').html());
														alert('Rowselected is: '+this.value
																+ ' : '
																+ row
																		.find(
																				'td:eq(3)')
																		.html());

													});

									if (rowSelected == '') {
										alert('Please Select at least one Row to Enable');
									} else {
										if (confirm('This action will result in deletion of '+rowSelected.length+' record(s), Do you want to continue?')){
											cleanUpHd(rowSelected);
										}
									}
								});

					},

					error : function(data) {
						alert('It failed');
						clearMpanelFormatting();
					}
				});

	}

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
		
		$("#user_crud").click(function() {

			$('#abc').empty();
			$('#abc').append('<a class="progressbar_c"><a>');
			displayAllUsers();

		});

		$("#syncHD").click(function() {

			$('#abc').empty();
			$('#abc').append('<a class="progressbar"><a>');
			updateDb();

		});

		$("#updateMedia").click(function() {

			alert('This Option is under Construction!');

		});
		
		$("#cleanupHD").click(function() {

			$('#abc').empty();
			$('#abc').append('<a class="progressbar_c"><a>');
			displayJunkData();

		});

		$("#user_approval").click(function() {

			$('#abc').empty();
			$('#abc').append('<a class="progressbar_c"><a>');
			displayDisabledUsers();

		});
	
		$("#userProfile").click(function() {
			prepareMpanelFormatting();
			displayUserEditForm();
					});
	
		$("#changePwd").click(function() {

			prepareMpanelFormatting();
			displayPwdChgForm();
		
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
				<li><a href='#' id="syncHD"><span>Sync with Hard Disk</span></a></li>
				<li><a href='#' id="updateMedia"><span>Update Db via IMDB</span></a></li>
				<li><a href='#' id ="cleanupHD"><span>Manage Junk Data</span></a></li>
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
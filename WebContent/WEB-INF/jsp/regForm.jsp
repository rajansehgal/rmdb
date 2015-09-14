<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$("#reg_cancel").click(function() {
	
});
</script>
<div class="c-container">
	<sf:form class="login" method="POST" modelAttribute="user">
		<h1>Registration Form</h1>
		<fieldset>
			<p>
				<sf:input path="fullName" size="15" id="user_full_name"
					placeholder="Full Name*" />
			</p>
			<p>
				<sf:errors path="fullName" cssStyle="color:red"  />
			</p>
			<p>
				<sf:input path="username" size="15" maxlength="15"
					id="user_screen_name"
					placeholder="Username* (No Spaces, Min 6 Chars)" />
			</p>
			<p>
				<sf:errors path="username" cssStyle="color:red" />
			</p>
			<p>
				<sf:password path="password" size="30" showPassword="true"
					id="user_password" placeholder="Password*" />
			</p>
			<p>
				<sf:errors path="password" cssStyle="color:red"/>
			</p>
			<p>
				<sf:password path="password" size="30" showPassword="true"
					id="user_password2" placeholder="Re-enter Password*" />
			</p>
			<p>
				<sf:errors path="password" cssStyle="color:red"/>
			</p>
			<p>
				<sf:input path="email" size="30" id="user_email"
					placeholder="Email*" />
			</p>
			<p>
				<sf:errors path="email" cssStyle="color:red"/>
			</p>
			<!-- 			<p class="remember_me"> -->
			<%-- 				<label> <sf:checkbox path="updateByEmail" --%>
			<%-- 						id="user_send_email_newsletter" /> I agree to receive --%>
			<!-- 					Notifications -->
			<!-- 				</label> -->
			<!-- 			</p> -->
			<p class="submit">
				<input name="commit" type="submit" value="Create my Account." /> <input name="commit" id="reg_cancel" type="submit" value="No, Thanks!"/>
			</p>
		</fieldset>
	</sf:form>
</div>
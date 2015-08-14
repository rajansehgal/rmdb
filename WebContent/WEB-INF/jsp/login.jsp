<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> --%>
<script>
	function setNewUserName() {

		document.getElementById("userNameNew").value = "/moviesdb/"
				+ document.getElementById("username").value;
		return true
	}
</script>

<div class="c-container">
	<%-- <sec:authorize access="!isAuthenticated()"> --%>

	<form class="login" action="<s:url value="/login"/>" method="post">
		<h1>Login to RMDB</h1>
		<fieldset>
			<p>
				<input id="username" type="text" name="username"
					placeholder="Username" />
			</p>
			<p>
				<input id="pass" type="password" name="password"
					placeholder="Password" />
			</p>
			<p class="remember_me">
				<label> <input id="remember_me" type="checkbox" value="1"
					name="remember_me" /> Remember me on this Computer
				</label>
			</p>
			<p class="submit">
				<input id="submit" type="submit" value="Login" name="commit"
					onclick="setNewUserName()" />
			</p>
			<input type="hidden" id="userNameNew" name="userNameNew" />
		</fieldset>
	</form>
	<div class="login-help">
		<p>
			First Time User?, <a class="login-help"
				href="<s:url value="/moviesdb?new"/>">Please register here</a>
		</p>
	</div>
</div>






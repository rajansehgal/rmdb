<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles"%>
<html>
<head>
<title>Movies Database at RS</title>
<link href="<s:url value="/resources" />/css/style.css"
	rel="stylesheet" type="text/css" />
</head>

<body style="background-color: white;">
	<div class="container">
			<div id="left">
			<t:insertAttribute name="left" />
		</div>
		<div id="right" class="rightpanel">
			<t:insertAttribute name="right" />
		</div>
<!-- 			<div id="centre" class="centrepanel"> -->
<%-- 			<t:insertAttribute name="centre" /> --%>
<!-- 		</div> -->
	</div>
</body>
</html>
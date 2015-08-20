<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles"%>
<html>
<head>
<title>Movies Database at RS</title>
<link href="<s:url value="/resources" />/css/style.css"
	rel="stylesheet" type="text/css" />
</head>

<body>
	<div class="container">
	<div style="clear:both;"></div>
			<div id="left" class="leftpanel" style="background-color: white;">
			<t:insertAttribute name="left" />
			<!--<co id="co_tile_side" />-->
		</div>
		<div id="right" class="rightpanel">
			<t:insertAttribute name="right" />
			<!--<co id="co_tile_side" />-->
		</div>
<!-- 			<div id="centre" class="centrepanel"> -->
<%-- 			<t:insertAttribute name="centre" /> --%>
<!-- 		</div> -->
	</div>
</body>
</html>
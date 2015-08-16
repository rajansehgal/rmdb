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
			<div id="left">
			<t:insertAttribute name="left" />
			<!--<co id="co_tile_side" />-->
		</div>
		<div id="right">
			<t:insertAttribute name="right" />
			<!--<co id="co_tile_side" />-->
		</div>
			<div id="centre">
			<t:insertAttribute name="centre" />
			<!--<co id="co_tile_content" />-->
		</div>
	</div>
</body>
</html>
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
	function getMediaDetails(name) {
		$
				.ajax({
					type : 'GET',
					url : location.origin
							+ "${pageContext.request.contextPath}"
							+ '/moviesdb/media/getMediaDetails',
					data : {
						'mediaName' : name
					},
					headers : {
						Accept : 'application/json'
					},
					dataType : 'json',

					success : function(data) {
						var tableHolder = '<table id="myTable" class="display"><thead><tr><th>Display Name</th><th>Parent Directory</th><th>Subtitles</th><th>File Size(Mb)</th></tr></thead><tbody>';

						$
								.each(
										data,
										function(index, val) {
											var subDisplay = (val.hasSubtitles == true) ? 'Available'
													: 'NA/Muxed';

											tableHolder += '<tr><td>'
													+ val.displayName
													+ '</td><td>'
													+ val.parentDir
													+ '</td><td>' + subDisplay
													+ '</td><td>'
													+ val.fileSize
													+ '</td></tr>';

										});
						tableHolder += '</tbody></table>';
						$('#abc').empty();
						$('#abc').append(tableHolder);
						$('#myTable').DataTable(
								{
									scrollY : 300,
									"scrollCollapse" : true,
									"scrollX" : false,
									"lengthMenu" : [
											[ 10, 25, 50, 75, 100, -1 ],
											[ 10, 25, 50, 75, 100, "All" ] ],
									"pagingType" : "full_numbers"
								});
						$('#abc').css("background-color", "white");

					},

					error : function(data) {
						alert('It failed');
						$('#abc').empty();
						$('#abc').css("background-color", "#FFF4F8");
					}
				});
	}

	
	function getSeasonDetails(name,season) {
		$
				.ajax({
					type : 'GET',
					url : location.origin
							+ "${pageContext.request.contextPath}"
							+ '/moviesdb/media/seasonDetails',
					data : {
						'seriesName' : name,
						'seasonName'  : season
					},
					headers : {
						Accept : 'application/json'
					},
					dataType : 'json',

					success : function(data) {
						var tableHolder = '<table id="myTable" class="display"><thead><tr><th>Episode Name</th><th>Season #</th><th>Subtitles</th><th>File Size(Mb)</th></tr></thead><tbody>';

						$
								.each(
										data,
										function(index, val) {
											var subDisplay = (val.hasSubtitles == true) ? 'Available'
													: 'NA/Muxed';

											tableHolder += '<tr><td>'
													+ val.displayName
													+ '</td><td>'
													+ val.seasonNo
													+ '</td><td>' + subDisplay
													+ '</td><td>'
													+ val.fileSize
													+ '</td></tr>';

										});
						tableHolder += '</tbody></table>';
						$('#abc').empty();
						$('#abc').append(tableHolder);
						$('#myTable').DataTable(
								{
									scrollY : 300,
									"scrollCollapse" : true,
									"scrollX" : false,
									"lengthMenu" : [
											[ 10, 25, 50, 75, 100, -1 ],
											[ 10, 25, 50, 75, 100, "All" ] ],
									"pagingType" : "full_numbers"
								});
						$('#abc').css("background-color", "white");

					},

					error : function(data) {
						alert('It failed');
						$('#abc').empty();
						$('#abc').css("background-color", "#FFF4F8");
					}
				});
	}
	
	$(document).ready(function() {
		$(".leftmenu li.has-sub>a").click(function() {
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

			
		$(".leftmenu ul ul li a").click(function() {
			if ($(this).parent('li').attr('class') != "has-sub open" && $(this).parent('li').attr('class') != "has-sub") {
				var seriesName = $(this).parent('li').attr('id');
				var seasonName = $(this).html();
				if(seriesName != 'nonSeries' && seriesName != 'sName'){
					$(this).removeAttr('href');
					$('#abc').empty();
					$('#abc').append('<a class="progressbar_c"><a>');
					getSeasonDetails(seriesName, seasonName);
					
				} else  {
					$(this).removeAttr('href');
					$('#abc').empty();
					$('#abc').append('<a class="progressbar_c"><a>');
					getMediaDetails($(this).html());
				}
				
				
				
			} 
			
		});
		
		
	});
</script>



<div class="leftpanel">
	<div class="leftmenu">
		<ul>
			<li class='active'><a href='/MoviesDBatRS/moviesdb/userHome'>Home</a></li>
		</ul>


		<ul>
			<li class='has-sub'><a id="Series" href="#">TV Series</a> <c:forEach
					var="seriesList" items="${seriesList}">
					<ul>
						<li class='has-sub' id="sName"><a href="#"><c:out
									value="${seriesList.key}" /></a> <c:forEach var="season"
								items="${seriesList.value}">
								<ul>
									<li id="${seriesList.key}"><a id="Child" href="#"  style="background: white;"><c:out value="${season}" /></a>
								</ul>
							</c:forEach></li>
					</ul>
				</c:forEach></li>
		</ul>


		<c:forEach var="category" items="${categories}">
			<ul>
				<li class='has-sub'><a id="Parent" href="#"><c:out
							value="${category.key}" /></a> <c:forEach var="subcategory"
						items="${category.value}">
						<ul>
							<li id="nonSeries"><a href="#"><c:out value="${subcategory}" /></a>
						</ul>
					</c:forEach></li>
			</ul>
		</c:forEach>
	</div>
</div>
<div class="middlepanel">
	<div class="headerpanel">
		<h1>Welcome to RMDb</h1>
	</div>
	<div id="abc" class="moviepanel">
		<table id="myTable" class="display">
		</table>

	</div>
</div>




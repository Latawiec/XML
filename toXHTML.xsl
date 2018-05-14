<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>Movies!</title>
			</head>
			<body>
				<h2>Top movies list</h2>
				<ol>
					<li><a href="#stats">Stats</a></li>			

				</ol>
					<div id="stats">
						<h3>Statistics</h3>
						<xsl:call-template name="statsTemplate"/>
					</div>
				<td>
					<tr>Email : <a href="mailto:marzecL@tubiedronka.pl">Marzec Łukasz</a></tr>
					<tr>Email : <a href="mailto:nieMarzec@buziaczek.pl">NieMarzec Łukasz</a></tr>
				</td>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="statsTemplate">
		<p>Number of movies:
			<xsl:value-of select="count(top_rated_movies/movies_list/movie)"/>
		</p>
	</xsl:template>

</xsl:stylesheet>
<!--<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
-->

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<title>Movies!</title>
			</head>
			<body>
				<h2>Top movies list</h2>
				<ol>
					<li><a href="#stats">Stats</a></li>			
					<li><a href="#movies">Movies</a></li>
					<li><a href="#movies_by_genre">Movies by genre</a></li>					
				</ol>
					<div id="stats">
						<h3>Statistics</h3>
						<xsl:call-template name="statsTemplate"/>
					</div>

					<div id="movies">
						<h3>Movies</h3>
						<table border="1">
						    <tr bgcolor="#fa8072">
								<th style="text-align:left">Title</th>
							  <th style="text-align:left">Title</th>
							  <th style="text-align:left">Rate</th>
								<th style="text-align:left">Duration</th>
							</tr>
				
							<xsl:for-each select="//movie">
								<tr>
									<td><xsl:value-of select="position()"/></td>
									<xsl:apply-templates select="."/>
								</tr>
							</xsl:for-each>
						</table>
					
					</div>
					<div id="movies_by_genre">
					<h3>Movies by genre</h3>
						<table border="1">
							<th style="text-align:left">Genres</th>
							<th style="text-align:left">Titles</th>
							<xsl:for-each select="//genres/genre">
									<xsl:variable name="ajdi" select="@id_g"/>
									<xsl:variable name="counter" select="@id_g"/>
								<tr>
									<td><xsl:value-of select="."/></td>
									<xsl:for-each select="../../movies_list/movie[@genre_id_ref=$ajdi]">
										<td><xsl:value-of select="titles/title"/></td>
									</xsl:for-each>
								</tr>
							</xsl:for-each>
						</table>
					</div>
				<td>
					<tr>Email : <a href="mailto:marzecL@tubiedronka.pl">Marzec Łukasz</a></tr>
					<tr>Email : <a href="mailto:nieMarzec@buziaczek.pl">NieMarzec Łukasz</a></tr>
				</td>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="movie">	
			<td><xsl:value-of select="titles/title"/></td>
			<td><xsl:value-of select="rate"/></td>
			<td><xsl:value-of select="duration"/></td>
	</xsl:template>
	<xsl:template name="statsTemplate">
		<p>Number of movies:
			<xsl:value-of select="count(top_rated_movies/movies_list/movie)"/>
		</p>
	</xsl:template>

</xsl:stylesheet>
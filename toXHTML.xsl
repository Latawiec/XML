<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns="http://www.w3.org/1999/xhtml">
	<xsl:template match="/">
		<html>
			<head>
				<title>Movies!</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
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

        <div id="movies" class="container">
          <h3>Movies</h3>
          <table border="1" class="table">
            <tr style="background-color:#fa8072">
              <th style="text-align:left">Nr</th>
              <th style="text-align:left">Title</th>
              <th style="text-align:left">Title PL</th>
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

        <div id="movies_by_genre" class="container">
          <h3>Movies by genre</h3>
          <table border="1" class="table">
			<tr>
				<th style="text-align:left">Genres</th>
				<th style="text-align:left">Titles</th>
			</tr>
            <xsl:for-each select="//genres/genre">
              <xsl:variable name="ID" select="@id_g"/>
              <xsl:variable name="counter" select="@id_g"/>
              <tr>
                <td><xsl:value-of select="."/></td>
                <xsl:for-each select="../../movies_list/movie[@genre_id_ref=$ID]">
                  <td><xsl:value-of select="titles/title"/></td>
                </xsl:for-each>
              </tr>
            </xsl:for-each>
          </table>
        </div>
			<table border="1" class="table2">
					<tr>
						<td>Email : <a href="mailto:marzecL@tubiedronka.pl">Marzec Łukasz</a></td>
					</tr>
					<tr>
						<td>Email : <a href="mailto:nieMarzec@buziaczek.pl">NieMarzec Łukasz</a></td>
					</tr>
			</table>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="movie">	
			<td><xsl:value-of select="titles/title[@original='true']"/></td>
      <td><xsl:value-of select="titles/title[@locale_id_ref='L3']"/></td>
			<td><xsl:value-of select="rate"/></td>
			<td><xsl:value-of select="duration"/></td>
	</xsl:template>

	<xsl:template name="statsTemplate">
		<p>Number of movies:
			<xsl:value-of select="count(top_rated_movies/movies_list/movie)"/>
		</p>
	</xsl:template>

</xsl:stylesheet>
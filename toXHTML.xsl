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
      <div class="container">
        <h2>Top movies list</h2>

        <ol>
          <li><a href="#movies_by_genre">Movies by genre</a></li>			
          <li><a href="#movies_count_by_genre">Movies count by genre</a></li>
          <li><a href="#movies_titles_count">Movies' titles count</a></li>
          <li><a href="#movies_by_original_title_to_locale_id">Movies' original titles to locale id</a></li>
          <li><a href="#original_titles_count_by_locale_id">Original titles' count by locale id</a></li>
          <li><a href="#movies_by_year">Movies by year</a></li>
          <li><a href="#movies_count_by_year">Movies count by year</a></li>
        </ol>

        <div class="jumbotron" id="movies_by_genre">
          <h3> Movies by genre </h3>
          <xsl:call-template name="movies_by_genre_template"/>
        </div>

        <div class="jumbotron" id="movies_count_by_genre">
          <h3> Movies count by genre </h3>
          <xsl:call-template name="movies_count_by_genre_template"/>
        </div>

        <div class="jumbotron" id="movies_titles_count">
          <h3> Movies' titles count </h3>
          <xsl:call-template name="movies_titles_count_template"/>
        </div>

        <div class="jumbotron" id="movies_by_original_title_to_locale_id">
          <h3> Movies' original titles to locale id </h3>
          <xsl:call-template name="movies_by_original_title_to_locale_id_template"/>
        </div>

        <div class="jumbotron" id="original_titles_count_by_locale_id">
          <h3> Original titles' count by locale id </h3>
          <xsl:call-template name="original_titles_count_by_locale_id_template"/>
        </div>

        <div class="jumbotron" id="movies_by_year">
          <h3> Movies by year </h3>
          <xsl:call-template name="movies_by_year_template"/>
        </div>

        <div class="jumbotron" id="movies_count_by_year">
          <h3> Movies count by year </h3>
          <xsl:call-template name="movies_count_by_year_template"/>
        </div>      

      </div>
    </body>
  </html>
</xsl:template>

<xsl:template name="movies_by_genre_template">
  <div class="col-12">
    <xsl:value-of select="//movies_by_genre/@description"/>
  </div>
  <table class="table">
    <tr>
      <th>Genre</th>
      <th>Movies</th>
    </tr>
    <xsl:for-each select="//movies_by_genre/genre">
      <xsl:variable name="genreName" select="@name"/>
      <xsl:variable name="moviesCount" select="count(./movie)"/>

      <xsl:for-each select="movie">
        <xsl:variable name="movieTitle" select="."/>

        <tr>
          <xsl:if test="position() = 1">
            <td>
              <xsl:attribute name="rowspan">
                <xsl:value-of select="$moviesCount"/>
              </xsl:attribute>
              <xsl:value-of select="$genreName"/>
            </td>
          </xsl:if>
          <td>
            <xsl:value-of select="$movieTitle"/>
          </td>
        </tr>
      </xsl:for-each>
    </xsl:for-each>
  </table>
</xsl:template>

<xsl:template name="movies_count_by_genre_template">
  <div class="col-12">
    <xsl:value-of select="//movies_count_by_genre/@description"/>
  </div>
  <table class="table">
    <tr>
      <th>Genre</th>
      <th>Movies Count</th>
    </tr>
    <xsl:for-each select="//movies_count_by_genre/genre">
      <xsl:variable name="genreName" select="@name"/>
      <xsl:variable name="moviesCount" select="."/>

      <tr>
        <td>
          <xsl:value-of select="$genreName"/>
        </td>
        <td>
          <xsl:value-of select="$moviesCount"/>
        </td>
      </tr>

    </xsl:for-each>
  </table>
</xsl:template>

<xsl:template name="movies_titles_count_template">
  <div class="col-12">
    <xsl:value-of select="//movies_titles_count/@description"/>
  </div>
  <table class="table">
    <tr>
      <th>Movie</th>
      <th>Titles count</th>
    </tr>
    <xsl:for-each select="//movies_titles_count/movie">
      <xsl:variable name="movieName" select="@name"/>
      <xsl:variable name="titlesCount" select="."/>

      <tr>
        <td>
          <xsl:value-of select="$movieName"/>
        </td>
        <td>
          <xsl:value-of select="$titlesCount"/>
        </td>
      </tr>

    </xsl:for-each>
  </table>
</xsl:template>

<xsl:template name="movies_by_original_title_to_locale_id_template">
  <div class="col-12">
    <xsl:value-of select="//movies_by_original_title_to_locale_id/@description"/>
  </div>
  <table class="table">
    <tr>
      <th>Locale ID</th>
      <th>Movies</th>
    </tr>
    <xsl:for-each select="//movies_by_original_title_to_locale_id/locale">
      <xsl:variable name="Id" select="@localeId"/>
      <xsl:variable name="moviesCount" select="count(./movie)"/>

      <xsl:choose>
        <xsl:when test="$moviesCount > 0">
          <xsl:for-each select="movie">
            <xsl:variable name="movieTitle" select="."/>

            <tr>
              <xsl:if test="position() = 1">
                <td>
                  <xsl:attribute name="rowspan">
                    <xsl:value-of select="$moviesCount"/>
                  </xsl:attribute>
                  <xsl:value-of select="$Id"/>
                </td>
              </xsl:if>
              <td>
                <xsl:value-of select="$movieTitle"/>
              </td>
            </tr>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <tr>
            <td>
              <xsl:value-of select="$Id"/>
            </td>
            <td>
              <strong>No records.</strong>
            </td>
          </tr>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </table>
</xsl:template>

<xsl:template name="original_titles_count_by_locale_id_template">
  <div class="col-12">
    <xsl:value-of select="//original_titles_count_by_locale_id/@description"/>
  </div>
  <table class="table">
    <tr>
      <th>Locale ID</th>
      <th>Titles count</th>
    </tr>
    <xsl:for-each select="//original_titles_count_by_locale_id/locale">
      <xsl:variable name="Id" select="@localeId"/>
      <xsl:variable name="titlesCount" select="."/>
      <tr>
        <td>
          <xsl:value-of select="$Id"/>
        </td>
        <td>
          <xsl:value-of select="$titlesCount"/>
        </td>
      </tr>
    </xsl:for-each>
  </table>
</xsl:template>

<xsl:template name="movies_by_year_template">
  <div class="col-12">
    <xsl:value-of select="//movies_by_year/@description"/>
  </div>
  <table class="table">
    <tr>
      <th>Year</th>
      <th>Movies</th>
    </tr>
    <xsl:for-each select="//movies_by_year/year">
      <xsl:variable name="year" select="@value"/>
      <xsl:variable name="titlesCount" select="count(./movie)"/>

      <xsl:for-each select="movie">
        <xsl:variable name="movieTitle" select="."/>

        <tr>
          <xsl:if test="position() = 1">
            <td>
              <xsl:attribute name="rowspan">
                <xsl:value-of select="$titlesCount"/>
              </xsl:attribute>
              <xsl:value-of select="$year"/>
            </td>
          </xsl:if>
          <td>
            <xsl:value-of select="$movieTitle"/>
          </td>
        </tr>
      </xsl:for-each>
    </xsl:for-each>
  </table>
</xsl:template>

<xsl:template name="movies_count_by_year_template">
  <div class="col-12">
    <xsl:value-of select="//movies_count_by_year/@description"/>
  </div>
  <table class="table">
    <tr>
      <th>Year</th>
      <th>Movies Count</th>
    </tr>
    <xsl:for-each select="//movies_count_by_year/year">
      <xsl:variable name="year" select="@value"/>
      <xsl:variable name="moviesCount" select="."/>

      <tr>
        <td>
          <xsl:value-of select="$year"/>
        </td>
        <td>
          <xsl:value-of select="$moviesCount"/>
        </td>
      </tr>

    </xsl:for-each>
  </table>
</xsl:template>

</xsl:stylesheet>
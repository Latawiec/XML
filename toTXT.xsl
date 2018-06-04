<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
<xsl:template match="/">

  <xsl:text>!---Top movies list---!</xsl:text>
  <xsl:call-template name="newline"/>
  <xsl:call-template name="newline"/>

  <xsl:text>Movies by genre</xsl:text>
  <xsl:call-template name="newline"/>
  <xsl:call-template name="movies_by_genre_template"/>   

</xsl:template>

<xsl:template name="newline">
  <xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template name="indent">
  <xsl:text>  </xsl:text>
</xsl:template>

<xsl:variable name="spaces">
<xsl:text>                                                                                                                                    </xsl:text>
</xsl:variable>

<xsl:template name="movies_by_genre_template">
  
  <xsl:call-template name="newline"/>
  <xsl:value-of select="concat('Description:', '&#xA;', //movies_count_by_genre/@description)"/>
  <xsl:call-template name="newline"/>
  <xsl:call-template name="newline"/>

  <xsl:value-of select="substring(concat('|Genre', $spaces), 1, 50)"/>
  <xsl:value-of select="substring(concat('|Title', $spaces), 1, 50)"/>
  <xsl:call-template name="newline"/>
  <xsl:for-each select="//movies_by_genre/genre">
      <xsl:variable name="genreName" select="@name"/>

      <xsl:for-each select="movie">
        <xsl:variable name="movieTitle" select="."/>
        <xsl:call-template name="newline"/>

          <xsl:choose>
            <xsl:when test="position() = 1">
              <xsl:value-of select="substring(translate($spaces, ' ', '-'), 1, 50)"/>
              <xsl:value-of select="substring(translate($spaces, ' ', '-'), 1, 50)"/>
              <xsl:call-template name="newline"/>

              <xsl:value-of select="substring(concat($genreName, $spaces), 1, 50)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="substring($spaces, 1, 50)"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:value-of select="substring(concat($movieTitle, $spaces), 1, 50)"/>

      </xsl:for-each>
    </xsl:for-each>
</xsl:template>
</xsl:stylesheet>
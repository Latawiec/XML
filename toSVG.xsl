<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/2000/svg"
xmlns:xs="http://www.w3.org/2001/XMLSchema">

<xsl:output
     method="xml"
     encoding="UTF-8"
     indent="yes"/>

<xsl:template match="/">
  <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%">
    
    <xsl:call-template name="movies_count_by_genre_template">
    </xsl:call-template>
  </svg>

</xsl:template>

<xsl:template name="movies_count_by_genre_template">
  <xsl:variable name="W" select="500"/>
  <xsl:variable name="H" select="350"/>

  <rect id="movies_count_by_genre_CHART" x="10" y="50" fill="ghostwhite">
    <xsl:attribute name="width">
      <xsl:value-of select="$W"/>
    </xsl:attribute>

    <xsl:attribute name="height">
      <xsl:value-of select="$H"/>
    </xsl:attribute>
  </rect>

  <xsl:variable name="elementsCount" select="count(//movies_count_by_genre/genre)"/>

  <xsl:for-each select="//movies_count_by_genre/genre">
    <rect y="50" width="2" fill="black" opacity="0.4">
      <xsl:attribute name="x">
        <xsl:value-of select="(position() - 1) * ($W div $elementsCount) + 10"/>
      </xsl:attribute>
      <xsl:attribute name="height">
        <xsl:value-of select="$H"/>
      </xsl:attribute>
    </rect>
    <text writing-mode="tb-rl">
      <xsl:attribute name="y">
        <xsl:value-of select="50 + $H + 20"/>
      </xsl:attribute>
      <xsl:attribute name="x">
        <xsl:value-of select="(position() - 1) * ($W div $elementsCount) + 10"/>
      </xsl:attribute>
      <xsl:value-of select="@name"/>
    </text>
  </xsl:for-each>

  <xsl:variable name="maximumValue" select="max(//movies_count_by_genre/genre/xs:integer(.))"/>

  <xsl:for-each select="0 to $maximumValue">
    <rect x="10" height="2" fill="black" opacity="0.4">
      <xsl:attribute name="y">
        <xsl:value-of select="(position() - 1) * ($H div $maximumValue) + 50"/>
      </xsl:attribute>
      <xsl:attribute name="width">
        <xsl:value-of select="$W"/>
      </xsl:attribute>
    </rect>
    <text x="2">
      <xsl:attribute name="y">
        <xsl:value-of select="$H - (position() - 1) * ($H div $maximumValue) + 50"/>
      </xsl:attribute>
      <xsl:value-of select="xs:integer(position()-1)"/>
    </text>
  </xsl:for-each>

  <xsl:for-each select="//movies_count_by_genre/genre">
    <xsl:if test="not(position() = last())">
      <xsl:variable name="currentX" select="(position()-1) * ($W div $elementsCount)"/>
      <xsl:variable name="nextX"    select="position() * ($W div $elementsCount)"/>

      <xsl:variable name="currentY" select="$H - xs:integer(.) * ($H div $maximumValue)"/>
      <xsl:variable name="nextY" select="$H - ( xs:integer(following-sibling::genre[1]) * ($H div $maximumValue) )"/>

      <line style="stroke:rgb(255,0,0);stroke-width:2">
        <xsl:attribute name="x1">
          <xsl:value-of select="$currentX + 10"/>
        </xsl:attribute>
        <xsl:attribute name="y1">
          <xsl:value-of select="$currentY + 50"/>
        </xsl:attribute>
        <xsl:attribute name="x2">
          <xsl:value-of select="$nextX + 10"/>
        </xsl:attribute>
        <xsl:attribute name="y2">
          <xsl:value-of select="$nextY + 50"/>
        </xsl:attribute>
      </line>
    </xsl:if>

  </xsl:for-each>

</xsl:template>

</xsl:stylesheet>
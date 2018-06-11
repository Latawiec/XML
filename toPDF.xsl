<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version   = "1.0"
                xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
                xmlns:fo  = "http://www.w3.org/1999/XSL/Format">

  <xsl:output method    = "xml"
              encoding  = "utf-8"/>

  <xsl:template match = "/">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master  master-name   = "Filmy"
                                page-height   = "297mm"
                                page-width    = "210mm"
                                margin-top    = "20mm"
                                margin-bottom = "10mm"
                                margin-left   = "25mm"
                                margin-right  = "25mm">
          <fo:region-body   margin = "20mm"/>
          <fo:region-before extent = "5" />
          <fo:region-after  extent = "5" />
          <fo:region-start  extent = "5" />
          <fo:region-end    extent = "5" />
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference = "Filmy">

        <!-- Header -->
        <fo:static-content flow-name = "xsl-region-before">
          <fo:block text-align  = "right"
                    font-family = "Segoe UI"
                    font-size   = "10px">
            <xsl:text>Filmy</xsl:text>
          </fo:block>
        </fo:static-content>

        <!-- Footer -->
        <fo:static-content flow-name = "xsl-region-after">
          <fo:block text-align  = "center"
                    font-family = "Segoe UI"
                    font-size   = "10px">
            <xsl:text>page </xsl:text><fo:page-number/>
          </fo:block>
        </fo:static-content>

        <!-- Content -->
        <fo:flow flow-name = "xsl-region-body">
          <xsl:call-template name="movies_by_genre"/>
        </fo:flow>

      </fo:page-sequence>
    </fo:root>

  </xsl:template>

  <xsl:template name="movies_by_genre">
    <!-- Table name -->
    <fo:block font-size="16px"
              text-align="left"
              font-family="Segoe UI">
      <xsl:text>Movies by genre</xsl:text>
    </fo:block>

    <fo:block>
      <fo:table border = "solid black"
                width  = "100%">
        <!-- Table header -->
        <fo:table-header>
          <fo:table-row>
            <!-- Genre -->
            <fo:table-cell>
              <fo:block font-weight = "bold"
                        text-align  = "center">
                Genre
              </fo:block>
            </fo:table-cell>
            <!-- Movies -->
            <fo:table-cell>
              <fo:block font-weight = "bold"
                        text-align  = "center">
                Movies
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-header>

        <!-- Table content -->
        <fo:table-body>
          <xsl:for-each select="//movies_by_genre/genre">
            <xsl:variable name="genreName" select="@name"/>
            <fo:table-row>
              <!-- Genre Name -->
              <fo:table-cell border="solid black">
                <fo:block text-align="center">
                  <xsl:value-of select="$genreName"/>
                </fo:block>
              </fo:table-cell>

              <!-- Movies List -->
              <fo:table-cell border="solid black">
                <fo:block>
                  <xsl:for-each select="movie">
                    <fo:block text-align="center">
                      <xsl:value-of select="."/>
                    </fo:block>
                  </xsl:for-each>
                </fo:block>
              </fo:table-cell>

            </fo:table-row>
          </xsl:for-each>
        </fo:table-body>

      </fo:table>
    </fo:block>

  </xsl:template>

</xsl:stylesheet>
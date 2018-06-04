<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
    <movies_by_genre description="What movies are of given genre?">
        <xsl:for-each select="//genres/genre">
            <xsl:variable name="genreName" select="."/>
            <xsl:variable name="ID" select="@id_g"/>

            <genre>
                <xsl:attribute name="name">
                    <xsl:value-of select="$genreName"/>
                </xsl:attribute>
                <xsl:for-each select="../../movies_list/movie[@genre_id_ref=$ID]">
                    <movie><xsl:value-of select="titles/title"/></movie>
                </xsl:for-each>
            </genre>
        </xsl:for-each>
    </movies_by_genre>

    <movies_count_by_genre description="How many movies are of given genre?">
        <xsl:for-each select="//genres/genre">
            <xsl:variable name="genreName" select="."/>
            <xsl:variable name="ID" select="@id_g"/>
            <xsl:variable name="count" select="count(../../movies_list/movie[@genre_id_ref=$ID])"/>

            <genre>
                <xsl:attribute name="name">
                    <xsl:value-of select="$genreName"/>
                </xsl:attribute>
                <xsl:value-of select="$count"/>
            </genre>

        </xsl:for-each>
    </movies_count_by_genre>

    <movies_titles_count description="How many titles are registered for given movie?">
        <xsl:for-each select="//movies_list/movie">
            <xsl:variable name="originalName" select="titles/title[@original='true']"/>
            <movie>
                <xsl:attribute name="name">
                    <xsl:value-of select="$originalName"/>
                </xsl:attribute>
                <xsl:value-of select="count(titles/title)"/>
            </movie>
        </xsl:for-each>
    </movies_titles_count>

    <movies_by_original_title_to_locale_id description="What movies have original title in given language?">
        <xsl:for-each select="//locales/localeId">
            <xsl:variable name="localeName" select="."/>
            <xsl:variable name="ID" select="@id_lang"/>

            <locale>
                <xsl:attribute name="localeId">
                    <xsl:value-of select="$localeName"/>
                </xsl:attribute>

                <xsl:for-each select="../../movies_list/movie/titles/title[@locale_id_ref=$ID and @original='true']">
                    <xsl:variable name="originalName" select="."/>
                        <movie>
                            <xsl:value-of select="$originalName"/>
                        </movie>
                </xsl:for-each>
            </locale>
        </xsl:for-each>
    </movies_by_original_title_to_locale_id>

    <original_titles_count_by_locale_id description="How many movies have original title in given language?">
        <xsl:for-each select="//locales/localeId">
            <xsl:variable name="localeName" select="."/>
            <xsl:variable name="ID" select="@id_lang"/>

            <locale>
                <xsl:attribute name="localeId">
                    <xsl:value-of select="$localeName"/>
                </xsl:attribute>
                <xsl:value-of select="count(../../movies_list/movie/titles/title[@locale_id_ref=$ID and @original='true'])"/>
            </locale>
        </xsl:for-each>
    </original_titles_count_by_locale_id>

    <movies_by_year description="Which movies were released in given year?">
        <xsl:for-each select="//movies_list/movie/release_date/year[not(.=preceding::*)]">
            <xsl:sort select="."/>
            <xsl:variable name="yearValue" select="."/>
            <year>
                <xsl:attribute name="value">
                    <xsl:value-of select="$yearValue"/>
                </xsl:attribute>
                <xsl:for-each select="//movies_list/movie/titles/title[../../release_date/year = $yearValue and @original='true']">
                    <xsl:variable name="originalName" select="."/>
                    <movie>
                        <xsl:value-of select="$originalName"/>
                    </movie>
                </xsl:for-each>
            </year>
        </xsl:for-each>
    </movies_by_year>

    <movies_count_by_year description="How many movies were released in given year?">
        <xsl:for-each select="//movies_list/movie/release_date/year[not(.=preceding::*)]">
            <xsl:sort select="."/>
            <xsl:variable name="yearValue" select="."/>
            <year>
                <xsl:attribute name="value">
                    <xsl:value-of select="$yearValue"/>
                </xsl:attribute>
                <xsl:value-of select="count(//movies_list/movie/titles/title[../../release_date/year = $yearValue and @original='true'])"/>
            </year>
        </xsl:for-each>
    </movies_count_by_year>
    
</xsl:template>
<!-- main template -->

</xsl:stylesheet>
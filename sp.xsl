<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0">
  <xsl:variable name="num" select="1" />
  <xsl:variable name="speaker">
    <xsl:choose>
      <xsl:when test="contains(//tei:speaker[1]/text(), '.')"><xsl:value-of select="substring-before(./text(), '.')" /></xsl:when>
      <xsl:otherwise><xsl:value-of select="//tei:speaker[1]/text()" /></xsl:otherwise>
    </xsl:choose>
    
  </xsl:variable>
  <xsl:variable name="filename" select="concat(substring-after(document-uri(/), 'ente/'),'-1')" />
<xsl:template match="/">
  <xsl:result-document href="{$filename}" method="xml" indent="yes">
    <root>
    <xsl:for-each select="//tei:speaker">
      <xsl:element name="speak">
        <xsl:attribute name="who">
          <xsl:choose>
            <xsl:when test="contains(./text(), '.')"><xsl:value-of select="substring-before(./text(), '.')" /></xsl:when>
            <xsl:otherwise><xsl:value-of select="./text()" /></xsl:otherwise>
          </xsl:choose>
          </xsl:attribute>
        <xsl:value-of select="following-sibling::tei:l/text() | following-sibling::tei:lg/tei:l/text()" />
      </xsl:element>
    </xsl:for-each>
    </root>
  </xsl:result-document>
</xsl:template>
</xsl:stylesheet>

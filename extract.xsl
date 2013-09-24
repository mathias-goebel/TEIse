<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="filename" select="substring-after(document-uri(/), '/2/')" />
    <xsl:variable name="newName" select="concat('sorted_', $filename, '.xml')" />
    <xsl:strip-space elements="*"/>
        <xsl:template match="/">
                <xsl:apply-templates />
        </xsl:template>
    <xsl:template match="speak[1]">
        <xsl:variable name="who" select="@who" />
        <xsl:variable name="newFile" select="concat(substring-before($filename, '.xml'), '/', @who)" />
        <xsl:result-document href="{$newFile}" method="text">
            <xsl:value-of select="//speak[@who = $who]" />
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="speak[@who != preceding::speak[1]/@who]">
        <xsl:variable name="who" select="@who" />
        <xsl:variable name="newFile" select="concat(substring-before($filename, '.xml'), '/', @who)" />
    <xsl:result-document href="{$newFile}" method="text">
        <xsl:value-of select="//speak[@who = $who]" />
    </xsl:result-document>
</xsl:template>
</xsl:stylesheet>

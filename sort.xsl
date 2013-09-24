<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="filename" select="substring-after(document-uri(/), '/2/')" />
    <xsl:variable name="newName" select="concat('sorted_', $filename, '.xml')" />
<xsl:strip-space elements="*"/>
        <xsl:template match="@*|node()">
<!--            <xsl:result-document href="{$newName}" method="xml" indent="yes">-->
            <xsl:copy>
                <xsl:apply-templates select="@*|node()">
                    <xsl:sort select="@who"/>
                </xsl:apply-templates>
            </xsl:copy>
        <!--    </xsl:result-document>-->
        </xsl:template>

    
<!--    <xsl:template match="speak[@who != preceding::speak[2]/@who]">
                <xsl:value-of select="./text()" />
    </xsl:template>-->
</xsl:stylesheet>

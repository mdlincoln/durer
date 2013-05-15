<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" version="1.0" encoding="utf8" />
<xsl:template match="/diary">
	Title|Date|Text|Location|People|Artwork
	<xsl:apply-templates match="entry"/>
</xsl:template>

<xsl:template select="entry">		
	<!-- Print dates, diary text -->
	<xsl:value-of select="date"/>|<xsl:value-of select="date"/>|<xsl:value-of select="text" />|<xsl:apply-templates match="text/place"/>
</xsl:template>
	
	<!-- Print all places -->
<xsl:template select="place">	
	<xsl:variable name="placeID">					
		<xsl:value-of select="@id" />
	</xsl:variable>
	<xsl:variable name="placeName">
		<xsl:value-of select="document('../xml/locations.xml')/Document/Row[@id=$placeID]/name" />
	</xsl:variable>
	<xsl:value-of select="$placeName"/>,
</xsl:template>

</xsl:stylesheet>
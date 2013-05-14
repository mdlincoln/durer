<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" version="1.0" encoding="utf8" />
<xsl:template match="/diary">
	Title|Date|Text|Location|People|Artwork
	<xsl:apply-templates match="entry"/>
</xsl:template>

<xsl:template select="entry">		
	<!-- Print dates, diary text -->
	<xsl:value-of select="date"/>|<xsl:value-of select="date"/>|<xsl:value-of select="text" />|
	
	<!-- Print all places -->
	<xsl:for-each select="place">

		<xsl:variable name="placeID">					
			<xsl:value-of select="@id" />
		</xsl:variable>

		<xsl:variable name="placeName">
			<xsl:value-of select="document('artworks.xml')/document/row[@id=$placeID]/name" />
		</xsl:variable>

		<xsl:value-of select="$placeName"/>,

	</xsl:for-each>

	<!-- Print all people -->
	<xsl:for-each select="People">
		<xsl:variable name="personID" select="@id" />
		<xsl:varible name="personName"><xsl:value-of select="document('people.xml')/document/row[@id=$placeID]/name" />
		<xsl:value-of select="$personName"/>,

</xsl:template>

</xsl:stylesheet>
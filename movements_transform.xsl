<!-- XSLT stylesheet to translate Dürer diary markup into an XML compatible with the Artists' Movements project -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xpath="http://www.w3.org/2005/xpath-functions">
	<xsl:output method="xml" omit-xml-declaration="yes" version="1.0" encoding="utf-8" indent="yes" />

	<xsl:template match="/diary">
			<artist>
				<name>Albrecht Dürer</name>
				<xsl:apply-templates select="entry/text/place" />
			</artist>
	</xsl:template>

	<xsl:template match="place">
		<xsl:variable name="placeID" select="@id" />
		<xsl:variable name="location" select="document('xml/locations.xml')/Document/Row[@id=$placeID]/name" />
		<xsl:variable name="date" select="../../date" />
		<location>
			<place><xsl:value-of select="$location" /></place>
			<begin><xsl:value-of select="$date" /></begin>
			<end><xsl:value-of select="$date" /></end>
		</location>
	</xsl:template>
</xsl:stylesheet>
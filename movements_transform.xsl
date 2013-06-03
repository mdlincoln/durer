<!-- XSLT stylesheet to translate Dürer diary markup into an XML compatible with the Artists' Movements project -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
	<xsl:output method="xml" omit-xml-declaration="yes" version="1.0" encoding="utf-8" indent="yes" />

	<xsl:template match="/diary">
			<artist>
				<name>Albrecht Dürer</name>
				<xsl:apply-templates select="entry/text/place" />
			</artist>
	</xsl:template>

	<xsl:template match="place">
		<xsl:variable name="placeID" select="@id" />
		<xsl:variable name="location" select="document('locations.xml')/Document/Row[@id=$placeID]/name" />
		<xsl:variable name="date" select="../../date" />
		<xsl:variable name="entry" select=".." />
		<location>
			<place><xsl:value-of select="$location" /></place>
			<begin><xsl:value-of select="$date" /></begin>
			<end><xsl:value-of select="$date" /></end>
			<notes>
				<p>Dürer's Diary of his trip to the Netherlands, 1520-1521</p>
				<p><xsl:value-of select="$entry"/></p>
			</notes>
		</location>
	</xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" version="1.0" encoding="utf-8" indent="yes"/>
<xsl:template match="/personList"><xsl:for-each select="person"><xsl:value-of select="@id"/>|<xsl:value-of select="name" />|<xsl:value-of select="birthDate" />|<xsl:value-of select="deathDate" />|<xsl:value-of select="description" />|
</xsl:for-each></xsl:template>

</xsl:stylesheet>
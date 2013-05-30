<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xpath="http://www.w3.org/2005/xpath-functions">
<xsl:output method="xml" omit-xml-declaration="yes" version="1.0" encoding="utf-8" indent="yes" />

<!-- Declare location.xml location -->
<xsl:variable name="locationsDat" select="'locations.xml'" />
	
<!-- Declare people.xml location -->
<xsl:variable name="peopleDat" select="'people.xml'" />

<!-- Declare artworks.xml location -->
<xsl:variable name="artDat" select="'artworks.xml'" />

<!-- Top-level header -->
<xsl:template match="/diary">
    <kml xmlns="http://www.opengis.net/kml/2.2"
 xmlns:gx="http://www.google.com/kml/ext/2.2">
    	<Document>
    		<name>Albrecht Durer's Diary of his Trip to the Netherlands: 1520-1521</name>
    		<open>1</open>

    		<description>
		 		<p>This map has been generated from the text of the first month of Albrecht Dürer's diary of his trip to the Netherlands in 1520-1521. By encoding the text as an XML document, marking up places, people, and artworks as elements in a hierarchical tree of diary entries, we were able to create a machine-readable "index" of the diary. Matthew Lincoln develped a computer script to read this text and translate it into a KML file readable by Google Earth.</p>

		 		<hr/>
				<p>By <a href="http://mlincoln.wordpress.com">Matthew Lincoln, 2013</a></p>
				<p>Ph.D student, Graduate Assistant in the Digital Humanitites, Department of Art History and Archaeology, University of Maryland, College Park.</p>
			 </description>

			 <atom:author>
			 	<atom:name>Matthew Lincoln, Michelle Smith Collaboratory for Visual Culture, Department of Art History <![CDATA[&]]> Archaeology, University of Maryland, College Park</atom:name>
			 </atom:author>
			 <atom:link href="http://michellesmithcollaboratory.umd.edu/" rel="related"></atom:link>

    		<!-- Artwork style -->
    		<StyleMap id="msn_square">
    			<Pair>
    				<key>normal</key>
    				<styleUrl>#square</styleUrl>
    			</Pair>
    			<Pair>
    				<key>highlight</key>
    				<styleUrl>#Hsquare</styleUrl>
    			</Pair>
    		</StyleMap>
    		<Style id="square">
    			<IconStyle>
    				<scale>0.7</scale>
    				<Icon><href>http://maps.google.com/mapfiles/kml/shapes/square.png</href></Icon>
    			</IconStyle>
    			<LabelStyle>
    				<scale>0.7</scale>
    			</LabelStyle>
    		</Style>
    		<Style id="Hsquare">
    			<IconStyle>
    				<scale>1.2</scale>
    				<Icon>
    					<href>http://maps.google.com/mapfiles/kml/shapes/square.png</href>
    				</Icon>
    			</IconStyle>
    		</Style>

    		<!-- City Style -->
    		<StyleMap id="city">
    			<Pair>
    				<key>normal</key>
    				<styleUrl>#cityN</styleUrl>
    			</Pair>
    			<Pair>
    				<key>highlight</key>
    				<styleUrl>#cityH</styleUrl>
    			</Pair>
    		</StyleMap>
    		<Style id="cityH">
    			<IconStyle>
    				<scale>1.1</scale>
    				<Icon>
    					<href>http://maps.google.com/mapfiles/kml/pushpin/blue-pushpin.png</href>
    				</Icon>
    			</IconStyle>
    			<LabelStyle>
    				<scale>1</scale>
    			</LabelStyle>
    		</Style>
    		<Style id="cityN">
    			<IconStyle>
    				<scale>0.9</scale>
    				<Icon>
    					<href>http://maps.google.com/mapfiles/kml/pushpin/blue-pushpin.png</href>
    				</Icon>
    			</IconStyle>
    			<LabelStyle>
    				<scale>0.7</scale>
    			</LabelStyle>
    		</Style>

    		<!-- Person style -->
    		<StyleMap id="person">
    			<Pair>
    				<key>normal</key>
    				<styleUrl>#p1</styleUrl>
    			</Pair>
    			<Pair>
    				<key>highlight</key>
    				<styleUrl>#p2</styleUrl>
    			</Pair>
    		</StyleMap>
    		<Style id="p1">
    			<IconStyle>
    				<scale>0.9</scale>
    				<Icon>
    					<href>http://maps.google.com/mapfiles/kml/shapes/man.png</href>
    				</Icon>
    			</IconStyle>
    			<LabelStyle>
    				<scale>0.7</scale>
    			</LabelStyle>
    		</Style>
    		<Style id="p2">
    			<IconStyle>
    				<scale>1.1</scale>
    				<Icon>
    					<href>http://maps.google.com/mapfiles/kml/shapes/man.png</href>
    				</Icon>
    			</IconStyle>
    			<LabelStyle>
    				<scale>1</scale>
    			</LabelStyle>
    		</Style>


    		<!-- Draws a static line of Dürer's journey -->
    		<Placemark>
    			<name>Dürer's Path</name>
    			<Style id="line">
					<LineStyle>
						<color>ff0080ff</color>
						<width>3</width>
					</LineStyle>
				</Style>
				<TimeSpan>
					<begin>1520-07-12</begin>
					<end>1520-08-06</end>
				</TimeSpan>
    			<LineString>
    				<tessellate>1</tessellate>
    				<coordinates>
    					<xsl:for-each select="entry/text/place">
    						<xsl:variable name="placeID"><xsl:value-of select="@id" /></xsl:variable>

    						<xsl:variable name="coordinates"><xsl:value-of select="document($locationsDat)/Document/Row[@id=$placeID]/coordinates" /></xsl:variable>
    						<xsl:if test="string-length($coordinates) != 0">								
    							<xsl:value-of select="$coordinates" />&#160;
    						</xsl:if>
    					</xsl:for-each>
    				</coordinates>
    			</LineString>
    		</Placemark>

				
			<Folder>
				<name>The Places</name>
				<xsl:apply-templates select="entry/text/place"/>
			</Folder>

			<Folder>
				<name>The Artworks</name>
				<xsl:apply-templates select="entry/text/place/artwork" />
			</Folder>
			
			<Folder>
				<name>The People</name>
				<xsl:apply-templates select="entry/text/place/person" />
			</Folder>

        </Document>
    </kml>
</xsl:template>

<!-- Generate pushpins for each city -->
<xsl:template match="place">
	<!-- Create a variable for the place ID -->
	<xsl:variable name="placeID">					
		<xsl:value-of select="@id" />
	</xsl:variable>
	<xsl:variable name="coordinates">
		<xsl:value-of select="document($locationsDat)/Document/Row[@id=$placeID]/coordinates" />
	</xsl:variable>
	<xsl:variable name="time"><xsl:value-of select="../../date"/></xsl:variable>


	<!-- Check if place has a location assigned to it. If not, does not create placemark -->
	<xsl:if test="string-length($coordinates) != 0">
	<!-- Calls external locations.xml file for the name and coordinates of the city -->
		<Placemark>
			<styleUrl>#city</styleUrl>
			<name>
				<xsl:value-of select="document($locationsDat)/Document/Row[@id=$placeID]/name" />
			</name>

			<TimeStamp>
				<xsl:value-of select="$time" />
			</TimeStamp>

			<description>
<!-- 			Inserts associated entry -->
				
				<p><b><xsl:value-of select="$time" />: </b>"<xsl:value-of select=".." />"</p>
			</description>

			<MultiGeometry>
				<Point><coordinates><xsl:value-of select="$coordinates" /></coordinates></Point>
			</MultiGeometry>
		</Placemark>
	</xsl:if>
</xsl:template>

<!-- Generates floating pushpins for artworks at key cities -->
<xsl:template match="artwork">

<!-- 	Art Variable Declarations -->
	<xsl:variable name="artID">
		<xsl:value-of select="@id"/>
	</xsl:variable>
	<xsl:variable name="placeID">
		<xsl:value-of select="../@id"/>
	</xsl:variable>
	<xsl:variable name="artName">
		<xsl:value-of select="document('artworks.xml')/Document/Row[@id=$artID]/name"/>
	</xsl:variable>
	<xsl:variable name="artDate">
		<xsl:value-of select="document('artworks.xml')/Document/Row[@id=$artID]/date"/>
	</xsl:variable>
	<xsl:variable name="artMedium">
		<xsl:value-of select="document('artworks.xml')/Document/Row[@id=$artID]/medium"/>
	</xsl:variable>
	<xsl:variable name="artNote">
		<xsl:value-of select="document('artworks.xml')/Document/Row[@id=$artID]/note"/>
	</xsl:variable>
	<xsl:variable name="artCoordinates">
		<xsl:value-of select="document($locationsDat)/Document/Row[@id=$placeID]/coordinates" />
	</xsl:variable>
	<xsl:variable name="artImg" select="document('artworks.xml')/Document/Row[@id=$artID]/img" />

	<xsl:variable name="time"><xsl:value-of select="../../../date"/></xsl:variable>

	
	<xsl:choose>
<!-- 	Artwork with image -->
	<xsl:when test="string-length($artImg) != 0">	

		<Style>
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>

			<IconStyle>
				<scale>1.7</scale>
				<Icon><href><xsl:value-of select="$artImg"/></href></Icon>
				<hotSpot x="0.5" y="0.5" xunits="fraction" yunits="fraction"/>
			</IconStyle>
			<LineStyle>
				<width>2</width>
			</LineStyle>
		</Style>
	
		<Placemark>
			<styleUrl><xsl:value-of select="@id" /></styleUrl>		
			<name><xsl:copy-of select="$artName" /></name>
			<description>
				<xsl:if test="string-length($artDate) != 0">
					<p><b>Date: </b><xsl:copy-of select="$artDate" /></p>
				</xsl:if>
				<xsl:if test="string-length($artMedium) != 0">
					<p><b>Medium: </b><xsl:copy-of select="$artMedium" /></p>
				</xsl:if>
				<xsl:if test="string-length($artNote) != 0">
					<p><b>Notes: </b><xsl:copy-of select="$artNote" /></p>
				</xsl:if>
				<p><b><xsl:value-of select="$time" />: </b>"<xsl:value-of select="../.."/>"</p>
				<p><img><xsl:attribute name="src"><xsl:copy-of select="$artImg" /></xsl:attribute></img></p>
			</description>

			<TimeStamp>
				<xsl:value-of select="$time" />
			</TimeStamp>


			<Point>
				<extrude>1</extrude>
				<altitudeMode>relativeToGround</altitudeMode>
				<coordinates><xsl:copy-of select="$artCoordinates"/>&#x2c;0</coordinates>
			</Point>
		</Placemark>
	</xsl:when>

<!-- 	Generates empty pushpins for image-less artworks -->
	<xsl:otherwise>
		<Placemark>
			<name><xsl:value-of select="$artName"/></name>
			<description>
				<xsl:if test="string-length($artDate) != 0">
					<p><b>Date: </b><xsl:copy-of select="$artDate" /></p>
				</xsl:if>
				<xsl:if test="string-length($artMedium) != 0">
					<p><b>Medium: </b><xsl:copy-of select="$artMedium" /></p>
				</xsl:if>
				<xsl:if test="string-length($artNote) != 0">
					<p><b>Notes: </b><xsl:copy-of select="$artNote" /></p>
				</xsl:if>
				<p><b><xsl:value-of select="$time" />: </b>"<xsl:value-of select="../.."/>"</p>
			</description>

			<TimeStamp>
				<xsl:value-of select="$time" />
			</TimeStamp>

			<styleUrl>#msn_square</styleUrl>		
			<Point>
				<extrude>1</extrude>
				<altitudeMode>relativeToGround</altitudeMode>
				<coordinates><xsl:value-of select="$artCoordinates" />&#x2c;0</coordinates>
			</Point>
		</Placemark>
	</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- Generates people pins -->
<xsl:template match="person">

	<xsl:variable name="personID"><xsl:value-of select="@id"/></xsl:variable>

	<xsl:variable name="personName"><xsl:value-of select="document('people.xml')/Document/Row[@id=$personID]/name" /></xsl:variable>
	
	<xsl:variable name="personDescription"><xsl:value-of select="document('people.xml')/Document/Row[@id=$personID]/description" /></xsl:variable>
	
	<xsl:variable name="birthDate"><xsl:value-of select="document('people.xml')/Document/Row[@id=$personID]/birthDate" /></xsl:variable>
	
	<xsl:variable name="deathDate"><xsl:value-of select="document('people.xml')/Document/Row[@id=$personID]/deathDate" /></xsl:variable>
	
	<xsl:variable name="placeID">
		<xsl:value-of select="../@id"/>
	</xsl:variable>
	
	<xsl:variable name="personCoordinates">
		<xsl:value-of select="document($locationsDat)/Document/Row[@id=$placeID]/coordinates" />
	</xsl:variable>
	
	<xsl:variable name="time"><xsl:value-of select="../../../date"/></xsl:variable>


	<Placemark>
		<styleUrl>#person</styleUrl>
		<name><xsl:value-of select="$personName" /><!--  - "...<xsl:value-of select="." />..." --></name>
		<description>
			<xsl:if test="string-length($birthDate) != 0">
				<p><b>Born: </b><xsl:copy-of select="$birthDate" /></p>
			</xsl:if>
			<xsl:if test="string-length($deathDate) != 0">
				<p><b>Died: </b><xsl:copy-of select="$deathDate" /></p>
			</xsl:if>
			<xsl:if test="string-length($personDescription) != 0">
				<p><b>Notes: </b><xsl:copy-of select="$personDescription" /></p>
			</xsl:if>
			<p><b><xsl:value-of select="$time" />: </b>"<xsl:value-of select="../.."/>"</p>
		</description>

		<TimeStamp>
				<xsl:value-of select="$time" />
		</TimeStamp>

		<Point>
			<extrude>1</extrude>
			<altitudeMode>relativeToGround</altitudeMode>
			<coordinates><xsl:copy-of select="$personCoordinates"/>&#x2c;0</coordinates>
		</Point>
	</Placemark>
</xsl:template>


<!-- END -->
</xsl:stylesheet>

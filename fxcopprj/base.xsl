<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/FxCopReport">
	<html>
		<body>
			<div>
            FxCop Tool Version <xsl:value-of select="@Version"/><br/>
			<xsl:apply-templates select="Targets"/>
			<xsl:apply-templates select="Namespaces"/>
			<xsl:apply-templates select="Rules"/>
			</div>
		</body>
	</html>
</xsl:template>	
		
<xsl:template name="table">
	<xsl:param name="data"/>
	<xsl:param name="title"/>
	<xsl:param name="id"/>
	<div class="infoDiv">
		<ul>
		<li>
			<button type="button">
			<xsl:attribute name="onclick">
				showHide('<xsl:value-of select="$id"/>',this);
			</xsl:attribute>
			-</button>
		</li>
		<li>
			<xsl:value-of select="name($data[1]/..)"/> - <xsl:value-of select="count($data)"/>
		</li>
		</ul>
	</div>
	<div class="infoDiv" style="visibility:visible;">
		<xsl:attribute name="id">
			<xsl:value-of select="$id"/>
		</xsl:attribute>	

		<table border="1">
			<xsl:for-each select="$data">				 
				<xsl:sort select="@*[name()=$title]"/>
				<tr><td>
					<xsl:value-of select="position()"/>
				</td><td>
					<xsl:value-of select="@*[name()=$title]"/>
				</td></tr>
			</xsl:for-each>
		</table>
	</div>
</xsl:template>	

<xsl:template name="Titles">
	<xsl:param name="title"/>
	<div class="infoDiv">
		<ul>
		<li>
			<button type="button">
			<xsl:attribute name="onclick">
				showHide('<xsl:value-of select="$title"/>',this);
			</xsl:attribute>
			-</button>
		</li>
		<li>
			<xsl:value-of select="$title"/> - <xsl:value-of select="count(child::*)"/>
		</li>
		</ul>
	</div>
</xsl:template>	

<xsl:template match="Targets">   
	<xsl:variable name="nodeTitle">
		<xsl:value-of select="name(.)"/>
	</xsl:variable>

	<xsl:call-template name="Titles">
		<xsl:with-param name="title" select="$nodeTitle"/>
	</xsl:call-template>

	<div class="infoDiv" style="visibility:visible;">
		<xsl:attribute name="id">
			<xsl:value-of select="$nodeTitle"/>
		</xsl:attribute>	
		<table border="1">
			<xsl:for-each select="child::*">				 
				<xsl:sort select="@Name"/>
				<tr><td>
					<xsl:value-of select="position()"/>
				</td><td>
					<xsl:value-of select="@Name"/>
				</td></tr>
			</xsl:for-each>
		</table>
	</div>
</xsl:template>

<xsl:template match="Namespaces">   
	<xsl:variable name="nodeTitle">
		<xsl:value-of select="name(.)"/>
	</xsl:variable>

	<xsl:call-template name="Titles">
		<xsl:with-param name="title" select="$nodeTitle"/>
	</xsl:call-template>

	<div class="infoDiv" style="visibility:visible;">
		<xsl:attribute name="id">
			<xsl:value-of select="$nodeTitle"/>
		</xsl:attribute>	
		<table border="1">
			<xsl:for-each select="child::*">				 
				<xsl:sort select="@Name"/>
				<tr><td>
					<xsl:value-of select="position()"/>
				</td><td>
					<xsl:value-of select="@Name"/>
				</td></tr>
			</xsl:for-each>
		</table>
	</div>
</xsl:template>

<xsl:template match="Rules">   
	<xsl:variable name="nodeTitle">
		<xsl:value-of select="name(.)"/>
	</xsl:variable>

	<xsl:call-template name="Titles">
		<xsl:with-param name="title" select="$nodeTitle"/>
	</xsl:call-template>

	<div class="infoDiv" style="visibility:visible;">
		<xsl:attribute name="id">
			<xsl:value-of select="$nodeTitle"/>
		</xsl:attribute>	
		<table border="1">
			<xsl:for-each select="child::*">				 
				<xsl:sort select="@TypeName"/>
				<tr><td>
					<xsl:value-of select="position()"/>
				</td><td>
					<xsl:value-of select="@TypeName"/>
				</td></tr>
			</xsl:for-each>
		</table>
	</div>
</xsl:template>
</xsl:stylesheet>

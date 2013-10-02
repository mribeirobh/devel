<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/FxCopReport">
	<html>
		<head>
			<style>
			<![CDATA[
	 		 
			ul 
			{
				background-color: #F0F0F0 ;
				//border-bottom: 2px solid #999999 ;
				list-style-type: none ;
				padding: 0px;
				margin: 5px 0px 0px 0px;
			}
 
			ul.left
			{
			}
 
			ul.right
			{
				text-align: right ;
			}
 
			ul li 
			{
				display: inline ;
				padding: 0px;
			}
			
			.infoDiv
			{
				padding-top: 5px;
				position:relative;
				display:block;
			}
			]]>
			</style>
			<script type="text/javascript">
			<![CDATA[
	    
			function showHide(id,sender){			
				var e = document.getElementById(id);
				if(e != undefined)
				{
					var eStatus = e.style.visibility;
					if (eStatus === 'visible')
					{
						e.style.visibility = 'hidden';
						e.style.display = 'none';						
						sender.firstChild.data="+"
					}
					else
					{
						e.style.visibility = 'visible';
						e.style.display = 'block';
						sender.firstChild.data="-"
					}
				}
			}
		]]>
	</script>
	</head>
		<body>
			<div>
            FxCop Tool Version <xsl:value-of select="@Version"/><br/>
			</div>
			<div>
			<xsl:call-template name="table">
				<xsl:with-param name="data" select="Targets/Target"/>
				<xsl:with-param name="title">Name</xsl:with-param>
				<xsl:with-param name="id">Files</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="table">
			  <xsl:with-param name="data" select="Namespaces/Namespace"/>
			  <xsl:with-param name="title">Name</xsl:with-param>
			  <xsl:with-param name="id">Namespaces</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="table">
				<xsl:with-param name="data" select="Rules/Rule"/>
				<xsl:with-param name="title">TypeName</xsl:with-param>
				<xsl:with-param name="id">Rules</xsl:with-param>
			</xsl:call-template>
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
</xsl:stylesheet>

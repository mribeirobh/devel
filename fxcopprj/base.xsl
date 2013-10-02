<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/FxCopReport">
	<html>
		<head>
			<style>
			<![CDATA[
		 
			.onoff
			{
				width:32px;
				height:32px;
				padding:1px 2px 3px 3px;	
				font-size:12px;
				background:lightgray;
				text-align:center;	
			}
			
			.onoff div
			{
				width:18px;
				height:18px;
				min-height:18px;	
				background:lightgray;
				overflow:hidden;
				border-top:1px solid gray;
				border-right:1px solid white;
				border-bottom:1px solid white;
				border-left:1px solid gray;			
				margin:0 auto;
				color:gray;
			}
			
			.setTable
			{
				border:1px;
			}
		 
			.infoDivs
			{
				top:5px;
				visibility:visible;
				position:relative;
				display:block;
			}
			]]>
			</style>
			<script type="text/javascript">
			<![CDATA[
	  
			var buttonstate=0;
			function onoff(element)
			{
				buttonstate= 1 - buttonstate;
				var blabel, bstyle, bcolor;
				if(buttonstate)
				{
					blabel="on";
					bstyle="green";
					bcolor="lightgreen";
				}
				else
				{
					blabel="off";
					bstyle="lightgray";
					bcolor="gray";
				}
				var child=element.firstChild;
				child.style.background=bstyle;
				child.style.color=bcolor;
				child.innerHTML=blabel;
			}
	  
	  
			function showHide(id){			
				var infoDivs = document.getElementsByClassName('infoDivs');
				var e = document.getElementById(id);
				if(e != undefined)
				{
					var eStatus = e.style.visibility;
					for(var i = 0; i < infoDivs.length; i++)
					{
						infoDivs[i].style.visibility = 'hidden';
						infoDivs[i].style.display = 'none';
					} 
					if (eStatus === 'visible')
					{
						e.style.visibility = 'hidden';
						e.style.display = 'none';
					}
					else
					{
						e.style.visibility = 'visible';
						e.style.display = 'block';
					}
				}
				}
				]]>
	</script>
	</head>
		<body>
			<div>
            FxCop Tool Version <xsl:value-of select="@Version"/><br/>				
			<button type="button" onclick ="showHide('Files');">Files: <xsl:value-of select="count(Targets/Target)"/></button>
			<button type="button" onclick ="showHide('Rules');">Rules: <xsl:value-of select="count(Rules/Rule)"/></button>
			<button type="button" onclick ="showHide('Namespaces');">Namespaces: <xsl:value-of select="count(Namespaces/Namespace)"/></button>
			<button class="onoff" onclick="onoff(this)"><div>off</div></button>
			</div>
			<xsl:call-template name="table">
				<xsl:with-param name="data" select="Targets/Target"/>
				<xsl:with-param name="title" select="'Name'"/>
				<xsl:with-param name="id" select="'Files'"/>
			</xsl:call-template>
			<xsl:call-template name="table">
				<xsl:with-param name="data" select="Rules/Rule"/>
				<xsl:with-param name="title">TypeName</xsl:with-param>
				<xsl:with-param name="id">Rules</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="table">
			  <xsl:with-param name="data" select="Namespaces/Namespace"/>
			  <xsl:with-param name="title">Name</xsl:with-param>
			  <xsl:with-param name="id">Namespaces</xsl:with-param>
			</xsl:call-template>
		</body>
	</html>
</xsl:template>	
			
<xsl:template name="table">
	<xsl:param name="data"/>
	<xsl:param name="title"/>
	<xsl:param name="id"/>
	<div class="infoDivs">
	<xsl:attribute name="id">
		<xsl:value-of select="$id"/>
	</xsl:attribute>
		<table border="1">
			<xsl:for-each select="$data">				 
				<xsl:sort select="@*[name() = $title]"/>
					<tr><td>
						<xsl:value-of select="position()"/>
					</td><td>
						<xsl:value-of select="@*[$title]"/>
					</td></tr>
			</xsl:for-each>
		</table>
	</div>
</xsl:template>	
</xsl:stylesheet>

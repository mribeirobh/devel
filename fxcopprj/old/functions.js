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
	
function importXML(xmlfile)
  {
   var xmlDoc = null;
   var xmlloaded = false;
   var xmlhttp = null;   
   
   try   
    {
     xmlhttp = new XMLHttpRequest();
     xmlhttp.open("GET", xmlfile, false); 	 
    }
   catch (Exception)
    {
     var ie = (typeof window.ActiveXObject != 'undefined');
 
     if (ie)
      {
       xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
       xmlDoc.async = false;
       while(xmlDoc.readyState != 4) {};
        xmlDoc.load(xmlfile);
       xmlloaded = true;
      }
     else
      {
		xmlDoc = document.implementation.createDocument("", "", null);
        xmlDoc.load(xmlfile);
        xmlloaded = true;
	  }
    }

   if (!xmlloaded)
    {
     try
	 {
	  xmlhttp.setRequestHeader('Content-Type', 'text/xml')
      xmlhttp.send("");
      xmlDoc = xmlhttp.responseXML;
	 }   
     catch (Exception) 	 
	 {
	  alert(Exception);
	 }
    }
   return xmlDoc;
  }

function displayResult(OutInfoId)
{
 var is_chrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;
 if(is_chrome)
	{
		alert('Not supported on Chrome');
		alert(document.location.href);
		var xml = importXML(document.location.href);//loadXMLtext(document.location.href);
		alert(xml);
		alert(chrome.extension.getURL('base.xsl'));
        var xsl = importXML(chrome.extension.getURL('base.xsl'));
        alert(xsl);
		var xsltPrs = new XSLTProcessor();
		xsltPrs.importStylesheet(xsl);

		var result = xsltPrs.transformToFragment(xml, document);

		var xmlsrv = new XMLSerializer();
		var plaintext = xmlsrv.serializeToString(result);
		alert(plaintext);
		document.getElementById(OutInfoId).innerHTML = plaintext;		
	}
else
	{
		xml = importXML('relat.xml');
		xsl = importXML('base.xsl');
		// code for IE
		if (window.ActiveXObject)
		{
			ex=xml.transformNode(xsl);
			document.getElementById(OutInfoId).innerHTML=ex;
		}
		// code for Mozilla, Firefox, Opera, etc.
		else if (document.implementation && document.implementation.createDocument)
		{
			xsltProcessor=new XSLTProcessor();
			xsltProcessor.importStylesheet(xsl);
			resultDocument = xsltProcessor.transformToFragment(xml,document);
			document.getElementById(OutInfoId).appendChild(resultDocument);
		}
	}
}

function loadXMLtext(url)
{
  xhttp = new XMLHttpRequest();
  xhttp.open("GET", url, false);
  xhttp.send();
  if(xhttp.responseXML == undefined) throw "XHR failed for " + url;
  return xhttp.responseXML;
}

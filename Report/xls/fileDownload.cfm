
	
	
	<!--- El link que invoque debe tener el formato:
			 ... /fileDownload.cfm?filename=miArchivo.xls
	 ---->
	
	<cfset folder = "C:/inetpub/wwwroot/CONS_REP/ssdovovi/Report/xls/">	<!--- "[ PATH TO YOUR FILES FOR DOWNLOAD ]"> ---->
	<cfif StructKeyExists(url, "filename") && fileExists(folder & filename)>
		 <cfset filename = "#url.filename#">  
		<cfset fileInfo = GetFileInfo(folder & filename)>
		<cfset mimeType = getPageContext().getServletContext().getMimeType(folder & filename)>
		<cfheader name="Content-Disposition" value="attachment; filename=""#filename#""">
		<cfheader name="Expires" value="#Now()#">
		<cfheader name="Content-Length" value="#fileInfo.size#">
		<cfcontent type="#mimeType#" file="#folder##filename#" deletefile="No">
    <cfelse>
    	<h1> Archivo no disponible </h1>
	</cfif>

	
	
	<!--- El link que invoque debe tener el formato:
			 ... /fileDownload.cfm?filename=miArchivo.xls
	 ---->
	
    <cfoutput>
	<cfset origen=''>
    <cfif isdefined("url.origenNumber")>
    	<cfset origenNumber = #url.origenNumber#>
    <cfelse>
    	<cfset origenNumber = 0>
    </cfif>
    
    <cfswitch expression="#origenNumber#">
    	<cfcase value="0">
	    	<cfset origen = './'>        	
        </cfcase>
    	<cfcase value="1">
        	<!--catálogos servicio social ---> 
	    	<cfset origen = 'rpt_Principal.cfm'>        	
        </cfcase>
    </cfswitch>
	
	<cfset folder = "C:/inetpub/wwwroot/CONS_REP/ssdovovi/Report/">	<!--- "[ PATH TO YOUR FILES FOR DOWNLOAD ]"> ---->
    
    <cfset rutaOrigen = #folder# & #origen# >
    
	<cfif StructKeyExists(url, "filename") && fileExists(folder & filename)>
		 <cfset filename = "xls/#url.filename#">  
		<cfset fileInfo = GetFileInfo(folder & filename)>
		<cfset mimeType = getPageContext().getServletContext().getMimeType(folder & filename)>
		<cfheader name="Content-Disposition" value="attachment; filename=""#filename#""">
		<cfheader name="Expires" value="#Now()#">
		<cfheader name="Content-Length" value="#fileInfo.size#">
		<cfcontent type="#mimeType#" file="#folder##filename#" deletefile="No">
        
        <cflocation url="#rutaOrigen#" addtoken="no">
    <cfelse>
    	<h1> Archivo no disponible </h1>
        <a href="#rutaOrigen#" > Regresar - #rutaOrigen#</a>
	</cfif>
    </cfoutput>
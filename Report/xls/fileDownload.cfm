
	
	
	<!--- El link que invoque debe tener el formato:
			 ... /fileDownload.cfm?filename=miArchivo.xls
	 ---->
	
    <cfoutput>
    
    <!--- ruta origen de los reportes ---->
	<cfset origen=''>
    <cfif isdefined("url.origenNumber")>
    	<cfset origenNumber = #url.origenNumber#>
    <cfelse>
    	<cfset origenNumber = 0>
    </cfif>
    
    
    <cfset filename = "xls/"> 
    
    
    
    <cfswitch expression="#origenNumber#">
    	<cfcase value="0">
	    	<cfset origen = './'>        	
        </cfcase>
    	<cfcase value="1">
        	<!--catálogos servicio social ---> 
	    	<cfset origen = 'rpt_Principal.cfm'>  
		    <cfset filename = filename & "orders.xls">       	
        </cfcase>
    </cfswitch>
    
    <!---SE OBTIENE EL REPORTE --->
    <cfinvoke component="CONS_REP.ssdovovi.Consult.spGetReporteSS" method="getReporteSS" returnvariable="qGetReporteSS">
        <cfinvokeargument name="tipoReporte" value="SS">
        <cfinvokeargument name="numReporte" value="1">
    </cfinvoke>
    
    
	<cfset rutaOrigen = "/CONS_REP/ssdovovi/Report/" & #origen# >
    
	<cfset folder = "C:/inetpub/wwwroot/CONS_REP/ssdovovi/Report/">	<!--- "[ PATH TO YOUR FILES FOR DOWNLOAD ]"> ---->
    
	<cfif StructKeyExists(url, "filename") && fileExists(folder & filename)>
		 
		<cfset fileInfo = GetFileInfo(folder & filename)>
		<cfset mimeType = getPageContext().getServletContext().getMimeType(folder & filename)>
		<cfheader name="Content-Disposition" value="attachment; filename=""#filename#""">
		<cfheader name="Expires" value="#Now()#">
		<cfheader name="Content-Length" value="#fileInfo.size#">
		<cfcontent type="#mimeType#" file="#folder##filename#" deletefile="No">
        
        <cflocation url="#rutaOrigen#" addtoken="no">
    <cfelse>
    	<h1> Archivo no disponible </h1>
        <a href="#rutaOrigen#" > Regresar - #rutaOrigen# - #origen#</a>
	</cfif>
    </cfoutput>
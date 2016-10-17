<!doctype html>
<html class="">
<head>
   	<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="siscap">
	<title>Servicio social</title>	
   	<cfset SetLocale("es_MX")>
</head>
<body  class="areafija">
<cfoutput>
<!---
<cfif IsDefined("URL.export") AND #URL.export# EQ 1>
	<cfcontent type="application/msexcel">
	<cfheader name="Content-Disposition" value="filename=gen.xls"> 
    
</cfif>--->


<cfheader name="Content-Disposition" value="inline; filename=testDocument.pdf">
<cfcontent variable="bla" type="application/pdf" reset="yes" />
	
    <!--- CONSULTAR REPORTE ---->
    <cfif IsDefined("URL.export") AND #URL.export# EQ 1>
        	<cfset tipoReporte = #url.tipoReporte#>
        	<cfset rdEstatusSS = #url.rdEstatusSS#>
        	<cfset chkAddIap = #url.chkAddIap#>
        	<cfset fechainicio = #url.fechainicio#>
        	<cfset fechaFin = #url.fechaFin#>
        	<cfset rdPeriodo = #url.rdPeriodo#>
    
        <cfif rdPeriodo EQ 0>
                <cfif isdefined("form.ftxtfechainicio") AND LEN(#form.ftxtfechainicio#) GT 0> <cfset fechainicio = #form.ftxtfechainicio#>  <cfelse> <cfset fechainicio=''>  </cfif>
                <cfif isdefined("form.ftxtfechaFin") AND LEN(#form.ftxtfechaFin#) GT 0> <cfset fechaFin = #form.ftxtfechaFin#>  <cfelse> <cfset fechaFin=''>  </cfif>
            <cfelse>
                 <cfset fechainicio='01/01/' & #rdPeriodo#> 
                 <cfset fechaFin= #lsdateformat(NOW(),'dd/mm/yyy')#>
                 <cfset rdPeriodo = 1>
                 <!---- '31/12/' & #rdPeriodo#> ---->
            </cfif>
	    <cfinvoke component="CONS_REP.ssdovovi.Consult.spGetReporteSS" method="getReporteSS" returnvariable="qGetReporteSS">
            <cfinvokeargument name="tipoReporte" value="#tipoReporte#">
            <cfinvokeargument name="rdEstatusSS" value="#rdEstatusSS#">
            <cfinvokeargument name="chkAddIap" value="#chkAddIap#">
            <cfinvokeargument name="fechainicio" value="#fechainicio#">
            <cfinvokeargument name="fechaFin" value="#fechaFin#">     
            <cfinvokeargument name="intervalo" value="#rdPeriodo#">     
                            
		</cfinvoke>
    <cfelse>
    	<cflocation url="rpt_Gen.cfm">
    </cfif>    
        
   
    <table class="table table-striped" id="myTable" border="1">  
        <thead>
            <th>#qGetReporteSS.TIPOCONCEPTO#</th>
            <th>PRESTADORES DE S.S. </th>
        </thead>
        <tbody>                
            <cfloop query="qGetReporteSS">
                <tr>
                    <td>#qGetReporteSS.CONCEPTODESC# </td>
                    <td align="center">#qGetReporteSS.TOTALCONCEPTO# </td>
                </tr>
            </cfloop>
            <tr>
                <td>Periodo: #fechainicio# - #fechafin# </td>
                <td>Total: #qGetReporteSS.TOTALSS# </td>
            </tr>                    
        </tbody>
    </table>
    
		
</cfoutput>
</body>
</html>

		
		<!---
        
        FILA	TIPOCONCEPTO	TOTALCONCEPTO	TOTALINSTITUCION	IDCONCEPTO	CONCEPTODESC	INSTITUCIONSS	TIPO
1	RUBRO	3	3	200	Adultos mayores	0236 - LOS SESENTA, I.A.P.	1
        ---->
		
        
    
	
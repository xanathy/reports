	
    <!--- CONSULTAR REPORTE ---->
    <cfif isdefined ("url.cr") AND #url.cr# EQ 1>   
        
		<cfif isdefined("form.tipoReporte") AND LEN(#form.tipoReporte#) GT 0> <cfset tipoReporte = #form.tipoReporte#> </cfif>
		<cfif isdefined("form.rdEstatusSS") AND LEN(#form.rdEstatusSS#) GT 0> <cfset rdEstatusSS = #form.rdEstatusSS#> <cfelse> <cfset rdEstatusSS = 'AC'> </cfif>
        <cfif isdefined("form.chkAddIap") AND LEN(#form.chkAddIap#) GT 0> <cfset chkAddIap = #form.chkAddIap#> <cfelse> <cfset chkAddIap = '0'> </cfif>
		<cfif isdefined("form.rdPeriodo") AND LEN(#form.rdPeriodo#) GT 0> <cfset rdPeriodo = #form.rdPeriodo#> </cfif>        
		<cfif rdPeriodo EQ 0>
			<cfif isdefined("form.ftxtfechainicio") AND LEN(#form.ftxtfechainicio#) GT 0> <cfset fechainicio = #form.ftxtfechainicio#>  <cfelse> <cfset fechainicio=''>  </cfif>
            <cfif isdefined("form.ftxtfechaFin") AND LEN(#form.ftxtfechaFin#) GT 0> <cfset fechaFin = #form.ftxtfechaFin#>  <cfelse> <cfset fechaFin=''>  </cfif>
        <cfelse>
        	 <cfset fechainicio='01/01/' & #rdPeriodo#> 
        	 <cfset fechaFin= #lsdateformat(NOW(),'dd/mm/yyy')#>
			 <!---- '31/12/' & #rdPeriodo#> ---->
		</cfif>      
        
        <!---
        <cfif isdefined("form.aa") AND LEN(#form.aa#) GT 0> <cfset aa = #form.aa#> </cfif>
		<cfif isdefined("form.idNI")>
        	<cflocation url="../view/updDetalle.cfm?cve=#idCve##idNI#">
        <cfelse>
        	<cflocation url="../view/regConstancia.cfm?cve=#idCve#">
        </cfif>
		
		--->
        
        <cfoutput>
        	<BR /> tipoReporte: #tipoReporte#
        	<BR /> rdEstatusSS: #rdEstatusSS#
        	<BR /> chkAddIap: #chkAddIap#
        	<BR /> fechainicio: #fechainicio#
        	<BR /> fechaFin: #fechaFin#
        
        </cfoutput>
        
      
    
	    <cfinvoke component="CONS_REP.ssdovovi.Consult.spReporteSS" method="getReporteSS" returnvariable="qGetReporteSS">
            <cfinvokeargument name="tipoReporte" value="#tipoReporte#">
            <cfinvokeargument name="rdEstatusSS" value="#rdEstatusSS#">
            <cfinvokeargument name="chkAddIap" value="#chkAddIap#">
            <cfinvokeargument name="fechainicio" value="#fechainicio#">
            <cfinvokeargument name="fechaFin" value="#fechaFin#">                     
		</cfinvoke>
    
    	<cfoutput>
            <table>
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
                        <td>Total: #qGetReporteSS.TOTALDISTINCT# </td>
                    </tr>                    
                </tbody>
            </table>
        </cfoutput>
		
		
		<!---
        
        FILA	TIPOCONCEPTO	TOTALCONCEPTO	TOTALINSTITUCION	IDCONCEPTO	CONCEPTODESC	INSTITUCIONSS	TIPO
1	RUBRO	3	3	200	Adultos mayores	0236 - LOS SESENTA, I.A.P.	1
        ---->
		
        
    </cfif>
	
<!doctype html>
<!--[if lt IE 7]> <html class="ie6 oldie"> <![endif]-->
<!--[if IE 7]>    <html class="ie7 oldie"> <![endif]-->
<!--[if IE 8]>    <html class="ie8 oldie"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="">
<!--<![endif]-->
<head>
   	<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="siscap">
	<title>Servicio social</title>	
    <!--- 
    <cfif not isdefined("session.no_user")>
    	<cflocation addtoken="no" url="/logout.cfm">
    </cfif>
	--->
    <cfinclude template="#session.head#"> 
    
   	<cfset SetLocale("es_MX")>
</head>
<body  class="areafija" >
<cfoutput>

	
    <!--- GENERAR PDF DEL REPORTE ---->
		<cfif isdefined("form.tipoReporte") AND LEN(#form.tipoReporte#) GT 0> <cfset tipoReporte = #form.tipoReporte#> </cfif>
        <cfif isdefined("form.rdEstatusSS") AND LEN(#form.rdEstatusSS#) GT 0> <cfset rdEstatusSS = #form.rdEstatusSS#> <cfelse> <cfset rdEstatusSS = 'AC'> </cfif>
        <cfif isdefined("form.chkAddIap") AND LEN(#form.chkAddIap#) GT 0> <cfset chkAddIap = #form.chkAddIap#> <cfelse> <cfset chkAddIap = '0'> </cfif>
        <cfif isdefined("form.intervalo") AND LEN(#form.intervalo#) GT 0> <cfset intervalo = #form.intervalo#> </cfif>       
        <cfif isdefined("form.ftxtfechainicio") AND LEN(#form.ftxtfechainicio#) GT 0> <cfset fechainicio = #form.ftxtfechaInicio#>  <cfelse> <cfset fechainicio=''>  </cfif>
        <cfif isdefined("form.ftxtfechaFin") AND LEN(#form.ftxtfechaFin#) GT 0> <cfset fechaFin = #form.ftxtfechaFin#>  <cfelse> <cfset fechaFin=''>  </cfif>



	    <cfinvoke component="CONS_REP.ssdovovi.Consult.spGetReporteSS" method="getReporteSS" returnvariable="qGetReporteSS">
            <cfinvokeargument name="tipoReporte" value="#tipoReporte#">
            <cfinvokeargument name="rdEstatusSS" value="#rdEstatusSS#">
            <cfinvokeargument name="chkAddIap" value="#chkAddIap#">
            <cfinvokeargument name="fechainicio" value="#fechainicio#">
            <cfinvokeargument name="fechaFin" value="#fechaFin#">     
            <cfinvokeargument name="intervalo" value="#intervalo#">     
                            
		</cfinvoke>
 
    <cfdocument 
    format = "PDF" 
    saveAsName = "PDF filename" 
    marginBottom = "2" 
    marginLeft = "2.5" 
    marginRight = "2.5" 
    marginTop = "5" 
    unit = "cm" 
    bookmark="yes"> 
    <cfdocumentsection margintop="3"> 
        <cfdocumentitem type="header"> 
        	<p>&nbsp;  </p>
	        <font  style="font-family:Verdana, Geneva, sans-serif; font-size:16px;">                     
            <table>
            	<tr> 
                	<td > <img src="/cons_rep/ssdovovi/report/img/115logojap.png" width="180" > </td>
                    <td>&nbsp;  </td>
                	<td align="center"> <b>DIRECCI&Oacute;N DE PROGRAMAS ASISTENCIALES </b></td>
                    
                </tr>
			</table>
			</font>
        </cfdocumentitem>
        <cfdocumentitem type="footer"> 
            <p align="right"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:8px; color:##999">                      
            Reporte generado: #lsdateformat(now())# </font> </p>
        </cfdocumentitem>
        
        
    <!--- construccion de reporte en pantalla ---->
    <center>
    	<p>&nbsp;  </p>
        <P>
         <table>
            	<tr><td align="center">
                	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:14px;">      
                     <b>REPORTE DE PRESTACI&Oacute;N DE SERVICIO SOCIAL POR #qGetReporteSS.TIPOCONCEPTO # </b>
                    </font>
                    </td>
                </tr>
                <tr><td align="center"> 
                	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:14px;"> 
                
                <b>Periodo:  
						 <cfif #intervalo# EQ 1> #fechainicio# - #fechafin# <cfelse> #YEAR(fechainicio)# </cfif></b>
                         </font>
                    </td>
                </tr>
			</table>
        </P>
    	<p>&nbsp;  </p>
    	<p>                
        <table id="myTable" border="1" cellspacing="1">
            <thead >
                <th bgcolor="##003399">
                    <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">
                    #qGetReporteSS.TIPOCONCEPTO#</font></th>
                <th bgcolor="##003399">
                    <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">
                    PRESTADORES DE S.S.</font></th>
            </thead>
            <tbody>                
                <cfloop query="qGetReporteSS">
                    <tr>	                     
                        <td>  
                        	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px;">
                            #qGetReporteSS.CONCEPTODESC# </font>
                        </td>
                        <td align="center">
                        	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px;">
                            #qGetReporteSS.TOTALCONCEPTO#  </font>
                       </td>                        
                    </tr>
                </cfloop>
                <tr> 
                    <td align="right">                    
                        <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px;">
                        Total </font>
                    </td>
                    <td align="center">                    
                        <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px;">
                        #qGetReporteSS.TOTALSS#</font>
                    </td>
                </tr>                    
            </tbody>
        </table>
        </p>
    	<p>&nbsp;  </p>
        <p>
			<!--- Bar graph, from Query of Queries ---> 
                <cfchart format="png"  
                show3D = "no"  
                showBorder = "yes"  
                showLegend = "no"  
                font="Verdana"  
                yaxistitle="Prestadores de S.S."
                chartwidth="600"
                chartheight="300"
                title="SERVICIOS SOCIALES POR #qGetReporteSS.TIPOCONCEPTO#">  
                
                    <cfchartseries type="bar" query="qGetReporteSS" 
                    itemcolumn="CONCEPTODESC" 
                    valuecolumn="TOTALCONCEPTO" 
                    seriesLabel="CONCEPTODESC"
                    seriescolor="##0099CC"
                    colorlist="##33CCCC,
                        ##FF9966,
                        ##3366CC,
                        ##CC66FF,
                    	##99CC99,
                        ##FF9933,
                        ##9933CC,
                        ##009999,
                        ##CC9966"
                    /> 
    			
                </cfchart>    
                    
		</p>
	</center>
            
    </cfdocumentsection>
    </cfdocument>

</cfoutput>
</body>
</html>

		
		<!---
        
        FILA	TIPOCONCEPTO	TOTALCONCEPTO	TOTALINSTITUCION	IDCONCEPTO	CONCEPTODESC	INSTITUCIONSS	TIPO
1	RUBRO	3	3	200	Adultos mayores	0236 - LOS SESENTA, I.A.P.	1
        ---->
		
        
    
	
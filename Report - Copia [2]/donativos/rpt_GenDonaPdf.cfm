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
	<title>Reportes de Donativos</title>	
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

    <!--- CONSULTAR REPORTE ---->
        <cfif isdefined("form.fechainicio") AND LEN(#form.fechainicio#) GT 0> <cfset fechainicio = #form.fechainicio#> </cfif>
        <cfif isdefined("form.fechaFin") AND LEN(#form.fechaFin#) GT 0> <cfset fechaFin = #form.fechaFin#> </cfif>
	    <cfif isdefined("form.tipoReporte") AND LEN(#form.tipoReporte#) GT 0> <cfset tipoReporte = #form.tipoReporte#> </cfif>
	    <cfif isdefined("form.periodo") AND LEN(#form.periodo#) GT 0> <cfset periodo = #form.periodo#> </cfif>
	    
	    <cfinvoke component="CONS_REP.ssdovovi.Consult.spGetReporteDona" method="getDonativo" returnvariable="qGetDonativo">
            <cfinvokeargument name="tipoReporte" value="#tipoReporte#">
            <cfinvokeargument name="fechainicio" value="#fechainicio#">
            <cfinvokeargument name="fechaFin" value="#fechaFin#">                       
		</cfinvoke>
        
        <cfinvoke component="CONS_REP.ssdovovi.Consult.spGetReporteVol" method="getVinculacion" returnvariable="qGetVinculacion">
            <cfinvokeargument name="fechainicio" value="#fechainicio#">
            <cfinvokeargument name="fechaFin" value="#fechaFin#">   
		</cfinvoke>

	<!--- CONSTRUCCION DEL PDF ---->
	<cfdocument 
    format = "PDF" 
    saveAsName = "PDF filename" 
    marginBottom = "1" 
    marginLeft = "1" 
    marginRight = "1" 
    marginTop = "2" 
    unit = "cm" 
    bookmark="yes"
     orientation="portrait"> 
    <cfdocumentsection margintop="2.8"> 
        <cfdocumentitem type="header"> 
        	<p>&nbsp;  </p>
	        <font  style="font-family:Verdana, Geneva, sans-serif; font-size:16px;">                     
            <table width="100%">
            	<tr> 
                	<td >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="../img/115logojap.png" width="180" > </td>
                	<td> <b>DIRECCI&Oacute;N DE PROGRAMAS ASISTENCIALES <br> </b></td>
                    
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
    	<P><center>
            <font  style="font-family:Verdana, Geneva, sans-serif; font-size:13px;"><b> REPORTE DE DONATIVOS <br> #periodo#</b></font>
           </center>
        </P>
    	<!---- DONATIVOS ---->
        <cfif #qGetDonativo.RECORDCOUNT# GT 0>
        	<cfif #tipoReporte# EQ 1>
            <p>           
             <table id="myTable" border="1" cellspacing="1" width="100%">
                <thead >
                    <thead>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:11px; color:##FFF">DONANTE </font></th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">PRODUCTO </font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">MES </font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">IAP </font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">CANTIDAD</font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">MONTO APROXIMADO </font> </th>
                    </thead>
                </thead>
                <tbody>                                              
                    <cfloop query="qGetDonativo">
                        <tr>
                            <td style="padding:5px;"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetDonativo.DONANTE# </font></td>
                            <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetDonativo.PRODUCTO# </font></td>
                            <td align="center" style="padding:5px;">
	                            <font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #MONTHASSTRING(qGetDonativo.MES)#  </font></td>
                            <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetDonativo.NOMBREIAP# </font></td>                                            
                            <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetDonativo.CANTIDAD# </font></td>
                            <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;">#qGetDonativo.MONTOAPROXIMADO# </font></td>
                        </tr>
                    </cfloop>              
                </tbody>
            </table>
			</p>
            </cfif>
            <!----
            <p>
                <table id="myTable" border="1" cellspacing="1" width="90%">
                    <thead>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##fff">Total de voluntarios </font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##fff">Total de horas </font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##fff">Aportaci&oacute;n econ&oacute;mica de empresas </font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##fff">Aportaci&oacute;n econ&oacute;mica de voluntarios</font> </th>
                    </thead>
                    <tbody>
                        <tr>
                            <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetVoluntariado.TOTALVOL# </font></td>
                            <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetVoluntariado.TOTALHRS# </font></td>
                            <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetVoluntariado.TOTALAPORTAEMP# </font></td>
                            <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetVoluntariado.TOTALAPORTAVOL# </font></td>
                        </tr>                    
                    </tbody>
                </table>
            </p>
            ---->
        </cfif>            
               
	
    </center>
    </cfdocumentsection>
    </cfdocument>
</cfoutput>
</body>
</html>

	
		
        
    
	
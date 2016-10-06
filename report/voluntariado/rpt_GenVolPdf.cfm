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
	<title>Reportes de Voluntariado</title>	
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
	    
	    <cfinvoke component="CONS_REP.ssdovovi.Consult.spGetReporteVol" method="getVoluntariado" returnvariable="qGetVoluntariado">
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
     orientation="landscape"> 
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
            <font  style="font-family:Verdana, Geneva, sans-serif; font-size:13px;"><b> REPORTE DE VOLUNTARIADO <br> #periodo#</b></font>
           </center>
        </P>
    	<!---- VOLUNTARIADO ---->
        <cfif #qGetVoluntariado.RECORDCOUNT# GT 0>
            <p>           
             <table id="myTable" border="1" cellspacing="1" width="100%">
                <thead >
                    <thead>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:11px; color:##FFF">I.A.P. </font></th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">Horas</font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">No. Voluntarios</font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">D&iacute;as</font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">Nombre de la empresa o grupo</font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">Horas totales</font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">Aportaci&oacute;n econ&oacute;mica (Empresa) </font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">Aportaci&oacute;n econ&oacute;mica (Voluntarios) </font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">Descripci&oacute;n de la Actividad</font> </th>
                    </thead>
                </thead>
                <tbody>                
                    <cfloop query="qGetVoluntariado">
                        <tr>
                            <td style="padding:5px;"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetVoluntariado.NOMBREIAP# </font></td>
                            <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetVoluntariado.HORAS# </font></td>
                            <td align="center" style="padding:5px;">
	                            <font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetVoluntariado.NOVOLUNTARIOS# </font></td>
                            <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #lsdateformat(qGetVoluntariado.FECHAVOLUNTARIADO,'dd/mm/yyyy')#  
                                	<cfif LEN(#qGetVoluntariado.FECHAVOLUNTARIADOFINALIZA#) GT 0> - #lsdateformat(qGetVoluntariado.FECHAVOLUNTARIADOFINALIZA,'dd/mm/yyyy')# </cfif> </font></td>
                            <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetVoluntariado.EMPRESA# </font></td>                                            
                            <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetVoluntariado.HRSVOLUNTARIOS# </font></td>
                            <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;">#qGetVoluntariado.APORTACIONEMPRESA# </font></td>
                            <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;">#qGetVoluntariado.APORTACIONVOLUNTARIOS# </font></td>
                            <td align="justify" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;">#qGetVoluntariado.DESCRIPCIONACTIVIDAD# </font></td>
                        </tr>
                    </cfloop>              
                </tbody>
            </table>
			</p>
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
        </cfif>            
               
        <p> &nbsp; </p>   
                  
		<!---- VINCULACION ---->
        <cfif #qGetVinculacion.RECORDCOUNT# GT 0>
            <p>  
                <P><center>
	                <font  style="font-family:Verdana, Geneva, sans-serif; font-size:13px;"><b> VINCULACI&Oacute;N CON EMPRESAS Y ORGANISMOS SOCIALMENTE RESPONSABLE PARA VINCULACI&Oacute;N DE VOLUNTARIADO  <br>#periodo# </b></font>
                </center></P>                     
                <table id="myTable" border="1" cellspacing="1" width="100%">
                    <thead>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">Ente </font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">Fecha de vinculaci&oacute;n</font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">Instalaciones</font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">Sede</font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">Concepto de la reuni&oacute;n</font> </th>
                        <th style="padding:5px;" bgcolor="##576D7D"> <font  style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:##FFF">Notas </font> </th>
                    </thead>
                    <tbody>                
                        <cfloop query="qGetVinculacion">
                            <tr>
                                <td style="padding:5px;">
                                <font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetVinculacion.ENTE# </font></td>
                                <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #lsdateformat(qGetVinculacion.FECHAVINCULACION,'dd/mm/yyyy')# </font></td>
                                <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetVinculacion.INSTALACIONES# </font></td>
                                <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetVinculacion.SEDE# </font></td>
                                <td align="center" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetVinculacion.CONCEPTOREUNION# </font></td>
                                <td align="justify" style="padding:5px;">
                            	<font  style="font-family:Verdana, Geneva, sans-serif; font-size:10px;"> #qGetVinculacion.NOTAS# </font></td>
                            </tr>
                        </cfloop>
                    </tbody>
                </table>
              </p>
        </cfif>
	
    </center>
    </cfdocumentsection>
    </cfdocument>
</cfoutput>
</body>
</html>

	
		
        
    
	
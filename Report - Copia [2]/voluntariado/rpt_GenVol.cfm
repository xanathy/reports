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
    <!-- Bootstrap -->
    <link rel="stylesheet" href="/CONS_REP/ssdovovi/Report/model/bootstrap-3.3.6-dist/css/bootstrap.min.css">
	
    <link rel="stylesheet" href="/CONS_REP/ssdovovi/Report/model/custom/dataTables.bootstrap.css">
    <link rel="stylesheet" href="/CONS_REP/ssdovovi/Report/model/custom/custom.css">

    <!--- Datetimepicker--->
    <link rel="stylesheet" href="/CONS_REP/ssdovovi/Report/model/custom/bootstrap-datetimepicker.css">	
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]--> 

<style>
	th{
		vertical-align:central;
		text-align:center;
	}
	td{		
		max-width:600px;
		vertical-align:central;
	}
</style>    



    <!--- 
    <cfif not isdefined("session.no_user")>
    	<cflocation addtoken="no" url="/logout.cfm">
    </cfif>
	--->
    <cfinclude template="#session.head#"> 
    
    
    <!--- TODOS LOS DONATIVOS
    <cfinvoke component="App.ssdovovi.controller.proveedor" method="fAllDonativos" returnvariable="qGetAllDonativos" />
	---->
   	<cfset SetLocale("es_MX")>


</head>
<body  >
<cfoutput>


	
    <!--- CONSULTAR REPORTE ---->
    
    
    
    <cfif (isdefined ("url.cr") AND #url.cr# EQ 1)>
        <cfif (isdefined ("url.cr") AND #url.cr# EQ 1)>
			<cfif isdefined("form.tipoReporteVol") AND LEN(#form.tipoReporteVol#) GT 0> <cfset tipoReporte = #form.tipoReporteVol#> </cfif>
            <cfif isdefined("form.rdPeriodoVol") AND LEN(#form.rdPeriodoVol#) GT 0> <cfset rdPeriodo = #form.rdPeriodoVol#> </cfif>       
            <cfif isdefined("form.mesReporteVol") > <cfset mesReporteVol= #form.mesReporteVol#> </cfif>       
             
        </cfif> 
        <cfset intervalo = 0>
        <cfif rdPeriodo EQ 0>
        	<!--- SE CONSIDERA UN INTERVALO ESPECIFICADO POR EL USUARIO --->
			<cfif isdefined("form.ftxtfechainicioVol") AND LEN(#form.ftxtfechainicioVol#) GT 0> <cfset fechainicio = #form.ftxtfechainicioVol#>  <cfelse> <cfset fechainicio=''>  </cfif>
            <cfif isdefined("form.ftxtfechaFinVol") AND LEN(#form.ftxtfechaFinVol#) GT 0> <cfset fechaFin = #form.ftxtfechaFinVol#>  <cfelse> <cfset fechaFin=''>  </cfif>
	        <cfset intervalo = 1>
        <cfelse>
        	<!--- CONSULTA POR UN MES ESPECIFICO --->            
        	<cfif #mesReporteVol# GT 0>
                 <cfset fechainicio='01/' & #mesReporteVol# & '/' & #rdPeriodo#> 
                 <cfif  #mesReporteVol# EQ 2>
	                 <cfset fechaFin=  '28/' & #mesReporteVol# & '/' & #rdPeriodo#> 
                 <cfelseif #mesReporteVol# EQ 4 OR #mesReporteVol# EQ 6 OR #mesReporteVol# EQ 9 OR #mesReporteVol# EQ 11>
	                 <cfset fechaFin=  '30/' & #mesReporteVol# & '/' & #rdPeriodo#> 
                 <cfelse>
	                 <cfset fechaFin=  '31/' & #mesReporteVol# & '/' & #rdPeriodo#> 
                 </cfif>
            <cfelse>
				<!--- CONSULTA POR UN AÑO ESPECIFICO --->
                 <cfset fechainicio='01/01/' & #rdPeriodo#> 
                 <cfset fechaFin=  '31/12/' & #rdPeriodo#>
             </cfif>
             <cfset intervalo = 0>
             <!---- #lsdateformat(NOW(),'dd/mm/yyyy')#> ---->
        </cfif>
	    <cfinvoke component="CONS_REP.ssdovovi.Consult.spGetReporteVol" method="getVoluntariado" returnvariable="qGetVoluntariado">
            <cfinvokeargument name="tipoReporte" value="#tipoReporte#">
            <cfinvokeargument name="fechainicio" value="#fechainicio#">
            <cfinvokeargument name="fechaFin" value="#fechaFin#">                       
		</cfinvoke>
        
        <cfinvoke component="CONS_REP.ssdovovi.Consult.spGetReporteVol" method="getVinculacion" returnvariable="qGetVinculacion">
            <cfinvokeargument name="fechainicio" value="#fechainicio#">
            <cfinvokeargument name="fechaFin" value="#fechaFin#">   
		</cfinvoke>
        
    <cfelse>
    	<cflocation url="rpt_PrincipalVol.cfm"> 
    </cfif>    
    
    <!--- construccion de reporte en pantalla --->
    
    <div class="container-fluid" style="margin-top:20px;">
    
     	<div class="row col-sm-12">
            <div class="panel panel-primary">
                <div class="panel-heading"><span class="glyphicon glyphicon-list "></span>
                	Reportes de Voluntariado            
                </div>    
                
                <cfif #intervalo# EQ 1> 
                	<cfset periodo = "<h4><b> " & #fechainicio# & " - " & #fechafin# & "</b></h4>">
                	<cfset periodoPdf = #fechainicio# & " - " & #fechafin#>
                <cfelseif #mesReporteVol# GT 0> 
	                <cfset periodo = "<h4><b>" & #UCASE(MonthAsString(mesReporteVol))# & " " & #YEAR(fechainicio)# & "</b></h4>">
	                <cfset periodoPdf = #UCASE(MonthAsString(mesReporteVol))# & " " & #YEAR(fechainicio)# >
                <cfelse>
	                <cfset periodo = "<h4><b>" & #YEAR(fechainicio)# & "</b></h4>">
	                <cfset periodoPdf = #YEAR(fechainicio)# >
                </cfif> 
                
                      
                   
                <div class="panel-body"  style="margin-top:10px;" >
                  <div class="form-group-sm">
                    <div class="row col-md-12 ">
                        <div class="row col-md-6 ">
                            <a href="/cons_rep/ssdovovi/report/rpt_Principal.cfm?r=2">Generar otro reporte </a>
                        </div>
                        <div class=" col-md-6 ">
                            
                            <cfform action="/cons_rep/ssdovovi/report/voluntariado/rpt_GenVolPdf.cfm" id="formPdf" target="_blank"> 
                                <input type="hidden" id="tipoReporte" name="tipoReporte" value="#tipoReporte#">
                                <input type="hidden" id="periodo" name="periodo" value="#periodoPdf#">
                                <input type="hidden" id="fechainicio" name="fechainicio" value="#fechainicio#">
                                <input type="hidden" id="fechaFin" name="fechaFin" value="#fechaFin#">
                                <button class="btn btn-warning  pull-right" type="submit" value="">
                                    <span class="glyphicon glyphicon-download">
                                    	<font style="font-family:Verdana, Geneva, sans-serif">&nbsp; Descargar PDF</font></span> 
                                </button>                        
                            </cfform>
                        </div>   
                   </div></div>
                  
                  <cfif #qGetVoluntariado.RECORDCOUNT# GT 0>
                  <div class="form-group-sm" id="divVoluntariado">                    
					<div class="col-sm-12" style="margin-top:15px; margin-bottom:10px;">
                        <center>
                            <h4><b>REPORTE DE VOLUNTARIADO </b></h4>  
                            #periodo#
                        </center>
					</div>
				    <div class="table-responsive col-sm-12">
                        <font style="font-family:Verdana, Geneva, sans-serif; font-size:12px;">                        
                        	<table class="table table-striped" id="myTable" border="1">  
                                <thead>
                                    <th>I.A.P. </th>
                                    <th>Horas</th>
                                    <th>No. Voluntarios</th>
                                    <th>D&iacute;as</th>
                                    <th>Nombre de la empresa o grupo</th>
                                    <th>Horas totales</th>
                                    <th>Aportaci&oacute;n econ&oacute;mica (Empresa) </th>
                                    <th>Aportaci&oacute;n econ&oacute;mica (Voluntarios) </th>
                                    <th>Descripci&oacute;n de la Actividad</th>
                                </thead>
                                <tbody>                
                                    <cfloop query="qGetVoluntariado">
                                        <tr>
                                            <td>#qGetVoluntariado.NOMBREIAP# </td>
                                            <td align="center">#qGetVoluntariado.HORAS# </td>
                                            <td align="center">#qGetVoluntariado.NOVOLUNTARIOS# </td>
                                            <td align="center">#lsdateformat(qGetVoluntariado.FECHAVOLUNTARIADO,'dd/mm/yyyy')#  
                                            	<cfif LEN(#qGetVoluntariado.FECHAVOLUNTARIADOFINALIZA#) GT 0>- #lsdateformat(qGetVoluntariado.FECHAVOLUNTARIADOFINALIZA,'dd/mm/yyyy')# </cfif> </td>
                                            <td align="center">#qGetVoluntariado.EMPRESA# </td>                                            
                                            <td align="center">#qGetVoluntariado.HRSVOLUNTARIOS#</td>
                                            <td align="center">#qGetVoluntariado.APORTACIONEMPRESA# </td>
                                            <td align="center">#qGetVoluntariado.APORTACIONVOLUNTARIOS# </td>
                                            <td align="justify">#qGetVoluntariado.DESCRIPCIONACTIVIDAD# </td>
                                        </tr>
                                    </cfloop>
								</tbody>
							</table>
                            
                            <table class="table table-striped" id="totalTable" border="1" width="70%">  
                            	<thead>
                                	<th>Total de voluntarios </th>
                                	<th>Total de horas </th>
                                	<th>Aportaci&oacute;n econ&oacute;mica de empresas </th>
                                	<th>Aportaci&oacute;n econ&oacute;mica de voluntarios</th>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td  align="center">#qGetVoluntariado.TOTALVOL# </td>
                                        <td  align="center">#qGetVoluntariado.TOTALHRS# </td>
                                        <td  align="center">#qGetVoluntariado.TOTALAPORTAEMP# </td>
                                        <td  align="center">#qGetVoluntariado.TOTALAPORTAVOL# </td>
                                    </tr>                    
                                </tbody>
                            </table>
							
						</font>
					</div>
        		  </div><!--div voluntariado --->
                  </cfif>
                  
                  <!---- VOLUNTARIOS INDIVIDUALES  ---->
                  
                  <!---- VINCULACION ---->
                  <cfif #qGetVinculacion.RECORDCOUNT# GT 0>
                  <div class="form-group-sm" id="divVinculacion" >
                  	<div class="col-sm-12" style="margin-top:40px; margin-bottom:10px;">
                        <center>
                            <h4><b>VINCULACI&Oacute;N CON EMPRESAS Y ORGANISMOS SOCIALMENTE RESPONSABLE PARA VINCULACI&Oacute;N DE VOLUNTARIADO </b></h4>  
                            #periodo#
                        </center>
					</div>
				    <div class="table-responsive col-sm-12">
                        <font style="font-family:Verdana, Geneva, sans-serif; font-size:12px;">                        
                        	<table class="table table-striped" id="myTable" border="1">  
                                <thead>
                                    <th>ENTE </th>
                                    <th>FECHA DE VINCULACI&Oacute;N</th>
                                    <th>INSTALACIONES</th>
                                    <th>SEDE</th>
                                    <th>CONCEPTO DE LA REUNI&Oacute;N</th>
                                    <th>NOTAS</th>
                                </thead>
                                <tbody>                
                                    <cfloop query="qGetVinculacion">
                                        <tr>
                                            <td>#qGetVinculacion.ENTE# </td>
                                            <td align="center">#lsdateformat(qGetVinculacion.FECHAVINCULACION,'dd/mm/yyyy')# </td>
                                            <td align="center">#qGetVinculacion.INSTALACIONES# </td>
                                            <td align="center">#qGetVinculacion.SEDE# </td>
                                            <td align="center">#qGetVinculacion.CONCEPTOREUNION# </td>
                                            <td align="justify">#qGetVinculacion.NOTAS# </td>
                                        </tr>
                                    </cfloop>
								</tbody>
							</table>
                            
						</font>
					</div>
                  </div><!--DIV VINCULACION--->
                  </cfif>
                  
                  <!---
                  <div class="form-group-sm" style="padding-top:20px;">
                    <center> <br><br>
                     Bar graph, from Query of Queries ---
                    <cfchart format="png"  
                        show3D = "no"  
                        showBorder = "yes"  
                        showLegend = "no"  
                        font="Verdana"  
                        yaxistitle="Prestadores de S.S."
                        chartwidth="600"
                        chartheight="300"
                        title="SERVICIOS SOCIALES POR #qGetReporteSS.TIPOCONCEPTO#"
                        >  
                            
                                           
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
                    </center>
   				  </div>--->
   
   
			   	</div>
			</div>
		</div>
	</div> <!-- container -->
    
</cfoutput>
</body>
</html>

		
		<!---
        
        FILA	TIPOCONCEPTO	TOTALCONCEPTO	TOTALINSTITUCION	IDCONCEPTO	CONCEPTODESC	INSTITUCIONSS	TIPO
1	RUBRO	3	3	200	Adultos mayores	0236 - LOS SESENTA, I.A.P.	1
        ---->
		
        
    
	
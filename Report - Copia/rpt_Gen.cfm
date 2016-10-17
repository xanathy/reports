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
<body  class="areafija">
<cfoutput>


	
    <!--- CONSULTAR REPORTE ---->
    
    
    
    <cfif (isdefined ("url.cr") AND #url.cr# EQ 1)>
        <cfif (isdefined ("url.cr") AND #url.cr# EQ 1)>
			<cfif isdefined("form.tipoReporte") AND LEN(#form.tipoReporte#) GT 0> <cfset tipoReporte = #form.tipoReporte#> </cfif>
            <cfif isdefined("form.rdEstatusSS") AND LEN(#form.rdEstatusSS#) GT 0> <cfset rdEstatusSS = #form.rdEstatusSS#> <cfelse> <cfset rdEstatusSS = 'AC'> </cfif>
            <cfif isdefined("form.chkAddIap") AND LEN(#form.chkAddIap#) GT 0> <cfset chkAddIap = #form.chkAddIap#> <cfelse> <cfset chkAddIap = '0'> </cfif>
            <cfif isdefined("form.rdPeriodo") AND LEN(#form.rdPeriodo#) GT 0> <cfset rdPeriodo = #form.rdPeriodo#> </cfif>       
             
        </cfif> 
        <cfset intervalo = 0>
        <cfif rdPeriodo EQ 0>
        	<!--- SE CONSIDERA UN INTERVALO ESPECIFICADO POR EL USUARIO --->
			<cfif isdefined("form.ftxtfechainicio") AND LEN(#form.ftxtfechainicio#) GT 0> <cfset fechainicio = #form.ftxtfechainicio#>  <cfelse> <cfset fechainicio=''>  </cfif>
            <cfif isdefined("form.ftxtfechaFin") AND LEN(#form.ftxtfechaFin#) GT 0> <cfset fechaFin = #form.ftxtfechaFin#>  <cfelse> <cfset fechaFin=''>  </cfif>
	        <cfset intervalo = 1>
        <cfelse>
        	<!--- CONSULTA POR UN AÑO ESPECIFICO --->
             <cfset fechainicio='01/01/' & #rdPeriodo#> 
             <cfset fechaFin= #lsdateformat(NOW(),'dd/mm/yyyy')#>
             <cfset intervalo = 0>
             <!---- '31/12/' & #rdPeriodo#> ---->
        </cfif>
	    <cfinvoke component="CONS_REP.ssdovovi.Consult.spGetReporteSS" method="getReporteSS" returnvariable="qGetReporteSS">
            <cfinvokeargument name="tipoReporte" value="#tipoReporte#">
            <cfinvokeargument name="rdEstatusSS" value="#rdEstatusSS#">
            <cfinvokeargument name="chkAddIap" value="#chkAddIap#">
            <cfinvokeargument name="fechainicio" value="#fechainicio#">
            <cfinvokeargument name="fechaFin" value="#fechaFin#">     
            <cfinvokeargument name="intervalo" value="#intervalo#">     
                            
		</cfinvoke>
    <cfelse>
    	<cflocation url="rpt_Principal.cfm"> 
    </cfif>    
    
    <!--- construccion de reporte en pantalla ---->
    
    <div class="container-fluid" style="margin-top:20px;">
    
     	<div class="row col-sm-12">
            <div class="panel panel-primary">
                <div class="panel-heading"><span class="glyphicon glyphicon-list "></span>
                	Reportes de Servicio Social                    
                </div>          
                   
                <div class="panel-body"  style="margin-top:10px;" >
                  <div class="form-group-sm">
                    <div class="row col-md-12 ">
                        <div class="row col-md-6 ">
                            <a href="/cons_rep/ssdovovi/report/rpt_Principal.cfm?r=1">Generar otro reporte </a>
                        </div>
                        <div class=" col-md-6 ">
                            <!---- OJOOOOOO ---->
                            
                            <cfform action="rpt_GenPdf.cfm" id="formPdf" target="_blank"> 
                                <input type="hidden" id="tipoReporte" name="tipoReporte" value="#tipoReporte#">
                                <input type="hidden" id="rdEstatusSS" name="rdEstatusSS" value="#rdEstatusSS#">
                                <input type="hidden" id="chkAddIap" name="chkAddIap" value="#chkAddIap#">
                                <input type="hidden" id="intervalo" name="intervalo" value="#intervalo#">
                                <input type="hidden" id="ftxtfechainicio" name="ftxtfechainicio" value="#fechainicio#">
                                <input type="hidden" id="ftxtfechaFin" name="ftxtfechaFin" value="#fechaFin#">
                                <button class="btn btn-warning  pull-right" type="submit" value="">
                                    <span class="glyphicon glyphicon-download">
                                    	<font style="font-family:Verdana, Geneva, sans-serif">&nbsp; Descargar PDF</font></span> 
                                </button>                        
                            </cfform>
                        </div>   
                   </div></div>
                  
                  <div class="form-group-sm">
                    <div class="txtDetalle">
                        <div class="col-sm-12" style="margin-top:15px; margin-bottom:10px;">
                        	<center>
	                        	<h4><b>REPORTE DE PRESTACI&Oacute;N DE SERVICIO SOCIAL POR #qGetReporteSS.TIPOCONCEPTO#</b></h4>  
                                <h5>Periodo: <cfif #intervalo# EQ 1> #fechainicio# - #fechafin# <cfelse> #YEAR(fechainicio)# </cfif></h5>
                            </center>
                        </div>
				        <div class="table-responsive col-sm-12">
                        <font style="font-family:Verdana, Geneva, sans-serif">
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
                                        <td>Total</td>
                                        <td  align="center">#qGetReporteSS.TOTALSS# </td>
                                    </tr>                    
                                </tbody>
                            </table>
						</font>
						</div>
					</div>
        		  </div>
                  <div class="form-group-sm" style="padding-top:20px;">
                    <center> <br><br>
                    <!--- Bar graph, from Query of Queries ---> 
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
   				  </div>
   
   
			   	</div>
			</div>
		</div>
	</div>
    
</cfoutput>
</body>
</html>

		
		<!---
        
        FILA	TIPOCONCEPTO	TOTALCONCEPTO	TOTALINSTITUCION	IDCONCEPTO	CONCEPTODESC	INSTITUCIONSS	TIPO
1	RUBRO	3	3	200	Adultos mayores	0236 - LOS SESENTA, I.A.P.	1
        ---->
		
        
    
	
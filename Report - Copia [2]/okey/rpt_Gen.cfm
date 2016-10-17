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
			<cfif isdefined("form.ftxtfechainicio") AND LEN(#form.ftxtfechainicio#) GT 0> <cfset fechainicio = #form.ftxtfechainicio#>  <cfelse> <cfset fechainicio=''>  </cfif>
            <cfif isdefined("form.ftxtfechaFin") AND LEN(#form.ftxtfechaFin#) GT 0> <cfset fechaFin = #form.ftxtfechaFin#>  <cfelse> <cfset fechaFin=''>  </cfif>
	        <cfset intervalo = 1>
        <cfelse>
             <cfset fechainicio='01/01/' & #rdPeriodo#> 
             <cfset fechaFin= NOW()>
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
    	<!---- <cflocation url="rpt_Principal.cfm"> ---->
        aaa
    </cfif>    
    <br> #form.rdPeriodo# - 
	#form.ftxtfechaFin# - fechaFin: #fechaFin#
	
    <!--- construccion de reporte en pantalla ---->
    
    <div class="container-fluid" style="margin-top:20px;">
    
     	<div class="row col-sm-12">
            <div class="panel panel-primary">
                <div class="panel-heading"><span class="glyphicon glyphicon-list "></span>
                	Reportes de Servicio Social 
                </div>                
                <div class="panel-body"  style="margin-top:10px;" >
                  <div class="form-group-sm">
                    <div class="txtDetalle">
                        <div class="col-sm-12">
	                        <h5>Prestadores de Servicio Social activos </h5>
                        </div>
    	                <div class="row col-md-12 pull-right">
        	            <!---- OJOOOOOO ---->
                        
                            <cfform action="rpt_GenPdf.cfm" id="formPdf" target="_blank"> 
                            <br>tipoReporte
                                <input type="text" id="tipoReporte" name="tipoReporte" value="#tipoReporte#">
                            <br>rdEstatusSS
                                <input type="text" id="rdEstatusSS" name="rdEstatusSS" value="#rdEstatusSS#">
                            <br>chkAddIap
                                <input type="text" id="chkAddIap" name="chkAddIap" value="#chkAddIap#">
                            <br>intervalo
                                <input type="text" id="intervalo" name="intervalo" value="#intervalo#">
                            <br>fechainicio
                                <input type="text" id="ftxtfechainicio" name="ftxtfechainicio" value="#fechainicio#">
                            <br>fechaFin
                                <input type="text" id="ftxtfechaFin" name="ftxtfechaFin" value="#fechaFin#">
                                <button class="btn btn-default" type="submit" value="">
                                    <span class="glyphicon glyphicon-download">Descargar -  PDF</span> 
                                </button>
                                
                            </cfform>
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
                                        <td>Periodo: #fechainicio# - #fechafin# </td>
                                        <td>Total: #qGetReporteSS.TOTALSS# </td>
                                    </tr>                    
                                </tbody>
                            </table>
						</font>
						</div>
					</div>
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
		
        
    
	
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
	<title>Reporte de Servicio Social</title>	
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
    
    <!--- SI ESTA MARCADO ENTONCES MOSTRAMOS IAPS --->
    <cfset chkAddIap = 1>
    
    
    <!--- CONSULTA SOLICITADA ---->
     <cfinvoke component="CONS_REP.ssdovovi.Consult.spReporteSS" method="getReporteSS" returnvariable="qGetReporteSS">
        <cfinvokeargument name="tipoReporte" value="2">	
        <cfinvokeargument name="rdEstatusSS" value="AC">	
        <cfinvokeargument name="fechaInicio" value="01/01/2015">	
        <cfinvokeargument name="fechaFin" value="01/12/2017">	
    </cfinvoke>
    
    
     <cfinvoke component="CONS_REP.ssdovovi.Consult.spReporteSS" method="getReporteSS" returnvariable="qGetRubrosSS">
        <cfinvokeargument name="tipoReporte" value="1">	
        <cfinvokeargument name="rdEstatusSS" value="AC">	
        <cfinvokeargument name="fechaInicio" value="01/01/2015">	
        <cfinvokeargument name="fechaFin" value="02/09/2017">	
    </cfinvoke>
    
    <cfinvoke component="CONS_REP.ssdovovi.Consult.spReporteSS" method="getEscuelasSS" returnvariable="qGetEscuelaSS"> </cfinvoke>
    
    
   	<cfset SetLocale("es_MX")>
</head>
<body class="areafija" > <!---- class="areafija" ----->
<cfoutput>
     <div class="container-fluid" style="margin-top:20px;">
     	<div class="row col-sm-12">
            <div class="panel panel-primary">
                <div class="panel-heading"><span class="glyphicon glyphicon-list "></span>
                	Reportes de Servicio Social 
                </div>                
                <div class="panel-body"  style="margin-top:10px;" >
                aa
                
                    <div class="panel-group">
                      <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                              <a data-toggle="collapse" href="##collapse1">Collapsible panel</a>
                            </h4>
                            </div>
                            <div id="collapse1" class="panel-collapse collapse">
                            	<div class="panel-body">
                                    <cfloop query="qGetEscuelaSS">
                                        #qGetEscuelaSS.acronimo#         	 <br>                    
                                    </cfloop>
                                </div>
                            	<div class="panel-footer">Panel Footer</div>
                        	</div>
                      </div>
                    </div>
                    <div class="panel-group col-sm-6">
                      <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title" data-toggle="collapse" href="##collapseCarrera"  style="cursor:pointer;">Carreras - #qGetReporteSS.RecordCount#  </h4>
                            </div>
                            <div id="collapseCarrera" class="panel-collapse collapse">
                            	<div class="panel-body">
                                    <cfloop query="qGetReporteSS">
                                        <div class="row">
                                          	<div class="col-sm-1">
                                            	<span class="badge"> #qGetReporteSS.TOTALCONCEPTO# </span> 
                                            </div>
                                            <div class="col-sm-10">
                                            	#qGetReporteSS.CONCEPTODESC#                     
                                            </div> 
                                         </div>
                                    </cfloop>
                                </div>
                            	<div class="panel-footer">Panel Footer</div>
                        	</div>
                      </div>
                    </div>
                    
                    <cfset tipoReporte = 1>
                    <cfloop from="1" to="2" index="x">
                    	<cfinvoke component="CONS_REP.ssdovovi.Consult.spReporteSS" method="getReporteSS" returnvariable="qGetReporteSS2">
                            <cfinvokeargument name="tipoReporte" value="#x#">	
                            <cfinvokeargument name="rdEstatusSS" value="AC">	
                            <cfinvokeargument name="fechaInicio" value="01/01/2015">	
                            <cfinvokeargument name="fechaFin" value="01/12/2017">	
                        </cfinvoke>
                         <div class="panel-group col-sm-6">
                      <div class="panel panel-default">
                                	<cfset auxConcepto="">
                                    <cfset cont= 0>
                                    <cfloop query="qGetReporteSS2">
										<cfif cont EQ 0>
                                        
                                        <div class="panel-heading">
                                        <h4 class="panel-title" data-toggle="collapse" href="##collapseREPORTE#x#"  style="cursor:pointer;">#qGetReporteSS2.TIPOCONCEPTO# - #qGetReporteSS2.TOTALDISTINCT#  </h4>
                                        </div>
                                        <div id="collapseREPORTE#x#" class="panel-collapse collapse">
                                        <div class="panel-body">
                                         <cfset cont= 1>
                                        </CFIF>
                                    
                                    	<cfif auxConcepto NEQ #qGetReporteSS2.CONCEPTODESC#>
                                        	<div class="row">
                                                <div class="col-sm-1">
                                                    <span class="badge"> #qGetReporteSS2.TOTALCONCEPTO# </span> 
                                                </div>
                                                <div class="col-sm-10">
                                                     #qGetReporteSS2.CONCEPTODESC#
                                                </div> 
                                             </div>
                                        	<cfset auxConcepto = #qGetReporteSS2.CONCEPTODESC#>
										</cfif>
                                    </cfloop>
                                </div>
                            	<div class="panel-footer">Panel Footer</div>
                        	</div>
                      </div>
                    </div>
                	
                        
                    </cfloop>
                    
                    <!----------------------------------------------------------->
                    
                     <div class="panel-group col-sm-6">
                      <div class="panel panel-default">
                                	<cfset auxConcepto="">
                                    <cfset cont= 0>
                                    <cfloop query="qGetRubrosSS">
										<cfif cont EQ 0>
                                        
                                        <div class="panel-heading">
                                        <h4 class="panel-title" data-toggle="collapse" href="##collapseRubros"  style="cursor:pointer;">Rubros - #qGetRubrosSS.TOTALDISTINCT#  </h4>
                                        </div>
                                        <div id="collapseRubros" class="panel-collapse collapse">
                                        <div class="panel-body">
                                         <cfset cont= 1>
                                        </CFIF>
                                    
                                    	<cfif auxConcepto NEQ #qGetRubrosSS.CONCEPTODESC#>
                                        	<div class="row">
                                                <div class="col-sm-1">
                                                    <span class="badge"> #qGetRubrosSS.TOTALCONCEPTO# </span> 
                                                </div>
                                                <div class="col-sm-10">
                                                     #qGetRubrosSS.CONCEPTODESC#
                                                </div> 
                                             </div>
                                        	<cfset auxConcepto = #qGetRubrosSS.CONCEPTODESC#>
										</cfif>
                                    </cfloop>
                                </div>
                            	<div class="panel-footer">Panel Footer</div>
                        	</div>
                      </div>
                    </div>
                	
                    <div data-toggle="collapse" data-target="##demo">Escuelas prestadoras de servicio <span class="badge">#qGetEscuelaSS.RecordCount#</span> </div>
                    <div id="demo" class="collapse">                    	
                        <cfloop query="qGetEscuelaSS">
           					#qGetEscuelaSS.acronimo# <span class="badge">5</span>        	 <br>                    
                        </cfloop>
                        <button type="button" class="btn btn-info" data-toggle="collapse" data-target="##demo">Simple collapsible</button>
                    </div>
                    
                    <div data-toggle="collapse" data-target="##collapseCarreras">Carreras<span class="badge">#qGetReporteSS.RecordCount#</span> </div>
                    <div id="collapseCarreras" class="collapse">                    	
                        <cfloop query="qGetReporteSS">
           					#qGetReporteSS.CONCEPTODESC# <span class="badge"> #qGetReporteSS.TOTALCONCEPTO# </span>        	 <br>                    
                        </cfloop>
                        <button type="button" class="btn btn-info" data-toggle="collapse" data-target="##collapseCarreras">Simple collapsible</button>
                    </div>
                    
                    
                    
                    
                </div>
        	</div><!-- panel --->
        </div><!--row-->
	</div> <!-- container --->
       
       
         <!-- Libreria jQuery requerida por los plugins de JavaScript -->
        <script src="/CONS_REP/ssdovovi/Report/model/jquery/jquery-2.2.3.min.js"></script>
        <!-- Todos los plugins JavaScript de Bootstrap (tambien puedes incluir archivos JavaScript individuales de los unicos
        plugins que utilices) -->
        <script src="/CONS_REP/ssdovovi/Report/model/bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>
        
        <!----
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>---->
        
</cfoutput>            
</body>
</html>

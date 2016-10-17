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
			<cfif isdefined("form.tipoReporteDona") AND LEN(#form.tipoReporteDona#) GT 0> <cfset tipoReporte = #form.tipoReporteDona#> </cfif>
            <cfif isdefined("form.rdPeriodoDona") AND LEN(#form.rdPeriodoDona#) GT 0> <cfset rdPeriodo = #form.rdPeriodoDona#> </cfif>       
            <cfif isdefined("form.mesReporteDona") > <cfset mesReporteDona= #form.mesReporteDona#> </cfif>       
        </cfif> 
        <cfset intervalo = 0>
        <cfif rdPeriodo EQ 0>
        	<!--- SE CONSIDERA UN INTERVALO ESPECIFICADO POR EL USUARIO --->
			<cfif isdefined("form.ftxtfechainicioDona") AND LEN(#form.ftxtfechainicioDona#) GT 0> <cfset fechainicio = #form.ftxtfechainicioDona#>  <cfelse> <cfset fechainicio=''>  </cfif>
            <cfif isdefined("form.ftxtfechaFinDona") AND LEN(#form.ftxtfechaFinDona#) GT 0> <cfset fechaFin = #form.ftxtfechaFinDona#>  <cfelse> <cfset fechaFin=''>  </cfif>
	        <cfset intervalo = 1>
        <cfelse>
        	<!--- CONSULTA POR UN MES ESPECIFICO --->            
        	<cfif #mesReporteDona# GT 0>
                 <cfset fechainicio='01/' & #mesReporteDona# & '/' & #rdPeriodo#> 
                 <cfif  #mesReporteDona# EQ 2>
	                 <cfset fechaFin=  '28/' & #mesReporteDona# & '/' & #rdPeriodo#> 
                 <cfelseif #mesReporteDona# EQ 4 OR #mesReporteDona# EQ 6 OR #mesReporteDona# EQ 9 OR #mesReporteDona# EQ 11>
	                 <cfset fechaFin=  '30/' & #mesReporteDona# & '/' & #rdPeriodo#> 
                 <cfelse>
	                 <cfset fechaFin=  '31/' & #mesReporteDona# & '/' & #rdPeriodo#> 
                 </cfif>
            <cfelse>
				<!--- CONSULTA POR UN AÑO ESPECIFICO --->
                 <cfset fechainicio='01/01/' & #rdPeriodo#> 
                 <cfset fechaFin=  '31/12/' & #rdPeriodo#>
             </cfif>
             <cfset intervalo = 0>
             <!---- #lsdateformat(NOW(),'dd/mm/yyyy')#> ---->
        </cfif>
	    
        
            <cfinvoke component="CONS_REP.ssdovovi.Consult.spGetReporteDona" method="getDonativo" returnvariable="qGetDonativo">
                <cfinvokeargument name="tipoReporte" value="#tipoReporte#">
                <cfinvokeargument name="fechainicio" value="#fechainicio#">
                <cfinvokeargument name="fechaFin" value="#fechaFin#">                       
            </cfinvoke>
		
        
    <cfelse>
    	<cflocation url="../rpt_Principal.cfm"> 
    </cfif>    
    
    <!--- construccion de reporte en pantalla --->
    
    <div class="container-fluid" style="margin-top:20px;">
    
     	<div class="row col-sm-12">
            <div class="panel panel-primary">
                <div class="panel-heading"><span class="glyphicon glyphicon-list "></span>
                	Reportes de Donativos            
                </div>    
                
                <cfif #intervalo# EQ 1> 
                	<cfset periodo = "<h4><b> " & #fechainicio# & " - " & #fechafin# & "</b></h4>">
                	<cfset periodoPdf = #fechainicio# & " - " & #fechafin#>
                <cfelseif #mesReporteDona# GT 0> 
	                <cfset periodo = "<h4><b>" & #UCASE(MonthAsString(mesReporteDona))# & " " & #YEAR(fechainicio)# & "</b></h4>">
	                <cfset periodoPdf = #UCASE(MonthAsString(mesReporteDona))# & " " & #YEAR(fechainicio)# >
                <cfelse>
	                <cfset periodo = "<h4><b>" & #YEAR(fechainicio)# & "</b></h4>">
	                <cfset periodoPdf = #YEAR(fechainicio)# >
                </cfif> 
                
                      
                   
                <div class="panel-body"  style="margin-top:10px;" >
                  <div class="form-group-sm">
                    <div class="row col-md-12 ">
                        <div class="row col-md-6 ">
                            <a href="/cons_rep/ssdovovi/report/rpt_Principal.cfm?r=3">Generar otro reporte </a>
                        </div>
                        <div class=" col-md-6 ">
                            <cfform action="/cons_rep/ssdovovi/report/donativos/rpt_GenDonaPdf.cfm" id="formPdf" target="_blank"> 
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
                  
                  <cfif #qGetDonativo.RECORDCOUNT# GT 0>
                  <div class="form-group-sm" id="divVoluntariado">                    
					<div class="col-sm-12" style="margin-top:15px; margin-bottom:10px;">
                        <center>
                            <h4><b> 
                            	<cfif #tipoReporte# EQ 1>  <cfset tituloReporteDona = 'REPORTE GENERAL '> </cfif>
						        <cfif #tipoReporte# EQ 2>  <cfset tituloReporteDona = 'REPORTE GENERAL POR MES '> </cfif>
						        <cfif #tipoReporte# EQ 3>  <cfset tituloReporteDona = 'RES&Uacute;MEN DONATIVOS CAPTADOS '> </cfif>
						        <cfif #tipoReporte# EQ 4>  <cfset tituloReporteDona = 'IAP BENEFICIADAS '> </cfif>
                            	#tituloReporteDona# 
                            </b></h4>  
							#periodo#
                        </center>
					</div>
				    <div class="table-responsive col-sm-12">
                        <font style="font-family:Verdana, Geneva, sans-serif; font-size:12px;">                        
                        	<cfif #tipoReporte# EQ 1 OR #tipoReporte# EQ 2 OR #tipoReporte# EQ 3>  
                                <table class="table table-striped" id="myTable" border="1">  
                                    <thead>
                                    	<th>DONANTE </th>
                                        <th>PRODUCTO</th>
                                        <cfif  #tipoReporte# EQ 1 OR  #tipoReporte# EQ 2>
                                        	<th>MES</th>                                                                                
                                            <th>IAP</th>
                                            <th>CANTIDAD</th>
                                            <th>MONTO APROXIMADO</th>
                                        </cfif>                                        
                                    </thead>
                                    <tbody>               
                                        <cfset mesActual ='x'>
                                        <cfset cont = 0>
                                        
                                        <cfloop query="qGetDonativo">                                    
                                            <cfif #tipoReporte# EQ 2 OR #tipoReporte# EQ 3> 
                                                <cfif #mesActual# NEQ #qGetDonativo.MES#>
                                                    <cfif #tipoReporte# EQ 2 AND #mesActual# NEQ 'x'>
                                                        <tr>
                                                            <td colspan="6" align="center"><b>
                                                            Donativos: #qGetDonativo.TOTAL_DONATIVOS#   -   Donantes: #qGetDonativo.TOTAL_DONANTES# 
                                                              -   Monto aproximado total: #qGetDonativo.TOTAL_MONTO#   -   IAP beneficiadas: #qGetDonativo.TOTAL_IAPS# </b></td>
                                                        </tr>
                                                        <cfset cont=-1>
                                                    <cfelse>
                                                        <tr> <td colspan="6"><b> 
                                                        	#UCASE(MONTHASSTRING(qGetDonativo.MES))# 
                                                            <cfif #tipoReporte# EQ 3>  
                                                            	&nbsp;&nbsp; -  &nbsp;&nbsp; #qGetDonativo.TOTAL_DONATIVOS# donativos captados
                                                            </cfif>
                                                        </b></td> </tr>                                            	
                                                    </cfif>
                                                    <cfset mesActual = #qGetDonativo.MES#>
                                                </cfif>
                                                <cfif #cont# EQ -1 >
                                                        <tr> <td colspan="6"><b> 
                                                        	#UCASE(MONTHASSTRING(qGetDonativo.MES))# 
                                                            <cfif #tipoReporte# EQ 3>  
                                                            	&nbsp;&nbsp; -  &nbsp;&nbsp; #qGetDonativo.TOTAL_DONATIVOS# donativos captados
                                                            </cfif>
                                                        </b></td> </tr>                                           	                                        	
                                                </cfif>
                                                <cfset cont = cont + 1>
                                            </cfif>
                                            
                                            <tr>
                                                <td>#qGetDonativo.DONANTE# </td>
                                                <td align="center">#qGetDonativo.PRODUCTO# </td>                                                
		                                        <cfif  #tipoReporte# EQ 1 OR  #tipoReporte# EQ 2>
                                                    <td align="center">#MONTHASSTRING(qGetDonativo.MES)# </td>
                                                    <td align="center">#qGetDonativo.NOMBREIAP# </td>                                            
                                                    <td align="center">#qGetDonativo.CANTIDAD#</td>
                                                    <td align="center">#qGetDonativo.MONTOAPROXIMADO# </td>                                            
                                                </cfif>
                                            </tr>
                                            
                                        </cfloop>
                                        <cfif #tipoReporte# EQ 2> 
                                            <tr>
                                                <td colspan="6" align="center"><b>
                                                Donativos: #qGetDonativo.TOTAL_DONATIVOS#   -   Donantes: #qGetDonativo.TOTAL_DONANTES# 
                                                  -   Monto aproximado total: #qGetDonativo.TOTAL_MONTO#   -   IAP beneficiadas: #qGetDonativo.TOTAL_IAPS# </b></td>
                                            </tr>
                                        </cfif>                                                
                                    </tbody>
                                </table>
                                
                                <cfif #tipoReporte# EQ 1>
                                    <table class="table table-striped" id="totalTable" border="1" width="70%">  
                                        <thead>
                                            <th>DONATIVOS TOTALES</th>
                                            <th>DONANTES TOTALES </th>
                                            <th>IAP BENEFICIADAS </th>
                                            <th>MONTO APROXIMADO TOTAL</th>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td  align="center">#qGetDonativo.TOTAL_DONATIVOS# </td>
                                                <td  align="center">#qGetDonativo.TOTAL_DONANTES# </td>
                                                <td  align="center">#qGetDonativo.TOTAL_IAPS# </td>
                                                <td  align="center">#qGetDonativo.TOTAL_MONTO# </td>
                                            </tr>                    
                                        </tbody>
                                    </table>
                                </cfif>
							</cfif> <!-- tipo reporte 1,2,3 --->
                            
                            <!-- tipo reporte 4 --->
                            <cfif #tipoReporte# EQ 4>  
                                <table class="table table-striped" id="myTable" border="1" width="80%">  
                                    <thead>
                                    	<th>MES </th>
                                        <th>IAP</th>                                       
                                    </thead>
                                    <tbody>               
                                        <cfset mesActual ='x'>
                                        <cfset cont = 0>
                                        
                                        <cfloop query="qGetDonativo"> 
                                        	<tr>                                   
											<cfif #mesActual# NEQ #qGetDonativo.MES#>
                                                <cfif #mesActual# NEQ 'x'>
                                                    <cfset cont=-1>  
                                                    </tr>    
                                                    <td align="center" rowspan="#qGetDonativo.TOTAL_IAPS#" width="20%">#MONTHASSTRING(qGetDonativo.MES)# </td>                                                                                     	
                                                <cfelse>
                                                    
                                                        <td align="center" rowspan="#qGetDonativo.TOTAL_IAPS#" width="20%">#MONTHASSTRING(qGetDonativo.MES)# </td>                                               
                                                </cfif>
                                                <cfset mesActual = #qGetDonativo.MES#>
                                            </cfif>
                                            
                                            <td>#qGetDonativo.NOMBREIAP# </td>
											<cfset cont = cont + 1>
                                        </cfloop>
                                            </tr>
                                                                                    
                                    </tbody>
                                </table>
                                
							</cfif> <!-- tipo reporte 4--->
                            
                            
                            
						</font>
					</div>
        		  </div><!--divDonativos general --->
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
		
        
    
	
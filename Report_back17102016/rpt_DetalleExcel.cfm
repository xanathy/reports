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
    
    <style>
		.txtDetalle{
			font-size:11px;	
		}
	</style>
    
    
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
                	
                  <div class="form-group-sm">
        <cfinvoke component="CONS_REP.ssdovovi.Consult.spReporteSS" method="getSSActual" returnvariable="qGetSSActual">
        <cfinvokeargument name="consultaAnio" value="0">	
                        </cfinvoke>
                                    
        
        <div class="txtDetalle">
        <div class="col-sm-12">
            <h5>Prestadores de Servicio Social activos </h5>
        </div>
        <div class="row col-md-12 pull-right">
        <!---- OJOOOOOO ---->
            <a href="xlsPrestadores.cfm?anio=0"> <img src="img/excel.png">Descargar</a>
        </div>
        <div class="table-responsive col-sm-12">
                    <table class="table table-striped" id="myTable" border="1">  
        <thead>  
          <tr>  
            <th>Prestador</th>  
            <th>Escuela</th>  
            <th>Carrera</th>  
            <th>Fecha de Inicio de S.S.</th>  
            <th>Fecha de t&eacute;rmino de S.S.</th>  
            <th>Instituci&oacute;n asignada</th>  
          </tr>  
        </thead>  
        <tbody>  
        
                        <cfloop query="qGetSSActual">
                        
          <tr class="txtDetalle">  
            <td>
            <a href="##modalPrestadoresDetalle" data-toggle="modal" 
            data-id="#qGetSSActual.NOMBRE# , #qGetSSActual.EDAD# , #qGetSSActual.EMAIL# , #qGetSSActual.TELEFONOFIJO# , 
			#qGetSSActual.TELEFONOCELULAR# , #qGetSSActual.INSTITUCIONEDUCATIVA# , #qGetSSActual.ACRONIMO# , #qGetSSActual.CARRERA# , 
            #qGetSSActual.NIVELCURSADO#, #qGetSSActual.UNIDADNIVELCURSADO# , #LSDateFormat(qGetSSActual.FECHAINICIO,'dd/mm/yyyy')# , 
            #LSDateFormat(qGetSSActual.FECHAFINAL,'dd/mm/yyyy')# , #qGetSSActual.INSTITUCIONASIGNADA#">
            <i class="icon-edit bigger-120"></i> #qGetSSActual.NOMBRE # </a> &nbsp;
            
            
            <!---<a data-toggle="modal" data-target="##modalPrestadoresDetalle"> </a> --->
            </td>  
            <td>#qGetSSActual.ACRONIMO #</td>  
            <td>#qGetSSActual.CARRERA #</td>  
            <td>#qGetSSActual.FECHAINICIO #</td>  
            <td>#qGetSSActual.FECHAFINAL #</td>  
            <td>#qGetSSActual.INSTITUCIONASIGNADA #</td>  
          </tr>  
          </cfloop>
            
        </tbody>  
      </table>  
      </div>
                    </div>
                </div>    
                    
                    <!----
					
					<div class="form-group-sm">
                    <cfinvoke component="CONS_REP.ssdovovi.Consult.spReporteSS" method="getSSActual" returnvariable="qGetSSActual">
                        </cfinvoke>
                        
                        <cfloop query="qGetSSActual">
                        
                        </cfloop>
                    
                    
                    </div>
                ---->
                
                    
                    <!------ OJO REVISAR LOS TOTALES DE PRESTADORES --->
                    
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
                                        </CFIF>
                                    	<cfset cont= cont + 1>
                                        <cfif auxConcepto NEQ "" AND auxConcepto NEQ #qGetReporteSS2.CONCEPTODESC#>
                                        </div>
                                                </div> 
                                             </div>
                                        </cfif>
                                    	<cfif auxConcepto NEQ #qGetReporteSS2.CONCEPTODESC#>
                                        	<div class="row">
                                                <div class="col-sm-1">
                                                    <span class="badge"> #qGetReporteSS2.TOTALCONCEPTO# </span> 
                                                </div>
                                                <div class="col-sm-10">
                                          			<a data-toggle="collapse" href="##collapseIAP_#x#_#cont#"> #qGetReporteSS2.CONCEPTODESC# </a>
                                                    <div id="collapseIAP_#x#_#cont#" class="panel-collapse collapse">   
                                        </cfif>
                                                     <span class="txtDetalle">#qGetReporteSS2.INSTITUCIONSS# <BR></span>
                                      
                                        	<cfset auxConcepto = #qGetReporteSS2.CONCEPTODESC#>
                                        
										
                                    </cfloop>
                                    <!---FIN ---->
									</div>
                                                </div> 
                                             </div>
									
									<!------>
                                </div>
                            	<div class="panel-footer">Panel Footer</div>
                        	</div>
                      </div>
                    </div>
                	
                        
                    </cfloop>
                    
                    <!----------------------- modal -------------------------------
                   <p>Link 1</p>

<a href="##" data-target="##addBookDialog" data-toggle="modal" data-id="ISBN564541">ISBN564541 Modal</a>
<p>&nbsp;</p>


<p>Link 2</p>
<a href="##" data-target="##addBookDialog" data-toggle="modal" data-id="my_id_value">Open Modal</a>

<div class="modal hide" id="addBookDialog">
 <div class="modal-header">
    <button class="close" data-dismiss="modal">×</button>
    <h3>Modal header</h3>
  </div>
    <div class="modal-body">
        <p>some content</p>
        <input type="text" name="bookId" id="bookId" value=""/>
    </div>
</div>----->

  <!----------------------- modal ------------------------------------>
                    
                      <!-- Modal -->
                      <div class="modal fade" id="modalPrestadoresDetalle" role="dialog">
                        <div class="modal-dialog modal-md">
                          <div class="modal-content">
                            <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                              <h4 class="modal-title">Detalle del prestador de Servicio Social</h4>
                            </div>
                            <div class="modal-body">
                            	<div class="table-responsive">
                                <table class="table table-striped" style="border:none;">
                                	<tr>
	                                    <td>Nombre: </td>
                                        <td><span id="ssnom"></span></td>
                                    </tr>
                                	<tr>
	                                    <td>Edad: </td>
                                        <td><span id="ssedad"></span></td>
                                    </tr>
                                	<tr>
	                                    <td>Email: </td>
                                        <td><span id="ssemail">email: </span></td>
                                    </tr>
                                	<tr>
	                                    <td>Tel&eacute;fono fijo: </td>
                                        <td><span id="sstelfijo"></span></td>
                                    </tr>
                                	<tr>
	                                    <td>Tel&eacute;fono celular: </td>
                                        <td><span id="sscel"></span></td>
                                    </tr>
                                	<tr>
	                                    <td>Instituci&oacute;n educativa: </td>
                                        <td><span id="ssescuela"></span></td>
                                    </tr>
                                	<tr>
	                                    <td>Acr&oacute;nimo: </td>
                                        <td><span id="ssacronimo"></span></td>
                                    </tr>
                                	<tr>
	                                    <td>Carrera: </td>
                                        <td><span id="sscarrera"></span></td>
                                    </tr>
                                	<tr>
	                                    <td>Nivel cursado: </td>
                                        <td><span id="ssnivel"></span> <span id="ssunidadnivel"></span></td>
                                    </tr>
                                	<tr>
	                                    <td>Inicio del servicio social: </td>
                                        <td><span id="ssfechainicio"></span></td>
                                    </tr>
                                	<tr>
	                                    <td>Finalizaci&oacute;n del servicio social: </td>
                                        <td><span id="ssfechafin"></span></td>
                                    </tr>
                                	<tr>
	                                    <td>Instituci&oacute;n asignada: </td>
                                        <td><span id="ssinstitucion"></span></td>
                                    </tr>
                              </table>          
                              </div>
                            </div>
                            <!--
                            <div class="modal-footer">
                              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
							--->
                          </div>
                        </div>
                      </div>

  <!----------------------------------------------------------->
                    
                    
                   
                	
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
        

                    
<link rel="stylesheet" href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css">
<script type="text/javascript" src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>

 
<script>
$(document).ready(function(){
    $('##myTable').dataTable();
});
</script>
        

<script>
/*
var product = $('a[href="##modal-form-edit"]').data('id');
*/
// using latest bootstrap so, show.bs.modal
$('##modalPrestadoresDetalle').on('show.bs.modal', function(e) {
  var str = $(e.relatedTarget).data('id');
	var temp = new Array();
	temp = str.split(",");
	alert(temp);
	var ssedad = temp[1];
	alert(ssedad);
	 $("##ssnom").text(temp[0]);
	 $("##ssedad").text(temp[1]);
	 $("##ssemail").text(temp[2]);
	 $("##sstelfijo").text(temp[3]);
	 $("##sscel").text(temp[4]);
	 $("##ssescuela").text(temp[5]);
	 $("##ssacronimo").text(temp[6]);
	 $("##sscarrera").text(temp[7]);
	 $("##ssnivel").text(temp[8]);
	 $("##ssunidadnivel").text(temp[9]);
	 $("##ssfechainicio").text(temp[10]);
	 $("##ssfechafin").text(temp[11]);
	 if(temp[13] !== null && temp[13] !== undefined){
		$("##ssinstitucion").text(temp[12] + ',' + temp[13]);	
	 }else{
		$("##ssinstitucion").text(temp[12]);	
	 }
});
</script>        
        
        <!----
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>---->
        
</cfoutput>            
</body>
</html>

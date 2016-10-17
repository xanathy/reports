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
     <div class="container-fluid" style="margin-top:20px;">
     	<div class="row">
         <div class="col-md-12">
         
         	<div class="panel panel-primary">
              	<div class="panel-heading"><span class="glyphicon glyphicon-list "></span>
              		Reportes de Servicio Social 
              	</div>                
              	<div class="panel-body"  style="margin-top:10px;" >
<!---                 	<cfform action="../Consult/action.cfm?cr=1" id="formConsulta"> --->
                 	<cfform action="rpt_Gen.cfm?cr=1" id="formConsulta"> 
                        <div class="form-group col-sm-12">
                            <div class="col-sm-3">
                                <label>Tipo de reporte: </label>
                            </div>
                            <div class="col-sm-9">
                                <select id="tipoReporte" name="tipoReporte"> 
                                    <option value="0" ></option>
                                    <option value="1" >Servicio social por rubro </option>
                                    <option value="2">Servicio social por carrera </option>
                                    <option value="3">Servicio social por escuela</option>
                                    <option value="4">Servicio social por IAP</option>
                                    <option value="5">Servicio social por IAP y Organos</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-sm-12" style="margin-top:20px;">							
                            <div class="col-sm-4">
                                <label>Estatus del servicio social </label>
                            </div>
                            <div class="col-sm-7">
                            	<input type="radio" id="rdEstatusSS" name="rdEstatusSS" value="1">En servicio
                                <br><input type="radio" id="rdEstatusSS" name="rdEstatusSS" value="2">Servicio conlcuido
                                <br><input type="radio" id="rdEstatusSS" name="rdEstatusSS" value="3">No importa el estatus
                            </div>
                        </div>                        
                        <div class="form-group col-sm-12" style="margin-top:20px;">	  
                            <div class="col-sm-12">
                                <div class="col-sm-4">
                                    <label>Periodo del reporte: </label>
                                </div>
                                <div class="col-sm-7">
									<!--- se mostrarán los últimos 3 años (a partir de 2015 que se empieza a llenar la base) ---->
									<cfset anio = #YEAR(NOW())#>
                                    <cfloop condition="#anio# GT (#YEAR(NOW())# - 3) AND #anio# GTE 2015" >
                                        <input type="radio" id="rdPeriodo" name="rdPeriodo" value="#anio#">#anio# <br />
                                        <cfset anio = anio - 1>
                                    </cfloop>
                                    <input type="radio" id="rdPeriodo" name="rdPeriodo" value="0">Otro <br />
                                </div>
                            </div>
	                        <div id="divPeriodo" class="col-sm-12" style="display:none;">
                                <div class="col-sm-5" style="margin-left:15px;">
                                    <label>Inicio</label>
                                    <div class="form-group" >
                                        <div class="input-group date col-sm-10" id="datetimepicker1">
                                            <cfset vFechaInicio = "">
                                            <cfinput type="text" class="form-control redondos" id="ftxtfechainicio" name="ftxtfechainicio" 
                                            placeholder="Fecha inicio(dd/mm/aaaa)"  
                                            message="Capture fecha de inicio del SS en formato dd/mm/yyyy"
                                             validate="eurodate" value="#LSDateFormat(vFechaInicio,'dd/mm/yyyy')#" tooltip="Fecha de inicio">
                                             <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>    
                                     </div>
                                </div>
                                <div class="col-sm-5" style="margin-left:15px;" >
                                    <label>Fin</label>
                                    <div class="form-group" >
                                        <div class="input-group date col-sm-10" id="datetimepicker2">
                                            <cfset vFechaFin = "">
                                            <cfinput type="text" class="form-control redondos" id="ftxtfechaFin" name="ftxtfechaFin" 
                                            placeholder="Fecha final (dd/mm/aaaa)"  
                                            message="Capture fecha final del periodo dd/mm/yyyy"
                                             validate="eurodate" value="#LSDateFormat(vFechaFin,'dd/mm/yyyy')#" tooltip="Fecha de inicio">
                                             <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>    
                                     </div>
                                </div>
							</div>
                        </div><!--form-group fechas --->       
                        <div class="col-sm-12" style="margin-top:20px;" >
                        	<center> <button type="button" class="btn btn-warning" id="btnRptSS" name="btnRptSS">Generar reporte</button> </center>
                        </div>
                    </cfform>
                </div>
			</div><!-- panel -->
		</div>
       </div><!--row-->
	</div>
       
       
     <!-- Libreria jQuery requerida por los plugins de JavaScript -->
    <script src="/CONS_REP/ssdovovi/Report/model/jquery/jquery-2.2.3.min.js"></script>
    <!-- Todos los plugins JavaScript de Bootstrap (tambien puedes incluir archivos JavaScript individuales de los unicos
    plugins que utilices) -->
    <script src="/CONS_REP/ssdovovi/Report/model/bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>
    <!--- AUTOCOMPLETADO--->
    <script src="/CONS_REP/ssdovovi/Report/model/custom/typeahead.bundle.js"></script>
    <script src="/CONS_REP/ssdovovi/Report/model/custom/bloodhound.js"></script>
    <!--- Datetimepicker--->
    <script src="/CONS_REP/ssdovovi/Report/model/custom/moment-with-locales.js"></script>
    <script src="/CONS_REP/ssdovovi/Report/model/custom/bootstrap-datetimepicker.js"></script>
    <script src="/CONS_REP/ssdovovi/Report/model/custom/transition.js"></script>
    <script src="/CONS_REP/ssdovovi/Report/model/custom/collapse.js"></script>
    
	<script type="text/javascript">
    $(function () {
        $('##datetimepicker1').datetimepicker({
            //viewMode: 'years'
            locale: 'es',
            format: 'L'
        });
        $('##datetimepicker2').datetimepicker({
                locale: 'es',
                format: 'L'
            });
            
    });
   
    </script>
    
    <!-- periodo --->
    <!--- <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script> --->
    <script>
        $(document).ready(function() {
          $('input:radio').change(function() {
            var rdPeriodo = $("input[name='rdPeriodo']:checked").val();//name is is_external not radio
            if(rdPeriodo == 0){
                $('##divPeriodo').css('display','block');	
            }else{
               $('##divPeriodo').css('display','none');	
            }
          });
		  
		  $("##btnRptSS").click(function() {
			var verificaRequeridos = false;
			var msg = '';
			if($('##divPeriodo').css('display') == 'block'){
				if($('##ftxtfechainicio').val().length == 0 ||  $('##ftxtfechaFin').val().length == 0 ){
					msg = 'Debe indicar la fecha de inicio y fecha final del periodo a consultar';	
				}
			}
			
			if($('##tipoReporte option:selected').val()==0){
				msg = msg + '\n  - Tipo de reporte ';	
			}
			
			/*
			if(!$('##rdEstatusSS').is(':checked') ){
				msg = msg + '\n  - Estatus de los prestadores del servicio';	
			}
			*/
			
/*			$("input[name='rdPeriodo']:checked").val();*/
			/*
			if($("input[name='rdPeriodo']:checked").val().length > 0){
				alert($("input[name='rdPeriodo']:checked").val());
			}
			*/
				/*
			if($("input[name='rdPeriodo']:checked").val().length > 0){
				alert($("input[name='rdPeriodo']:checked").val().length);
				msg = msg + '\n  - Periodo de consulta';	
			}
			*/
			
			if(msg.length == 0){
				$('##formConsulta').submit();
			}else{
				alert('Por favor indique: ' + msg);
			}
			
		  });
		  
		  
        });    
	</script>
    
</cfoutput>     
</body>
</html>

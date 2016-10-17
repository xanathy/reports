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
    <link rel="stylesheet" href="/CONS_REP/ssdovovi/Report/model/custom/custom.css">
    <!--- Datetimepicker--->
    <link rel="stylesheet" href="/CONS_REP/ssdovovi/Report/model/custom/bootstrap-datetimepicker.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->  
    <cfif not isdefined("session.no_user")>
    	<cflocation addtoken="no" url="/logout.cfm">
    </cfif>
    <cfinclude template="#session.head#">  
    
	<!--- CATALAGO DE ESCUELAS--->
	<cfinvoke component="App.ssdovovi.controller.proveedor" method="fEscuelas" returnvariable="qGetEscuelas" />
    
	<!--- CATALOGO DE CARRERAS--->
    <cfinvoke component="App.ssdovovi.controller.proveedor" method="fCarreras" returnvariable="qGetCarreras" />
    <!--- CATALOGO DE IAPS--->
    <cfinvoke component="App.ssdovovi.controller.proveedor" method="fIaps" returnvariable="qGetIaps" />
    <!--- CATALOGO DE RAMOS DE CARRERAS--->
    <cfinvoke component="App.ssdovovi.controller.proveedor" method="framosoferta" returnvariable="qGetRamosOferta" />
    
    <!--- VARIABLES PARA EL AUTOCOMPLETADO--->
    <cfset vListaEscuelas = QuotedValueList(qGetEscuelas.NOMBREYSIGLAS,",")>
    <cfset vPreListaIaps = QuotedValueList(qGetIaps.NONOMBRE,",")>
	<!--- AGREGA LA JAPDF A LA LISTA DE SELECCIONABLES--->
	<cfset vListaIaps = ListAppend(vPreListaIaps, "'JAPDF Junta de Asistencia Privada del DF'")>
   
   	<cfset SetLocale("es_MX")>
    
    <cfif isdefined("url.idprestador")>
        <!--- PRESTADORES DE SERVICIO SOCIAL--->
        <cfinvoke component="App.ssdovovi.controller.proveedor" method="fAllPrestadores" returnvariable="qGetPrestadores">
            <cfinvokeargument name="aidprestador" value="#url.idprestador#">
        </cfinvoke>
		
		<cfset vNombre = '#qGetPrestadores.NOMBRES#'>
        <cfset vApellidoPaterno = '#qGetPrestadores.APELLIDOPATERNO#'>
        <cfset vApellidoMaterno = '#qGetPrestadores.APELLIDOMATERNO#'>
        <cfset vEdad = '#qGetPrestadores.EDAD#'>
        <cfset vTelFijo = '#qGetPrestadores.TELEFONOFIJO#'>
        <cfset vTelCel = '#qGetPrestadores.TELEFONOCELULAR#'>
        <cfset vEmail = '#qGetPrestadores.EMAIL#'>
        <cfset vEscuela = '#qGetPrestadores.ESCUELA#'>
        <cfset vCarrera = '#qGetPrestadores.REFID_CARRERA#'>
        <cfset vNivel = '#qGetPrestadores.NIVELCURSADO#'>
        <cfset vUnidadNivel = '#qGetPrestadores.UNIDADNIVELCURSADO#'>
        <cfset vFechaInicio = '#qGetPrestadores.FECHAINICIO#'>
        <cfset vFechaFinal = '#qGetPrestadores.FECHAFINAL#'>
        <cfset vFechaRegistroSS = '#qGetPrestadores.FECHAREGISTROSS#'>
		<cfif #qGetPrestadores.NONOIAP# neq ''>
        	<cfset vNoIAPOrgano = '#qGetPrestadores.NONOIAP#'> 
        <cfelse>
        	<cfset vNoIAPOrgano = '#qGetPrestadores.ORGANO#'> 
        </cfif>    
        <cfset vRubro = '#qGetPrestadores.RUBRO#'>
    <cfelse>
    	<cfset vNombre = ''>
        <cfset vApellidoPaterno = ''>
        <cfset vApellidoMaterno = ''>
        <cfset vEdad = ''>
        <cfset vTelFijo = ''>
        <cfset vTelCel = ''>
        <cfset vEmail = ''>
        <cfset vEscuela = ''>
        <cfset vCarrera = ''>
        <cfset vNivel = ''>
        <cfset vUnidadNivel = ''>
        <cfset vFechaInicio = ''>
        <cfset vFechaFinal = ''>
        <cfset vFechaRegistroSS = ''>
        <cfset vNoIAPOrgano = ''>
        <cfset vRubro = ''>
    </cfif>
    
    <cfajaximport>
</head>

<body>
     
     <div class="container-fluid">
     	<div class="row">
         <div class="col-md-12">
         	<div class="panel panel-primary">
              	<div class="panel-heading"><span class="glyphicon glyphicon-user"></span>
              		Registro de nuevo servicio social
              	</div>
              	<div class="panel-body">
              	<cfform id="idform1" name="form1" action="/CONS_REP/ssdovovi/Report/controller/sersoc/action.cfm"class="form-horizontal" role="form" onsubmit="return validar();">
              	
                 <div class="col-md-6">
                 	<div class="form-group">
                    	<p class="bg-primary">&nbsp;Datos acad&eacute;micos del SS</p>
                    </div>
                    <!---
                    <div class="form-group has-feedback">
  						<cfinput type="text" class="form-control typeahead" id="idftxtescuela" name="ftxtescuela" placeholder="Instituci&oacute;n educativa" required message="Capture la instituci\u00f3n educativa" value="#vEscuela#" tooltip="Escriba el nombre y seleccione el resultado de la lista. Para da de alta un nuevo registro, capture la instituci&oacute;n educativa y entre par&aacute;ntesis indique el acr&oacute;nimo. Ej. Universidad de Ciencias y Humanidades (UCYH)">
                        <i class="glyphicon glyphicon-education form-control-feedback"></i>
					</div>
                   --->
                   <div class="form-group has-feedback">
  						<cfinput type="text" class="form-control typeahead" id="idftxtescuela" 
                        name="ftxtescuela" 
                        placeholder="Instituci&oacute;n educativa" 
                        required message="Capture la instituci\u00f3n educativa"
                        tooltip="Escriba el nombre y seleccione el resultado de la lista. Para da de alta un nuevo registro, 
                        capture la instituci&oacute;n educativa y entre par&aacute;ntesis indique el acr&oacute;nimo. Ej. 
                        Universidad de Ciencias y Humanidades (UCYH)">
                        <i class="glyphicon glyphicon-education form-control-feedback"></i>
					</div>
                    <div class="form-group">
                    	
                    </div>
                    
                     <div class="form-group">
                     	<div class="input-group date" id="datetimepicker9">
  							<cfinput type="text" class="form-control redondos" id="idftxtfechainicio" name="ftxtfechainicio" placeholder="Fecha de inicio del SS en formato dd/mm/aaaa" required message="Capture fecha de inicio del SS en formato dd/mm/yyyy" validate="eurodate" value="#LSDateFormat(vFechaInicio,'dd/mm/yyyy')#" tooltip="Fecha de inicio">
                             <span class="input-group-addon">
                    			<span class="glyphicon glyphicon-calendar"></span>
                			</span>
                        </div>    
                     </div>

                    <div class="form-group">
                     	<div class="input-group date" id="datetimepicker2">
  							<cfinput type="text" class="form-control redondos" id="idftxtfechafinal" name="ftxtfechafinal" placeholder="Fecha de t&eacute;rmino del SS en formato dd/mm/aaaa" message="Capture fecha de t\u00e9rmino del SS en formato dd/mm/yyyy" validate="eurodate" onClick="addDate(6,'M');" value="#LSDateFormat(vFechaFinal,'dd/mm/yyyy')#" tooltip="Fecha final">
                             <span class="input-group-addon">
                    			<span class="glyphicon glyphicon-calendar"></span>
                			</span>
                        </div>    
					 </div>
                     
                     <div class="form-group">
                     	<div class="input-group date" id="datetimepicker3">
  							<cfinput type="text" class="form-control redondos" id="idftxtfecharegistro" name="ftxtfecharegistro" placeholder="Fecha de registro del SS en formato dd/mm/aaaa" message="Capture fecha de registro del SS en formato dd/mm/yyyy" validate="eurodate" tooltip="Fecha de registro del SS" value="#LSDateFormat(vFechaRegistroSS,'dd/mm/yyyy')#">
                             <span class="input-group-addon">
                    			<span class="glyphicon glyphicon-calendar"></span>
                			</span>
                        </div>    
					 </div>
                     
                    <div class="form-group">
                    	<p class="bg-primary">&nbsp;Datos de la IAP</p>
                    </div>
                    
                    <div class="form-group has-feedback">
  						<cfinput type="text" class="form-control typeahead" id="idftxtIAP" name="ftxtidftxtIAP" placeholder="Nombre o n&uacute;mero de la IAP" message="Capture la IAP" value="#vNoIAPOrgano#" tooltip="Nombre o n&uacute;mero de la IAP">
                        <i class="glyphicon glyphicon-search form-control-feedback"></i>
					</div>
                    
                    <div class="form-group has-feedback">
  						<cfinput type="text" class="form-control redondos" id="idftxtRubro" name="ftxtRubro" placeholder="Rubro" disabled bind="cfc:app.ssdovovi.controller.proveedor.fOneRubro({ftxtidftxtIAP@blur})" onFocus="form.ftxtidftxtIAP.focus()" value="#vRubro#">
                        <i class="glyphicon glyphicon-hand-left form-control-feedback"></i>
					</div>
                    
                     <div class="form-group" style="text-align:right;">   
                        
						<cfif isdefined("url.idprestador")>
                            <cfinput type="button" name="bEliminar" id="idbEliminar" value="Eliminar prestador actual" class="btn btn-danger" role="button" onClick="eliminar()">&nbsp;
                        </cfif>
                        <cfinput type="submit" name="bGuardar" id="idGuardar" value=" Guardar " class="btn btn-success" role="button"> <br /><br />
                        <cfinput type="button" name="bAnterior" id="idAnterior" value=" << Anterior " class="btn btn-info" role="button" onclick="goBack()">         		 
                     </div>
                 
                 </div>
              	<cfif isdefined("url.idprestador")>
                	<cfinput type="hidden" name="fhididprestador" value="#url.idprestador#">
                </cfif>    
              	</cfform>
              
            	</div>
            </div>
         </div>
        </div>
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
        
		<cfoutput>
			<script>
            var lista_escuelas = [#vListaEscuelas#];
            var lista_iaps = [#vListaIaps#]
            //$(document).ready(function() {
            //$("idftxtescuela").typeahead()
            $(document).ready(function() {
            <!---
            var $myinput = $('#myinput');
            $myinput.data('typeahead')._showDropdown()
            --->
            // constructs the suggestion engine
            var my_Suggestion_class = new Bloodhound({
              datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
              queryTokenizer: Bloodhound.tokenizers.whitespace,
              limit:4,
              local: $.map(lista_escuelas, function(filtered_items) { return { value: filtered_items }; })
            });
            // kicks off the loading/processing of `local` and `prefetch`
            my_Suggestion_class.initialize();
            
             var my_Suggestion_classIaps = new Bloodhound({
              datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
              queryTokenizer: Bloodhound.tokenizers.whitespace,
              limit:10,
              local: $.map(lista_iaps, function(filtered_items) { return { value: filtered_items }; })
            });
            // kicks off the loading/processing of `local` and `prefetch`
            my_Suggestion_classIaps.initialize();
            
            
            <!---
            var img_url = "https://raw.githubusercontent.com/cristiroma/countries/master/data/flags/";--->
            //var typeahead_elem = $('.typeahead');
                var typeahead_escuela = $(idftxtescuela);
                typeahead_escuela.typeahead({
                  hint: true,
                  highlight: true,
                  minLength: 1
                },
                {
                  // `ttAdapter` wraps the suggestion engine in an adapter that
                  // is compatible with the typeahead jQuery plugin
                      name: 'escuelas',
                      displayKey: '',
                      source: my_Suggestion_class.ttAdapter()
                });
                
                var typeahead_iaps = $(idftxtIAP);
                typeahead_iaps.typeahead({
                  hint: true,
                  highlight: true,
                  minLength: 1
                },
                {
                  // `ttAdapter` wraps the suggestion engine in an adapter that
                  // is compatible with the typeahead jQuery plugin
                      name: 'iaps',
                      displayKey: '',
                      source: my_Suggestion_classIaps.ttAdapter()
                });
            });
            </script>
            <script language="javascript">
            function validar(){
                        if(document.getElementById('IdfSelCarrera').value == '--' || 
						document.getElementById('IdfSelCarrera').value == 0){
							alert ('Seleccione una carrera')
                        	return false;
						}else{
							if(document.getElementById('IdfSelNivelCursado').value == '--'){
								alert ('Seleccione un nivel cursado')
                        		return false;
							}else{
								if(document.getElementById('IdfSelUnidadCursado').value == '--'){
									alert ('Seleccione una unidad del nivel cursado')
                        			return false;
								}else{
									if ([#vListaIaps#].indexOf(document.getElementById('idftxtIAP').value) >= 0 ||
									document.getElementById('idftxtIAP').value == ''){
										return true;
									}else{
										alert('El n\u00famero y nombre de la IAP no es correcto o no existe');
										return false;
									}
								}
							}
						}
			}
            </script>
            
            <!---
            <!---TOOLTIP --->
            <script>
				$(document).ready(function(){
					$('[data-toggle="tooltip"]').tooltip();   
				});
			</script>--->
		</cfoutput>
            
            <script type="text/javascript">
            $(function () {
                $('#datetimepicker9').datetimepicker({
                    //viewMode: 'years'
                    locale: 'es',
                    format: 'L'
                });
                $('#datetimepicker2').datetimepicker({
                        locale: 'es',
                        format: 'L'
                    });
				$('#datetimepicker3').datetimepicker({
                        locale: 'es',
                        format: 'L'
                    });	
            });
            </script>
            
            
            <script language="javascript">
			function refresh(){
				ColdFusion.bindHandlerCache['IdfSelCarrera'].call();
			}
            </script>
            
            <!--- SUMA N MESES A LA FECHA INCIAL--->
			<script>
			function addDate(offset, offsetType) {
				
				if(!document.getElementById('idftxtfechafinal').value == ''){
					document.getElementById('idftxtfechafinal').value = '';
				}
				
				
				if(!document.getElementById('idftxtfechainicio').value=='' && document.getElementById('idftxtfechafinal').value==''){
					var starDate = document.getElementById('idftxtfechainicio').value;
					var day=starDate.substring(0,2);
					var month=starDate.substring(3,5);
					var year=starDate.substring(6,10); 
					var createStartDate = new Date(year,month,day);
					
					var year = parseInt(createStartDate.getFullYear());
					var month = parseInt(createStartDate.getMonth());
					var date = parseInt(createStartDate.getDate());
					var hour = parseInt(createStartDate.getHours());
					var newDate;
					switch (offsetType) {
						case "Y":
						case "y":
						   newDate = new Date(year + offset, month, date, hour);
						   break;
					   case "M":
					   case "m":
						   newDate = new Date(year, month + (offset-1), date, hour);
						   break;
					   case "D":
					   case "d":
						   newDate = new Date(year, month, date + offset, hour);
						   break;
					   case "H":
					   case "h":
						   newDate = new Date(year, month, date, hour + offset);
						   break;
				   }
				   
				   aniofixed=newDate.getFullYear(); //anio
				   monthfixed=newDate.getMonth(); //mes
				   	
				   switch (monthfixed){
				   		case 0:
						   monthfixed = '01';
						   break;
						case 1:
						   monthfixed = '02';
						   break;
						case 2:
						   monthfixed = '03';
						   break;
						case 3:
						   monthfixed = '04';
						   break;
						case 4:
						   monthfixed = '05';
						   break;
						case 5:
						   monthfixed = '06';
						   break;
						case 6:
						   monthfixed = '07';
						   break;
						case 7:
						   monthfixed = '08';
						   break;
						case 8:
						   monthfixed = '09';
						   break;
						case 9:
						   monthfixed = '10';
						   break;
						case 10:
						   monthfixed = '11';
						   break;
						case 11:
						   monthfixed = '12';
						   break;                                 
				   }
				   dayfixed=newDate.getDate(); //dia
				   var dayfixed2=dayfixed.toString();

				   if(dayfixed2.length==1){
				   		dayfixed2='0'+dayfixed2;
				   }
				   finalDate=dayfixed2+'/'+monthfixed+'/'+aniofixed;
				   

				   document.getElementById('idftxtfechafinal').value = finalDate;           
				  
				}/*else{
				document.getElementById('idftxtfechafinal').value = '';
				}*/
   			} 
			</script>
            <script>
			function goBack() {
				//window.history.back();
				document.location = "/CONS_REP/ssdovovi/Report/view/sersoc/edit.cfm";
			}
			</script>
            <cfif isdefined("url.idprestador")>
				<cfoutput>
					<script>
                    function eliminar(){
                        if (confirm('\u00bfDesea eliminar el registro?')){
                            document.location = "/CONS_REP/ssdovovi/Report/controller/sersoc/action.cfm?action=del&idprestador=#url.idprestador#";
                        }
        
                            
                    }
                    </script>
            	</cfoutput>    
            </cfif>
            
</body>
</html>

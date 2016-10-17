  
   	<cfset SetLocale("es_MX")>
<cfoutput>
     <div class="container-fluid" style="margin-top:20px;">
     	<div class="row">
         <div class="col-md-12">
         
         	<div class="panel panel-primary">
              	<div class="panel-heading"><span class="glyphicon glyphicon-list "></span>
              		Reportes de Voluntariado
              	</div>                
              	<div class="panel-body"  style="margin-top:10px;" >
<!---                 	<cfform action="../Consult/action.cfm?cr=1" id="formConsulta"> --->
                 	<cfform action="/cons_rep/ssdovovi/report/voluntariado/rpt_GenVol.cfm?cr=1" id="formConsultaVol"> 
                        <div class="form-group col-sm-12">
                            <div class="col-sm-3">
                                <label>Tipo de reporte: </label>
                            </div>
                            <div class="col-sm-9">
                                <select id="tipoReporteVol" name="tipoReporteVol"> 
                                    <option value="0" ></option>
                                    <option value="1" >Voluntariado general</option>
                                   <!----
								    <option value="2">Servicio social por carrera </option>
                                    <option value="3">Servicio social por escuela</option>
                                    <option value="4">Servicio social por IAP</option>
                                    <option value="5">Servicio social por IAP y Organos</option>
									---->
                                </select>
                            </div>
                        </div>
                        <!---
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
                        ---->
                        
                        <div class="form-group col-sm-12" style="margin-top:20px;">	  
                            <div class="col-sm-12">
                                <div class="col-sm-4">
                                    <label>Periodo a reportar: </label>
                                </div>
                                <div class="col-sm-7">
									<!--- se mostrarán los últimos 3 años (a partir de 2015 que se empieza a llenar la base)  AND #anio# GTE 2015" >---->
									<cfset anio = #YEAR(NOW())#>
                                    <cfloop condition="#anio# GT (#YEAR(NOW())# - 3)">
                                        <input type="radio" id="rdPeriodoVol" name="rdPeriodoVol" value="#anio#">#anio# <br />
                                        <cfset anio = anio - 1>
                                    </cfloop>
                                    <input type="radio" id="rdPeriodoVol" name="rdPeriodoVol" value="0">Otro <br />
                                </div>
                            </div>
	                        <div id="divPeriodoVol" class="col-sm-12" style="display:none;">
                                <div class="col-sm-5" style="margin-left:15px;">
                                    <label>Inicio</label>
                                    <div class="form-group" >
                                        <div class="input-group date col-sm-10" id="datetimepicker3">
                                            <cfset vFechaInicio = "">
                                            <cfinput type="text" class="form-control redondos" id="ftxtfechainicioVol" name="ftxtfechainicioVol" 
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
                                        <div class="input-group date col-sm-10" id="datetimepicker4">
                                            <cfset vFechaFin = "">
                                            <cfinput type="text" class="form-control redondos" id="ftxtfechaFinVol" name="ftxtfechaFinVol" 
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
                        
                        <div class="form-group col-sm-12" style="margin-top:20px;" id="divMeses">
                             <div class="form-group col-sm-12">
                                <div class="col-sm-3">
                                    <label>Mes a reportar: </label>
                                </div>
                                <div class="col-sm-9">
                                    <select id="mesReporteVol" name="mesReporteVol"> 
                                        <option value="00" >Todos los meses</option>
                                        <option value="01" >Enero</option>
                                        <option value="02" >Febrero</option>
                                        <option value="03" >Marzo</option>
                                        <option value="04" >Abril</option>
                                        <option value="05" >Mayo</option>
                                        <option value="06" >Junio</option>
                                        <option value="07" >Julio</option>
                                        <option value="08" >Agosto</option>
                                        <option value="09" >Septiembre</option>
                                        <option value="10" >Octubre</option>
                                        <option value="11" >Noviembre</option>
                                        <option value="12" >Diciembre</option>
                                    </select>
                                </div>
                            </div>
                        </div> <!-- div meses --->
                               
                        <div class="col-sm-12" style="margin-top:20px;" >
                        	<center> <button type="button" class="btn btn-warning" id="btnRptVol" name="btnRptVol">Generar reporte</button> </center>
                        </div>
                    </cfform>
                </div>
			</div><!-- panel -->
		</div>
       </div><!--row-->
	</div>
       
     
	<script type="text/javascript">
    $(function () {
        $('##datetimepicker3').datetimepicker({
            //viewMode: 'years'
            locale: 'es',
            format: 'L'
        });
        $('##datetimepicker4').datetimepicker({
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
            var rdPeriodo = $("input[name='rdPeriodoVol']:checked").val();//name is is_external not radio
            if(rdPeriodo == 0){
                $('##divPeriodoVol').css('display','block');	
            }else{
               $('##divPeriodoVol').css('display','none');	
            }
          });
		  
		  $("##btnRptVol").click(function() {
			var verificaRequeridos = false;
			var msg = '';
			if($('##divPeriodoVol').css('display') == 'block'){
				if($('##ftxtfechainicioVol').val().length == 0 ||  $('##ftxtfechaFinVol').val().length == 0 ){
					msg = 'Debe indicar la fecha de inicio y fecha final del periodo a consultar';	
				}
			}
			
			if($('##tipoReporteVol option:selected').val()==0){
				msg = msg + '\n  - Tipo de reporte ';	
			}
			
			if(isNaN($("input[name='rdPeriodoVol']:checked").val())){
				msg = msg + '\n  - Periodo a reportar ';	
			}
			
			
			if(msg.length == 0){
				$('##formConsultaVol').submit();
			}else{
				alert('Por favor indique: ' + msg);
			}
			
		  });
		  
		  
        });    
	</script>
    
</cfoutput>     

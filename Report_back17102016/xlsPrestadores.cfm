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
    
    
    <!--- CONSULTA SOLICITADA 
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
    ---->
    <cfinvoke component="CONS_REP.ssdovovi.Consult.spReporteSS" method="getEscuelasSS" returnvariable="qGetEscuelaSS"> </cfinvoke>
    
    
   	<cfset SetLocale("es_MX")>
</head>
<body > <!---- class="areafija" ----->
<cfoutput>

<cfif isdefined("url.anio")> <cfset anio = #url.anio#> <cfelse> <cfset anio=0>	</cfif>

<cfcontent type="application/msexcel" >
<cfheader name="Content-Disposition" value="filename=PrestadoresSS.xls"> 

            <cfinvoke component="CONS_REP.ssdovovi.Consult.spReporteSS" method="getSSActual" returnvariable="qGetSSActual">
        		<cfinvokeargument name="consultaAnio" value="#anio#">
            </cfinvoke>   
                <table >
                    <thead>  
                        <tr>  
                            <th>NOMBRE</th>  
                            <th>EDAD</th>  
                            <th>EMAIL</th>  
                            <th>TEL&Eacute;FONO FIJO</th>  
                            <th>TEL&Eacute;FONO CELULAR</th>  
                            <th>INSTITUCI&Oacute;N EDUCATIVA</th>  
                            <th>ACRONIMO</th>  
                            <th>CARERRA</th>  
                            <th>NIVEL CURSADO</th>  
                            <th>UNIDAD NIVEL CURSADO</th>  
                            <th>FECHA DE INICIO</th>  
                            <th>FECHA DE T&Eacute;RMINO</th>  
                            <th>INSTITUCI&Oacute;N ASIGNADA</th>  
                            <th>ESTATUS DEL SERVICIO SOCIAL</th>  
                        </tr>  
                    </thead>  
                <tbody>                  
                    <cfloop query="qGetSSActual">                    
                        <tr class="txtDetalle">  
                            <td>#qGetSSActual.NOMBRE#</td>
                            <td>#qGetSSActual.EDAD# </td> 
                            <td>#qGetSSActual.EMAIL#</td>
                            <td>#qGetSSActual.TELEFONOFIJO#</td>
                            <td>#qGetSSActual.TELEFONOCELULAR#</td>
                            <td>#qGetSSActual.INSTITUCIONEDUCATIVA# </td>
                            <td>#qGetSSActual.ACRONIMO# </td>
                            <td>#qGetSSActual.CARRERA# </td>
                            <td>#qGetSSActual.NIVELCURSADO#</td>
                            <td>#qGetSSActual.UNIDADNIVELCURSADO#</td>
                            <td>#LSDateFormat(qGetSSActual.FECHAINICIO,'dd/mm/yyyy')#</td>
                            <td>#LSDateFormat(qGetSSActual.FECHAFINAL,'dd/mm/yyyy')#</td>
                            <td>#qGetSSActual.INSTITUCIONASIGNADA# </td>
                            <td>#qGetSSActual.ESTATUS# </td>
                        </tr>  
                    </cfloop>                
                </tbody>  
            </table>  
        
       
<!---         <!-- Libreria jQuery requerida por los plugins de JavaScript -->
        <script src="/CONS_REP/ssdovovi/Report/model/jquery/jquery-2.2.3.min.js"></script>
        <!-- Todos los plugins JavaScript de Bootstrap (tambien puedes incluir archivos JavaScript individuales de los unicos
        plugins que utilices) -->
        <script src="/CONS_REP/ssdovovi/Report/model/bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>
        

                    
<link rel="stylesheet" href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css">
<script type="text/javascript" src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
--->
 
      
</cfoutput>            
</body>
</html>

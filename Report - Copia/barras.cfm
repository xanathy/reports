<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>
</head>

<body>

<!--- Variables generales --->
    	<cfset anioDiagnostico= YEAR(NOW()) - 2001> <!--- SE TOMA A PARTIR DEL AÑO ANTERIOR --->
        <cfif isdefined("URL.NOIAP")>
	        <cfset noiap = #URL.NOIAP#> <!--0002 / 0012 ---->
        <cfelse>
        	<cfset noiap = "">
        </cfif>
        
        <cfset vNivelMadurez =0>
        <cfset conAniosDiag =0>
        <cfset difPromDiag = 0>
        <cfset envioDiagnostico = false>
        <cfset cuartilPorc =0>
        <cfset cuartilNivel ="">
        <cfset cuartilReferencia ="">
        
       <!---Variables con datos de ejes de año anterior --->
			<cfset qAnt_estrategia= 4> 
            <cfset qAnt_patronato= 5>
            <cfset qAnt_aspecAdvos= 7>
            <cfset qAnt_eqOperativo= 8>
            <cfset qAnt_modAtencion= 2>
            <cfset qAnt_comDifusion= 3>
            <cfset qAnt_tic= 1>
            <cfset qAnt_genRecursos= 6>
            <cfset qAnt_Anio= 14>
        
<!--- Campos obtenidos de consultas previas --->
			<cfset qUlt_estrategia= 1> 
            <cfset qUlt_patronato= 3>
            <cfset qUlt_aspecAdvos= 4>
            <cfset qUlt_eqOperativo= 2>
            <cfset qUlt_modAtencion= 5>
            <cfset qUlt_comDifusion= 8>
            <cfset qUlt_tic= 3>
            <cfset qUlt_genRecursos= 1>  
            <cfset qUlt_Anio= 15>  

<table width="100%" align="center">
					<!------------------------------------------------SE DECLARA GRAFICA DE RADAR  Y TAMAÑOS DE LA MISMA------->
                    <tr> <td colspan="2" align="center">
                 
                 <cfquery name="DataTable" datasource="#application.dsn_japsql#">        	           
            /*------ DATOS GENERALES DE LOS PRESTADORES DE SERVICIO SOCIAL ------*/
            SELECT 'A' as nombreBarra,23 AS columnaValor
            UNION SELECT 'B',12
            UNION SELECT 'C',15
        
        </cfquery>
                 
                 
    
    <!---
	font = "font name"  
    fontBold = "yes|no"  
    fontItalic = "yes|no"  
    fontSize = "font size"  
    foregroundColor = "hexadecimal value|web color"  
    ---
    <cfchart      
    format = "png"  
    gridlines = "5"  
    labelFormat = "number"  
    markerSize = "5"  
    name = "grafica" 
    <!--- 
	pieSliceStyle = "solid|sliced"  
	--->
    scaleFrom = "1"  
    scaleTo = "10"  
    show3D = "yes"  
    showBorder = "yes"  
    showLegend = "yes"  
    showMarkers = "yes"  
    showXGridlines = "yes"  
    showYGridlines = "yes"  
    sortXAxis = "yes"  
    
    tipBGColor = "red"  
    tipStyle = "MouseOver" 
    title = "title of chart" 
    url = "../"  
    xAxisTitle = "title text"  
    xAxisType = "category" 
    xOffset = "0"  
    yAxisTitle = "title text"  
    yAxisType = "scale" 
    yOffset = "1"> 
--->

<!---- no funciono mandarlo a excel
<cfcontent type="application/msexcel" >
<cfheader name="Content-Disposition" value="filename=grafica.xls"> 
--->

<h1>Employee Salary Analysis</h1>  
<!--- Bar graph, from Query of Queries ---> 
<cfchart format="png"  
    show3D = "yes"  
    showBorder = "yes"  
    showLegend = "yes"  
    xaxistitle="Department"  
    yaxistitle="Salary Average"
     
    >  
     
        
<cfchartseries type="bar"  
    query="DataTable"  
    itemcolumn="nombreBarra"  
    valuecolumn="columnaValor"> 
 
<cfchartdata item="Facilities" value="15"> 
   
   
</cfchartseries> 
   </cfchart>

</td>
</tr></table>
                     
                        <!----
                        
                        <cfchart chartwidth="1" chartheight="1"/>
                    
                        <!---SE COMPARA SI EL VARIABLE SITIO SEGURO ES VERDADERO, ASIGNA VARIABLE--->
                        <cfif #CGI.HTTPS# eq 'on'>
                            <cfset baseURL = "https://"& CGI.HTTP_HOST &"/"><!---VARIABLE URL BASE--->
                        <!---DE LO CONTRARIO ES FALSO--->
                        <cfelseif #CGI.HTTPS# eq 'off'>
                            <cfset baseURL = "http://"& CGI.HTTP_HOST &"/"><!---VARIABLE URL BASE--->
                        </cfif>
                        <!---VARIABLE CON DATOS DE HOJA DE PROYECTO DE GRÁFICA---- se cambia la ruta!!!---->
                        <cfset wcp = XMLParse( ExpandPath("grafradar.wcp") )>
                        <!---VARIABLE ESTILO DE GRÁFICA--->
                        <cfset EstiloGrafica = ToString(wcp.project.style.radarChart)>
                        
                        <!---SE INICIA CREAR DATOS PARA GRÁFICA CREADA (XML)--->
                        <cfsavecontent variable="TipoGrafica">
                        <XML type="default"><cfoutput>
                            <COL>ASPECTOS ADMINISTRATIVOS</COL>
                            <COL>PATRONATO</COL>
                            <COL>T.I.C.</COL>
                            <COL>OBTENCION DE RECURSOS</COL>
                            <COL>MODELO DE ATENCION</COL>
                            <COL>EQUIPO OPERATIVO</COL>
                            <COL>COMUNICACION Y DIFUSION - #anioDiagnostico#</COL>
                            <COL>ESTRATEGIA</COL>
                            <cfif qAnt_Anio EQ (anioDiagnostico-1)>
								<!---Diagnóstico anterior --->
                                <ROW col0="#qAnt_aspecAdvos#" col1="#qAnt_patronato#" col2="#qAnt_tic#" col3="#qAnt_genRecursos#" col4="#qAnt_modAtencion#" col5="#qAnt_eqOperativo#" col6="#qAnt_comDifusion#" col7="#qAnt_estrategia#">RESULTADO DE DIAGNOSTICO 20#qAnt_Anio#</ROW>
                            </cfif>
                            <!---Diagnóstico año pasado ---->
                            <ROW col0="#qUlt_aspecAdvos#" col1="#qUlt_patronato#" col2="#qUlt_tic#" col3="#qUlt_genRecursos#" col4="#qUlt_modAtencion#" col5="#qUlt_eqOperativo#" col6="#qUlt_comDifusion#" col7="#qUlt_estrategia#">RESULTADO DE DIAGNOSTICO 20#qUlt_Anio#</ROW>
                            
                            
                        </cfoutput></XML>
                        </cfsavecontent>
                       
                       <!--- Se genera el estilo de la gráfica de radar ------>
                       <cfset estiloGrafica=  "<radarChart style='FillArea' gridColor='##333333' dashSize='6' isGridVisible='true' 
							 						isStarChart='false' dropShadow='false' isRadialGridVisible='true' isFrameCircle='false' 	
													labelPlacement='Horizontal'  is3D='true' isTransposed='false' isInterpolated='false' seriesTitle=''
													altText='' font='Arial-9' foreground='black' isMultiline='false'>">
						<cfif qAnt_Anio EQ (anioDiagnostico-1)>							 
                        	<cfset estiloGrafica=  estiloGrafica  & "<axis type='scale' scaleMin='0' />">
                        <cfelse>                        	
                        	<cfset estiloGrafica=  estiloGrafica & "<axis type='scale' scaleMin='0' scaleMax='100' />">
                        </cfif>
                        <cfset estiloGrafica=  estiloGrafica & " <legend isVisible='true'/> 
													<frameBackground type='PlainColor' minColor='##CBE9EA' maxColor='gray' imagePlacement='Centered' imageLocation=''/>
													<elements action='' target='' place='Clustered' shape='Bar' outline='null' markerSize='4' shapeSize='100'
														lineWidth='1' drawOutline='false' drawShadow='true' showMarkers='true' fixedWidth='5'>
														<movie framesPerSecond='16' frameCount='25' stageDelay='0' replayDelay='-1'/>
														<morph morph='Blur' stage='Rows'/>
													</elements>
													<paint palette='FiestaTransluent' paint='Light' />
												</radarChart>" >
                                                
<!----
						<cfset estiloGrafica ="<radarChart style='FillArea' gridColor='##333333' dashSize='6' isGridVisible='true' 
							 						isStarChart='false' dropShadow='false' isRadialGridVisible='true' isFrameCircle='false' 	
													labelPlacement='Horizontal'  is3D='true' isTransposed='false' isInterpolated='false' seriesTitle=''
													altText='' font='Arial-9' foreground='black' isMultiline='false'>
													<axis type='scale' scaleMin='0' />
													<legend isVisible='true'/> 
													<frameBackground type='PlainColor' minColor='##CBE9EA' maxColor='gray' imagePlacement='Centered' imageLocation=''/>
													<elements action='' target='' place='Clustered' shape='Bar' outline='null' markerSize='4' shapeSize='100'
														lineWidth='1' drawOutline='false' drawShadow='true' showMarkers='true' fixedWidth='5'>
														<movie framesPerSecond='16' frameCount='25' stageDelay='0' replayDelay='-1'/>
														<morph morph='Blur' stage='Rows'/>
													</elements>
													<paint palette='FiestaTransluent' paint='Light' />
												</radarChart>" >
                                                ------>
                                                
                                                
                       <!--- Fin estilo de la gráfica de radar ------>
                       <!---INICIA SCRIPT PARA ENVÍO DE PARAMETROS A HOJA DE GRÁFICA--->
                        <cfscript>
                            oMyWebChart = createObject("Java","com.gp.api.jsp.MxServerComponent");
                            oMyApp = getPageContext().getServletContext();
                            oSvr = oMyWebChart.getDefaultInstance(oMyApp);
                            oMyChart2 = oSvr.newImageSpec();
                            oMyChart2.width = 460;	//ANCHO DE LA GRÁFICA
                            oMyChart2.height =300; //ALTO DE LA GRÁFICA
                            oMyChart2.type = "png"; //TIPO DE FORMATO
							//oMyChart2.style = "#EstiloGrafica#"; //ESTILO DE GRÁFICA
							
							oMyChart2.style =  estiloGrafica;

												/**radarChat style='FillArea' - Polyline*/
												/**DawnTransluent - Pastel - Fiesta - modern - steel - sunburn*/
                            oMyChart2.model = "#TipoGrafica#"; //TIPO DE MODELO DE GRÁFICA
                        </cfscript>
                       
                        <!---INICIA CREAR VARIABLE ETIQUETA HTML--->
                        <cfsavecontent variable="ImagenGraf"><cfoutput>
                            #oSvr.getImageTag(oMyChart2, baseURL& "CFIDE/GraphData.cfm?graphCache=wc50&graphID=")#
                        </cfoutput></cfsavecontent>
                    
                        <!---SE DESPLIEGA GRÁFICA--->
                        <cfoutput>#ImagenGraf#</cfoutput>
                      <!---------------------------------- FIN GRAFICA DE RADAR  ------------>

---->
</body>
</html>
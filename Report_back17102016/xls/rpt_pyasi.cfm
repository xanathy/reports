<html>
	<head>
		<title>Reporte de Validación de Proyectos de Asistenciales 2005</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<STYLE TYPE="text/css">  
		<!-- 
		.TitTable {
			font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 8px;
			font-weight: bold;
		}
		.TextTable {
			font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 8px;
		}
		-->  
		</STYLE>
	</head>
	
	<body onLoad="Javascript:window.print();">
		<p align="left">
			<font size="5" face="Arial, Helvetica, sans-serif">
				<strong>
					<img src="/Others/Imgs/Icons/LOGO1.JPG" width="129" height="86" align="middle">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					Junta de Asistencia Privada del D.F.
				</strong>
			</font>
		</p>
		<div align="center">
			<cfquery name="qGsenvio" datasource="#application.dsn_jap#">
				SELECT 
				  CACCESO."CA_Envio"
				FROM
				  CACCESO
				where
				  CACCESO."CA_No_Iap"='#session.no_Iap#'
			</cfquery>
			<cfif #qGsenvio.CA_Envio# is 'NO'>
				<font color="#CC3300" size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong>
				No ha enviado su Presupuesto y Programa de Trabajo 2005</strong></font>
			</cfif>
			</div>
			<!---  --->
			<p align="center">
			<font size="3" face="Verdana, Arial, Helvetica, sans-serif">
				<strong>
					Reporte de Validaci&oacute;n<br>
					de Proyectos Asistenciales.
				</strong>
			</font>
		</p>
		<hr>
		<p>
			<font size="3" face="Verdana, Arial, Helvetica, sans-serif">
				<!--- Despliega el nombre de la insitución --->
				<cfoutput>
					<strong>
						#session.desc_iap#<br>
						Número IAP: #Session.no_iap#
					</strong>
				</cfoutput>
			</font>
		</p>
		<br>
		<cfquery name="qnomproy" datasource="#application.dsn_jap#">
			SELECT 
			  PROYECTOS."P_Meta_Proyecto_Cantidad"
			, PROYECTOS."P_Nombre_Proyecto"
			, PROYECTOS."P_No_Iap"
			, PROYECTOS."P_Cve_Clase_Proyecto"
			, CIAP."CI_Descripcion_Iap"
			, PROYECTOS."P_Meta_Proyecto_Unidad"
			, PROYECTOS."P_Estratejia"
			, PROYECTOS."P_Justificacion"
			, PROYECTOS."P_Objetivo_Proyecto"
			, PROYECTOS."P_Pob_Fija"
			, PROYECTOS."P_Pob_Flotante"
			FROM
				CIAP INNER JOIN PROYECTOS
				ON (
							(CIAP."CI_No_Iap" = PROYECTOS."P_No_Iap")
						AND (CIAP."CI_No_Iap" = '#Session.no_iap#')
					)
			WHERE
					 PROYECTOS."P_Anio_Presupuestal" = '05'
				 AND PROYECTOS."P_No_Proyecto"=#Url.Np#
		</cfquery>
		
		<cfif #qnomproy.RecordCount#>
			<table width="779" border="0">
				<tr>
					<td width="9">
						<!--- ESPACIO - SANGRIA IZQUIERDA --->
					</td>
					<!--- SI EXISTEN PROYECTOS DE FINANCIAMIENTO --->
					<td>
						<cfoutput>
							<table align="center">
								<tr>
									<td align="left" class="TitTable">
										Proyecto
									</td>
									<td align="left" class="TextTable">
										#qnomproy.P_Nombre_Proyecto#
									</td>
								</tr>
								<tr>
									<td align="left" class="TitTable">
										Población<br> Beneficiaria
									</td>
									<td align="left" class="TextTable">
										#qnomproy.P_Meta_Proyecto_Cantidad# 
										#qnomproy.P_Meta_Proyecto_Unidad#
									</td>
								</tr>
								<tr>
									<td align="left" class="TitTable">
										Población<br> Fija
									</td>
									<td align="left" class="TextTable">
										#qnomproy.P_Pob_Fija#
									</td>
								</tr>
								<tr>
									<td align="left" class="TitTable">
										Población<br> Flotante
									</td>
									<td align="left" class="TextTable">
										#qnomproy.P_Pob_Flotante#
									</td>
								</tr>
								<tr>
									<td align="left" class="TitTable">
										Objetivo<br> del Proyecto
									</td>
									<td align="left" class="TextTable">
										#qnomproy.P_Objetivo_Proyecto#
									</td>
								</tr>
								<tr>
									<td align="left" class="TitTable">
										Estrategia<br> del Proyecto
									</td>
									<td align="left" class="TextTable">
										#qnomproy.P_Estratejia#
									</td>
								</tr>
								<tr>
									<td align="left" class="TitTable">
										Justificación<br> del Proyecto
									</td>
									<td align="left" class="TextTable">
										#qnomproy.P_Justificacion#
									</td>
								</tr>
							</table>
						</cfoutput>
					</td>
					<td width="10">
						<!--- ESPACIO - SANGRIA DERECHA --->
					</td>
				</tr>
			</table>
			<br>			
		</cfif>

	
	</body>
</html>

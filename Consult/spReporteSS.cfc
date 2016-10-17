<cfcomponent>
	    
        <cfset setlocale ("es_MX")> <!--- requerido para guardar correctamente las fechas ---->
        
       
    
    <!--- Obtener Escuelas a las que pertenecen los prestadores del servicio social --->
    <cffunction name="getEscuelasSS" access="public" returntype="query">
		<cfquery name="qGetEscuelasSS" datasource="#application.dsn_japsql#">        	
            SELECT DISTINCT REFID_INSTITUCIONESEDUCATIVAS, B.ACRONIMO
            FROM DATAPRES.SSPRESTADORES A
            LEFT JOIN DATAPRES.CF_SSINSTITUCIONESEDUCATIVAS B ON A.REFID_INSTITUCIONESEDUCATIVAS = B.ID
            WHERE ESTATUS = 'AC'
	    </cfquery>
		<cfreturn qGetEscuelasSS>
	</cffunction>
    
    
    <!--- Obtener listado de datos de prestadores de servicio social activos actualmente --->
    <cffunction name="getSSActual" access="public" returntype="query">
		<!--- Parámetros que se requieren para el query ---->     
		<cfargument name="consultaAnio" type="string" required="no"> <!--- 2015 por ahora--->
		<cfquery name="qGetSSActual" datasource="#application.dsn_japsql#">        	           
            /*------ DATOS GENERALES DE LOS PRESTADORES DE SERVICIO SOCIAL ------*/
            
            SELECT 
            ISNULL(NOMBRES,'') + ISNULL(' ' + APELLIDOPATERNO,'') + ISNULL(' ' + APELLIDOMATERNO,'') AS NOMBRE,
            EDAD,
            EMAIL,
            TELEFONOFIJO [TELEFONOFIJO],
            TELEFONOCELULAR AS [TELEFONOCELULAR],
            B.NOMBRE AS [INSTITUCIONEDUCATIVA],
            B.ACRONIMO AS [ACRONIMO],
            C.DESCRIPCION AS CARRERA,		
            CASE WHEN A.NIVELCURSADO= 0 THEN 'Concluido'
            ELSE CASE WHEN A.NIVELCURSADO = 99 THEN 'Otro' ELSE CONVERT(VARCHAR,A.NIVELCURSADO) END
            END AS [NIVELCURSADO],
            CASE WHEN UNIDADNIVELCURSADO = 1 THEN 'Anual'
            ELSE CASE WHEN UNIDADNIVELCURSADO = 2 THEN 'Bimestre'		
                 ELSE CASE WHEN UNIDADNIVELCURSADO = 3 THEN 'Trimestre'
                      ELSE CASE WHEN UNIDADNIVELCURSADO = 4 THEN 'Cuatrimestre'
                           ELSE CASE WHEN UNIDADNIVELCURSADO = 6 THEN 'Semestre' 
                                ELSE CASE WHEN UNIDADNIVELCURSADO = 99 THEN 'Otro' END
                                END
                           END
                      END
                 END
            END AS [UNIDADNIVELCURSADO],
            FECHAINICIO AS [FECHAINICIO],
            FECHAFINAL AS [FECHAFINAL],
            CASE WHEN ISNULL(D.CDIAP_NombreIap,'1') = '1' THEN
                CASE WHEN ISNULL(A.ORGANO,'1') = '1' THEN 'SIN ASIGNAR'
                ELSE ORGANO END
            ELSE D.CDIAP_NombreIap	END AS [INSTITUCIONASIGNADA],
            CASE WHEN ISNULL(A.TERMINOSS,'1') = '1' THEN 'En servicio'
					ELSE CASE WHEN A.TERMINOSS = 'SI' THEN 'Concluido'
					ELSE 'Cancelado' END
				END AS ESTATUS
            FROM DATAPRES.SSPRESTADORES A
            INNER JOIN DATAPRES.CF_SSINSTITUCIONESEDUCATIVAS B ON A.REFID_INSTITUCIONESEDUCATIVAS = B.ID
            INNER JOIN DATAPRES.CF_SSOFERTAEDUCATIVA C ON A.REFID_CARRERA = C.ID
            LEFT JOIN CD_Iap D ON A.NOIAP = D.CDIAP_NoIap
            WHERE ESTATUS = 'AC' /*-S.S. Validos-*/
            AND ISNULL(A.TERMINOSS,'1') = '1' /* aún no concluyen servicio*/
            <!---
			<cfif #consultaAnio# NEQ '0'>
            	AND YEAR(FECHAINICIO) = <cfoutput>#consultaAnio# </cfoutput>
			</cfif>
			--->
	    </cfquery>
		<cfreturn qGetSSActual>
	</cffunction>
    
    
</cfcomponent>
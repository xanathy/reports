<cfcomponent>
	<cffunction name="getReporteSS" access="public" returntype="query">
		
        <!--- Parámetros que se requieren para el query ---->     
        <cfargument name="tipoReporte" type="string" required="yes">  <!--- 1 / 2 --->
		<cfargument name="rdEstatusSS" type="string" required="yes"> <!--- 1 - En servicio / 2 - Concluido / 3 - No especificado--->
		<cfargument name="intervalo" type="string" required="yes"> <!--- 1 /0 --->
		<cfargument name="fechaInicio" type="string" required="yes"> <!--- 1 /0 --->
		<cfargument name="fechaFin" type="string" required="no"> <!--- 1 /0 --->
        <!---- <cfargument name="chkAddIap" type="string" required="YES"> ---->
        <!---<cfargument name="intervalo" type="string" required="yes">  1 /0 --->
        
        
        <cfset setlocale ("es_MX")> <!--- requerido para guardar correctamente las fechas ---->
        
        <cfquery name="qGetReporteSS" datasource="#application.dsn_japsql#">
         	DECLARE 
            @TIPOREPORTE INT = #tipoReporte#,
            @INTERVALO INT = #intervalo#,
            @INTERVALOINICIO DATE = '#lsdateformat(fechaInicio,'yyyymmdd')#',   
            @INTERVALOFIN DATE =  '#lsdateformat(fechaFin,'yyyymmdd')#',
            @TIPOCONCEPTO VARCHAR(50) = ''
            
            DECLARE @T_PRESTADORES AS TABLE(
                ID INT,
                PRESTADOR VARCHAR(120),
                ESTATUSREGISTRO VARCHAR(2),
                IDESCUELA INT,
                IDCARRERA INT,
                NOIAP VARCHAR(4),
                ORGANO VARCHAR(40),	
                FECHAREGISTROSS SMALLDATETIME,
                FECHAINICIO SMALLDATETIME,
                FECHAFINAL SMALLDATETIME,
                ESTATUSSS VARCHAR(40)
            )
            
                INSERT INTO @T_PRESTADORES
                SELECT 
                ID,
                NOMBRES + ISNULL(' ' + APELLIDOPATERNO,'') + ISNULL(' ' + APELLIDOMATERNO,'') AS PRESTADOR,
                ESTATUS,
                REFID_INSTITUCIONESEDUCATIVAS AS IDESCUELA,
                REFID_CARRERA AS IDCARRERA,
                NOIAP,
                ORGANO,
                FECHAREGISTROSS,
                FECHAINICIO,
                FECHAFINAL,
                CASE WHEN ISNULL(TERMINOSS,'1')='1' THEN 'En servicio' 
                ELSE CASE WHEN ISNULL(TERMINOSS,'1')='SI' THEN 'Concluido'  ELSE 'Cancelado' END END AS TERMINOSS
                FROM DATAPRES.SSPRESTADORES
                WHERE ESTATUS = 'AC'
    
    			/*-----INTERVALO REVISAR CON COLDFUSION 
                    0 = POR AÑO, OBTENER AÑO DE LA FECHA DE INICIO
                    1 = POR PERIDODO INDICADO POR EL USUARIO ----*/
                <cfif #intervalo# EQ 0>
                    AND YEAR(FECHAINICIO) =  YEAR(@INTERVALOINICIO)
                <cfelseif  #intervalo# EQ 1>
                     AND FECHAINICIO >= @INTERVALOINICIO
                	AND FECHAFINAL <= @INTERVALOFIN           	
                </cfif>
         
                /*-----TERMINOSS REVISAR CON COLDFUSION ----*/
                   -- 	AND TERMINOSS = 'SI'
                   /*-----------------*/
                <cfif #rdEstatusSS# EQ 1>
                    AND TERMINOSS IS NULL
                <cfelseif  #rdEstatusSS# EQ 2>
                	AND TERMINOSS = 'SI'
                </cfif>
                   
                   
        
               /*/*---------- QUERY PARA PRUEBA */
    SELECT A.NOMBRES, B.DESCRIPCION,A.NOIAP, A.ORGANO,c.CFGRU_Descripcion,  A.* FROM DATAPRES.SSPRESTADORES A
    INNER JOIN DATAPRES.CF_SSOFERTAEDUCATIVA B ON A.REFID_CARRERA = B.ID
     left JOIN CD_IAP d ON A.NOIAP = d.CDIAP_NoIap
                    left JOIN CF_Grupos C ON d.CDIAP_CveGrupo = C.CFGRU_CveGrupo
    WHERE ESTATUS='AC'
         --       	AND TERMINOSS = 'SI'          	
                AND FECHAINICIO >= @INTERVALOINICIO
                AND FECHAFINAL <= @INTERVALOFIN
    ORDER BY B.DESCRIPCION
                ----------*/
    
    
    
            
            /*------------------------------------------------------- REPORTE SS PRESTADO POR CARRERA Y POR IAP/ORGANO ---*/
            DECLARE @TOTALSS INT = 0
            SELECT @TOTALSS = COUNT(*) FROM @T_PRESTADORES
            
            IF @TIPOREPORTE = 1
            BEGIN
                SET @TIPOCONCEPTO = 'RUBRO' 
                    SELECT 
                    @TIPOCONCEPTO AS TIPOCONCEPTO,
                    COUNT(C.CFGRU_Descripcion) AS TOTALCONCEPTO,
                    C.CFGRU_Descripcion AS CONCEPTODESC,
                    @TOTALSS AS TOTALSS
                    FROM @T_PRESTADORES A
                    LEFT JOIN CD_IAP B ON A.NOIAP = B.CDIAP_NoIap
                    LEFT JOIN CF_Grupos C ON B.CDIAP_CveGrupo = C.CFGRU_CveGrupo
                    WHERE 
                        (ISNULL(NOIAP,'1') != '1' AND NOIAP != '')
                    GROUP BY C.CFGRU_Descripcion 
                
                UNION
                    SELECT 
                    @TIPOCONCEPTO AS TIPOCONCEPTO,
                    COUNT(ORGANO) AS TOTALCONCEPTO,
                    ORGANO AS CONCEPTODESC,
                    @TOTALSS AS TOTALSS
                    FROM @T_PRESTADORES A
                    WHERE 
                        (ISNULL(NOIAP,'1') = '1' OR NOIAP = '')
                        AND (ISNULL(ORGANO,'1') != '1' OR ORGANO !='')
                    GROUP BY ORGANO 
                UNION
                    SELECT 
                    @TIPOCONCEPTO AS TIPOCONCEPTO,
                    COUNT(*)  AS TOTALCONCEPTO,
                    'Sin asignar' AS CONCEPTODESC,
                    @TOTALSS AS TOTALSS
                    FROM @T_PRESTADORES A
                    WHERE 
                        (ISNULL(NOIAP,'1') = '1' OR NOIAP = '')
                        AND (ISNULL(ORGANO,'1') = '1' OR ORGANO ='')
            END    
             
            
            IF @TIPOREPORTE = 2 /*--2--*/
            BEGIN
                SET @TIPOCONCEPTO = 'CARRERA' 
                 SELECT 
                    @TIPOCONCEPTO AS TIPOCONCEPTO,
                    COUNT(E.DESCRIPCION) AS TOTALCONCEPTO,
                    E.DESCRIPCION AS CONCEPTODESC,
                    @TOTALSS AS TOTALSS
                    FROM @T_PRESTADORES A
                    INNER JOIN DATAPRES.CF_SSOFERTAEDUCATIVA E ON A.IDCARRERA = E.ID
                    GROUP BY DESCRIPCION 
            END    
    
               

        
        </cfquery>
		<cfreturn qGetReporteSS>
	</cffunction>
    
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
		<cfargument name="consultaAnio" type="string" required="yes"> <!--- AC / IN / ES --->
<cfoutput> <script> alert('#consultaAnio#'); </script> </cfoutput>
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
            <cfif #consultaAnio# NEQ '0'>
            	AND YEAR(FECHAINICIO) = <cfoutput>#consultaAnio# </cfoutput>
			</cfif>
	    </cfquery>
		<cfreturn qGetSSActual>
	</cffunction>
    
    
</cfcomponent>
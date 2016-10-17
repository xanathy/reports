<cfcomponent>
	<cffunction name="getReporteSS" access="public" returntype="query">
		
        <!--- Parámetros que se requieren para el query ---->     
        <cfargument name="tipoReporte" type="string" required="yes">  <!--- 1 / 2 --->
		<cfargument name="rdEstatusSS" type="string" required="yes"> <!--- AC / IN / ES --->
		<cfargument name="fechaInicio" type="string" required="yes"> <!--- 1 /0 --->
		<cfargument name="fechaFin" type="string" required="yes"> <!--- 1 /0 --->
        <!---- <cfargument name="chkAddIap" type="string" required="YES"> ---->
        <!---<cfargument name="intervalo" type="string" required="yes">  1 /0 --->
        
        
        <cfset setlocale ("es_MX")> <!--- requerido para guardar correctamente las fechas ---->
        
        <cfquery name="qGetReporteSS" datasource="#application.dsn_japsql#">
        /**
            TIPO REPORTE
            1)TOTAL DE SS POR RUBRO
            2)TOTAL DE SS POR CARRERA
        */
        DECLARE 
        @TIPOREPORTE INT = #tipoReporte#,
/*        @estatus VARCHAR(2)= ,*/
        @INTERVALOS BIT = 1, /*intervalo,*/
        @INTERVALOINICIO DATE = <cfif LEN(fechaInicio) GT 0>  '#lsdateformat(fechaInicio,'yyyymmdd')# ',  <cfelse>  NULL,  </cfif> 
        @INTERVALOFIN DATE = <cfif LEN(fechaFin) GT 0>  '#lsdateformat(fechaFin,'yyyymmdd')# ',  <cfelse>  NULL,  </cfif> 
        @TIPOCONCEPTO VARCHAR(50)
        
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
            AND FECHAINICIO >= @INTERVALOINICIO
            AND FECHAFINAL <= @INTERVALOFIN
            <cfif #rdEstatusSS# EQ 1>
            	AND TERMINOSS IS NULL
            <cfelseif  #rdEstatusSS# EQ 2>
            	AND TERMINOSS = 'SI'            	
            </cfif>
			
        /*------------------------------------------------------- REPORTE SS PRESTADO POR RUBRO Y POR IAP/ORGANO ---*/
        IF @TIPOREPORTE = 1 BEGIN SET @TIPOCONCEPTO = 'RUBRO' END
        
        DECLARE @T_CONCEPTO AS TABLE(
            FILA INT,	
            TIPOCONCEPTO VARCHAR(50),
            TOTALCONCEPTO INT,
            TOTALINSTITUCION INT,
            IDCONCEPTO INT,
            CONCEPTODESC VARCHAR(200),
            INSTITUCIONSS VARCHAR(200),
            TIPO INT
        )
        
        IF @TIPOREPORTE = 1
        BEGIN
            INSERT INTO @T_CONCEPTO
            SELECT ROW_NUMBER() OVER (ORDER BY TIPO,CONCEPTODESC,INSTITUCIONSS) AS FILA,*
            FROM(
                SELECT @TIPOCONCEPTO AS ['TIPOCONCEPTO'], 0 AS TOTALCONCEPTO, COUNT(*) AS TOTALINSTITUCION,IDCONCEPTO, CONCEPTODESC, NOIAP AS INSTITUCIONSS, '1' AS TIPO
                FROM (
                    SELECT B.CDIAP_CveGrupo AS IDCONCEPTO, 
                    C.CFGRU_Descripcion AS CONCEPTODESC, 
                    A.ID,
                    A.NOIAP + ' - ' + B.CDIAP_NombreIap AS NOIAP
                    FROM @T_PRESTADORES A
                    INNER JOIN CD_IAP B ON A.NOIAP = B.CDIAP_NoIap
                    INNER JOIN CF_Grupos C ON B.CDIAP_CveGrupo = C.CFGRU_CveGrupo
                )Z
                GROUP BY IDCONCEPTO,CONCEPTODESC, NOIAP
            UNION
                SELECT @TIPOCONCEPTO, 0 AS TOTALCONCEPTO, COUNT(*) AS TOTALINSTITUCION,-1 AS IDCONCEPTO, 'Organo', SUBSTRING(ORGANO,1,5), '2'
                FROM @T_PRESTADORES A
                WHERE --ISNULL(NOIAP,'1') = '1' AND ISNULL(ORGANO,'1') != '1'	
                    (ISNULL(NOIAP,'1') = '1' OR NOIAP = '')
                    AND (ISNULL(ORGANO,'1') != '1' OR ORGANO!='')
                GROUP BY ORGANO
            UNION
                SELECT @TIPOCONCEPTO, 0 AS TOTALCONCEPTO, COUNT(*) AS TOTALINSTITUCION,-2 AS IDCONCEPTO, 'Sin asignar', 'SIN ASIGNAR', '3'
                FROM @T_PRESTADORES A
                WHERE	
                    (ISNULL(NOIAP,'1') = '1' OR NOIAP = '')
                    AND (ISNULL(ORGANO,'1') = '1' OR ORGANO='')
                GROUP BY ORGANO,NOIAP
            )TEMP_RUBRO
        END
        
        
        /*------------------------------------------------------- REPORTE SS PRESTADO POR CARRERA Y POR IAP/ORGANO ---*/
        
        IF @TIPOREPORTE = 2
        BEGIN
            SET @TIPOCONCEPTO = 'CARRERA' 
            INSERT INTO @T_CONCEPTO
            SELECT ROW_NUMBER() OVER (ORDER BY CONCEPTODESC,TIPO,INSTITUCION) AS FILA,*
            FROM(
        
        
                SELECT  @TIPOCONCEPTO AS ['TIPOCONCEPTO'], 0 AS TOTALCONCEPTO, COUNT(*) AS TOTALINSTITUCION,IDCONCEPTO, CONCEPTODESC, NOIAP AS INSTITUCION, '1' AS TIPO
                FROM (
                    SELECT 
                    E.ID AS IDCONCEPTO,
                    E.DESCRIPCION AS CONCEPTODESC,
                    A.ID,
                    A.NOIAP + ' - ' + B.CDIAP_NombreIap AS NOIAP
                    FROM @T_PRESTADORES A
                    INNER JOIN DATAPRES.CF_SSOFERTAEDUCATIVA E ON A.IDCARRERA = E.ID
                    INNER JOIN CD_IAP B ON A.NOIAP = B.CDIAP_NoIap
                    INNER JOIN CF_Grupos C ON B.CDIAP_CveGrupo = C.CFGRU_CveGrupo
                )Z
                GROUP BY IDCONCEPTO,CONCEPTODESC, NOIAP
        
            UNION
                SELECT  @TIPOCONCEPTO AS ['TIPOCONCEPTO'], 0 AS TOTALCONCEPTO, COUNT(*) AS TOTALINSTITUCION,
                E.ID AS IDCONCEPTO, E.DESCRIPCION AS CONCEPTODESC, SUBSTRING(ORGANO,1,5), '2'
                FROM @T_PRESTADORES A
                INNER JOIN DATAPRES.CF_SSOFERTAEDUCATIVA E ON A.IDCARRERA = E.ID
                WHERE --ISNULL(NOIAP,'1') = '1' AND ISNULL(ORGANO,'1') != '1'
                    (ISNULL(NOIAP,'1') = '1' OR NOIAP = '')
                    AND (ISNULL(ORGANO,'1') != '1' OR ORGANO !='')
                GROUP BY ORGANO,E.ID, E.DESCRIPCION
            UNION
                SELECT  
                     @TIPOCONCEPTO AS ['TIPOCONCEPTO'],
                     0 AS TOTALCONCEPTO, 
                    (SELECT COUNT(*) AS TOTALINSTITUCION FROM @T_PRESTADORES A WHERE (ISNULL(NOIAP,'1') = '1' OR NOIAP = '')
                        AND (ISNULL(ORGANO,'1') = '1' OR ORGANO='')) AS TOTALINSTITUCION,
                    E.ID AS IDCONCEPTO, 
                    E.DESCRIPCION AS CONCEPTODESC, 
                    'Sin asignar', 
                    '3'
                FROM @T_PRESTADORES A
                INNER JOIN DATAPRES.CF_SSOFERTAEDUCATIVA E ON A.IDCARRERA = E.ID
                WHERE 	
                    (ISNULL(NOIAP,'1') = '1' OR NOIAP = '')
                    AND (ISNULL(ORGANO,'1') = '1' OR ORGANO='')
                GROUP BY E.ID, E.DESCRIPCION
            )TEMP_CARRERA
        END
        
        --SELECT 'CARRERA', * FROM @T_CONCEPTO
        
        
        /*--------------------------------------------------------*/
        
        
        /*
        SELECT * FROM @T_CONCEPTO
        
        
        SELECT COUNT(*), IDCARRERA
        FROM @T_PRESTADORES A
        GROUP BY IDCARRERA
        */
        
        
        /*--- ACTUALIZANDO TOTALES --*/
        DECLARE @AUX_TOT INT,
        @AUX_CONT INT,
        @aux_totalInst INT,
        @AUX_FILA INT,
        @aux_IDCONCEPTO INT,
        @aux_IDCONCEPTOLast INT
        
        SELECT @AUX_TOT = COUNT(*) FROM @T_CONCEPTO
        SET @AUX_FILA =1
        SET @AUX_CONT=0
        set @aux_IDCONCEPTO =0
        set @aux_IDCONCEPTOLast =0
        SET @aux_totalInst = 0
        
        WHILE @AUX_FILA <= (@AUX_TOT+1)
        BEGIN
            IF @AUX_FILA != (@AUX_TOT+1)
            BEGIN
                SELECT @aux_IDCONCEPTO = IDCONCEPTO, @aux_totalInst = TOTALINSTITUCION FROM @T_CONCEPTO WHERE FILA = @AUX_FILA	
            END
            ELSE
            BEGIN 
                SET @aux_IDCONCEPTOLast = @aux_IDCONCEPTO
            END
            IF @aux_IDCONCEPTOLast = @aux_IDCONCEPTO AND @AUX_FILA != (@AUX_TOT+1)
            BEGIN
                SET @AUX_CONT = @AUX_CONT + @aux_totalInst
            END
            ELSE
            BEGIN
                IF @aux_IDCONCEPTOLast = 0 
                BEGIN
                    SET @aux_IDCONCEPTOLast= @aux_IDCONCEPTO
                    SET @AUX_CONT = @AUX_CONT + @AUX_TOT
                END
                UPDATE @T_CONCEPTO
                SET TOTALCONCEPTO = @AUX_CONT
                WHERE IDCONCEPTO = @aux_IDCONCEPTOLast
                PRINT 'UP ' + CONVERT(VARCHAR, @aux_totalInst ) + ' WHEN ' + CONVERT(VARCHAR, @aux_IDCONCEPTOLast)
                SET @AUX_CONT = @aux_totalInst
                SET @aux_IDCONCEPTOLast = @aux_IDCONCEPTO
            END
        
            SET @AUX_FILA = @AUX_FILA  + 1
        END
        
        SELECT (SELECT COUNT(DISTINCT IDCONCEPTO) FROM @T_CONCEPTO) AS TOTALDISTINCT,* FROM @T_CONCEPTO
        
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
            <!---
			<cfif #consultaAnio# NEQ '0'>
            	AND YEAR(FECHAINICIO) = <cfoutput>#consultaAnio# </cfoutput>
			</cfif>
			--->
	    </cfquery>
		<cfreturn qGetSSActual>
	</cffunction>
    
    
</cfcomponent>
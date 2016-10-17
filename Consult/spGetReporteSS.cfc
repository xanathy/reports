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
    
    
    
            
            DECLARE @TOTALSS INT = 0
            SELECT @TOTALSS = COUNT(*) FROM @T_PRESTADORES
            
            /*------------------------------------------------------- 1 -  REPORTE SS PRESTADO POR RUBRO ---*/
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
             
            /*------------------------------------------------------- 2 -  REPORTE SS PRESTADO POR CARRERA ---*/
            IF @TIPOREPORTE = 2 
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
    
    	   /*------------------------------------------------------- 3 -  REPORTE SS PRESTADO POR ESCUELA ---*/
            IF @TIPOREPORTE = 3
            BEGIN
                SET @TIPOCONCEPTO = 'ESCUELA' 
			      SELECT 
                    @TIPOCONCEPTO AS TIPOCONCEPTO,
                    COUNT(B.ACRONIMO) AS TOTALCONCEPTO,
                    B.ACRONIMO AS CONCEPTODESC,
                    @TOTALSS AS TOTALSS
                    FROM @T_PRESTADORES A
                    INNER JOIN DATAPRES.CF_SSINSTITUCIONESEDUCATIVAS B ON A.IDESCUELA = B.ID
                    GROUP BY B.ACRONIMO
              END  
			
          /*------------------------------------------------------- 4 y 5 -  REPORTE SS PRESTADO POR IAP - IAP/ORG ---*/
            IF @TIPOREPORTE = 4 OR @TIPOREPORTE = 5
            BEGIN
			    DECLARE @T_IAPORG AS TABLE(
					TIPOCONCEPTO VARCHAR(50),
					TOTALCONCEPTO INT,
					CONCEPTODESC VARCHAR(400),
					TOTALSS INT) 

                IF @TIPOREPORTE = 4 
                BEGIN
                    SELECT @TOTALSS = COUNT(*) FROM @T_PRESTADORES A
                    INNER JOIN CD_IAP B ON A.NOIAP = B.CDIAP_NoIap
                END
                
                SET @TIPOCONCEPTO = 'IAP BENEFICIADAS' 
                INSERT @T_IAPORG
                SELECT 
                    @TIPOCONCEPTO AS TIPOCONCEPTO,
                    COUNT(NOIAP) AS TOTALCONCEPTO,
                    B.CDIAP_NombreIap AS CONCEPTODESC,
                    @TOTALSS AS TOTALSS
                    FROM @T_PRESTADORES A
                    INNER JOIN CD_IAP B ON A.NOIAP = B.CDIAP_NoIap
                    GROUP BY B.CDIAP_NombreIap
				
				IF @TIPOREPORTE = 5
				BEGIN
					SET @TIPOCONCEPTO = 'IAP/ORG BENEFICIADAS'
					INSERT @T_IAPORG
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
                 SELECT * FROM @T_IAPORG	
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
<!----
<cfoutput> <script> alert('#consultaAnio#'); </script> </cfoutput>
---->

		<cfquery name="qGetSSActual" datasource="#application.dsn_japsql#">        	           
            /*------ DATOS GENERALES DE LOS PRESTADORES DE SERVICIO SOCIAL ------*/
            
            SELECT 
            /*ISNULL(NOMBRES,'') + ISNULL(' ' + APELLIDOPATERNO,'') + ISNULL(' ' + APELLIDOMATERNO,'') AS NOMBRE,*/
            ISNULL(APELLIDOPATERNO,'') AS APELLIDOPATERNO,
            ISNULL(APELLIDOMATERNO,'') AS APELLIDOMATERNO,
            ISNULL(NOMBRES,'') AS NOMBRE,
            ISNULL(EDAD,'') AS EDAD,
            ISNULL(TELEFONOFIJO,'') AS [TELEFONOFIJO],
            ISNULL(TELEFONOCELULAR,'') AS [TELEFONOCELULAR],
            ISNULL(EMAIL,'') AS [EMAIL],
            C.DESCRIPCION AS CARRERA,		
            B.NOMBRE AS [UNIVERSIDAD],
            B.ACRONIMO AS [ACRONIMO],
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
            CASE WHEN ISNULL(D.CDIAP_NombreIap,'1') = '1' THEN
                CASE WHEN ISNULL(A.ORGANO,'1') = '1' THEN 'SIN ASIGNAR'
                ELSE ORGANO END
            ELSE D.CDIAP_NombreIap	END AS [INSTITUCIONASIGNADA],
            E.CFGRU_Descripcion AS [RUBRO],
			FECHAINICIO AS [FECHAINICIO],
            FECHAFINAL AS [FECHAFINAL],
            F.DESCRIPCION AS [RAMO],
            CASE WHEN ISNULL(A.TERMINOSS,'1') = '1' THEN 'En servicio'
					ELSE CASE WHEN A.TERMINOSS = 'SI' THEN 'Concluido'
					ELSE 'Cancelado' END
				END AS ESTATUS
            FROM DATAPRES.SSPRESTADORES A
            INNER JOIN DATAPRES.CF_SSINSTITUCIONESEDUCATIVAS B ON A.REFID_INSTITUCIONESEDUCATIVAS = B.ID
            INNER JOIN DATAPRES.CF_SSOFERTAEDUCATIVA C ON A.REFID_CARRERA = C.ID
			INNER JOIN DATAPRES.CF_SSRAMOOFERTAEDUCATIVA F ON C.REFIDRAMO = F.ID
            LEFT JOIN CD_Iap D ON A.NOIAP = D.CDIAP_NoIap
			LEFT JOIN CF_Grupos E ON D.CDIAP_CveGrupo = E.CFGRU_CveGrupo
            WHERE ESTATUS = 'AC' /*-S.S. Validos-*/
            AND ISNULL(A.TERMINOSS,'1') = '1' /* aún no concluyen servicio*/
            <cfif #consultaAnio# NEQ '0'>
            	AND YEAR(FECHAINICIO) = <cfoutput>#consultaAnio# </cfoutput>
			</cfif>
	    </cfquery>
		<cfreturn qGetSSActual>
	</cffunction>
    
    
</cfcomponent>
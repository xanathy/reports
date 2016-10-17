<cfcomponent>
	    
    <cfset setlocale ("es_MX")> <!--- requerido para guardar correctamente las fechas ---->
        
    <!--- Obtener reporte de voluntariado --->
    <cffunction name="getVoluntariado" access="public" returntype="query">
    	<!--- Parámetros que se requieren para el query ---->     
        <cfargument name="tipoReporte" type="string" required="yes">  <!--- 1 --->
		<cfargument name="fechaInicio" type="string" required="yes"> 
		<cfargument name="fechaFin" type="string" required="no"> 
        
        <cfset setlocale ("es_MX")> <!--- requerido para guardar correctamente las fechas ---->
        
        <cfquery name="qGetVoluntariado" datasource="#application.dsn_japsql#">
         	DECLARE 
            @TIPOREPORTE INT = #tipoReporte#,
            @INTERVALOINICIO DATE = '#lsdateformat(fechaInicio,'yyyymmdd')#',   
            @INTERVALOFIN DATE =  '#lsdateformat(fechaFin,'yyyymmdd')#',
            @TIPOCONCEPTO VARCHAR(50) = ''
                
            /*------ DATOS DEL VOLUNTARIADO ------*/       	
                                
            DECLARE @T_VOLUNTARIADO AS TABLE(
                ID INT,
                NOIAP VARCHAR(4),
                NOMBREIAP VARCHAR(500),
                HORAS INT,
                NOVOLUNTARIOS INT,
                HRSVOLUNTARIOS INT,
                FECHAVOLUNTARIADO SMALLDATETIME,
                FECHAVOLUNTARIADOFINALIZA SMALLDATETIME,
                IDEMPRESA INT, 
                EMPRESA VARCHAR(200),
                APORTACIONEMPRESA DECIMAL,
                APORTACIONVOLUNTARIOS DECIMAL,
                NOTA VARCHAR(4000),
                DESCRIPCIONACTIVIDAD VARCHAR(4000)
            )
            
           INSERT INTO @T_VOLUNTARIADO
            SELECT A.ID,
                NOIAP,
                C.CDIAP_NombreIap AS NOMIAP,
                HORAS,
                NOVOLUNTARIOS,
				CONVERT(INT,NOVOLUNTARIOS) * CONVERT(INT,HORAS),
                FECHAVOLUNTARIADO,
                FECHAVOLUNTARIADOFINALIZA,
                REFIDEMPRESAVOLUNTARIO,
                B.NOMBRE,
                APORTACIONEMPRESA,
                APORTACIONVOLUNTARIO,
                NOTA,
                DESCRIPCIONACTIVIDAD
            FROM DATAPRES.VOLUNTARIADO A 
            INNER JOIN DATAPRES.CF_EMPRESASVOLUNTARIADO B ON A.REFIDEMPRESAVOLUNTARIO = B.ID
            INNER JOIN BDI.dbo.CD_IAP C ON A.NOIAP = C.CDIAP_NoIap
            WHERE 
                ESTATUS = 'AC' /*--VALIDO EN EL SISTEMA ---*/
                AND FECHAVOLUNTARIADO >= @INTERVALOINICIO        
                AND FECHAVOLUNTARIADO <= @INTERVALOFIN
            
            DECLARE @TOTALVOL INT = 0,
            @TOTALHORAS INT = 0,
            @TOTALAPORTAEMPRESA INT = 0,
            @TOTALAPORTAVOL INT = 0
                
            SELECT @TOTALVOL = SUM(NOVOLUNTARIOS),
            @TOTALHORAS = SUM(HRSVOLUNTARIOS),
            @TOTALAPORTAEMPRESA = SUM(APORTACIONEMPRESA),
            @TOTALAPORTAVOL = SUM(APORTACIONVOLUNTARIOS)
            FROM @T_VOLUNTARIADO
        
            SELECT *, @TOTALVOL AS 'TOTALVOL',
            @TOTALHORAS AS 'TOTALHRS',
            @TOTALAPORTAEMPRESA AS 'TOTALAPORTAEMP',
            @TOTALAPORTAVOL AS 'TOTALAPORTAVOL'
            FROM @T_VOLUNTARIADO
            ORDER BY FECHAVOLUNTARIADO,NOMBREIAP
            
	    </cfquery>
		<cfreturn qGetVoluntariado>
	</cffunction>
    
    <!--- Obtener datos de vinculacion --->
    <cffunction name="getVinculacion" access="public" returntype="query">
    	<cfargument name="fechaInicio" type="string" required="yes"> 
		<cfargument name="fechaFin" type="string" required="no"> 
        
        <cfquery name="qGetVinculacion" datasource="#application.dsn_japsql#">
         	DECLARE 
            @INTERVALOINICIO DATE = '#lsdateformat(fechaInicio,'yyyymmdd')#',   
            @INTERVALOFIN DATE =  '#lsdateformat(fechaFin,'yyyymmdd')#'
            
            SELECT A.ID,
                UPPER(B.NOMBRE) AS ENTE,
                A.FECHAVINCULACION,
                CASE WHEN INSTALACIONES = 1 THEN 'EMPRESA'
                    ELSE CASE WHEN INSTALACIONES = 2 THEN 'IAP'			
                        ELSE CASE WHEN INSTALACIONES = 3 THEN 'JAPDF'			
                            ELSE CASE WHEN INSTALACIONES = 4 THEN UPPER(INSTALACIONESOTRO)
                            END
                        END
                    END
                END AS INSTALACIONES,
                ISNULL(UPPER(SEDE),'') AS SEDE,
                CONCEPTOREUNION,
                NOTAS
            FROM DATAPRES.VINCULACIONVOLUNTARIADO A
            INNER JOIN DATAPRES.CF_EMPRESASVOLUNTARIADO B ON A.REFIDEMPRESA = B.ID
            WHERE
			ESTATUS = 'AC'
            AND FECHAVINCULACION >= @INTERVALOINICIO
            AND FECHAVINCULACION <= @INTERVALOFIN
            ORDER BY FECHAVINCULACION, ENTE
            
	    </cfquery>
		<cfreturn qGetVinculacion>
	</cffunction>
    
 </cfcomponent>
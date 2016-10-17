<cfcomponent>
	    
    <cfset setlocale ("es_MX")> <!--- requerido para guardar correctamente las fechas ---->
        
    <!--- Obtener reporte de voluntariado --->
    <cffunction name="getDonativo" access="public" returntype="query">
    	<!--- Parámetros que se requieren para el query ---->     
        <cfargument name="tipoReporte" type="string" required="yes">  <!--- 1 --->
		<cfargument name="fechaInicio" type="string" required="yes"> 
		<cfargument name="fechaFin" type="string" required="no"> 
        
        <cfset setlocale ("es_MX")> <!--- requerido para guardar correctamente las fechas ---->
        
        <cfquery name="qGetDonativo" datasource="#application.dsn_japsql#">
         	DECLARE 
            @TIPOREPORTE INT = '#tipoReporte#',
            @INTERVALOINICIO DATE = '#lsdateformat(fechaInicio,'yyyymmdd')#',   
            @INTERVALOFIN DATE =  '#lsdateformat(fechaFin,'yyyymmdd')#',
            @TIPOCONCEPTO VARCHAR(50) = ''
                            
                            
             /*------ REPORTE GENERAL DE DONATIVOS ------*/   
            DECLARE @T_DONATIVOS AS TABLE(
                FILA INT, 
                DONANTE VARCHAR(400),
                PRODUCTO VARCHAR(800),
                MES INT,
				ANIO INT,
				FECHA SMALLDATETIME,
                NOIAP VARCHAR(4),
                NOMBREIAP  VARCHAR(400),
                CANTIDAD  VARCHAR(800),
                MONTOAPROXIMADO DECIMAL,
                TOTAL_DONATIVOS INT,	
                TOTAL_MONTO DECIMAL,
                TOTAL_DONANTES INT, 
                TOTAL_IAPS INT
            )
            
            DECLARE
                @TOTAL_DONATIVOS INT,	
                @TOTAL_MONTO DECIMAL,
                @TOTAL_DONANTES INT, 
                @TOTAL_IAPS INT,
                @TOTAL_TABLADONATIVOS INT,
                @CONT INT 
            
            INSERT INTO @T_DONATIVOS
                SELECT 
                ROW_NUMBER() OVER (ORDER BY FECHADONATIVO, DONANTE,NOIAP),
                B.DONANTE,
                DESCRIPCIONDONATIVO AS PRODUCTO,
                MONTH(FECHADONATIVO) AS MES,
                YEAR(FECHADONATIVO) AS ANIO,
				FECHADONATIVO,
                NOIAP,
                C.CDIAP_NombreIap AS NOMBREIAP,
                CANTIDAD,
                MONTOAPROXIMADO,
                NULL,NULL,NULL,NULL
                FROM DATAPRES.DONATIVOSXIAP A 
                INNER JOIN DATAPRES.CF_DONANTES B ON A.REFIDDONANTE = B.ID
                INNER JOIN BDI.dbo.CD_Iap C ON A.NOIAP = C.CDIAP_NoIap
                WHERE
                ESTATUS = 'AC'
                AND FECHADONATIVO >= @INTERVALOINICIO
                AND FECHADONATIVO <= @INTERVALOFIN
				ORDER BY FECHADONATIVO
                
            SELECT @TOTAL_TABLADONATIVOS = COUNT(*) FROM @T_DONATIVOS
            
            /*------------ DONATIVOS GENERALES ----------------------------*/
            
            IF @TIPOREPORTE = 1
            BEGIN  
                SELECT @TOTAL_DONATIVOS = COUNT(*) FROM @T_DONATIVOS
                SELECT @TOTAL_MONTO = SUM(MONTOAPROXIMADO) FROM @T_DONATIVOS
                SELECT @TOTAL_DONANTES = COUNT(DISTINCT DONANTE) FROM @T_DONATIVOS
                SELECT @TOTAL_IAPS = COUNT(DISTINCT NOIAP) FROM @T_DONATIVOS
            
                UPDATE @T_DONATIVOS
                SET TOTAL_DONATIVOS = @TOTAL_DONATIVOS,
                TOTAL_DONANTES = @TOTAL_DONANTES,
                TOTAL_IAPS = @TOTAL_IAPS,
                TOTAL_MONTO = @TOTAL_MONTO
            
				SELECT * FROM @T_DONATIVOS
            END
           
            /*-------------------- DONATIVOS POR MES -------------------------*/
            IF @TIPOREPORTE = 2 OR @TIPOREPORTE = 3  OR @TIPOREPORTE = 4
            BEGIN
                SET @CONT = 1
                DECLARE @AUXMES INT = 0,
                @AUXMESANT INT = 0
            
                WHILE @CONT <= @TOTAL_TABLADONATIVOS
                BEGIN
                    SELECT @AUXMES = MES FROM @T_DONATIVOS WHERE FILA = @CONT
                    IF @AUXMES != @AUXMESANT
                    BEGIN
                        SET @AUXMESANT = @AUXMES
                        SELECT @TOTAL_MONTO = SUM(MONTOAPROXIMADO) FROM @T_DONATIVOS WHERE MES = @AUXMES
                        SELECT @TOTAL_DONATIVOS = COUNT(*) FROM @T_DONATIVOS WHERE MES = @AUXMES
                        SELECT @TOTAL_DONANTES = COUNT(DISTINCT DONANTE) FROM @T_DONATIVOS WHERE MES = @AUXMES
                        SELECT @TOTAL_IAPS = COUNT(DISTINCT NOIAP) FROM @T_DONATIVOS WHERE MES = @AUXMES
                        
                        UPDATE @T_DONATIVOS
                        SET TOTAL_DONATIVOS = @TOTAL_DONATIVOS,
                        TOTAL_DONANTES = @TOTAL_DONANTES,
                        TOTAL_IAPS = @TOTAL_IAPS,
                        TOTAL_MONTO = @TOTAL_MONTO
                        WHERE MES = @AUXMES
                    END
                    SET @CONT = @CONT + 1
                END
				
				IF @TIPOREPORTE = 2 OR @TIPOREPORTE = 3 
				BEGIN
					SELECT * FROM @T_DONATIVOS
				END
            END
			

			IF @TIPOREPORTE = 4
			BEGIN
				SELECT DISTINCT NOMBREIAP, MES,ANIO,TOTAL_IAPS FROM @T_DONATIVOS ORDER BY ANIO,MES,NOMBREIAP
			END

           
	    </cfquery>
		<cfreturn qGetDonativo>
	</cffunction>
    
    
 </cfcomponent>
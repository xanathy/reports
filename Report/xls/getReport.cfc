<cfcomponent>
	<cffunction name="myFunction" access="public" returntype="string">
		<cfargument name="tipoReporte" type="string" required="yes">
        <cfargument name="numReporte" type="string" required="yes">
        
        <cfquery name="qReporte" datasource="#application.dsn_japsql#">
            SELECT 'NO HAY REPORTE' AS COL
        </cfquery>
                    
        <cfif #tipoReporte# EQ 'SS'>
        	<cfswitch expression="#numReporte#">
            	<cfcase value="1">
                    <cfquery name="qReporte" datasource="#application.dsn_japsql#">
                    	/*--SE CONSIDERA MAXIMO 10 COLS (11 OCT)--*/
                        SELECT 
                            '3' as [COLUMNAS],
                            ROW_NUMBER() OVER (ORDER BY NOMBRE) AS [COL1],
                            NOMBRE AS [COL2'],
                            ACRONIMO AS [COL3]
                        FROM DATAPRES.CF_SSINSTITUCIONESEDUCATIVAS
					</cfquery>
                </cfcase>
            </cfswitch>
        </cfif>
        
		<cfreturn qReporte>
	</cffunction>
</cfcomponent>
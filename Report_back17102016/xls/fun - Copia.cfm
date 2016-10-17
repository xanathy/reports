<cfquery name="q1" datasource="#application.dsn_japsql#">
	/*SELECT 
    	'COLUMNA',
        'FILA',
        'NOMBRE',
        'ACRONIMO'
    UNION
    */
    SELECT 
                convert(VARCHAR,ROW_NUMBER() OVER (ORDER BY ID)) AS [COL1],
        NOMBRE AS [COL2'],
        ACRONIMO AS [COL3]
	FROM DATAPRES.CF_SSINSTITUCIONESEDUCATIVAS
</cfquery>
<cfset eq1 = "COLUMNA,FILA,NOMBRE,ACRONIMO">

<cfquery name="q2" datasource="#application.dsn_japsql#">
	SELECT 
        '3' AS [COLUMNAS],
        convert(VARCHAR,ROW_NUMBER() OVER (ORDER BY A.DESCRIPCION)) AS [COL1],
        A.DESCRIPCION AS [COL2],
        B.DESCRIPCION AS [COL3]
    FROM DATAPRES.CF_SSOFERTAEDUCATIVA A
    INNER JOIN DATAPRES.CF_SSRAMOOFERTAEDUCATIVA B ON A.REFIDRAMO = B.ID
</cfquery>
<cfset eq2 = "COLUMNA,des1,des3">

<cfscript>
// Define a format for the column. 
	encabezado = StructNew();
	encabezado.bold = true;
	encabezado.font="Arial"; 
     
	encabezado.fgcolor = "plum";
	encabezado.color = "white";
</cfscript>

<cffunction name="QueriesToXLS" access="public">
    <cfargument name="queryArr" required="true"><!--- An Array of Query Objects --->
    <cfargument name="sheetNameArr" required="false"><!--- Optional sheet names to use instead of "Sheet1","Sheet2",... --->
    <cfargument name="qTitleArr" required="false"><!--- Optional sheet names to use instead of "Sheet1","Sheet2",... --->
    <cfset tempPath = GetTempDirectory() & CreateUuid() & ".xls"><!--- Creaete a Temp XLS File --->
    <cfset counter = 1>
    <cfloop array="#ARGUMENTS.queryArr#" index="i">
        <cfset sheetName = "Sheet#counter#">
         <cfif isDefined("ARGUMENTS.sheetNameArr")>
            <cfset sheetName = ARGUMENTS.sheetNameArr[counter]>
        </cfif>
        <cfset title= "">
         <cfif isDefined("ARGUMENTS.qTitleArr")>
            <cfset title = ARGUMENTS.qTitleArr[counter]>
        </cfif>
               
        <cfscript>
		    theSheet = SpreadsheetNew("SourceData1"); 
            SpreadsheetAddRow(theSheet, title);
            SpreadsheetAddRows(theSheet,i); 
            SpreadsheetFormatRow(theSheet,encabezado,1);	    
        </cfscript> 
        <cfspreadsheet action="update" filename="#tempPath#" name="theSheet" sheetName="#sheetName#"> 
       <cfset counter += 1>
    </cfloop>
    <cfreturn SpreadsheetRead(tempPath)>
</cffunction>

<!---original 

<cffunction name="QueriesToXLS" access="public">
    <cfargument name="queryArr" required="true"><!--- An Array of Query Objects --->
    <cfargument name="sheetNameArr" required="false"><!--- Optional sheet names to use instead of "Sheet1","Sheet2",... --->
    <cfset tempPath = GetTempDirectory() & CreateUuid() & ".xls"><!--- Creaete a Temp XLS File --->
    <cfset counter = 1>
    <cfloop array="#ARGUMENTS.queryArr#" index="i">
        <cfset sheetName = "Sheet#counter#">
         <cfif isDefined("ARGUMENTS.sheetNameArr")>
            <cfset sheetName = ARGUMENTS.sheetNameArr[counter]>
        </cfif>
        
        <cfspreadsheet action="update" filename="#tempPath#" query="i" sheetName="#sheetName#"/>
        <cfset counter += 1>
    </cfloop>
    <cfreturn SpreadsheetRead(tempPath)>
</cffunction>

------->


<cfset xlsData = QueriesToXLS(
    [q1,q2],
    ["Details","Summary"],
	[eq1, eq2]
)>

<cfheader name="content-disposition" value="attachment; filename=export.xls">
<cfcontent type="application/msexcel" variable="#spreadsheetReadBinary(xlsData)#" reset="true">
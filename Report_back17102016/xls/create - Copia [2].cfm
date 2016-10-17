<cfquery name="q1" datasource="#application.dsn_japsql#">
	/*SELECT 
    	'COLUMNA',
        'FILA',
        'NOMBRE',
        'ACRONIMO'
    UNION
    */
    SELECT 
        ROW_NUMBER() OVER (ORDER BY NOMBRE) AS [COL1],
        NOMBRE AS [COL2'],
        ACRONIMO AS [COL3]
	FROM DATAPRES.CF_SSINSTITUCIONESEDUCATIVAS
</cfquery>

<cfquery name="q2" datasource="#application.dsn_japsql#">
	SELECT 
        '3' AS [COLUMNAS],
        ROW_NUMBER() OVER (ORDER BY A.DESCRIPCION) AS [COL1],
        A.DESCRIPCION AS [COL2],
        B.DESCRIPCION AS [COL3]
    FROM DATAPRES.CF_SSOFERTAEDUCATIVA A
    INNER JOIN DATAPRES.CF_SSRAMOOFERTAEDUCATIVA B ON A.REFIDRAMO = B.ID
</cfquery>

<cfinvoke component="CONS_REP.ssdovovi.Consult.spGetReporteSS" method="getSSActual" returnvariable="qGetReporteSS">
    <cfinvokeargument name="consultaAnio" value="2016">
</cfinvoke>

<cfset tipoReporte = "SSGeneral">
asdkasdpkasopd
<cfoutput> #tipoReporte# </cfoutput>

<!---Cretare spreadsheet --->

<!---- GetDirectoryFromPath(GetCurrentTemplatePath()) ---->
<cfscript> 
    //Use an absolute path for the files. ---> 
    theDir= "C:/inetpub/wwwroot/CONS_REP/ssdovovi/Report/xls/";
    
    
	 // Define a format for the column. 
    format1=StructNew();
    format1.font="Courier"; 
    format1.fontsize="10"; 
    format1.color="dark_blue";
	format1.italic="true"; 
    format1.bold="true"; 
    format1.alignment="left"; 
    format1.textwrap="true"; 
    format1.fgcolor="pale_blue"; 
    format1.bottomborder="dotted"; 
    format1.bottombordercolor="blue_grey"; 
    format1.leftborder="thick"; 
    format1.leftbordercolor="blue_grey"; 
    format1.rightborder="thick"; 
    format1.rightbordercolor="blue_grey"; 
	
	 // Define a format for the column. 
    formatDatos=StructNew();
    formatDatos.font="Courier"; 
    formatDatos.fontsize="10"; 
    formatDatos.color="dark_blue";
    formatDatos.textwrap="true"; 
	
	// Define a format for the column. 
	encabezado = StructNew();
	encabezado.bold = true;
	encabezado.font="Calibri"; 
	encabezado.fgcolor = "indigo";
	encabezado.fgcolor = "white";
</cfscript>

<cfswitch expression="#tipoReporte#">

	<cfcase value="SSCatalogos">
    <cfoutput> <script> alert("chhaaa"); </script></cfoutput>
		<cfscript>
            theSheet = SpreadsheetNew("SourceData1"); 
            SpreadsheetAddRow(theSheet, "FILA, Nombre, Acr&oacute;nimo");
            SpreadsheetAddRows(theSheet,q1); 
            SpreadsheetFormatRow(theSheet,encabezado,1);	
			
            theSecondSheet = SpreadsheetNew("SourceData2");         
            SpreadsheetFormatColumn(theSheet,format1,4); 	
            SpreadsheetAddRows(theSecondSheet,q2); 	
        </cfscript> 
        
        <cfspreadsheet action="write" filename="#theFile#" name="theSheet"  
            sheetname="Hoja1" overwrite=true> 
        <cfspreadsheet action="update" filename="#theFile#" name="theSecondSheet" 
				sheetname="Hoja2" > 
	</cfcase>
    
    <cfcase value="SSGeneral">
    	<cfscript>
			theFile=theDir & "ServiciosSocial.xls"; 
            theSheet = SpreadsheetNew("SourceData1"); 
            SpreadsheetAddRow(theSheet, "APELLIDO PATERNO, APELLIDO MATERNO, NOMBRE, EDAD, TELEFONO, CELULAR, CORREO ELECTRONICO, CARRERA, 
			UNIVERSIDAD, ACRONIMO, NIVEL QUE CURSA, PERIODO, ASISTENCIA, RUBRO A ASISTIR, FECHA/INICIO, FECHA/TERMINO, RAMO, ESTATUS");
            SpreadsheetAddRows(theSheet,qGetReporteSS); 
            SpreadsheetFormatRow(theSheet,encabezado,1);	        
            SpreadsheetFormatRows(theSheet,formatDatos, '2-8'); 
        </cfscript> 
        <cfspreadsheet action="write" filename="#theFile#" name="theSheet"  
				sheetname="Alumnos de Servicio Social" overwrite=true> 
	</cfcase>
    
</cfswitch>


 
 <!-----
  
   
    
    
    ---->
 
    
<!--- Read all or part of the file into a spreadsheet object, CSV string, 
      HTML string, and query. 
<cfspreadsheet action="read" src="#theFile#" sheetname="Hoja1" name="SourceData1"> 
<cfspreadsheet action="read" src="#theFile#" sheet=1 rows="3,4" format="csv" name="csvData"> 
<cfspreadsheet action="read" src="#theFile#" format="html" rows="5-10" name="htmlData"> 
<cfspreadsheet action="read" src="#theFile#" sheetname="centers" query="queryData"> 
    ---> 
    
    <!----
<cfspreadsheet action="read" src="#theFile#" sheetname="Hoja1" name="SourceData1">
    
<!--- Modify the courses sheet. ---> 
<cfscript> 
    SpreadsheetAddRow(SourceData1,"03,ENGL,230,Poetry 1",8,1); 
    SpreadsheetAddColumn(SourceData1, 
    "Basic,Intermediate,Advanced,Basic,Intermediate,Advanced,Basic,Intermediate,Advanced", 
    3,2,true); 
</cfscript> 
    
    <cfspreadsheet action="write" filename="#theDir#updatedFile.xls" name="SourceData1"  
    sheetname="courses" overwrite=true> 
    
	---->
 <!-----------------------------------

<cfset sObj = SpreadsheetNew()>

<cfset SpreadsheetAddRow(sObj, "Order, Last Name,First Name, Amount")>
<cfset SpreadsheetFormatRow(sObj, {bold=TRUE, aligment="center"}, 1)>

 <cfset SpreadsheetAddRows(sObj, q1)>


<!-- figure ot row for formula, 2 after data -->
<cfset rowDataStart = 2>
<cfset rowDataEnd = q1.recordCount+1>
<cfset rowTotal = rowDataEnd + 2>
<cfset totalFormula ="SUM(D#rowDataStart#:D#rowDataEnd#)">

<!-- ADD TOTAL FORMULA -->
<cfset SpreadsheetSetCellValue(sObj, "Total:", rowTotal, 3)>
<cfset SpreadsheetSetCellFormula(sObj, totalFormula, rowTotal, 4 )>

<!-- format amount column as currency -->
<cfset SpreadSheetFormatColumn(sObj, {dataformat="$0,000.00"},4)>

<cfspreadsheet action="write"
filename = "C:/inetpub/wwwroot/CONS_REP/ssdovovi/Report/xls/ordersModif.xls"
name = "sObj"
overwrite = "true">

<!---
<cfspreadsheet action="write"
filename = "C:/inetpub/wwwroot/CONS_REP/ssdovovi/Report/xls/ordersModif.xls"
query = "q1"
overwrite = "true">
--->

------>
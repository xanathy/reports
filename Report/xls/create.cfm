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

<cfquery name="qEstilos" datasource="#application.dsn_japsql#">
    DECLARE @CONT INT = 0,
    @QUERY VARCHAR(8000) = ''
    
    WHILE @CONT < 44
    BEGIN	
        IF @CONT = 0
            SET @QUERY = ' SELECT ' + CONVERT(VARCHAR,@CONT) + ' AS [X] '
        ELSE
            SET @QUERY = @QUERY  + ' UNION SELECT ' + CONVERT(VARCHAR,@CONT) + ' AS [X]'
        
        SET @CONT = @CONT + 1
        if @cont = 1 SET @QUERY = @query + ', ''black'' AS [COLOR]'
        if @cont = 2 SET @QUERY = @query + ', ''brown'' AS [COLOR]'	
        if @cont = 3 SET @QUERY = @query + ', ''olive_green'' AS [COLOR]'
        if @cont = 4 SET @QUERY = @query + ', ''dark_green'' AS [COLOR]'
        if @cont = 5 SET @QUERY = @query + ', ''dark_teal'' AS [COLOR]'
        if @cont = 6 SET @QUERY = @query + ', ''dark_blue'' AS [COLOR]'
        IF @cont = 7 SET @QUERY = @query + ', ''indigo'' AS [COLOR]'
        if @cont = 8 SET @QUERY = @query + ', ''grey_80_percent'' AS [COLOR]'
        if @cont = 9 SET @QUERY = @query + ', ''orange'' AS [COLOR]'	
        if @cont = 10 SET @QUERY = @query + ', ''dark_yellow'' AS [COLOR]'
        if @cont = 11 SET @QUERY = @query + ', ''green'' AS [COLOR]'
        if @cont = 12 SET @QUERY = @query + ', ''teal'' AS [COLOR]'
        if @cont = 13 SET @QUERY = @query + ', ''blue'' AS [COLOR]'
        if @cont = 14 SET @QUERY = @query + ', ''blue_grey'' AS [COLOR]'
        if @cont = 15 SET @QUERY = @query + ', ''grey_50_percent'' AS [COLOR]'
        if @cont = 16 SET @QUERY = @query + ', ''red'' AS [COLOR]'
        If @cont = 17 SET @QUERY = @query + ', ''light_orange'' AS [COLOR]'
        if @cont = 18 SET @QUERY = @query + ', ''lime'' AS [COLOR]'
        if @cont = 19 SET @QUERY = @query + ', ''sea_green'' AS [COLOR]'
        if @cont = 20 SET @QUERY = @query + ', ''aqua'' AS [COLOR]'
        if @cont = 21 SET @QUERY = @query + ', ''light_blue'' AS [COLOR]'
        if @cont = 22 SET @QUERY = @query + ', ''violet'' AS [COLOR]'
        if @cont = 23 SET @QUERY = @query + ', ''grey_40_percent'' AS [COLOR]'
        if @cont = 24 SET @QUERY = @query + ', ''gold'' AS [COLOR]'
        if @cont = 25 SET @QUERY = @query + ', ''yellow'' AS [COLOR]'
        if @cont = 26 SET @QUERY = @query + ', ''bright_green'' AS [COLOR]'
        if @cont = 27 SET @QUERY = @query + ', ''turquoise'' AS [COLOR]'
        if @cont = 28 SET @QUERY = @query + ', ''dark_red'' AS [COLOR]'
        if @cont = 29 SET @QUERY = @query + ', ''sky_blue'' AS [COLOR]'
        if @cont = 30 SET @QUERY = @query + ', ''grey_25_percent'' AS [COLOR]'
        if @cont = 31 SET @QUERY = @query + ', ''rose'' AS [COLOR]'
        if @cont = 32 SET @QUERY = @query + ', ''light_yellow'' AS [COLOR]'
        if @cont = 33 SET @QUERY = @query + ', ''light_green'' AS [COLOR]'
        if @cont = 34 SET @QUERY = @query + ', ''light_turquoise'' AS [COLOR]'
        if @cont = 35 SET @QUERY = @query + ', ''light_turquoise'' AS [COLOR]'
        if @cont = 36 SET @QUERY = @query + ', ''pale_blue'' AS [COLOR]'
        if @cont = 37 SET @QUERY = @query + ', ''lavender'' AS [COLOR]'
        if @cont = 38 SET @QUERY = @query + ', ''cornflower_blue'' AS [COLOR]'
        if @cont = 39 SET @QUERY = @query + ', ''lemon_chiffon'' AS [COLOR]'
        if @cont = 40 SET @QUERY = @query + ', ''maroon'' AS [COLOR]'
        if @cont = 41 SET @QUERY = @query + ', ''orchid'' AS [COLOR]'
        if @cont = 42 SET @QUERY = @query + ', ''coral'' AS [COLOR]'
        if @cont = 43 SET @QUERY = @query + ', ''royal_blue'' AS [COLOR]'
        if @cont = 44 SET @QUERY = @query + ', ''light_cornflower_blue'' AS [COLOR]'	
    END
    --PRINT @QUERY    
    EXEC(@QUERY)
</cfquery>


<cfinvoke component="CONS_REP.ssdovovi.Consult.spGetReporteSS" method="getSSActual" returnvariable="qGetReporteSS">
    <cfinvokeargument name="consultaAnio" value="2016">
</cfinvoke>

<cfset tipoReporte = "estilos">
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
	encabezado.font="Arial"; 
    format1.fontsize="12"; 
	encabezado.fgcolor = "plum";
	encabezado.color = "white";
	

	c1 = StructNew();	c1.fgcolor = "black";
	c2 = StructNew();	c2.fgcolor = "brown";
	c3 = StructNew();	c3.fgcolor = "olive_green";
	c4 = StructNew();	c4.fgcolor = "dark_green";
	c5 = StructNew();	c5.fgcolor = "dark_teal";
	c6 = StructNew();	c6.fgcolor = "dark_blue";
	c7 = StructNew();	c7.fgcolor = "indigo";
	c8 = StructNew();	c8.fgcolor = "grey_80_percent";
	c9 = StructNew();	c9.fgcolor = "orange";	
	c10 = StructNew();	c10.fgcolor = "dark_yellow";
	c11 = StructNew();	c11.fgcolor = "green";
	c12 = StructNew();	c12.fgcolor = "teal";
	c13 = StructNew();	c13.fgcolor = "blue";
	c14 = StructNew();	c14.fgcolor = "blue_grey";
	c15 = StructNew();	c15.fgcolor = "grey_50_percent";
	c16 = StructNew();	c16.fgcolor = "red";
	c17 = StructNew();	c17.fgcolor = "light_orange";
	c18 = StructNew();	c18.fgcolor = "lime";
	c19 = StructNew();	c19.fgcolor = "sea_green";
	c20 = StructNew();	c20.fgcolor = "aqua";
	c21 = StructNew();	c21.fgcolor = "light_blue";
	c22 = StructNew();	c22.fgcolor = "violet";
	c23 = StructNew();	c23.fgcolor = "grey_40_percent";
	c24 = StructNew();	c24.fgcolor = "gold";
	c25 = StructNew();	c25.fgcolor = "yellow";
	c26 = StructNew();	c26.fgcolor = "bright_green";
	c27 = StructNew();	c27.fgcolor = "turquoise";
	c28 = StructNew();	c28.fgcolor = "dark_red";
	c29 = StructNew();	c29.fgcolor = "sky_blue";
	c30 = StructNew();	c30.fgcolor = "grey_25_percent";
	c31 = StructNew();	c31.fgcolor = "rose";
	c32 = StructNew();	c32.fgcolor = "light_yellow";
	c33 = StructNew();	c33.fgcolor = "light_green";
	c34 = StructNew();	c34.fgcolor = "light_turquoise";
	c35 = StructNew();	c35.fgcolor = "light_turquoise";
	c36 = StructNew();	c36.fgcolor = "pale_blue";
	c37 = StructNew();	c37.fgcolor = "lavender";
	c38 = StructNew();	c38.fgcolor = "cornflower_blue";
	c39 = StructNew();	c39.fgcolor = "lemon_chiffon";
	c40 = StructNew();	c40.fgcolor = "maroon";
	c41 = StructNew();	c41.fgcolor = "orchid";
	c42 = StructNew();	c42.fgcolor = "coral";
	c43 = StructNew();	c43.fgcolor = "royal_blue";
	c44 = StructNew();	c44.fgcolor = "light_cornflower_blue";
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
        
        <cfspreadsheet action="write" filename="#theFile#" name="theSheet" sheetname="Hoja1" overwrite=true> 
        <cfspreadsheet action="update" filename="#theFile#" name="theSecondSheet" sheetname="Hoja2" > 
	</cfcase>
    
    <cfcase value="SSGeneral">
    	<cfscript>
			theFile=theDir & "ServiciosSocial.xls"; 
            theSheet = SpreadsheetNew("SourceData1"); 
            SpreadsheetAddRow(theSheet, "APELLIDO PATERNO, APELLIDO MATERNO, NOMBRE, EDAD, TELEFONO, CELULAR, CORREO ELECTRONICO, CARRERA, 
			UNIVERSIDAD, ACRONIMO, NIVEL QUE CURSA, PERIODO, ASISTENCIA, RUBRO A ASISTIR, FECHA/INICIO, FECHA/TERMINO, RAMO, ESTATUS");
            SpreadsheetAddRows(theSheet,qGetReporteSS); 
            SpreadsheetFormatRow(theSheet,encabezado,1);	    
        </cfscript> 
        <cfspreadsheet action="write" filename="#theFile#" name="theSheet" sheetname="Alumnos de Servicio Social" overwrite=true> 
	</cfcase>
    
     <cfcase value="estilos">
    	<cfscript>
			theFile=theDir & "estilos.xls"; 
            theSheet = SpreadsheetNew("SourceData1"); 
            SpreadsheetAddRow(theSheet, "APELLIDO PATERNO, APELLIDO MATERNO, NOMBRE, EDAD, TELEFONO, CELULAR, CORREO ELECTRONICO, CARRERA, 
			UNIVERSIDAD, ACRONIMO, NIVEL QUE CURSA, PERIODO, ASISTENCIA, RUBRO A ASISTIR, FECHA/INICIO, FECHA/TERMINO, RAMO, ESTATUS");
            SpreadsheetAddRows(theSheet,qEstilos); 
		</cfscript>
        
                <cfscript>        
                    SpreadsheetFormatRow(theSheet,c1,2);	    
                    SpreadsheetFormatRow(theSheet,c2,3);	    
                    SpreadsheetFormatRow(theSheet,c3,4);	    
                    SpreadsheetFormatRow(theSheet,c4,5);	    
                    SpreadsheetFormatRow(theSheet,c5,6);	    
                    SpreadsheetFormatRow(theSheet,c6,7);	    
                    SpreadsheetFormatRow(theSheet,c7,8);	    
                    SpreadsheetFormatRow(theSheet,c8,9);	    
                    SpreadsheetFormatRow(theSheet,c9,10);	    
                    SpreadsheetFormatRow(theSheet,c10,11);	    
                    SpreadsheetFormatRow(theSheet,c11,12);	    
                    SpreadsheetFormatRow(theSheet,c12,13);	    
                    SpreadsheetFormatRow(theSheet,c13,14);	    
                    SpreadsheetFormatRow(theSheet,c14,15);	    
                    SpreadsheetFormatRow(theSheet,c15,16);	    
                    SpreadsheetFormatRow(theSheet,c16,17);	    
                    SpreadsheetFormatRow(theSheet,c17,18);	    
                    SpreadsheetFormatRow(theSheet,c18,19);	    
                    SpreadsheetFormatRow(theSheet,c19,20);	    
                    SpreadsheetFormatRow(theSheet,c20,21);		    
                    SpreadsheetFormatRow(theSheet,c21,22);		    
                    SpreadsheetFormatRow(theSheet,c22,23);		    
                    SpreadsheetFormatRow(theSheet,c23,24);		    
                    SpreadsheetFormatRow(theSheet,c24,25);		    
                    SpreadsheetFormatRow(theSheet,c25,26);		    
                    SpreadsheetFormatRow(theSheet,c26,27);		    
                    SpreadsheetFormatRow(theSheet,c27,28);		    
                    SpreadsheetFormatRow(theSheet,c28,29);		    
                    SpreadsheetFormatRow(theSheet,c29,30);		    
                    SpreadsheetFormatRow(theSheet,c30,31);	        
                    SpreadsheetFormatRow(theSheet,c31,32);	        
                    SpreadsheetFormatRow(theSheet,c32,33);	        
                    SpreadsheetFormatRow(theSheet,c33,34);	        
                    SpreadsheetFormatRow(theSheet,c34,35);	        
                    SpreadsheetFormatRow(theSheet,c35,36);	        
                    SpreadsheetFormatRow(theSheet,c36,37);	        
                    SpreadsheetFormatRow(theSheet,c37,38);	        
                    SpreadsheetFormatRow(theSheet,c38,39);	        
                    SpreadsheetFormatRow(theSheet,c39,40);	        
                    SpreadsheetFormatRow(theSheet,c40,41); 
                    SpreadsheetFormatRow(theSheet,c41,42); 
                    SpreadsheetFormatRow(theSheet,c42,43); 
                    SpreadsheetFormatRow(theSheet,c43,44); 
                    SpreadsheetFormatRow(theSheet,c44,45);  
                </cfscript> 
               
        <cfspreadsheet action="write" filename="#theFile#" name="theSheet" sheetname="Alumnos de Servicio Social" overwrite=true> 
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
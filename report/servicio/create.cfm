<cfquery name="q1" datasource="#application.dsn_japsql#">
	SELECT 'A', 'B', 'C', '12345.23'
	UNION
	SELECT 'Z','W','X', '3456.22'
	UNION
	SELECT '1','2','3', '21656.22'
</cfquery>

<cfquery name="q2" datasource="#application.dsn_japsql#">
	SELECT 'aaa', 'bbb', 'ccc', '12345.23'
	UNION
	SELECT 'zzz','wwww','xxxX', '3456.22'
	UNION
	SELECT '1aa','2vvv','3zzz', '21656.22'
</cfquery>



<!---Cretare spreadsheet --->

<!---- GetDirectoryFromPath(GetCurrentTemplatePath()) ---->
<cfscript> 
    //Use an absolute path for the files. ---> 
       theDir= "C:/inetpub/wwwroot/CONS_REP/ssdovovi/Report/xls/";;  
    theFile=theDir & "createComplex.xls"; 
    
	//Create two empty ColdFusion spreadsheet objects. ---> 
    theSheet = SpreadsheetNew("SourceData1"); 
    theSecondSheet = SpreadsheetNew("SourceData2"); 
    
	//Populate each object with a query. ---> 
    SpreadsheetAddRows(theSheet,q1); 
    SpreadsheetAddRows(theSecondSheet,q2); 
</cfscript> 
 
<!--- Write the two sheets to a single file ---> 
<cfspreadsheet action="write" filename="#theFile#" name="theSheet"  
    sheetname="Hoja1" overwrite=true> 
<cfspreadsheet action="update" filename="#theFile#" name="theSecondSheet" 
    sheetname="Hoja2"> 
    
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
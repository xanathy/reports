<cfquery name="q1" datasource="#application.dsn_japsql#">
	SELECT 'A', 'B', 'C', '12345.23'
	UNION
	SELECT 'Z','W','X', '3456.22'
	UNION
	SELECT '1','2','3', '21656.22'
</cfquery>

<!---Cretare spreadsheet --->


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

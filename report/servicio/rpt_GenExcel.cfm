<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Reporte de Servicio Social</title>
</head>

<body>

<cfoutput>
<!----
<cfset q = queryNew("Name,Beers,Vegetables,Fruits,Meats", "cf_sql_varchar,cf_sql_integer,cf_sql_integer,cf_sql_integer,cf_sqlinteger")> 
<cfloop index="x" from="1" to="10">
	<cfset queryAddRow(q)> 
	<cfset querySetCell(q, "Name", form["name#x#"])> 
	<cfset querySetCell(q, "Beers", form["beers#x#"])> 
	<cfset querySetCell(q, "Vegetables", form["veggies#x#"])> 
	<cfset querySetCell(q, "Fruits", form["fruits#x#"])> 
	<cfset querySetCell(q, "Meats", form["meats#x#"])> 
</cfloop>


<cfset filename = expandPath("C:/myexcel.xls")> 
<cfspreadsheet action="write" query="q" filename="#filename#" overwrite="true">

<!--- Make a spreadsheet object ---> 
<cfset s = spreadsheetNew()> 
<!--- Add header row ---> 
<cfset spreadsheetAddRow(s, "Name,Beers,Vegetables,Fruits,Meats")> 
<!-- format header -->
<cfset spreadsheetFormatRow(s, { bold=true, fgcolor="lemon_chiffon", fontsize=14 }, 1)>

<!-- Add query --> 
<cfset spreadsheetAddRows(s, q)> <cfset spreadsheetWrite(s, filename, true)>

---->

 <cfquery 
        name="foo" 
        datasource="#application.dsn_japsql#">
        SELECT 'a','e','i'
        union 
        SELECT 'ra','er','ri'
        union
        SELECT '4','3','3'
</cfquery> 
<cfscript> 
    //Use an absolute path for the files. ---> 
    theDir="C:\TEST\luisvasquez\Form\imagenes\";
	/*GetDirectoryFromPath(GetCurrentTemplatePath()); */
    theFile=theDir & "courses2.xls"; 
    //Create two empty ColdFusion spreadsheet objects. ---> 
    theSheet = SpreadsheetNew("CourseData"); 
/*    theSecondSheet = SpreadsheetNew("CentersData"); */
    //Populate each object with a query. ---> 
    SpreadsheetAddRows(theSheet,foo); 
   /* SpreadsheetAddRows(theSecondSheet,centers); */
</cfscript> 


<cfspreadsheet action="write" 
filename="#theFile#" 
name="theSheet"  
    sheetname="courses2" overwrite=true> 
    
    
    <!----
	
<cfspreadsheet action="write" filename="#theFile#" name="theSheet"  
    sheetname="courses" overwrite=true> 
	
<cfspreadsheet  
    action="write" 
    filename = "c:\mio.xls" 
    format = "xls" 
    name = "text" 
    
    sheetname = "hojita" >
    ----->
</cfoutput>

</body>
</html>
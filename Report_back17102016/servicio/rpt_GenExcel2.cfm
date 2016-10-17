<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Reporte de Servicio Social</title>
</head>

<body>

<!---
<cfreport 
    format = "PDF|FlashPaper|Excel|RTF|HTML|XML" 
    template = "absolute pathname or pathname relative to the report file" 
    encryption = "128-bit|40-bit|none" 
    filename = "output filename" 
    name = "ColdFusion variable" 
    ownerpassword = "password" 
    overwrite = "no|yes" 
    permissions = "permission list" 
    query = "query variable" 
    resourceTimespan = #CreateTimeSpan (days, hours, minutes, seconds)# 
    style = "CSS style definition or css file pathname" 
    userpassword = "password"> 
    <cfreportparam ...> 
</cfreport> 
 
Crystal Reports syntax: 
<cfreport 
    report = "report path" 
    dataSource = "data source name"  
    formula = "formula" 
    orderBy = "result order" 
    password = "password" 
    timeout = "number of seconds"  
    type = "standard|netscape|microsoft"  
    username = "username"> 
</cfreport>
---->


    <cfquery 
        name="excelquery" 
        datasource="#application.dsn_japsql#">
        SELECT 'a','e','i'
        union 
        SELECT 'ra','er','ri'
        union
        SELECT '4','3','3'
</cfquery> 
<!--- Read data from two datasource tables. ---> 
<cfquery 
       name="courses" datasource="#application.dsn_japsql#"
       cachedwithin="#CreateTimeSpan(0, 6, 0, 0)#"> 
        
        SELECT 'a','e','i'
        union 
        SELECT 'ra','er','ri'
        union
        SELECT '4','3','3'
</cfquery> 
 
<cfquery 
       name="centers" datasource="#application.dsn_japsql#"
       cachedwithin="#CreateTimeSpan(0, 6, 0, 0)#"> 
        SELECT 'a','e','i'
        union 
        SELECT 'ra','er','ri'
        union
        SELECT '4','3','3' 
</cfquery> 
     
<cfscript> 
    //Use an absolute path for the files. ---> 
       theDir="C:/";
	   /*GetDirectoryFromPath(GetCurrentTemplatePath()); */

    theFile=theDir & "courses.xls"; 
    //Create two empty ColdFusion spreadsheet objects. ---> 
    theSheet = SpreadsheetNew("CourseData"); 
    theSecondSheet = SpreadsheetNew("CentersData"); 
    //Populate each object with a query. ---> 
    SpreadsheetAddRows(theSheet,courses); 
    SpreadsheetAddRows(theSecondSheet,centers); 
</cfscript> 
 
<!--- Write the two sheets to a single file ---> 
<cfspreadsheet action="write" filename="#theFile#" name="theSheet"  
    sheetname="courses" overwrite=true> 
<cfspreadsheet action="update" filename="#theFile#" name="theSecondSheet" 
    sheetname="centers"> 
 
<!--- Read all or part of the file into a spreadsheet object, CSV string, 
      HTML string, and query. ---> 
<cfspreadsheet action="read" src="#theFile#" sheetname="courses" name="spreadsheetData"> 
<cfspreadsheet action="read" src="#theFile#" sheet=1 rows="3,4" format="csv" name="csvData"> 
<cfspreadsheet action="read" src="#theFile#" format="html" rows="5-10" name="htmlData"> 
<cfspreadsheet action="read" src="#theFile#" sheetname="centers" query="queryData"> 
 
 	   <cfoutput> <br> theDir : #theDir#</cfoutput><br />
<h3>First sheet row 3 read as a CSV variable</h3> 
<cfdump var="#csvData#"> 
 
<h3>Second sheet rows 5-10 read as an HTML variable</h3> 
<cfdump var="#htmlData#"> 
 
<h3>Second sheet read as a query variable</h3> 
<cfdump var="#queryData#"> 
 
<!--- Modify the courses sheet. ---> 
<cfscript> 
    SpreadsheetAddRow(spreadsheetData,"03,ENGL,230,Poetry 1",8,1); 
    SpreadsheetAddColumn(spreadsheetData, 
    "Basic,Intermediate,Advanced,Basic,Intermediate,Advanced,Basic,Intermediate,Advanced", 
    3,2,true); 
</cfscript> 
 
<!--- Write the updated Courses sheet to a new XLS file  --->
<cfspreadsheet action="write" filename="#theDir#updatedFile.xls" name="spreadsheetData"  
    sheetname="courses" overwrite=true> 
<!--- Write an XLS file containing the data in the CSV variable. --->     
<cfspreadsheet action="write" filename="#theDir#dataFromCSV.xls" name="CSVData"  
    format="csv" sheetname="courses" overwrite=true>



</body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>
</head>

<body>

<!--- Use cfsetting to block output of HTML  
outside cfoutput tags. ---> 
<cfsetting enablecfoutputonly="Yes"> 
 
<!--- Get employee info. ---> 
<cfquery name="GetEmps" datasource="#application.dsn_japsql#">
    SELECT top 10 * FROM cd_iap
</cfquery> 
 
<!--- Set content type. ---> 
<cfcontent type="application/msexcel"> 
 
<!--- Suggest default name for XLS file. ---> 
<!--- "Content-Disposition" in cfheader also ensures  
relatively correct Internet Explorer behavior. ---> 
<cfheader name="Content-Disposition" value="filename=Employees.xls"> 
 
<!--- Format data using cfoutput and a table.  
        Excel converts the table to a spreadsheet. 
        The cfoutput tags around the table tags force output of the HTML when 
        using cfsetting enablecfoutputonly="Yes" ---> 
<cfoutput> 
    <table cols="4"> 
        <cfloop query="GetEmps"> 
            <tr>                 
                <td>#CDIAP_NoIap#</td> 
                <td>#CDIAP_NombreIap#</td> 
            </tr> 
        </cfloop> 
    </table> 
</cfoutput>



</body>
</html>

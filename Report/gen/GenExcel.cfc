<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Reporte de Servicio Social</title>
</head>

<body>

<cfquery name="q1" datasource="#application.dsn_japsql#">
    SELECT 
        ROW_NUMBER() OVER (ORDER BY NOMBRE) AS [No.],
        NOMBRE AS [INSTITUCION EDUCATIVA],
        ACRONIMO AS [ACRONIMO]
    FROM DATAPRES.CF_SSINSTITUCIONESEDUCATIVAS
</cfquery>
<cfset eq1 = "COLUMNA,FILA,NOMBRE,ACRONIMO">
<cfset tq1 = "QUERY 1">

<cfquery name="q2" datasource="#application.dsn_japsql#">
	SELECT 
        ROW_NUMBER() OVER (ORDER BY A.DESCRIPCION) AS [No.],
        A.DESCRIPCION AS [CARRERA],
        B.DESCRIPCION AS [RAMO]
    FROM DATAPRES.CF_SSOFERTAEDUCATIVA A
    INNER JOIN DATAPRES.CF_SSRAMOOFERTAEDUCATIVA B ON A.REFIDRAMO = B.ID
</cfquery>
<cfset eq2 = "COLUMNA,des1,des3">
<cfset tq2 = "QUERY 2">

<!----
<cfinvoke component="CONS_REP.ssdovovi.Consult.spGetReporteSS" method="getSSActual" returnvariable="qGetReporteSS">
    <cfinvokeargument name="consultaAnio" value="2016">
</cfinvoke>
--->

<cfset aquerys = ArrayNew(1)>
 <cfset aquerys[1] = '#q1#'>
  <cfset aquerys[2] = '#q2#'>
  
  
<cfset aSheet = ArrayNew(1)>
 <cfset aSheet[1] = '#eq1#'>
  <cfset aSheet[2] = '#eq2#'>
  
<cfset aTitle = ArrayNew(1)>
 <cfset aTitle[1] = '#tq1#'>
  <cfset aTitle[2] = '#tq2#'>

<cfinvoke component="GenExcel" method="QTXLS" returnvariable="xlsData">
    <cfinvokeargument name="queryArr" value="#aquerys#">
    <cfinvokeargument name="sheetNameArr" value="#aSheet#">
    <cfinvokeargument name="qTitleArr" value="#aTitle#">
</cfinvoke>

</body>
</html>
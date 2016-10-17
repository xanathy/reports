<cfcomponent>
	 <cfscript>
        header = StructNew();
        header.bold = true;
        header.font="Arial";      
        header.fgcolor = "TEAL";
        header.color = "white";
    </cfscript>
    
    <cffunction name="GETQTXLS" access="remote" >    
        <cfargument name="queryArr" required="true" type="array">
        <cfargument name="sheetNameArr" required="false" type="array">
        <cfargument name="qTitleArr" required="false" type="array">
        <cfset tempPath = GetTempDirectory() & CreateUuid() & ".xls">
        <cfset counter = 1>
        
       <cfoutput> aaaa <br></cfoutput>
        <cfset j = 0>
        <cfloop array="#ARGUMENTS.queryArr#" index="i">
            <cfset sheetName = "Sheet#counter#">
             <cfif isDefined("ARGUMENTS.sheetNameArr")>
                <cfset sheetName = ARGUMENTS.sheetNameArr[counter]>
            </cfif>
            <cfset title= "">
             <cfif isDefined("ARGUMENTS.qTitleArr")>
                <cfset title = ARGUMENTS.qTitleArr[counter]>
            </cfif>   
            
			<cfif #counter# EQ 1> <cfscript> header.fgcolor = "royal_blue"; </cfscript> </cfif>            
			<cfif #counter# MOD 2 EQ 0> <cfscript> header.fgcolor = "maroon"; </cfscript> </cfif>            
			<cfif #counter# MOD 3 EQ 0> <cfscript> header.fgcolor = "TEAL"; </cfscript> </cfif>         
			                       
            <cfscript>			
                theSheet = SpreadsheetNew("SourceData1"); 
                SpreadsheetAddRow(theSheet, sheetName);
                SpreadsheetAddRows(theSheet,i); 
                SpreadsheetFormatRow(theSheet,header,1);	    
            </cfscript> 
            <cfspreadsheet action="update" filename="#tempPath#" name="theSheet" sheetName="#title#"> 
           <cfset counter += 1>
        </cfloop>
        <cfreturn SpreadsheetRead(tempPath)>
    </cffunction>

    <cffunction name="QTXLS" access="remote" >
    	<cfargument name="queryArr" required="true" type="array">
        <cfargument name="sheetNameArr" required="false" type="array">
        <cfargument name="qTitleArr" required="false" type="array">
        
        <cfset xlsData = GETQTXLS(#queryArr#,#sheetNameArr#,#qTitleArr#)>
        <cfheader name="content-disposition" value="attachment; filename=aaa.xls">
        <cfcontent type="application/msexcel" variable="#spreadsheetReadBinary(xlsData)#" reset="true">
    </cffunction>
	
</cfcomponent>



<!---
<cfset xlsData = QueriesToXLS(
    [q1,q2],
    ["Details","Summary"],
	[eq1, eq2]
)>

<cfheader name="content-disposition" value="attachment; filename=export.xls">
<cfcontent type="application/msexcel" variable="#spreadsheetReadBinary(xlsData)#" reset="true">

---->
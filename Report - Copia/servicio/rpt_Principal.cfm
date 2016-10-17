<!DOCTYPE html>
<html lang="en">
<head>
  <title>Reportes Servicio Social - Voluntariado - Donativos</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap -->
    <link rel="stylesheet" href="/CONS_REP/ssdovovi/Report/model/bootstrap-3.3.6-dist/css/bootstrap.min.css">	
    <link rel="stylesheet" href="/CONS_REP/ssdovovi/Report/model/custom/dataTables.bootstrap.css">
    <link rel="stylesheet" href="/CONS_REP/ssdovovi/Report/model/custom/custom.css">
    <!--- Datetimepicker--->
    <link rel="stylesheet" href="/CONS_REP/ssdovovi/Report/model/custom/bootstrap-datetimepicker.css">	
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]--> 
    
    <!--- 
    <cfif not isdefined("session.no_user")>
    	<cflocation addtoken="no" url="/logout.cfm">
    </cfif>
	--->
    <cfinclude template="#session.head#"> 
    
</head>
<body>
 <cfoutput>
	<cfset class1=''> <cfset tab1 = ''>
	<cfset class2=''> <cfset tab2 = ''> 
    <cfset class3=''> <cfset tab3 = ''> 
 <cfif isdefined('url.r')>
	 <cfif #url.r# EQ 1> <cfset class1 ='class= "active"'> <cfset tab1 = 'in active'> </cfif>
     <cfif #url.r# EQ 2> <cfset class2 ='class= "active"'> <cfset tab2 = 'in active'> </cfif> 
     <cfif #url.r# EQ 3> <cfset class3 ='class= "active"'> <cfset tab3 = 'in active'> </cfif> 
 <cfelse>
	 <cfset class1 ='class= "active"'> <cfset tab1 = 'in active'>
 </cfif> 
 
 <div class="container">
  <ul class="nav nav-tabs">
 
    <li #class1#><a data-toggle="tab" href="##home">Servicio Social</a></li>
    <li #class2#><a data-toggle="tab" href="##menu1">Voluntariado</a></li>
    <li #class3#><a data-toggle="tab" href="##menu2">Donativos</a></li>

  </ul>

  <div class="tab-content">
    <div id="home" class="tab-pane fade #tab1#">
       <cfinclude template="rpt_PrincipalSS.cfm">
    </div>
            
    <div id="menu1" class="tab-pane fade #tab2#">        
         <cfinclude template="/cons_rep/ssdovovi/report/voluntariado/rpt_PrincipalVol.cfm">
    </div>
    
    <div id="menu2" class="tab-pane fade #tab3#">
         <cfinclude template="/cons_rep/ssdovovi/report/donativos/rpt_PrincipalDona.cfm">    
    </div>
        
  </div>
</div>

</cfoutput>



</body>
</html>


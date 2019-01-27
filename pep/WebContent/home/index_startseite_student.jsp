<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*, data_management.Driver"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Startseite Student</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap CSS-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <!-- Font Awesome CSS-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <!-- Google fonts - Popppins for copy-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,800">
        <!-- orion icons-->
        <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/css/orionicons.css">
        <!-- theme stylesheet-->
        <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/css/style.default.css" id="theme-stylesheet">
        <!-- Custom stylesheet - for your changes-->
        <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/css/custom.css">
       
       <!-- JavaScript files-->
       <script src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/jquery/jquery.min.js"></script>
       <script src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/popper.js/umd/popper.min.js"> </script>
       <script src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/bootstrap/js/bootstrap.min.js"></script>
       <script src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/jquery.cookie/jquery.cookie.js"> </script>
       <script src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/chart.js/Chart.min.js"></script>
       <script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
       <script src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/js/charts-custom.js"></script>
       <script src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/js/front.js"></script>
    </head>

    <body>
        <!-- navbar-->
        <%
			Driver datenhaltung = new Driver();
			String user = datenhaltung.getSessionUser(request.getSession().getAttribute("session_id").toString());
			String rolle = datenhaltung.getSubCat("account", user).get(0).get("rollename_ID");
			HashMap<String, String> html_contents = datenhaltung.getSubCat("account", user).get(0);
			String session_ID = (String)(session.getAttribute("session_id"));
	        String accountname_ID = datenhaltung.getSubCat("sessionmap", session_ID).get(0).get("accountname_ID");
	        ArrayList<HashMap<String, String>> teamname_ID = datenhaltung.getSubCat("teammap", "accountname_ID", accountname_ID, "teamname_ID");
	        ArrayList<HashMap<String, String>> teamRequests = datenhaltung.getSubCat("tempteam", "antragsteller", accountname_ID);
		%>
        <header class="header">
            <nav class="navbar navbar-expand-lg px-4 py-2 bg-white shadow"><a href="#" class="sidebar-toggler text-gray-500 mr-4 mr-lg-5 lead"><i class="fas fa-align-left"></i></a><a href="#" class="navbar-brand font-weight-bold text-uppercase text-base">Planungs- und Entwicklungsprojekt</a>
                <ul class="ml-auto d-flex align-items-center list-unstyled mb-0">
                    <li class="nav-item">
                        <a id="link_logout" class="nav-link text-gray" href="#">Abmelden</a>
                    </li>
                </ul>
            </nav>
        </header>
        <div class="d-flex align-items-stretch">
            <div id="sidebar" class="sidebar py-3">
                <div class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family">Main</div>
                <ul class="sidebar-menu list-unstyled">
                    <li id="link_home" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted active"><i class="o-home-1 mr-3 text-gray"></i><span>Home</span></a></li>
                    <%
                    if(teamname_ID.isEmpty()){
                    	%>
                    	 <li id="link_create_team" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-earth-globe-1 mr-3 text-gray"></i><span>Team erstellen</span></a></li>
                    	<%
                    }
                    %>
                    <li id="link_show_project" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-archive-1 mr-3 text-gray"></i><span>Projekt</span></a></li>
                </ul>
                <div class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family">Meine Daten</div>
                <ul class="sidebar-menu list-unstyled">
                    <li id="link_personal_settings" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-user-1 mr-3 text-gray"></i><span>Mein Account</span></a></li>
                </ul>
            </div>
            <div class="page-holder w-100 d-flex flex-wrap">
                <div class="container-fluid px-xl-5">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">Startseite</h1>
                
				</div>
				<h5>Hallo <%out.print(html_contents.get("vorname"));%> <%out.print(html_contents.get("nachname"));%>,</h5>
				hier alle wichtigen <strong>Abgabefristen</strong> im �berblick:<br>
				Dokumentation: <font color="red"><% out.print(datenhaltung.getSubCat("phase", "phasename_ID", "AbgabeDokument", "endDatum").get(0).get("endDatum")); %></font><br>
				Pr�sentation: <font color="red"><% out.print(datenhaltung.getSubCat("phase", "phasename_ID", "AbgabePraesentation", "endDatum").get(0).get("endDatum")); %></font><br>
				Poster: <font color="red"><% out.print(datenhaltung.getSubCat("phase", "phasename_ID", "AbgabePoster", "endDatum").get(0).get("endDatum")); %></font><br>
				Einseitige Zusammenfassung: <font color="red"><% out.print(datenhaltung.getSubCat("phase", "phasename_ID", "AbgabeZusammenfassung", "endDatum").get(0).get("endDatum")); %></font><br>
				<div class="pt-3 pb-2">
				
				<%
				if(!teamRequests.isEmpty()){
				%>
				<div>
				<label>Laden Sie hier das Anmeldeformular f�r das Projekt herunter und lassen Sie es von allen Teammitgliedern unterschreiben: <a href="/pep/team_list_pdf?<% out.print(user); %>">Anmeldeformular</a></label>
				</div>
				<%
				}
				%>
				
                <%-- <%
                String currentPhase = datenhaltung.getCurrentPhase();
                 if(currentPhase == null){
                	
                }
                else if(currentPhase.equals("Registrierungsphase")){
                	%>
                    <strong>Herlichen Gl�ckwunsch! Sie haben es geschafft sich zu regestrieren!</strong><br>
                    - Wenn Sie der Teamvorsitzende Ihres Teeames sind, dann erstellen Sie unter "Team erstellen" ein neues Team, drucken danach auf dieser Seite das Best�tigungs-Formular aus und lassen es von Ihren Teammitgliedern unterschreiben<br>
                    <%
                }
                else if(currentPhase.equals("Projektanmeldephase")){
                	if(rolle == null){
                		
                	}
                	else if(rolle.equals("Teilnehmer")){
                		%>
                    	<strong>Ihre Aufgaben w�hrend der Anmelde-Phase:</strong><br>
            			- Ihr Teamleiter sollte sich mit einem Formular melden, das Sie unterschreiben m�ssen, um f�r das PEP angemeldet zu werden
                    	<%
                	}
                	else if(rolle.equals("Teamleiter")){
                		%>
                		<strong>Herlichen Gl�ckwunsch! Sie wurden zum Teamleiter gew�hlt!</strong><br>
        				- Drucken Sie unter <strong >"Startseite"</strong> das Formular aus, lassen Sie es von ihren Teammitgliedern unterschreiben und geben Sie es im Pr�fungsamt ab<br>
        				<label class="pt-2">Laden Sie hier das Anmeldeformular f�r das Projekt herunter und lassen Sie es von allen Teammitgliedern unterschreiben: <a href="/pep/team_list_pdf?<% out.print(user); %>">Anmeldeformular</a></label></br>
                		<%
                	}
                }
                else if(currentPhase.equals("Projektbewertungsphase")){
                	%>
                	<strong>In der Bewertungsphase haben Sie die Aufgabe, ihr Projet vorzustellen</strong>
                    <%
                }
                %> --%>
                </div>
                </div>
                <footer class="footer bg-white shadow align-self-end py-3 px-xl-5 w-100">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-6 text-center text-md-left text-primary">
                                <p class="mb-2 mb-md-0">Universit�t Siegen Department Maschinenbau &copy; 2018</p>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>

        <script>   
            //Hier Javascript Code
            document.querySelector('#link_home').addEventListener("click",
				klickLinkHomeEvent);
			function klickLinkHomeEvent() {
				window.open("/pep/home", "_self");
			}
			document.querySelector('#link_logout').addEventListener("click",
					klickLinkLogoutEvent);
			function klickLinkLogoutEvent() {
				window.open("/pep/home/logout", "_self");
			}
			document.querySelector('#link_show_project').addEventListener(
					"click", klickLinkShowAllTeamsEvent);
			function klickLinkShowAllTeamsEvent() {
				window.open("/pep/home/show_project", "_self");
			}
			<%
            if(teamname_ID.isEmpty()){
           	%>
			document.querySelector('#link_create_team').addEventListener("click", klickLinkCreateTeam); 
	        function klickLinkCreateTeam(){
	        	window.open("/pep/home/create_team", "_self");
	        }
	        <%
            }
			%>
			document.querySelector('#link_personal_settings').addEventListener(
					"click", klickLinkPersonalSettingsEvent);
			function klickLinkPersonalSettingsEvent() {
				window.open("/pep/home/view_personal_info", "_self");
			}
        </script>
    </body>
</html>
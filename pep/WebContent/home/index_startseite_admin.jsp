<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*, data_management.Driver"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Startseite Admin</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS-->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<!-- Font Awesome CSS-->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
	integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
	crossorigin="anonymous">
<!-- Google fonts - Popppins for copy-->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,800">
<!-- orion icons-->
<link rel="stylesheet"
	href="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/css/orionicons.css">
<!-- theme stylesheet-->
<link rel="stylesheet"
	href="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/css/style.default.css"
	id="theme-stylesheet">
<!-- Custom stylesheet - for your changes-->
<link rel="stylesheet"
	href="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/css/custom.css">


<!-- Tweaks for older IEs-->
<!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
            <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
</head>

<body>
	<!-- navbar-->
	<header class="header">
		<nav class="navbar navbar-expand-lg px-4 py-2 bg-white shadow">
			<a href="#" class="sidebar-toggler text-gray-500 mr-4 mr-lg-5 lead"><i
				class="fas fa-align-left"></i></a><a href="#"
				class="navbar-brand font-weight-bold text-uppercase text-base">Planungs-
				und Entwicklungsprojekt</a>
			<ul class="ml-auto d-flex align-items-center list-unstyled mb-0">
				<li class="nav-item"><a id="link_logout"
					class="nav-link text-gray" href="#">Abmelden</a></li>
			</ul>
		</nav>
	</header>
	<div class="d-flex align-items-stretch">
		<div id="sidebar" class="sidebar py-3">
			<div
				class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family">Main</div>
			<ul class="sidebar-menu list-unstyled">
				<li id="link_home" class="sidebar-list-item"><a href="#"
					class="sidebar-link text-muted active"><i
						class="o-home-1 mr-3 text-gray"></i><span>Home</span></a></li>
				<li id="link_show_all_groups" class="sidebar-list-item"><a
					href="#" class="sidebar-link text-muted"><i
						class="o-archive-folder-1 mr-3 text-gray"></i><span>Gruppen</span></a></li>
				<li id="link_show_all_teams" class="sidebar-list-item"><a
					href="#" class="sidebar-link text-muted"><i
						class="o-archive-1 mr-3 text-gray"></i><span>Teams</span></a></li>
				<li id="link_show_all_accounts" class="sidebar-list-item"><a
					href="#" class="sidebar-link text-muted"><i
						class="o-profile-1 mr-3 text-gray"></i><span>Accounts</span></a></li>
				<li id="link_show_all_team_requests" class="sidebar-list-item"><a
					href="#" class="sidebar-link text-muted"><i
						class="o-paper-stack-1 mr-3 text-gray"></i><span>Team Anträge</span></a></li>
				<li id="link_project_settings" class="sidebar-list-item"><a
					href="#" class="sidebar-link text-muted"><i
						class="o-imac-screen-1 mr-3 text-gray"></i><span>Projekt
							Settings</span></a></li>
			</ul>
			<div
				class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family">Meine
				Daten</div>
			<ul class="sidebar-menu list-unstyled">
				<li id="link_personal_settings" class="sidebar-list-item"><a
					href="#" class="sidebar-link text-muted"><i
						class="o-user-1 mr-3 text-gray"></i><span>Mein Account</span></a></li>
			</ul>
		</div>
		<div class="page-holder w-100 d-flex flex-wrap">
			<div class="container-fluid px-xl-5">
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="h2">Startseite</h1>
					<%
						Driver datenhaltung = new Driver();
						String user = datenhaltung.getSessionUser(request.getSession().getAttribute("session_id").toString());
						HashMap<String, String> html_contents = datenhaltung.getSubCat("account", user).get(0);
					%>
				</div>
				<h5>Hallo <%out.print(html_contents.get("vorname"));%> <%out.print(html_contents.get("nachname"));%>,</h5>
				
				<!-- Hier aktuelle Phase anzeigen -->
				hier die <strong>Abgabefristen</strong> der Dokumente für die Studenten im Überblick:<br>
				Dokumentation: <font color="red"><% out.print(datenhaltung.getSubCat("phase", "phasename_ID", "AbgabeDokument", "endDatum").get(0).get("endDatum")); %></font><br>
				Präsentation: <font color="red"><% out.print(datenhaltung.getSubCat("phase", "phasename_ID", "AbgabePraesentation", "endDatum").get(0).get("endDatum")); %></font><br>
				Poster: <font color="red"><% out.print(datenhaltung.getSubCat("phase", "phasename_ID", "AbgabePoster", "endDatum").get(0).get("endDatum")); %></font><br>
				Einseitige Zusammenfassung: <font color="red"><% out.print(datenhaltung.getSubCat("phase", "phasename_ID", "AbgabeZusammenfassung", "endDatum").get(0).get("endDatum")); %></font><br>
				
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-5 pb-2 mb-3 border-bottom">
					<h3 class="h3">
						<b>Aufgaben des Administrators:</b>
					</h3>
				</div>
				<div class="pt-1 pb-2">
					<h5>1. Projekt Setup Phase:</h5>
					<p>
						Der Administrator hat noch vor Beginn des Projekts die Aufgabe,
						die Projekt-Einstellungen vorzunehmen (Linke Sidebar unter <strong>"Project
							Settings"</strong>).
					</p>
					- Legen Sie unter <strong>"Allgemein"</strong> die minimale und
					maximale Teilnehmerzahl fest</br> - Legen Sie unter <strong>"Phasen"</strong>
					die Fristen der Phasen fest</br> - Legen Sie unter <strong>"Masterkeys"</strong>
					die Passwörter fest, die für die Erstellung der Juroren und
					Betreuer Accounts erforderlich sind</br> - Legen Sie unter <strong>"Listen"</strong>
					Lehrstühle und Studiengänge an. Aus diesen können die Studenten und
					Betreuern später bei der Registrierung in einem Dropdown Feld
					wählen</br> - Legen Sie unter <strong>"Startbildschirme"</strong> die
					"Home" Screens fest, die den Studenten, Betreuern und Juroren
					später auf der Startseite angezeigt werden. Nutzen Sie diese
					Funktion, um Informationen, wie etwa Termine, bekannt zu geben</br>
				</div>
				<div class="pt-2 pb-2">
					<h5>2. Registrierungs Phase:</h5>
					<p>Während der Regestrierungsphase gibt es für den
						Administrator nichts zu tun.</p>
					-Falls es bei der Registrierung bei Teilnehmern schwierigkeiten
					geben sollte, können Sie unter <strong>"Accounts"</strong> 
					Accounts löschen oder Änderungen vornehmen
				</div>
				<div class="pt-2 pb-2">
					<h5>3. Projekt Anmelde Phase</h5>
					<p>Während der Projekt Anmelde Phase erstellen Sie die Teams
						und weisen ihnen die Accounts zu. Beachten Sie, dass Sie dadurch
						das Projekt des Teams bestätigen.</p>
					- Warten Sie bis der von den Teammitgliedern bestimmte Teamleiter
					sich bei Ihnen mit den Teamdetails meldet </br> - Erstellen Sie unter <strong>"Teams"</strong>
					Teams mit den von den Teamleitern stammenden Teamdetails</br> - Weisen
					Sie den Teamvorsitzenden unter <strong>"Accounts"</strong> die
					Rolle "Teamvorsitzender" zu</br>
				</div>
				<div class="pt-2 pb-2">
					<h5>4. Projekt Erarbeitungs Phase</h5>
					<p>Während der Projekterarbeitungsphase haben Sie so gut wie
						nichts zutun bis auf</p>
					- Spätestens zum Ende sollten Sie unter <strong>"Project
						Settings" -> "Listen"</strong> die Bewertungskriterien festgelegt haben</br>
				</div>
				<div class="pt-2 pb-2">
					<h5>5. Projekt Bewertungs Phase</h5>
					- Zu Beginn der Projekt Bewertungs Phase sollten Sie manuell über
					den Button auf Ihrer Startseite die Bewertung durch die Juroren
					freischalten</br> - Sie können die Bewertungen der Juroren unter <strong>"Teams"</strong>
					anschauen und gegebenenfalls anpassen</br> - Sobald die Bewertungen
					abgeschlossen sind, können Sie über Ihre Startseite eine PDF Datei
					mit einer Liste der jeweils besten Teams und eine PDF Datei mit
					einer Abschlusspräsentation herunterladen</br>
				</div>
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-5 pb-2 mb-3 border-bottom">
					<h3 class="h3">
						<b>Funktionen:</b>
					</h3>
				</div>
				<div>
					<button id="btn_start_valuation_phase" class="btn btn-primary">Bewertungsphase starten</button>
					<button id="btn_stop_valutaion_phase" class="btn btn-primary">Bewertungsphase beenden</button>
				</div>
				<div>
					<label class="pt-3">Laden Sie hier vor der Siegerehrung die
						Liste mit den Bestplazierten herunter: <a href="/pep/best_ranked_pdf">Bestplaziertenliste</a>
					</label></br> 
					<label class="pt-3">Laden Sie hier die Präsentation für
						die Siegerehrung herunter: <a href="/pep/presentation_pdf">Präsentation</a>
					</label></br>
					<label class="pt-3">Laden Sie hier ein komplettes Systembackup herunter 
						(aktuelle Datenbank + Projektdaten): <a href="/pep/provide_system_backup_download">Backup</a>
					</label></br>
					<label class="pt-3">Resetten Sie hier das System und setzen Sie es auf den ursprünglichen Zustand zurück  
						(<font color="red">Achtung: Daten in Datenbank sowie Projektdateien werden entgültig gelöscht</font>): <a href="/pep/handle_db_reset_system">Reset</a>
					</label></br>
				</div>
			</div>
			<footer
				class="footer bg-white shadow align-self-end py-3 px-xl-5 w-100">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-6 text-center text-md-left text-primary">
							<p class="mb-2 mb-md-0">Universität Siegen Department
								Maschinenbau &copy; 2018</p>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>

	<script>
		//Hier Javascript Code
		push_to_db ={};
		
		function post(path, params, method) {
		    method = method || "post"; // Set method to post by default if not specified.

		    // The rest of this code assumes you are not using a library.
		    // It can be made less wordy if you use one.
		    var form = document.createElement("form");
		    form.setAttribute("method", method);
		    form.setAttribute("action", path);

		    for(var key in params) {
		        if(params.hasOwnProperty(key)) {
		            var hiddenField = document.createElement("input");
		            hiddenField.setAttribute("type", "hidden");
		            hiddenField.setAttribute("name", key);
		            hiddenField.setAttribute("value", params[key]);

		            form.appendChild(hiddenField);
		        }
		    }

		    document.body.appendChild(form);
		    form.submit();
		}
		
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
		document.querySelector('#link_show_all_groups').addEventListener(
				"click", klickLinkShowAllGroupsEvent);
		function klickLinkShowAllGroupsEvent() {
			window.open("/pep/home/show_groups", "_self");
		}
		document.querySelector('#link_show_all_teams').addEventListener(
				"click", klickLinkShowAllTeamsEvent);
		function klickLinkShowAllTeamsEvent() {
			window.open("/pep/home/show_teams", "_self");
		}
		document.querySelector('#link_show_all_accounts').addEventListener(
				"click", klickLinkShowAllAccountsEvent);
		function klickLinkShowAllAccountsEvent() {
			window.open("/pep/home/show_accounts", "_self");
		}
		document.querySelector('#link_show_all_team_requests').addEventListener(
				"click", klickLinkShowAllTeamRequestsEvent);
		function klickLinkShowAllTeamRequestsEvent() {
			window.open("/pep/home/show_team_requests", "_self");
		}
		document.querySelector('#link_project_settings').addEventListener(
				"click", klickLinkGeneralSettingsEvent);
		function klickLinkGeneralSettingsEvent() {
			window.open("/pep/home/show_project_settings", "_self");
		}
		document.querySelector('#link_personal_settings').addEventListener(
				"click", klickLinkPersonalSettingsEvent);
		function klickLinkPersonalSettingsEvent() {
			window.open("/pep/home/view_personal_info", "_self");
		}
		document.querySelector('#btn_start_valuation_phase').addEventListener(
				"click", setEvaluationPhaseStart);
		function setEvaluationPhaseStart(){
			var today = new Date();
			var dd = today.getDate();
			var mm = today.getMonth()+1;
			var yyyy = today.getFullYear();
			if(dd  <10){
				dd = "0" + dd;
			}
			if(mm < 10){
				mm = "0" + mm;
			}
			today = yyyy + "-" + mm + "-" + dd;
			push_to_db["startDatum"] = today;
			
			post("/pep/handle_db_write_set_phase", push_to_db);
		}
		document.querySelector('#btn_stop_valutaion_phase').addEventListener(
				"click", setEvaluationPhaseEnd);
		function setEvaluationPhaseEnd(){
			push_to_db ={};
			var today = new Date();
			var dd = today.getDate();
			var mm = today.getMonth()+1;
			var yyyy = today.getFullYear();
			if(dd  <10){
				dd = "0" + dd;
			}
			if(mm < 10){
				mm = "0" + mm;
			}
			today = yyyy + "-" + mm + "-" + dd;
			push_to_db["endDatum"] = today;
			
			post("/pep/handle_db_write_set_phase", push_to_db);
		}
	</script>

	<!-- JavaScript files-->
	<script
		src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/jquery/jquery.min.js"></script>
	<script
		src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/popper.js/umd/popper.min.js">
		
	</script>
	<script
		src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script
		src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/jquery.cookie/jquery.cookie.js">
		
	</script>
	<script
		src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/chart.js/Chart.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
	<script
		src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/js/charts-custom.js"></script>
	<script
		src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/js/front.js"></script>
</body>
</html>
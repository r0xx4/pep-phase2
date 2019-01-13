<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*, data_management.Driver"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Projektansicht</title>
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
        <!-- Tweaks for older IEs--><!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
            <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
    </head>

    <body>
        <!-- navbar-->
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
                    <li id="link_home" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-home-1 mr-3 text-gray"></i><span>Home</span></a></li>
                    <li id="link_show_project" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted active"><i class="o-archive-1 mr-3 text-gray"></i><span>Projekt</span></a></li>
                </ul>
                <div class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family">Meine Daten</div>
                <ul class="sidebar-menu list-unstyled">
                    <li id="link_personal_settings" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-user-1 mr-3 text-gray"></i><span>Mein Account</span></a></li>
                </ul>
            </div>
            <div class="page-holder w-100 d-flex flex-wrap">
                <div class="container-fluid px-xl-5">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">Projekt</h1>
                    </div>
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-2 pb-1 mb-3 border-bottom">
                        <h1 class="h4">Dein Team:</h1>
                    </div>
                    <div>
                    <% 
                    Driver datenhaltung = new Driver();
                    String session_ID = (String)(session.getAttribute("session_id"));
                    String accountname_ID = datenhaltung.getSubCat("sessionmap", session_ID).get(0).get("accountname_ID");
                    ArrayList<HashMap<String, String>> teamname_ID = datenhaltung.getSubCat("teammap", "accountname_ID", accountname_ID, "teamname_ID");
                    if (!teamname_ID.isEmpty())
                    {
                    	ArrayList<HashMap<String, String>> teammitglieder = datenhaltung.getSubCat("teammap", "teamname_ID", teamname_ID.get(0).get("teamname_ID"), "accountname_ID");
                    	int count = 0;
                    	for (HashMap<String, String> teammitglied : teammitglieder)
                    	{ 	
                    		String mail = teammitglied.get("accountname_ID");
                    		String rolle = datenhaltung.getSubCat("account", mail).get(0).get("rollename_ID");
                    		if (!rolle.equals("Tutor"))
                    		{
                        		count++;
                    			HashMap<String, String> accountdata = datenhaltung.getSubCat("account", mail).get(0);
                    			%>
                    			<% out.print(count + ". " + accountdata.get("vorname") + " " + accountdata.get("nachname") + " (" + mail + ")"); %></br>
                    			<%
                    		}
                    	}
                    }
                   	%>
                    </div>
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-1 mb-3 border-bottom">
                        <h1 class="h4">Dateien</h1>
                    </div>
                    <div>
                    	<label>Laden Sie Ihre Projektdateien vor Ablauf der Frist als PDF Datei hier hoch</label>
                    	<div class="form-group row">
                            <div class="col-sm-3"><label>Bericht/Dokumentation</label></div>
                            <div class="col-sm-9">
                                <div class="custom-file">
                                	<form method = "post" action = "/pep/file_upload" enctype=multipart/form-data>
                                		<input type="file" class="custom-file-input" name="Bericht" accept=".pdf" onchange="onFileSelected(this)">     
                                    </form>
                                    <label class="custom-file-label" for="customFile">PDF Datei suchen</label>                                                                                                                                                  
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-3"><label>Projekt Präsentation</label></div>
                            <div class="col-sm-9">
                                <div class="custom-file">
                                	<form method = "post" action = "/pep/file_upload" enctype=multipart/form-data>
                                		<input type="file" class="custom-file-input" name="Praesentation" accept=".pdf" onchange="onFileSelected(this)">     
                                    </form>
                                    <label class="custom-file-label" for="customFile">PDF Datei suchen</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-3"><label>Poster</label></div>
                            <div class="col-sm-9">
                                <div class="custom-file">
                                	<form method = "post" action = "/pep/file_upload" enctype=multipart/form-data>
                                		<input type="file" class="custom-file-input" name="Poster" accept=".pdf" onchange="onFileSelected(this)">     
                                    </form> 
                                    <label class="custom-file-label" for="customFile">PDF Datei suchen</label>
                                </div>
                            </div>
                        </div>
	                    <div class="form-group row">
	                        <div class="col-sm-3"><label>Einseitige Zusammenfassung</label></div>
	                        <div class="col-sm-9">
	                            <div class="custom-file">
	                            	<form method = "post" action = "/pep/file_upload" enctype=multipart/form-data>
                                		<input type="file" class="custom-file-input" name="Zusammenfassung" accept=".pdf" onchange="onFileSelected(this)">     
                                    </form>
	                                <label class="custom-file-label" for="customFile">PDF Datei suchen</label>
	                            </div>
	                        </div>
	                    </div>
                    </div>
                    <!-- Button Ändern -->
                    <div class="float-sm-right btn-toolbar mb-md-0 pt-3 pb-3">
                        <button id="btn_submit" type="button" class="btn font-weight-bold text-light btn-lg btn-primary">Änderungen speichern</button>
                    </div>
                </div>
                <footer class="footer bg-white shadow align-self-end py-3 px-xl-5 w-100">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-6 text-center text-md-left text-primary">
                                <p class="mb-2 mb-md-0">Universität Siegen Department Maschinenbau &copy; 2018</p>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>

        <script>   
            //Hier Javascript Code
            form_list = [];
            
            document.querySelector('#link_home').addEventListener("click", klickLinkHomeEvent); 
	        function klickLinkHomeEvent(){
	        	window.open("/pep/home", "_self");
	        }
	        document.querySelector('#link_logout').addEventListener("click", klickLinkLogoutEvent); 
	        function klickLinkLogoutEvent(){
	            window.open("/pep/home/logout", "_self");
	        }
	        document.querySelector('#link_personal_settings').addEventListener("click", klickLinkPersonalSettingsEvent); 
	        function klickLinkPersonalSettingsEvent(){
	        	window.open("/pep/home/view_personal_info", "_self");
	        }
			document.querySelector('#link_show_project').addEventListener("click",
					klickLinkShowProjectEvent);
			function klickLinkShowProjectEvent() {
	        	window.open("/pep/home/show_project", "_self");
			}
			
			var form = document.createElement("form");
			form.setAttribute("method", "post");
			form.setAttribute("action", "/pep/file_upload");
			form.setAttribute("enctype", "multipart/form-data");
			
			function onFileSelected(element){
				var file = element.files[0];
				element.parentNode.parentNode.lastElementChild.innerHTML = file.name;
				form.appendChild(element);
			}
			
			document.querySelector('#btn_submit').addEventListener("click", sendPostForm);
			function sendPostForm(){
				document.body.appendChild(form);
				form.submit();
			}
			
			
			/*
			function onFileSelected(element) {
				var file = element.files[0];
				element.parentNode.parentNode.lastElementChild.innerHTML = file.name;
				form_list.push(element.parentNode);
				console.log(form_list);
			}
			
			document.querySelector('#btn_submit').addEventListener("click", sendPostForm);
			function sendPostForm(){
				for (var index = 0; index<form_list.length; index++)
				{
					form_list[index].submit();
				}
			}
			*/
			
        </script>
        
        <!-- JavaScript files-->
        <script src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/jquery/jquery.min.js"></script>
        <script src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/popper.js/umd/popper.min.js"> </script>
        <script src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/bootstrap/js/bootstrap.min.js"></script>
        <script src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/jquery.cookie/jquery.cookie.js"> </script>
        <script src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/chart.js/Chart.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
        <script src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/js/charts-custom.js"></script>
        <script src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/js/front.js"></script>
    </body>
</html>
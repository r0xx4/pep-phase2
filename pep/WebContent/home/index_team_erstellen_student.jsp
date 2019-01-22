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
                    <li id="link_create_team" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted active"><i class="o-earth-globe-1 mr-3 text-gray"></i><span>Team erstellen</span></a></li>
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
                        <h1 class="h2">Team erstellen</h1>
       					<%
						Driver datenhaltung = new Driver();
						String user = datenhaltung.getSessionUser(request.getSession().getAttribute("session_id").toString());
						String rolle = datenhaltung.getSubCat("account", user).get(0).get("rollename_ID");
						String session_ID = (String)(session.getAttribute("session_id"));
				        String accountname_ID = datenhaltung.getSubCat("sessionmap", session_ID).get(0).get("accountname_ID");
				        int team_min = Integer.parseInt(datenhaltung.getSubCat("projectconfiguration", "projectconfigurationname_ID", "1", "team_Min").get(0).get("team_Min"));
				        int team_max = Integer.parseInt(datenhaltung.getSubCat("projectconfiguration", "projectconfigurationname_ID", "1", "team_Max").get(0).get("team_Max"));
						ArrayList<HashMap<String, String>> teamname_ID = datenhaltung.getSubCat("teammap", "accountname_ID", accountname_ID, "teamname_ID");
						HashMap<String, String> html_contents = datenhaltung.getSubCat("account", user).get(0);
						%>
					</div>
					<div>
						<div class="form-group">
							<label for="input_team_name">Teamname:</label> 
							<input
							id="input_team_name" 
							value="*wird generiert*" readonly type="text" class="form-control">
						</div>
						<div class="form-group">
	                    	<label for="select_supervisor_1" class="col-form-label">Betreuer 1:</label>
	                       	<select id="select_supervisor_1" class="custom-select form-control">
	                        	<%
	                           		ArrayList<HashMap<String, String>> all_tutors = datenhaltung.getSubCat("account", "rollename_ID", "Tutor", "accountname_ID");
	                               	for (HashMap<String, String> t : all_tutors)
	                               	{
	                                	ArrayList<HashMap<String, String>> lehrstuhl_inhaber = datenhaltung.getSubCat("lehrstuhl", "accountname_ID", t.get("accountname_ID"));
										if(!lehrstuhl_inhaber.isEmpty()){
	                                		%>
	                                		<option><% out.print(t.get("accountname_ID")); %></option>
	                                		<%
										}
	                               	}
	                               	%>
	               			</select>
	                	</div>
	                	<div class="form-group">
	                    	<label for="select_supervisor_2" class="col-form-label">Betreuer 2:</label>
	                        <select id="select_supervisor_2" class="custom-select form-control">
	                        	<%
	                           	for (HashMap<String, String> t : all_tutors)
	                           	{
	                           		%>
	                          		<option><% out.print(t.get("accountname_ID")); %></option>
	                          		<%
	                           	}
	                          	%>
	                    	</select>
	                	</div>
	                	<div class="form-group">
	                       	<label for="input_project_name" class="col-form-label">Projektname:</label>
	                   	  	<input type="text" class="form-control" id="input_project_name">
	               	    </div>
	               	    <%
						for(int i=0; i<team_max-1; i++){ 
						%>
						<div class="form-group">
		                  	<label for="input_teammember<% out.print(i+1); %>_name" class="col-form-label">Teammitglied <% out.print(i+1); %> (Email-Adresse):</label>
		                   	<input type="text" class="form-control" id="input_teammember<% out.print(i+1); %>_name">
		       			</div>
		                <%
						}
		                %>
					</div>
					
	               	<!-- Button Abschicken -->
	               	<div class="float-sm-right btn-toolbar mb-md-0 pt-3 pb-3">
	                 	<button id="btn_submit" type="button" class="btn font-weight-bold text-light btn-lg btn-primary">Teamanfrage abschicken</button>
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
            function post(path, params, method) {
                method = method || "post";
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
			document.querySelector('#link_show_project').addEventListener(
					"click", klickLinkShowAllTeamsEvent);
			function klickLinkShowAllTeamsEvent() {
				window.open("/pep/home/show_project", "_self");
			}
			document.querySelector('#link_create_team').addEventListener("click", klickLinkCreateTeam); 
	        function klickLinkCreateTeam(){
	        	window.open("/pep/home/create_team", "_self");
	        }
			document.querySelector('#link_personal_settings').addEventListener(
					"click", klickLinkPersonalSettingsEvent);
			function klickLinkPersonalSettingsEvent() {
				window.open("/pep/home/view_personal_info", "_self");
			}
			document.querySelector('#btn_submit').addEventListener("click",
				klickBtnSubmitEvent);
			function klickBtnSubmitEvent() {
				var z=0;
				var data = {};
				var team_max = <% out.print(team_max); %>;
				<%
				for(int i=0; i<team_max -1; i++){ 
				%>
				data['teammitglied<% out.print(i+1); %>'] = document.getElementById('input_teammember<% out.print(i+1); %>_name').value;
				if (input_teammember<% out.print(i+1); %>_name.value != ""){
					z++;
				}
				<%
				}
                %>
                if(z >= <% out.print(team_min); %>-1 && z <= <% out.print(team_max); %>-1){
    				data['betreuer1'] = document.getElementById('select_supervisor_1').value;
    				data['betreuer2'] = document.getElementById('select_supervisor_2').value;
    				data['projekttitel'] = document.getElementById('input_project_name').value;
    				
    				var counter = 1;
    				for(var i=0; i<team_max - 1; i++){
    					if(document.getElementById('input_teammember' + (i+1) + '_name').value != ""){
    						data['teammitglied' + counter] = document.getElementById('input_teammember' + (i+1) + '_name').value;
    						counter++;
    					}
    				} 
                	post("/pep/handle_db_write_team_request", data);
                }
                else{
                	window.alert("Die Anzahl der eingetragenen Teammitglieder ist zu niedrig. Ein Team muss mindestens aus " + <% out.print(team_min); %> + " Mitgliedern bestehen!");
                }
                
			}
        </script>
    </body>
</html>
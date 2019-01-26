<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*, data_management.Driver" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Team Anträge</title>
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
                    <li id="link_show_all_groups" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-archive-folder-1 mr-3 text-gray"></i><span>Gruppen</span></a></li>
                    <li id="link_show_all_teams" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-archive-1 mr-3 text-gray"></i><span>Teams</span></a></li>
                    <li id="link_show_all_accounts" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-profile-1 mr-3 text-gray"></i><span>Accounts</span></a></li>
                    <li id="link_show_all_team_requests" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted active"><i class="o-paper-stack-1 mr-3 text-gray"></i><span>Team Anträge</span></a></li>
                    <li id="link_project_settings" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-imac-screen-1 mr-3 text-gray"></i><span>Projekt Settings</span></a></li>
                </ul>
                <div class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family">Meine Daten</div>
                <ul class="sidebar-menu list-unstyled">
                    <li id="link_personal_settings" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-user-1 mr-3 text-gray"></i><span>Mein Account</span></a></li>
                </ul>
            </div>
            <div class="page-holder w-100 d-flex flex-wrap">
                <div class="container-fluid px-xl-5">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">Teamansicht</h1>
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col">Datum</th>
                                    <th scope="col">Antragsteller</th>
                                    <th scope="col">Studenten</th>
                                    <th scope="col">Betreuer1</th>
                                    <th scope="col">Betreuer2</th>
                                    <th scope="col">Gruppe</th>
                                    <th scope="col">Projekt</th>
                                    <th scope="col"></th>
                                    <th scope="col"></th>
                                </tr>
                            </thead>
                            <tbody>
                            	<% 	
                           		Driver datenhaltung = new Driver();
                           		ArrayList<HashMap<String, String>> html_contents = datenhaltung.getSubCat("tempteam");
                           		ArrayList<HashMap<String, String>> tutors = new ArrayList<>();
                           		for (HashMap<String, String> row : html_contents)
                           		{
                           			tutors.add(new HashMap<String, String>());
                           		%>
	                           		<tr>
	                                    <th><% out.print(row.get("datum")); %></th>
	                                    <td><% out.print(row.get("antragsteller")); %></td>
	                                    <% 
	                                    int counter = 0;
	                                    ArrayList<HashMap<String, String>> accountsInTempteam = datenhaltung.getSubCat("tempteammap", "tempteamname_ID", row.get("tempteamname_ID"), "accountname_ID");
	                                    for(HashMap<String, String> account : accountsInTempteam){
                                    		counter++;
	                                    }
	                                   
	                                    %>
	                                    <td><% out.print(counter+1); %></td>
	                                    <%
	                                    String tutor_1 = row.get("betreuer1");
	                                    %> <td><% out.print(tutor_1); %></td> <%
	                                    String tutor_2 = row.get("betreuer2");
	                                    %> <td><% out.print(tutor_2); %></td> <%
	                        			ArrayList<HashMap<String, String>> lehrstuhl_tut_1 = datenhaltung.getSubCat("lehrstuhl", "accountname_ID", tutor_1);
	                                    String lehrstuhlname_ID = lehrstuhl_tut_1.get(0).get("lehrstuhlname_ID");
	                    				String org_einheit_lehrstuhl = lehrstuhl_tut_1.get(0).get("organisationseinheitname_ID");
	                                     
	                                     %>
	                                    <td><% out.print(org_einheit_lehrstuhl); %></td>
	                                    <td><% out.print(row.get("projekttitel")); %></td>
	                                    <td><button id="btn_tempteam_more_<% out.print(tutors.size()); %>" data-toggle="modal" data-target="#modal_more" class="btn btn-sm btn-info text-center col-sm">Mehr</button></td>
                                    	<td><button id="btn_confirm_tempteam_<% out.print(tutors.size()); %>" class="btn btn-sm btn-primary text-center col-sm">Team Bestätigen</button></td>
	                                </tr>
                           			<%
                           		}
                           		%>
                            </tbody>
                        </table>
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

		 <!-- Modal Team mehr -->
        <div class="modal fade" id="modal_more" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Team Info</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group row">
                                <div class="col-sm-4">
                                    <label class="col-form-label"><strong>Anfrage-Datum:</strong></label>
                                </div>
                                <div class="col-sm-8">
                                    <label class="col-form-label" id="lbl_date">-</label>
                                </div>    
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-4">
                                    <label class="col-form-label"><strong>Antragsteller:</strong></label>
                                </div>
                                <div class="col-sm-8">
                                    <label class="col-form-label" id="lbl_team_chairman">-</label>
                                </div>   
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-4">
                                    <label class="col-form-label"><strong>Betreuer 1:</strong></label>
                                </div>
                                <div class="col-sm-8">
                                    <label class="col-form-label" id="lbl_supervisor_1">-</label>
                                </div>   
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-4">
                                    <label class="col-form-label"><strong>Betreuer 2:</strong></label>
                                </div>
                                <div class="col-sm-8">
                                    <label class="col-form-label" id="lbl_supervisor_2">-</label>
                                </div>   
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-4">
                                    <label class="col-form-label"><strong>Gruppe:</strong></label>
                                </div>
                                <div class="col-sm-8">
                                    <label class="col-form-label" id="lbl_group">-</label>
                                </div>   
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-4">
                                    <label class="col-form-label"><strong>Projekt:</strong></label>
                                </div>
                                <div class="col-sm-8">
                                    <label class="col-form-label" id="lbl_project">-</label>
                                </div>   
                            </div>
                            <div class="form-group row">
                                <label class="col-form-label col-sm-4"><strong>Teammitglieder:</strong></label>
                                <div class="col-sm-8">                   
                                    <label class="col-form-label" id="lbl_team_members">-</label></br>
                                </div>   
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                    	<button id="btn_delete_team_request" type="button" class="btn btn-danger">Löschen</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Abbrechen</button>
                    </div>
                </div>
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
            
            
            document.querySelector('#link_home').addEventListener("click", klickLinkHomeEvent); 
            function klickLinkHomeEvent(){
            	window.open("/pep/home", "_self");
            }
            document.querySelector('#link_logout').addEventListener("click", klickLinkLogoutEvent); 
            function klickLinkLogoutEvent(){
                window.open("/pep/home/logout", "_self");
            }
            document.querySelector('#link_show_all_groups').addEventListener("click", klickLinkShowAllGroupsEvent); 
            function klickLinkShowAllGroupsEvent(){
            	window.open("/pep/home/show_groups", "_self");
            }
            document.querySelector('#link_show_all_teams').addEventListener("click", klickLinkShowAllTeamsEvent); 
            function klickLinkShowAllTeamsEvent(){
            	window.open("/pep/home/show_teams", "_self");
            }
            document.querySelector('#link_show_all_accounts').addEventListener("click", klickLinkShowAllAccountsEvent); 
            function klickLinkShowAllAccountsEvent(){
            	window.open("/pep/home/show_accounts", "_self");
            }
            document.querySelector('#link_show_all_team_requests').addEventListener("click", klickLinkShowAllTeamRequestsEvent);
    		function klickLinkShowAllTeamRequestsEvent() {
    			window.open("/pep/home/show_team_requests", "_self");
    		}
            document.querySelector('#link_project_settings').addEventListener("click", klickLinkGeneralSettingsEvent); 
            function klickLinkGeneralSettingsEvent(){
            	window.open("/pep/home/show_project_settings", "_self");
            }
            document.querySelector('#link_personal_settings').addEventListener("click", klickLinkPersonalSettingsEvent); 
            function klickLinkPersonalSettingsEvent(){
            	window.open("/pep/home/view_personal_info", "_self");
            }
            
            var current_html_content;
			
            
            <%
            for (int x = 0; x < html_contents.size(); x++){
             	%>
            	document.querySelector('#btn_confirm_tempteam_<% out.print(x+1); %>').addEventListener("click", function(){
            		var data = {};
            		data['tempteamname_ID'] = current_html_content;
            		post("/pep/handle_db_write_confirm_teams", data);
            	})
            	
            	document.querySelector('#btn_tempteam_more_<% out.print(x+1); %>').addEventListener("click", function(){
            		current_html_content = "<% out.print(html_contents.get(x).get("tempteamname_ID")); %>";
            		document.querySelector('#lbl_date').innerHTML = "<% out.print(html_contents.get(x).get("datum")); %>";
            		document.querySelector('#lbl_team_chairman').innerHTML = "<% out.print(html_contents.get(x).get("antragsteller")); %>";
            		document.querySelector('#lbl_supervisor_1').innerHTML = "<% out.print(html_contents.get(x).get("betreuer1")); %>";
            		document.querySelector('#lbl_supervisor_2').innerHTML = "<% out.print(html_contents.get(x).get("betreuer2")); %>";
            		<%
            		ArrayList<HashMap<String, String>> lehrstuhl_tut_1 = datenhaltung.getSubCat("lehrstuhl", "accountname_ID", html_contents.get(x).get("betreuer1"));
                    String lehrstuhlname_ID = lehrstuhl_tut_1.get(0).get("lehrstuhlname_ID");
    				String org_einheit_lehrstuhl = lehrstuhl_tut_1.get(0).get("organisationseinheitname_ID");
            		%>
            		document.querySelector('#lbl_group').innerHTML = "<% out.print(org_einheit_lehrstuhl); %>";
            		document.querySelector('#lbl_project').innerHTML = "<% out.print(html_contents.get(x).get("projekttitel")); %>";
            		<%
            		ArrayList<HashMap<String, String>> accounts_in_tempteam = datenhaltung.getSubCat("tempteammap", "tempteamname_ID", html_contents.get(x).get("tempteamname_ID"), "accountname_ID");
	                String teammitglieder = "";
	                for(int i=0; i<accounts_in_tempteam.size(); i++){
						teammitglieder = teammitglieder + accounts_in_tempteam.get(i).get("accountname_ID");	
						ArrayList<HashMap<String, String>> teammitglid = datenhaltung.getSubCat("account", "accountname_ID", accounts_in_tempteam.get(i).get("accountname_ID"), "rollename_ID");
						ArrayList<HashMap<String, String>> teammap_hits = datenhaltung.getSubCat("teammap", "accountname_ID", accounts_in_tempteam.get(i).get("accountname_ID"), "teamname_ID");
						
						if(!teammitglid.isEmpty() && teammitglid.get(0).get("rollename_ID").equals("Teilnehmer") && teammap_hits.isEmpty() && !html_contents.get(x).get("antragsteller").equals(accounts_in_tempteam.get(i).get("accountname_ID"))){
							teammitglieder = teammitglieder + " <i class=\\\"far fa-check-circle fa-1x\\\" style=\\\"color:green\\\"></i></br>";
						}
						else if(teammitglid.isEmpty()){
							teammitglieder = teammitglieder + " <i class=\\\"far fa-times-circle\\\" style=\\\"color:red\\\" data-toggle=\\\"tooltip\\\" data-placement=\\\"top\\\" title=\\\"Account existiert nicht\\\"></i></br>";
						}
						else if(!teammitglid.get(0).get("rollename_ID").equals("Teilnehmer")){
							teammitglieder = teammitglieder + " <i class=\\\"far fa-times-circle\\\" style=\\\"color:red\\\" data-toggle=\\\"tooltip\\\" data-placement=\\\"top\\\" title=\\\"Kein Teilnehmer Account\\\"></i></br>";
						}
						else if(!teammap_hits.isEmpty()){
							teammitglieder = teammitglieder + " <i class=\\\"far fa-times-circle\\\" style=\\\"color:red\\\" data-toggle=\\\"tooltip\\\" data-placement=\\\"top\\\" title=\\\"Teilnehmer bereits in anderem Team\\\"></i></br>";
						}
						else if(html_contents.get(x).get("antragsteller").equals(accounts_in_tempteam.get(i).get("accountname_ID"))){
							teammitglieder = teammitglieder + " <i class=\\\"far fa-times-circle\\\" style=\\\"color:red\\\" data-toggle=\\\"tooltip\\\" data-placement=\\\"top\\\" title=\\\"Teilnehmer doppelt\\\"></i></br>";
						}
	                }
	                if(teammitglieder.equals("")){
	                	teammitglieder = "-";
	                }
	                %>
	                document.querySelector('#lbl_team_members').innerHTML = "<% out.print(teammitglieder); %>";
            	})
            <%
           	}
            %>
            
            document.querySelector('#btn_delete_team_request').addEventListener("click", deleteTeamRequest);
            function deleteTeamRequest(){
            	var del = {};
            	del["type"] = "tempteam";
            	del["id"] = current_html_content;
            	post("/pep/delete_entry", del);
			}
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
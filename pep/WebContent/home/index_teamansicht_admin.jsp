<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*, data_management.Driver, java.nio.file.Files,
    java.nio.file.Path, java.nio.file.Paths" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Teamansicht</title>
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
                    <li id="link_show_all_teams" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted active"><i class="o-archive-1 mr-3 text-gray"></i><span>Teams</span></a></li>
                    <li id="link_show_all_accounts" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-profile-1 mr-3 text-gray"></i><span>Accounts</span></a></li>
                    <li id="link_show_all_team_requests" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-paper-stack-1 mr-3 text-gray"></i><span>Team Anträge</span></a></li>
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
                        <div class="btn-toolbar mb-2 mb-md-0">
                            <button id="btn_new_team" data-toggle="modal" data-target="#modal_new_team" class="btn btn-sm btn-outline-secondary">Neues Team</button>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col">Name</th>
                                    <th scope="col">Kennnummer</th>
                                    <th scope="col">Studenten</th>
                                    <th scope="col">Betreuer 1</th>
                                    <th scope="col">Betreuer 2</th>
                                    <th scope="col">Gruppe</th>
                                    <th scope="col">Projekt</th>
                                    <th scope="col"></th>
                                    <th scope="col"></th>
                                    <th scope="col"></th>
                                </tr>
                            </thead>
                            <tbody>
                            	<% 	
                           		Driver datenhaltung = new Driver();
                           		ArrayList<HashMap<String, String>> html_contents = datenhaltung.getSubCat("team");
                           		ArrayList<HashMap<String, String>> tutors = new ArrayList<>();
                           		for (HashMap<String, String> row : html_contents)
                           		{
                           			tutors.add(new HashMap<String, String>());
                           		%>
	                           		<tr>
	                                    <th><% out.print("Team " + row.get("teamnummer")); %></th>
	                                    <td><% out.print(row.get("teamname_ID")); %></td>
	                                    <% 
	                                    int counter = 0;
	                                    ArrayList<HashMap<String, String>> accountsInTeam = datenhaltung.getSubCat("teammap", "teamname_ID", row.get("teamname_ID"), "accountname_ID");
	                                    for(HashMap<String, String> account : accountsInTeam){
	                                    	if(!datenhaltung.getSubCat("account", "accountname_ID", account.get("accountname_ID"), "rollename_ID").get(0).get("rollename_ID").equals("Tutor")){
	                                    		counter++;
	                                    	}
	
	                                    }
	                                   
	                                    %>
	                                    <td> <% out.print(counter); %></td>
	                                    <%
	                                    ArrayList<HashMap<String, String>> accounts_in_team = datenhaltung.getSubCat("teammap", "teamname_ID", row.get("teamname_ID"), "accountname_ID");
	                                    String tutor_1 = null;
	                                    for (HashMap<String, String> account : accounts_in_team)
	                                    {
	                                    	if (datenhaltung.getSubCat("account", "accountname_ID", account.get("accountname_ID"), "rollename_ID").get(0).get("rollename_ID").equals("Tutor"))
	                                    	{
	                                    		tutor_1 = account.get("accountname_ID");
	                                    		tutors.get(tutors.size()-1).put("tutor1", tutor_1);
	                                    		break;
	                                    	}
	                                    }
	                                    %>
	                                    <td><% out.print(tutor_1); %></td>
	                                    <%
	                                    String tutor_2 = null;
	                                    boolean appeared = false;
	                                    for (HashMap<String, String> account : accounts_in_team)
	                                    {
	                                    	if (datenhaltung.getSubCat("account", "accountname_ID", account.get("accountname_ID"), "rollename_ID").get(0).get("rollename_ID").equals("Tutor"))
	                                    	{
	                                    		if (appeared)
	                                    		{
	                                    			tutor_2 = account.get("accountname_ID");
	                                    			tutors.get(tutors.size()-1).put("tutor2", tutor_2);
		                                    		break;
	                                    		}
	                                    		appeared = true;
	                                    	}
	                                    }
	                                    %>
	                                    <td><% out.print(tutor_2); %></td>
	                                    <% 
	                        			ArrayList<HashMap<String, String>> lehrstuhl_tut_1 = datenhaltung.getSubCat("lehrstuhl", "accountname_ID", tutors.get(tutors.size()-1).get("tutor1"), "lehrstuhlname_ID");
	                                    String org_einheit_lehrstuhl = "";
	                                    if(!lehrstuhl_tut_1.isEmpty()){
	                                    	String lehrstuhlname_ID = lehrstuhl_tut_1.get(0).get("lehrstuhlname_ID");
		                    				org_einheit_lehrstuhl = datenhaltung.getSubCat("lehrstuhl", "lehrstuhlname_ID", lehrstuhlname_ID, "organisationseinheitname_ID").get(0).get("organisationseinheitname_ID");
	                                    }
	                                    %>
	                                    <td><% out.print(org_einheit_lehrstuhl); %></td>
	                                    <td><% out.print(row.get("projekttitel")); %></td>
	                                    <td><button id="btn_team_<% out.print(tutors.size()); %>" data-toggle="modal" data-target="#modal_team" class="btn btn-sm btn-outline-info text-center col-sm">Mehr</button></td>
	                                    <td><button id="btn_valuation_<% out.print(tutors.size()); %>" data-toggle="modal" data-target="#modal_valuation" class="btn btn-sm btn-outline-primary text-center col-sm">Bewertung</button></td>
                                    	<td><button id="btn_edit_team_<% out.print(tutors.size()); %>" data-toggle="modal" data-target="#modal_edit_team" class="btn btn-sm btn-outline-secondary text-center col-sm">Bearbeiten</button></td>
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

        <!-- Modal Team hinzufügen -->
        <div class="modal fade" id="modal_new_team" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Team hinzufügen</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="input_team_name" class="col-form-label">Name:</label>
                                <input type="text" class="form-control" readonly id="input_team_name" placeholder="*wird generiert*">
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
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Abbrechen</button>
                        <button id ="btn_create" type="button" class="btn btn-primary">Hinzufügen</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Team bearbeiten -->
        <div class="modal fade" id="modal_edit_team" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Team bearbeiten</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="input_team_name_editmode" class="col-form-label">Name:</label>
                                <input type="text" class="form-control" readonly id="input_team_name_editmode">
                            </div>
                            <div class="form-group">
                                <label for="select_supervisor_1_editmode" class="col-form-label">Betreuer 1:</label>
                                <select id="select_supervisor_1_editmode" class="custom-select form-control">
                                	<%
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
                                <label for="select_supervisor_2_editmode" class="col-form-label">Betreuer 2:</label>
                                <select id="select_supervisor_2_editmode" class="custom-select form-control">
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
                                <label for="input_project_name_editmode" class="col-form-label">Projektname:</label>
                                <input type="text" class="form-control" id="input_project_name_editmode" placeholder="null">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button id="btn_delete_groupe" type="button" class="btn btn-danger">Löschen</button>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Abbrechen</button>
                        <button id = "btn_save" type="button" class="btn btn-primary">Speichern</button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Modal Team Mehr -->
        <div class="modal fade" id="modal_team" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Team Informationen</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group row">
                                <div class="col-sm-4">
                                    <label class="col-form-label"><strong>Name:</strong></label>
                                </div>
                                <div class="col-sm-8">
                                    <label class="col-form-label" id="lbl_team_name">-</label>
                                </div>    
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-4">
                                    <label class="col-form-label"><strong>Kennnummer:</strong></label>
                                </div>
                                <div class="col-sm-8">
                                    <label class="col-form-label" id="lbl_team_id">-</label>
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
                                    <label class="col-form-label"><strong>Projekt:</strong></label>
                                </div>
                                <div class="col-sm-8">
                                    <label class="col-form-label" id="lbl_project">-</label>
                                </div>   
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-4">
                                    <label class="col-form-label"><strong>Teamvorsitzender:</strong></label>
                                </div>
                                <div class="col-sm-8">
                                    <label class="col-form-label" id="lbl_team_chairman">-</label>
                                </div>   
                            </div>                           
                            <div class="form-group row">
                                <label class="col-form-label col-sm-4"><strong>Teammitglieder:</strong></label>
                                <div class="col-sm-8">                   
                                    <label class="col-form-label" id="lbl_team_member">-</label></br>
                                </div>   
                            </div>
                            <div class="form-group row">
                                <label class="col-form-label col-sm-4"><strong>Dokumente:</strong></label>
                                <div class="col-sm-8">
                                    <label><a id="link_download_documentation">Bericht/Dokumentation</a></label></br>
                                    <label><a id="link_download_presentation">Projekt Präsentation</a></label><br>
                                    <label><a id="link_download_poster">Poster</a></label><br>
                                    <label><a id="link_download_summary">Einseitige Zusammenfassung</a></label><br>                                  
                                </div>   
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Ok</button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Modal Team bewerten -->
        <div class="modal fade" id="modal_valuation" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Bewertung</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            	<%
                            	int c_hk = 1;
                            	ArrayList<HashMap<String, String>> hauptkriterien = datenhaltung.getSubCat("hauptkriterium");
	                           	for (HashMap<String, String> hauptkriterium : hauptkriterien)
                             	{
                                	%>
                                	<div class="form-group">
		                                <label><strong><% out.print(hauptkriterium.get("hauptkriteriumname_ID")); %></strong></label>
		                                <% 
		                                int c_tk = 1;
		                                ArrayList<HashMap<String, String>> teilkriterien = datenhaltung.getSubCat("teilkriterium", "hauptkriteriumname_ID", hauptkriterium.get("hauptkriteriumname_ID"));
		                                for (HashMap<String, String> teilkriterium : teilkriterien)
		                                {
		                               		 %>
		                                	<div class="form-group row">
		                                		<div class="col-sm-7">
		                                        	<label class="col-form-label"><% out.print(teilkriterium.get("teilkriteriumname_ID")); %> (<% out.print(teilkriterium.get("skala_Min")); %>/<% out.print(teilkriterium.get("skala_Max")); %>)</label>
		                                    	</div>
		                                    	<div class="col-sm-5 row">
		                                        	<select id="select_valuation_<% out.print(c_hk); %>_<% out.print(c_tk); %>" class="custom-select form-control">
		                                        		<option selected>-</option>
		                                        		<%
		                                        		for(int i = Integer.parseInt(teilkriterium.get("skala_Min")); i <= Integer.parseInt(teilkriterium.get("skala_Max")); i++){
		                                        			%>
		                                        			<option><% out.print(i); %></option>
		                                        			<%
		                                        		}
		                                        		%>
		                                        	</select>
		                                        </div>
		                                	</div>
		                                	<%
		                                	c_tk++;
		                                }
                                	c_hk++;
                                }
                            	%>
                          	</div> 
                          	<div class="form-group">
                                <label><strong>Endnote:</strong></label>
                                <div class="form-group row">
                                    <div class="col-sm-7">
                                        <label class="col-form-label">Note</label>
                                    </div>
                                    <div class="col-sm-5 row">
                                        <input id="input_grade" type="text" class="form-control">
                                    </div>    
                                </div>
                            </div>  
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button id="btn_break" type="button" class="btn btn-secondary" data-dismiss="modal">Abbrechen</button>
                        <button id="btn_save_valuation" type="button" class="btn btn-primary" data-dismiss="modal">Speichern</button>
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
            document.querySelector('#btn_new_team').addEventListener("click", klickBtnNewTeamEvent);
            function klickBtnNewTeamEvent(){
            	
            }
            
            var current_html_content;
               
            <%
            for (int x = 0; x < html_contents.size(); x++){
             	%>
            	document.querySelector('#btn_valuation_<% out.print(x+1); %>').addEventListener("click", function(){
            		current_html_content = "<% out.print(html_contents.get(x).get("teamname_ID")); %>";
            		<%
            		int hk_count = 0;
            		for (HashMap<String, String> hauptkriterium : hauptkriterien){
            			ArrayList<HashMap<String, String>> teilkriterien = datenhaltung.getSubCat("teilkriterium", "hauptkriteriumname_ID", hauptkriterium.get("hauptkriteriumname_ID"));
            			int tk_count = 0;
            			for (HashMap<String, String> teilkriterium : teilkriterien){
            				ArrayList<HashMap<String, String>> kriteriumsmap = datenhaltung.getScoreForCriterion(html_contents.get(x).get("teamname_ID"), teilkriterium.get("teilkriteriumname_ID"));
            				if(kriteriumsmap.isEmpty() == false){
            					%>
            					document.querySelector('#select_valuation_<% out.print(hk_count+1); %>_<% out.print(tk_count+1); %>').value = "<% out.print(kriteriumsmap.get(0).get("punkte")); %>";
            					<%
            				}
            				else{
            					%>
            					document.querySelector('#select_valuation_<% out.print(hk_count+1); %>_<% out.print(tk_count+1); %>').value = "<% out.print("-"); %>";
            					<%
            				}
            				tk_count++;
            			}
            			hk_count++;
            		}
            		String grade = datenhaltung.getSubCat("team", "teamname_ID", html_contents.get(x).get("teamname_ID"), "note").get(0).get("note") + "";
            		if(grade.equals("null")){
            			%>document.querySelector('#input_grade').value = "";<%
            		}
            		else{
            			%>document.querySelector('#input_grade').value = "<% out.print(datenhaltung.getSubCat("team", "teamname_ID", html_contents.get(x).get("teamname_ID"), "note").get(0).get("note")); %>";<%
            		}
            		%>
            	})
            	<%
            }
            
            %>
            
            document.querySelector('#btn_save_valuation').addEventListener("click", sendPostToDb_valuation);
            function sendPostToDb_valuation(){
            	var data = {};
            	data["teamname_ID"] = current_html_content;
            	<%
            	int hk_count = 0;
        		for (HashMap<String, String> hauptkriterium : hauptkriterien){
        			ArrayList<HashMap<String, String>> teilkriterien = datenhaltung.getSubCat("teilkriterium", "hauptkriteriumname_ID", hauptkriterium.get("hauptkriteriumname_ID"));
        			int tk_count = 0;
        			for (HashMap<String, String> teilkriterium : teilkriterien){
        				%>
        				data["<% out.print(teilkriterium.get("teilkriteriumname_ID")); %>"] = document.querySelector('#select_valuation_<% out.print(hk_count+1); %>_<% out.print(tk_count+1); %>').value; 
        				<%
        				tk_count++;
        			}
        			hk_count++;
        		}
            	%>
            	data["note_ID"] = document.querySelector('#input_grade').value;   
            	post("/pep/set_grades", data);
            }
            
    		<%
            for (int x = 1; x <= html_contents.size(); x++)
            {
            	%>
            	document.querySelector('#btn_edit_team_<% out.print(x); %>').addEventListener("click", function()
            	{
            		document.querySelector('#input_team_name_editmode').value = "<% out.print(html_contents.get(x-1).get("teamname_ID")); %>";
                    document.querySelector('#select_supervisor_1_editmode').value = "<% out.print(tutors.get(x-1).get("tutor1")); %>";
                    document.querySelector('#select_supervisor_2_editmode').value = "<% out.print(tutors.get(x-1).get("tutor2")); %>";
                    document.querySelector('#input_project_name_editmode').value = "<% out.print(html_contents.get(x-1).get("projekttitel")); %>";
            	})
            	<%	
            }
            %>
            
            <%
			for (int x = 0; x < html_contents.size(); x++){
				%>
				document.querySelector('#btn_team_<% out.print(x+1); %>').addEventListener("click", function(){
					document.querySelector('#lbl_team_name').innerHTML = "<% out.print("Team " + html_contents.get(x).get("teamnummer")); %>";
	                document.querySelector('#lbl_team_id').innerHTML = "<% out.print(html_contents.get(x).get("teamname_ID")); %>";
	                document.querySelector('#lbl_group').innerHTML = "<% out.print(html_contents.get(x).get("organisationseinheitname_ID")); %>";
	                <%
	                ArrayList<HashMap<String, String>> accounts_in_team = datenhaltung.getSubCat("teammap", "teamname_ID", html_contents.get(x).get("teamname_ID"), "accountname_ID");
                    String tutor_1 = null;
                    for (HashMap<String, String> account : accounts_in_team)
                    {
                    	if (datenhaltung.getSubCat("account", "accountname_ID", account.get("accountname_ID"), "rollename_ID").get(0).get("rollename_ID").equals("Tutor"))
                    	{
                    		tutor_1 = account.get("accountname_ID");
                    		tutors.get(tutors.size()-1).put("tutor1", tutor_1);
                    		break;
                    	}
                    }
	                %>
	                document.querySelector('#lbl_supervisor_1').innerHTML = "<% out.print(tutor_1); %>";
	                <%
	                String tutor_2 = null;
                    boolean appeared = false;
                    for (HashMap<String, String> account : accounts_in_team)
                    {
                    	if (datenhaltung.getSubCat("account", "accountname_ID", account.get("accountname_ID"), "rollename_ID").get(0).get("rollename_ID").equals("Tutor"))
                    	{
                    		if (appeared)
                    		{
                    			tutor_2 = account.get("accountname_ID");
                    			tutors.get(tutors.size()-1).put("tutor2", tutor_2);
                        		break;
                    		}
                    		appeared = true;
                    	}
                    }
	                %>
	                document.querySelector('#lbl_supervisor_2').innerHTML = "<% out.print(tutor_2); %>";
	                document.querySelector('#lbl_project').innerHTML = "<% out.print(html_contents.get(x).get("projekttitel")); %>";
	                <%
	            	String teamleiter = "-";
	                for(int i=0; i<accounts_in_team.size(); i++){
	                	if(datenhaltung.getSubCat("account", "accountname_ID", accounts_in_team.get(i).get("accountname_ID"), "rollename_ID").get(0).get("rollename_ID").equals("Teamleiter" + "")){
							teamleiter = datenhaltung.getSubCat("account", "accountname_ID", accounts_in_team.get(i).get("accountname_ID"), "vorname").get(0).get("vorname") + " " + datenhaltung.getSubCat("account", "accountname_ID", accounts_in_team.get(i).get("accountname_ID"), "nachname").get(0).get("nachname");
						}
	                }
	                %>
	                document.querySelector('#lbl_team_chairman').innerHTML = "<% out.print(teamleiter); %>";
	                <%
	                String teammitglieder = "";
	                for(int i=0; i<accounts_in_team.size(); i++){
	                	if(datenhaltung.getSubCat("account", "accountname_ID", accounts_in_team.get(i).get("accountname_ID"), "rollename_ID").get(0).get("rollename_ID").equals("Teilnehmer" + "")){
							teammitglieder = teammitglieder + datenhaltung.getSubCat("account", "accountname_ID", accounts_in_team.get(i).get("accountname_ID"), "vorname").get(0).get("vorname") + " " + datenhaltung.getSubCat("account", "accountname_ID", accounts_in_team.get(i).get("accountname_ID"), "nachname").get(0).get("nachname") + "</br>";
						}
	                }
	                if(teammitglieder.equals("")){
	                	teammitglieder = "-";
	                }
	                %>
	                document.querySelector('#lbl_team_member').innerHTML = "<% out.print(teammitglieder); %>";
	                
	                <%
                    Path pathBericht = Paths.get("c:/data" + html_contents.get(x).get("projektpfad") + "/Bericht.pdf");
	                if(Files.exists(pathBericht)){
	                %>
	                document.querySelector('#link_download_documentation').href="/pep/provide_project_file_download?filetype=documentation&team=<% out.print(html_contents.get(x).get("teamname_ID")); %>";
	                <%
	                }
                    Path pathPraesentation = Paths.get("c:/data" + html_contents.get(x).get("projektpfad") + "/Praesentation.pdf");
                    if(Files.exists(pathPraesentation)){
	                %>
	                document.querySelector('#link_download_presentation').href="/pep/provide_project_file_download?filetype=presentation&team=<% out.print(html_contents.get(x).get("teamname_ID")); %>";
	                <%
                    }
                    Path pathPoster = Paths.get("c:/data" + html_contents.get(x).get("projektpfad") + "/Poster.pdf");
                    if(Files.exists(pathPoster)){
                    %>
	                document.querySelector('#link_download_poster').href="/pep/provide_project_file_download?filetype=poster&team=<% out.print(html_contents.get(x).get("teamname_ID")); %>";
	                <%
                    }
                    Path pathZusammenfassung = Paths.get("c:/data" + html_contents.get(x).get("projektpfad") + "/Zusammenfassung.pdf");
                    if(Files.exists(pathZusammenfassung)){
                    %>
	                document.querySelector('#link_download_summary').href="/pep/provide_project_file_download?filetype=summary&team=<% out.print(html_contents.get(x).get("teamname_ID")); %>";
	                <%
                    }
                    %>
				})
	            
				<%
       		}
			%>
            
            document.querySelector('#btn_save').addEventListener("click", sendPostToDb_edit);
            function sendPostToDb_edit(){
            	var data = {};
            	data["teamname_ID"] = document.querySelector('#input_team_name_editmode').value;
            	data["projekttitel"] = document.querySelector('#input_project_name_editmode').value;
            	data["betreuer1"] = document.querySelector('#select_supervisor_1_editmode').value;
            	data["betreuer2"] = document.querySelector('#select_supervisor_2_editmode').value;
            	post("/pep/handle_db_write_edit_teams", data);
            }
            
            document.querySelector('#btn_create').addEventListener("click", sendPostToDb_create);
            function sendPostToDb_create(){
            	var data = {};
            	data["projekttitel"] = document.querySelector('#input_project_name').value;
            	data["betreuer1"] = document.querySelector('#select_supervisor_1').value;
            	data["betreuer2"] = document.querySelector('#select_supervisor_2').value;
            	post("/pep/handle_db_write_create_teams", data);
            }
            
            document.querySelector('#btn_delete_groupe').addEventListener("click", deleteAccount);
            function deleteAccount(){
            	var del = {};
            	del["type"] = "team";
            	del["id"] = document.querySelector('#input_team_name_editmode').value;
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
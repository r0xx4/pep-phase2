<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*, data_management.Driver" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Teamansicht Betreuer</title>
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
                    <li id="link_show_teams" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted active"><i class="o-archive-1 mr-3 text-gray"></i><span>Teams</span></a></li>
                </ul>
                <div class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family">Meine Daten</div>
                <ul class="sidebar-menu list-unstyled">
                    <li id="link_personal_settings" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-user-1 mr-3 text-gray"></i><span>Mein Account</span></a></li>
                </ul>
            </div>
            <div class="page-holder w-100 d-flex flex-wrap">
                <div class="container-fluid px-xl-5">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">Ihre Teams:</h1>
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
                                </tr>
                            </thead>
                            <tbody>
                            	<% 	
                           		Driver datenhaltung = new Driver();
                           		
                           		String user=datenhaltung.getSessionUser(request.getSession().getAttribute("session_id").toString());
                           		ArrayList<HashMap<String, String>> html_contents = datenhaltung.getTutorTeams(user);

                           		ArrayList<HashMap<String, String>> criterions = datenhaltung.getSubCat("teilkriterium");
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
	                                    String lehrstuhlname_ID = lehrstuhl_tut_1.get(0).get("lehrstuhlname_ID");
	                    				String org_einheit_lehrstuhl = datenhaltung.getSubCat("lehrstuhl", "lehrstuhlname_ID", lehrstuhlname_ID, "organisationseinheitname_ID").get(0).get("organisationseinheitname_ID");
	                                    %>
	                                    <td><% out.print(org_einheit_lehrstuhl); %></td>
	                                    <td><% out.print(row.get("projekttitel")); %></td>
                                    	<td><button id="btn_team_<% out.print(tutors.size()); %>" data-toggle="modal" data-target="#modal_team" class="btn btn-sm btn-outline-info text-center col-sm">Mehr</button></td>
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
                                    <label><a id="link_download_documentation" href="#">Bericht/Dokumentation</a></label></br>
                                    <label><a id="link_download_presentation" href="#">Projekt Präsentation</a></label><br>
                                    <label><a id="link_download_poster" href="#">Poster</a></label><br>
                                    <label><a id="link_download_summary" href="#">Einseitige Zusammenfassung</a></label><br>                                  
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

        <script>   
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
                document.querySelector('#link_download_documentation').href="/pep/provide_project_file_download?filetype=documentation&team=<% out.print(html_contents.get(x).get("teamname_ID")); %>";
                document.querySelector('#link_download_presentation').href="/pep/provide_project_file_download?filetype=presentation&team=<% out.print(html_contents.get(x).get("teamname_ID")); %>";
                document.querySelector('#link_download_poster').href="/pep/provide_project_file_download?filetype=poster&team=<% out.print(html_contents.get(x).get("teamname_ID")); %>";
                document.querySelector('#link_download_summary').href="/pep/provide_project_file_download?filetype=summary&team=<% out.print(html_contents.get(x).get("teamname_ID")); %>";
			})
            
			<%
   		}
		%>

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
    		document.querySelector('#link_show_teams').addEventListener(
    				"click", klickLinkShowTeamsEvent);
    		function klickLinkShowTeamsEvent() {
    			window.open("/pep/home/show_teams", "_self");
    		}
    		document.querySelector('#link_personal_settings').addEventListener(
    				"click", klickLinkPersonalSettingsEvent);
    		function klickLinkPersonalSettingsEvent() {
    			window.open("/pep/home/view_personal_info", "_self");
    		}
        </script>
    </body>
</html>
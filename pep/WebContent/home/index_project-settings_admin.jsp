<%@page import="java.util.*, data_management.Driver"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Projekt Einstellungen</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- CSS Files -->
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
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://d19m59y37dris4.cloudfront.net/bubbly-dashboard/1-0/vendor/popper.js/umd/popper.min.js"> </script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
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
                    <li id="link_show_all_groups" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-archive-folder-1 mr-3 text-gray"></i><span>Gruppen</span></a></li>
                    <li id="link_show_all_teams" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-archive-1 mr-3 text-gray"></i><span>Teams</span></a></li>
                    <li id="link_show_all_accounts" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-profile-1 mr-3 text-gray"></i><span>Accounts</span></a></li>
                    <li id="link_show_all_team_requests" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-paper-stack-1 mr-3 text-gray"></i><span>Team Anträge</span></a></li>
                    <li id="link_project_settings" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted active"><i class="o-imac-screen-1 mr-3 text-gray"></i><span>Projekt Settings</span></a></li>
                </ul>
                <div class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family">Meine Daten</div>
                <ul class="sidebar-menu list-unstyled">
                    <li id="link_personal_settings" class="sidebar-list-item"><a href="#" class="sidebar-link text-muted"><i class="o-user-1 mr-3 text-gray"></i><span>Mein Account</span></a></li>
                </ul>
            </div>
            <%
            Driver datenhaltung = new Driver();
            %>

            <!-- Haupt Container -->
            <div class="page-holder w-100 d-flex flex-wrap">
                <div class="container-fluid px-xl-5">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">Projekt Einstellungen</h1>
                    </div>

                    <!-- Allgemein -->
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-2 pb-1 mb-3 border-bottom">
                        <h1 class="h4">Allgemein</h1>
                    </div>
                    <div>
                        <label for="range_min_participants">Legen Sie die minimale Teilnehmerzahl pro Team fest</label>
                        <div class="row pb-3">
                            <div class="col-sm-11"><input id="range_min_participants" type="range" class="custom-range" min="0" max="15" step="1"></input></div>
                            <div class="col-sm-1"><label id="lbl_min_participants" for="range_min_participants"></label></div>
                        </div>
                        <label for="range_max_participants">Legen Sie die maximale Teilnehmerzahl pro Team fest</label>
                        <div class="row">
                            <div class="col-sm-11"><input id="range_max_participants" type="range" class="custom-range" min="0" max="15" step="1"></input></div>
                            <div class="col-sm-1"><label id="lbl_max_participants" for="range_max_participants"></label></div>
                        </div> 
                    </div>

                    <!-- Phasen -->
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-1 mb-3 border-bottom">
                        <h1 class="h4">Phasen</h1>
                    </div>
                   	<%
                    ArrayList<HashMap<String, String>> phasen = datenhaltung.getSubCat("phase");
                    %>
                    <div>
                        <label>Tragen Sie Daten ein ab bzw. bis zu denen bestimmte Aktionen verfügbar sein sollen</label>
                        <div class="form-group row">
                            <div class="form-group col-sm-3">
                                <label>Registrierungsphase</label>
                            </div> 
                            <div class="form-group col-sm-4">
                                <label for="input_start_date_registration_phase">Beginn:</label>
                                <input id="input_start_date_registration_phase" type="date" class="form-control">
                            </div> 
                            <div class="form-group col-sm-4">
                                <label for="input_end_date_registration_phase">Ende:</label>
                                <input id="input_end_date_registration_phase" type="date" class="form-control">
                            </div> 
                        </div>  
                        <div class="form-group row">
                            <div class="form-group col-sm-3">
                                <label>Abgabefrist Bericht/Dokumentation</label>
                            </div> 
                            <div class="form-group col-sm-8">
                                <label for="input_deadline_documentation">Ende:</label>
                                <input id="input_deadline_documentation" type="date" class="form-control">
                            </div> 
                        </div>  
                        <div class="form-group row">
                            <div class="form-group col-sm-3">
                                <label>Abgabefrist Projekt Präsentation</label>
                            </div> 
                            <div class="form-group col-sm-8">
                                <label for="input_deadline_presentation">Ende:</label>
                                <input id="input_deadline_presentation" type="date" class="form-control">
                            </div> 
                        </div>  
                        <div class="form-group row">
                            <div class="form-group col-sm-3">
                                <label>Abgabefrist Poster</label>
                            </div> 
                            <div class="form-group col-sm-8">
                                <label for="input_deadline_poster">Ende:</label>
                                <input id="input_deadline_poster" type="date" class="form-control">
                            </div> 
                        </div>  
                        <div class="form-group row">
                            <div class="form-group col-sm-3">
                                <label>Abgabefrist Einseitige Zusammenfassung</label>
                            </div> 
                            <div class="form-group col-sm-8">
                                <label for="input_deadline_summary">Ende:</label>
                                <input id="input_deadline_summary" type="date" class="form-control">
                            </div> 
                        </div>  
                        <!-- 
                        <div class="form-group row">
                            <div class="form-group col-sm-3">
                                <label>Projektanmeldephase</label>
                            </div> 
                            <div class="form-group col-sm-4">
                                <label for="input_start_date_project_registration_phase">Beginn:</label>
                                <input id="input_start_date_project_registration_phase" type="date" class="form-control">
                            </div> 
                            <div class="form-group col-sm-4">
                                <label for="input_end_date_project_registration_phase">Ende:</label>
                                <input id="input_end_date_project_registration_phase" type="date" class="form-control">
                            </div> 
                        </div> 
                        <div class="form-group row">
                            <div class="form-group col-sm-3">
                                <label>Projekterarbeitungsphase</label>
                            </div> 
                            <div class="form-group col-sm-4">
                                <label for="input_start_date_project_phase">Beginn:</label>
                                <input id="input_start_date_project_phase" type="date" class="form-control">
                            </div> 
                            <div class="form-group col-sm-4">
                                <label for="input_end_date_project_phase">Ende:</label>
                                <input id="input_end_date_project_phase" type="date" class="form-control">
                            </div> 
                        </div>    
                        <div class="form-group row">
                            <div class="form-group col-sm-3">
                                <label>Projektbewertungsphase</label>
                            </div> 
                            <div class="form-group col-sm-4">
                                <label for="input_start_date_valuation_phase">Beginn:</label>
                                <input id="input_start_date_valuation_phase" type="date" class="form-control">
                            </div> 
                            <div class="form-group col-sm-4">
                                <label for="input_end_date_valuation_phase">Ende:</label>
                                <input id="input_end_date_valuation_phase" type="date" class="form-control">
                            </div> 
                        </div> 
                        -->                            
                    </div>

                    <!-- Masterkeys -->
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-1 mb-3 border-bottom">
                        <h1 class="h4">Masterkeys</h1>
                    </div>
                    <div>
                        <div class="form-group row">
                            <div class="form-group col-sm-3">
                                <label>Betreuer</label>
                            </div> 
                            <div class="form-group col-sm">
                                <input id="input_masterkey_supervisor" type="text" class="form-control">
                            </div>     
                        </div> 
                        <div class="form-group row">
                            <div class="form-group col-sm-3">
                                <label>Juror</label>
                            </div> 
                            <div class="form-group col-sm">
                                <input id="input_masterkey_juror" type="text" class="form-control">
                            </div>     
                        </div> 
                    </div>

                    <!-- Listen -->
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-1 mb-3 border-bottom">
                        <h1 class="h4">Listen</h1>
                    </div>
                    <div>
                        <label>Vervollständigen Sie die Listen mit den für das Projekt gebrauchten Daten</label>
                        <div class="row pt-2">

                            <!-- Liste Studiengänge -->
                            <div class="col-sm-6">
                                <div class="list-group" id="course_of_studies">
                                    <div class="list-group-item list-group-item-dark">
                                        <div class="row">
                                            <h5 class="col-sm-9">Studiengänge</h5>
                                            <button id="btn_new_course_of_studies" data-toggle="modal" data-target="#modal_new_course_of_studies" class="btn btn-sm btn-outline-dark text-center col-sm"><strong>Neu</strong></button>
                                        </div>     
                                    </div>    
                                    <%
                                    ArrayList<HashMap<String, String>> studiengaenge = datenhaltung.getSubCat("studiengang");
                                   	for(HashMap<String, String> s : studiengaenge){
                                    %>
                                    <div class="list-group-item">
                                        <div class="row">
                                            <label class="col-sm-9"><% out.print(s.get("studiengangname_ID")); %></label>
                                            <button class="btn btn-sm btn-outline-danger text-center col-sm" onclick="deleteCourseOfStudies(this)" >Löschen</button>
                                            <input type="hidden" name="fromDB" value="true">
                                        </div>       
                                    </div>  
                                    <%
                                    }
                                    %>    
                                </div>
                            </div>

                            <!-- Liste Lehrstühle -->
                            <div class="col-sm-6">
                                <div class="list-group" id="university_chair">
                                    <div class="list-group-item list-group-item-dark">
                                        <div class="row">
                                            <h5 class="col-sm-9">Lehrstühle</h5>
                                            <button id="btn_new_university_chair" data-toggle="modal" data-target="#modal_new_university_chair" class="btn btn-sm btn-outline-dark text-center col-sm"><strong>Neu</strong></button>
                                        </div>       
                                    </div>   
                                    <%
                                    ArrayList<HashMap<String, String>> lehrstuehle = datenhaltung.getSubCat("lehrstuhl");
                                    for (HashMap<String, String> lehrstuhl : lehrstuehle){
                                    %>
									<div class="list-group-item">
										<div class="row">
											<label class="col-sm-9"><% out.print(lehrstuhl.get("lehrstuhlname_ID")); %></label>
											<%
											String lehrstuhlinhaber_mail = datenhaltung.getSubCat("lehrstuhl", "lehrstuhlname_ID", lehrstuhl.get("lehrstuhlname_ID"), "accountname_ID").get(0).get("accountname_ID");
											String lehrstuhl_organisationseinheit = datenhaltung.getSubCat("lehrstuhl", "lehrstuhlname_ID", lehrstuhl.get("lehrstuhlname_ID"), "organisationseinheitname_ID").get(0).get("organisationseinheitname_ID");
											%>
											<label class="col-sm-9"><%out.print(lehrstuhl_organisationseinheit); %></label>
											<label class="col-sm-9"><%out.print(lehrstuhlinhaber_mail); %></label>
											<button class="btn btn-sm btn-outline-danger text-center col-sm" onclick="deleteUniversityChair(this)">Löschen</button>
											<input type="hidden" name="fromDB" value="true">
										</div>
									</div> 
									<%
                                    }
									%>                        
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bewertung -->
                    
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-1 mb-3 border-bottom">
                        <h1 class="h4">Bewertung</h1>
                    </div>
                    <div>
                        <div class="row">
                            <div class="col-6">
                                <div class="list-group" id="list-tab" role="tablist">
                                    <div class="list-group-item list-group-item-dark">
                                        <div class="row">
                                            <h5 class="col-sm-9">Hauptkriterien</h5>
                                            <button id="btn_new_main_criterion" data-toggle="modal" data-target="#modal_new_main_criterion" class="btn btn-sm btn-outline-dark text-center col-sm"><strong>Neu</strong></button>
                                        </div>
                                    </div>
                                    <%
                                    ArrayList<HashMap<String, String>> hauptkriterien = datenhaltung.getSubCat("hauptkriterium");
                                    int countMain = 1;
                                    for(HashMap<String, String> hauptkriterium : hauptkriterien){
                                    %>
                                    <div class="list-group-item list-group-item-action" id="list-mainCriterion<% out.print(countMain); %>-list" data-toggle="list" href="#list-mainCriterion<% out.print(countMain); %>" role="tab">
                                        <div class="row">
                                            <a class="col-sm-9"><%out.print(hauptkriterium.get("hauptkriteriumname_ID")); %></a>
                                            <button class="btn btn-sm btn-outline-danger text-center col-sm" 
                                            	onclick="deleteMainCriterion(this, 'list-mainCriterion<% out.print(countMain); %>')">Löschen</button>
                                            <input type="hidden" name="fromDB" value="true">
                                        </div>
                                    </div>
                                    <%
                                    countMain++;
                                    }
                                    countMain = 1;
                                    %>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="tab-content" id="nav-tabContent">
                                <%
                            	for(HashMap<String, String> hauptkriterium : hauptkriterien){
                            	%>
                                    <div class="tab-pane fade" id="list-mainCriterion<% out.print(countMain); %>" role="tabpanel" aria-labelledby="list-mainCriterion<% out.print(countMain); %>-list">
                                        <div class="list-group">
                                        
                                            <div class="list-group-item list-group-item-dark">
                                                <div class="row">
                                                    <h5 class="col-sm-9">Teilkriterien</h5>
                                                    <button id="btn_new_subcriterion_1" data-toggle="modal" data-target="#modal_new_subcriterion" class="btn btn-sm btn-outline-dark text-center col-sm"><strong>Neu</strong></button>
                                                </div>       
                                            </div>           
                                            <%
                                            ArrayList<HashMap<String, String>> teilkriterien = datenhaltung.getSubCat("teilkriterium");
                                            int countSub = 1;
                                            for(HashMap<String, String> teilkriterium : teilkriterien){
                                            	if(teilkriterium.get("hauptkriteriumname_ID").equals(hauptkriterium.get("hauptkriteriumname_ID"))){
                                            %>
                                                    <div class="list-group-item" id='subCriterion<% out.print(countSub + "_" + countMain); %>'>
	                                                    <div class="row">
	                                                        <label class="col-sm-9"><% out.print(teilkriterium.get("teilkriteriumname_ID")); %></label>
	                                                        <button data-toggle="modal" data-target="#modal_edit_subcriterion" class="btn btn-sm btn-outline-info text-center col-sm" onclick="editSubCriterion(this)">Mehr</button>
	                                                        <input type="hidden" name="min" value="<% out.print(teilkriterium.get("skala_Min"));%>">
	                                                        <input type="hidden" name="max" value="<% out.print(teilkriterium.get("skala_Max"));%>">
	                                                        <input type="hidden" name="fromDB" value="true">
	                                                    </div>       
                                                </div> 
                                            <%
                                            	countSub++;
                                            	}
                                            }
                                            %>     
                                        </div>
                                    </div>
		                            <%
		                            countMain++;
		                            }
		                            %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Startbildschirme -->
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-1 mb-3 border-bottom">
                        <h1 class="h4">Startbildschirme</h1>
                    </div>
                    <div>
                        <label>Fügen Sie HTML Dateien hinzu, um die Startseiten der Nutzer zu den unterschiedlichen Phasen zu individualisieren und Infos bekannt zu geben</label>
                        <form>
                            <div class="form-group row pt-3">
                                <div class="col-sm-3"><label for="inputFileStudentRegistrationPhase">Projektteilnehmer - Registrierungsphase</label></div>
                                <div class="col-sm-9">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="input_file_project_participant_registration_phase">
                                        <label class="custom-file-label" for="customFile">HTML Datei suchen</label>
                                    </div>
                                </div>                    
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-3"><label>Projektteilnehmer - Projektanmeldung</label></div>
                                <div class="col-sm-9">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="input_file_project_participant_project_registration_phase">
                                        <label class="custom-file-label" for="customFile">HTML Datei suchen</label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-3"><label>Projektteilnehmer - Projektphase</label></div>
                                <div class="col-sm-9">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="input_file_project_participant_project_phase">
                                        <label class="custom-file-label" for="customFile">HTML Datei suchen</label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-3"><label>Teamvorsitzender - Projektanmeldung</label></div>
                                <div class="col-sm-9">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="input_file_team_chairman_project_registration_phase">
                                        <label class="custom-file-label" for="customFile">HTML Datei suchen</label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-3"><label>Betreuer - Allgemein</label></div>
                                <div class="col-sm-9">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="input_file_supervisor_general">
                                        <label class="custom-file-label" for="customFile">HTML Datei suchen</label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-3"><label>Juror - Allgemein</label></div>
                                <div class="col-sm-9">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="input_file_juror_general">
                                        <label class="custom-file-label" for="customFile">HTML Datei suchen</label>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Button Ändern -->
                    <div class="float-sm-right btn-toolbar mb-md-0 pt-3 pb-3">
                        <button id="btn_submit" type="button" class="btn font-weight-bold text-light btn-lg btn-primary">Änderungen speichern</button>
                    </div>
                </div>

                <!-- Footer -->   
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

        <!-- Modal Studiengang hinzufügen -->
        <div class="modal fade" id="modal_new_course_of_studies" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Studiengang hinzufügen</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="input_name_new_course_of_studies" class="col-form-label">Name Studiengang:</label>
                                <input type="text" class="form-control" id="input_name_new_course_of_studies">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="dismissCourseOfStudies()">Abbrechen</button>
                        <button id="btn_addCourseOfStudies" type="button" class="btn btn-primary" data-dismiss="modal">Hinzufügen</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Lehrstuhl hinzufügen -->
        <div class="modal fade" id="modal_new_university_chair" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Lehrstuhl hinzufügen</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="input_name_new_university_chair" class="col-form-label">Name Lehrstuhl:</label>
                                <input type="text" class="form-control" id="input_name_new_university_chair">
                            </div>
                            <div class="form-group">
	                            <label for="input_name_new_university_chair_unit" class="col-form-label">Organisationseinheit:</label>
	                            <select id="input_name_new_university_chair_unit" class="custom-select form-control">
                               	<%
								ArrayList<HashMap<String, String>> all_units = datenhaltung.getSubCat("organisationseinheit");
                                for (HashMap<String, String> u : all_units)
                                {
									String unit = u.get("organisationseinheitname_ID");
                                    %>
                                    <option><% out.print(unit); %></option>
                                    <%
                                }
                                %>
                                </select>
                                <label for="input_name_new_university_chair_owner" class="col-form-label">Lehrstuhlinhaber:</label>
                                <select id="input_name_new_university_chair_owner" class="custom-select form-control">
									<%
									ArrayList<HashMap<String, String>> all_tutors = datenhaltung.getSubCat("account", "rollename_ID", "Tutor", "accountname_ID");
                                    for (HashMap<String, String> t : all_tutors)
                                    {
                                    	if(datenhaltung.getSubCat("lehrstuhl", "accountname_ID", t.get("accountname_ID"), "lehrstuhlname_ID").isEmpty()){
											String tutor_mail = t.get("accountname_ID");
	                                %>
	                                        <option><% out.print(tutor_mail); %></option>
	                               	<%
                                    	}
                                    }
                                    %>                                    
                               </select>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="dismissUniversityChair()">Abbrechen</button>
                        <button id="btn_addUniversityChair" type="button" class="btn btn-primary" data-dismiss="modal">Hinzufügen</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Hauptkriterium hinzufügen -->
        <div class="modal fade" id="modal_new_main_criterion" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Hauptkriterium hinzufügen</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="input_name_new_main_criterion" class="col-form-label">Name Hauptkriterium:</label>
                                <input type="text" class="form-control" id="input_name_new_main_criterion">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="dismissMainCriterion()">Abbrechen</button>
                        <button id="btn_addMainCriterion"type="button" class="btn btn-primary" data-dismiss="modal">Hinzufügen</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Teilkriterium hinzufügen -->
        <div class="modal fade" id="modal_new_subcriterion" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Teilkriterium hinzufügen</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <input type="hidden" id="add_mainCriterion">
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="input_name_new_subcriterion" class="col-form-label">Name Teilkriterium:</label>
                                <input type="text" class="form-control" id="input_name_new_subcriterion" >
                            </div>
                            <!-- 
                            <div class="form-group">
                                <label for="select_main_criterion" class="col-form-label">Hauptkriterium::</label>
                                <select id="select_main_criterion" class="custom-select form-control">
                                    <option selected>Hauptkriterium</option>
                                    <option>Dokumentaion</option>
                                    <option>Poster</option>
                                    <option>Präsentation</option>
                               </select>
                            </div>
                            -->
                            <div class="form-group">
                                <label for="range_min_valuation_scale" class="col-form-label">Bewertungsskala Minimum</label>
                                <div class="row pb-3">
                                    <div class="col-sm-11"><input id="range_min_valuation_scale" type="range" class="custom-range" value="0" min="0" max="20" step="1"></input></div>
                                    <div class="col-sm-1"><label id="lbl_min_valuation_scale" for="range_min_valuation_scale"></label></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="range_max_valuation_scale" class="col-form-label">Bewertungsskala Maximum</label>
                                <div class="row pb-3">
                                    <div class="col-sm-11"><input id="range_max_valuation_scale" type="range" class="custom-range" value="20" min="0" max="20" step="1"></input></div>
                                    <div class="col-sm-1"><label id="lbl_max_valuation_scale" for="range_max_valuation_scale"></label></div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="dismissSubCriterion()">Abbrechen</button>
                        <button id="btn_addSubCriterion" type="button" class="btn btn-primary" data-dismiss="modal" >Hinzufügen</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Teilkriterium bearbeiten -->
        <div class="modal fade" id="modal_edit_subcriterion" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Teilkriterium bearbeiten</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <input type="hidden" id="subCriterion-Id">
                        <input type="hidden" id="update_mainCriterion">
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="input_name_subcriterion_editmode" class="col-form-label">Name Teilkriterium:</label>
                                <input type="text" class="form-control" id="input_name_subcriterion_editmode" readonly>
                            </div>
                            <!--
                            <div class="form-group">
                                <label for="select_main_criterion_editmode" class="col-form-label">Hauptkriterium::</label>
                                <select id="select_main_criterion_editmode" class="custom-select form-control">
                                    <option selected>Hauptkriterium</option>
                                    <option>Dokumentaion</option>
                                    <option>Poster</option>
                                    <option>Präsentation</option>
                               </select>
                            </div>
                            -->
                            <div class="form-group">
                                <label for="range_min_valuation_scale_editmode" class="col-form-label">Bewertungsskala Minimum</label>
                                <div class="row pb-3">
                                    <div class="col-sm-11"><input id="range_min_valuation_scale_editmode" type="range" class="custom-range" value="0" min="0" max="20" step="1"></input></div>
                                    <div class="col-sm-1"><label id="lbl_min_valuation_scale_editmode" for="range_min_valuation_scale_editmode"></label></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="range_max_valuation_scale_editmode" class="col-form-label">Bewertungsskala Maximum</label>
                                <div class="row pb-3">
                                    <div class="col-sm-11"><input id="range_max_valuation_scale_editmode" type="range" class="custom-range" value="20" min="0" max="20" step="1"></input></div>
                                    <div class="col-sm-1"><label id="lbl_max_valuation_scale_editmode" for="range_max_valuation_scale_editmode"></label></div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button id="btn_delete_subcriterion" type="button" class="btn btn-danger" data-dismiss="modal" onclick="deleteSubCriterion()">Löschen</button>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Abbrechen</button>
                        <button id="btn_save_changes_subcriterion" type="button" class="btn btn-primary" data-dismiss="modal" onclick="saveSubCriterion()">Änderungen speichern</button>
                    </div>
                </div>
            </div>
        </div>

        <script>   
            //Hier Javascript Code

            //Globale Variablen
			var push_to_db = {};
            
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
            
            //Navbar
            document.querySelector('#link_home').addEventListener("click", clickLinkHomeEvent); 
            function clickLinkHomeEvent(){
                //Hier Code für aufrufen von Startseite
                window.open("/pep/home", "_self");
            }
            document.querySelector('#link_logout').addEventListener("click", clickLinkLogoutEvent); 
            function clickLinkLogoutEvent(){
                //Hier Code für Logout Button gedrückt
                window.open("/pep/home/logout", "_self");
            }
            document.querySelector('#link_show_all_groups').addEventListener("click", clickLinkShowAllGroupsEvent); 
            function clickLinkShowAllGroupsEvent(){
                //Hier Code für zeige alle Organisationseinheiten Button gedrückt
                window.open("/pep/home/show_groups", "_self");
            }
            document.querySelector('#link_show_all_teams').addEventListener("click", clickLinkShowAllTeamsEvent); 
            function clickLinkShowAllTeamsEvent(){
                //Hier Code für zeige alle Teams Button gedrückt
                window.open("/pep/home/show_teams", "_self");
            }
            document.querySelector('#link_show_all_accounts').addEventListener("click", clickLinkShowAllAccountsEvent); 
            function clickLinkShowAllAccountsEvent(){
                //Hier Code für zeige alle Accounts Button gedrückt
                window.open("/pep/home/show_accounts", "_self");
            }
            document.querySelector('#link_show_all_team_requests').addEventListener("click", klickLinkShowAllTeamRequestsEvent);
    		function klickLinkShowAllTeamRequestsEvent() {
    			window.open("/pep/home/show_team_requests", "_self");
    		}
            document.querySelector('#link_project_settings').addEventListener("click", clickLinkGeneralSettingsEvent); 
            function clickLinkGeneralSettingsEvent(){
                //Hier Code für zeige Projekt Einstellungen Button gedrückt
                window.open("/pep/home/show_project_settings", "_self");
            }
            document.querySelector('#link_personal_settings').addEventListener("click", klickLinkPersonalSettingsEvent); 
            function klickLinkPersonalSettingsEvent(){
            	window.open("/pep/home/view_personal_info", "_self");
            }

            //Slider Anzahl Teilnehmer
            
            var minSliderParticipents = document.getElementById("range_min_participants");
            var minOutputParticipents = document.getElementById("lbl_min_participants");
            var maxSliderParticipents = document.getElementById("range_max_participants");
            var maxOutputParticipents = document.getElementById("lbl_max_participants");
            minSliderParticipents.value = <% out.print(datenhaltung.getSubCat("projectconfiguration").get(0).get("team_Min")); %>
            maxSliderParticipents.value = <% out.print(datenhaltung.getSubCat("projectconfiguration").get(0).get("team_Max")); %>
            minOutputParticipents.innerHTML = minSliderParticipents.value;
            maxOutputParticipents.innerHTML = maxSliderParticipents.value;
            
            minSliderParticipents.oninput = function() {
                if(parseInt(minSliderParticipents.value) > parseInt(maxSliderParticipents.value)){
                    minSliderParticipents.value = maxSliderParticipents.value;
                }
                minOutputParticipents.innerHTML = minSliderParticipents.value;
            } 

            maxSliderParticipents.oninput = function() {
                if(parseInt(maxSliderParticipents.value) < parseInt(minSliderParticipents.value)){
                    maxSliderParticipents.value = minSliderParticipents.value;
                }
                maxOutputParticipents.innerHTML = maxSliderParticipents.value;
            }    

            //Datum
            
            var inputStartDateRegistrationPhase = document.getElementById("input_start_date_registration_phase");
            inputStartDateRegistrationPhase.value = "<% out.print(datenhaltung.getSubCat("phase", "phasename_ID", "Registrierungsphase", "startDatum").get(0).get("startDatum"));%>"
            
            var inputEndDateRegistrationPhase = document.getElementById("input_end_date_registration_phase");
            inputEndDateRegistrationPhase.value = "<% out.print(datenhaltung.getSubCat("phase", "phasename_ID", "Registrierungsphase", "endDatum").get(0).get("endDatum"));%>"
            
            var inputDeadlineDocumentation = document.getElementById("input_deadline_documentation");
            inputDeadlineDocumentation.value = "<% out.print(datenhaltung.getSubCat("phase", "phasename_ID", "AbgabeDokument", "endDatum").get(0).get("endDatum"));%>"
            
            var inputDeadlinePresentation = document.getElementById("input_deadline_presentation");
            inputDeadlinePresentation.value = "<% out.print(datenhaltung.getSubCat("phase", "phasename_ID", "AbgabePraesentation", "endDatum").get(0).get("endDatum"));%>"
            
            var inputDeadlinePoster = document.getElementById("input_deadline_poster");
            inputDeadlinePoster.value = "<% out.print(datenhaltung.getSubCat("phase", "phasename_ID", "AbgabePoster", "endDatum").get(0).get("endDatum"));%>"
            
            var inputDeadlineSummary = document.getElementById("input_deadline_summary");
            inputDeadlineSummary.value = "<% out.print(datenhaltung.getSubCat("phase", "phasename_ID", "AbgabeZusammenfassung", "endDatum").get(0).get("endDatum"));%>"
            
            /*
            var startDateRegistrationPhase;
            var endDateRegistrationPhase;
            var startDateProjectRegistrationPhase;
            var endDateProjectRegistrationPhase;
            var startDateProjectPhase;
            var endDateProjectPhase;
            var startDateValuationPhase;
            var endDateValuationPhase;
            var dateToday = new Date();
            var dateTomorrow = new Date(dateToday);
            dateTomorrow.setDate(dateToday.getDate()+1);

            inputStartDateRegistrationPhase.oninput = function() {
                var split1 = (inputStartDateRegistrationPhase.value).split("-");
                startDateRegistrationPhase = new Date(split1[0], split1[1] - 1, split1[2]);
                if(startDateRegistrationPhase < dateToday){
                    window.alert("Das Startdatum für die Registrierungsphase kann nicht in der Vergangenheit liegen!");
                    inputStartDateRegistrationPhase.value = (dateTomorrow.getDate() + "." + (dateTomorrow.getMonth()+1) + "." + (dateTomorrow.getFullYear()-30));
                }
            }

            inputEndDateRegistrationPhase.oninput = function() {
                var split2 = (inputEndDateRegistrationPhase.value).split("-");
                endDateRegistrationPhase = new Date(split1[0], split1[1] - 1, split1[2]);
            }

            inputStartDateProjectRegistrationPhase.oninput = function() {
                var split3 = (inputStartDateProjectRegistrationPhase.value).split("-");
                startDateProjectRegistrationPhase = new Date(split1[0], split1[1] - 1, split1[2]);
            }

            inputEndDateProjectRegistrationPhase.oninput = function() {
                var split4 = (inputEndDateProjectRegistrationPhase.value).split("-");
                endDateProjectRegistrationPhase = new Date(split1[0], split1[1] - 1, split1[2]);
            }

            inputStartDateProjectPhase.oninput = function() {
                var split5 = (inputStartDateProjectPhase.value).split("-");
                startDateProjectPhase = new Date(split1[0], split1[1] - 1, split1[2]);
            }

            inputEndDateProjectPhase.oninput = function() {
                var split6 = (inputEndDateProjectPhase.value).split("-");
                endDateProjectPhase = new Date(split1[0], split1[1] - 1, split1[2]);
            }

            inputStartDateValuationPhase.oninput = function() {
                var split7 = (inputStartDateValuationPhase.value).split("-");
                startDateValuationPhase = new Date(split1[0], split1[1] - 1, split1[2]);
            }

            inputEndDateValuationPhase.oninput = function() {
                var split8 = (inputEndDateValuationPhase.value).split("-");
                endDateValuationPhase = new Date(split1[0], split1[1] - 1, split1[2]);
            }
			*/   

            //Modal Neues Bewertungskriterium Slider
            var minSliderValuationScale = document.getElementById("range_min_valuation_scale");
            var minOutputValuationScale = document.getElementById("lbl_min_valuation_scale");
            var maxSliderValuationScale = document.getElementById("range_max_valuation_scale");
            var maxOutputValuationScale = document.getElementById("lbl_max_valuation_scale");
            minOutputValuationScale.innerHTML = minSliderValuationScale.value;
            maxOutputValuationScale.innerHTML = maxSliderValuationScale.value; 
            
            minSliderValuationScale.oninput = function() {
                if(parseInt(minSliderValuationScale.value) > parseInt(maxSliderValuationScale.value)){
                    minSliderValuationScale.value = maxSliderValuationScale.value;
                }
                minOutputValuationScale.innerHTML = minSliderValuationScale.value;
            } 

            maxSliderValuationScale.oninput = function() {
                if(parseInt(maxSliderValuationScale.value) < parseInt(minSliderValuationScale.value)){
                    maxSliderValuationScale.value = minSliderValuationScale.value;
                }
                maxOutputValuationScale.innerHTML = maxSliderValuationScale.value;
            }    

            //Modal Teilkriterium bearbeiten Slider
            var minSliderValuationScaleEditMode = document.getElementById("range_min_valuation_scale_editmode");
            var minOutputValuationScaleEditMode = document.getElementById("lbl_min_valuation_scale_editmode");
            var maxSliderValuationScaleEditMode = document.getElementById("range_max_valuation_scale_editmode");
            var maxOutputValuationScaleEditMode = document.getElementById("lbl_max_valuation_scale_editmode");
            minOutputValuationScaleEditMode.innerHTML = minSliderValuationScaleEditMode.value;
            maxOutputValuationScaleEditMode.innerHTML = maxSliderValuationScaleEditMode.value; 
            
            minSliderValuationScaleEditMode.oninput = function() {
                if(parseInt(minSliderValuationScaleEditMode.value) > parseInt(maxSliderValuationScaleEditMode.value)){
                    minSliderValuationScaleEditMode.value = maxSliderValuationScaleEditMode.value;
                }
                minOutputValuationScaleEditMode.innerHTML = minSliderValuationScaleEditMode.value;
            } 

            maxSliderValuationScaleEditMode.oninput = function() {
                if(parseInt(maxSliderValuationScaleEditMode.value) < parseInt(minSliderValuationScaleEditMode.value)){
                    maxSliderValuationScaleEditMode.value = minSliderValuationScaleEditMode.value;
                }
                maxOutputValuationScaleEditMode.innerHTML = maxSliderValuationScaleEditMode.value;
            }
            document.querySelector('#btn_addCourseOfStudies').addEventListener("click", addToCourseOfStudies);
            function addToCourseOfStudies(){
            	var listItem = document.createElement("div");
            	listItem.className = "list-group-item";
            	var rowItem = document.createElement("div");
            	rowItem.className = "row";
            	var labelItem = document.createElement("label");
            	labelItem.className = "col-sm-9";
            	var buttonItem = document.createElement("button");
            	buttonItem.className = "btn btn-sm btn-outline-danger text-center col-sm";
            	buttonItem.innerHTML = "Löschen";
            	buttonItem.onclick = function(){deleteCourseOfStudies(buttonItem)};
            	var inputItem = document.createElement("input");
            	inputItem.type = "hidden";
            	inputItem.name = "fromDB";
            	inputItem.value = "false";
            	var text = document.getElementById("input_name_new_course_of_studies").value;
            	if(text != "" && text.trim().length != 0 && !elementExists(text, "course_of_studies", "label")){
            		labelItem.innerHTML = text;
	            	rowItem.appendChild(labelItem);
	            	rowItem.appendChild(buttonItem);
	            	rowItem.appendChild(inputItem);
	            	listItem.appendChild(rowItem);
	            	document.getElementById("course_of_studies").appendChild(listItem);
	            	
	            	
	            	
					if("Studiengang_add" in push_to_db){
						push_to_db["Studiengang_add"] += "%" + text;

					}else{
						push_to_db["Studiengang_add"] = text;
					}
            	}
            	document.getElementById("input_name_new_course_of_studies").value = "";
            }
            function deleteCourseOfStudies(elem){
            	if(elem.parentNode.querySelector('input[name="fromDB"]').value == "true"){
					if("Studiengang_del" in push_to_db){
						push_to_db["Studiengang_del"] += "%" + elem.parentNode.children[0].innerHTML;
	
					}else{
						push_to_db["Studiengang_del"] = elem.parentNode.children[0].innerHTML;
					}
            	}else{
            		if("Studiengang_add" in push_to_db){
            			if(push_to_db["Studiengang_add"].includes("%" + elem.parentNode.children[0].innerHTML)){
            				push_to_db["Studiengang_add"] = push_to_db["Studiengang_add"].replace("%" + elem.parentNode.children[0].innerHTML, "")
            			}
            			else if(push_to_db["Sudiengang_add"].includes(elem.parentNode.children[0].innerHTML)){
            				push_to_db["Studiengang_add"] = push_to_db["Studiengang_add"].replace(elem.parentNode.children[0].innerHTML, "")
            			}
            		}
            	}
            	elem.parentNode.parentNode.parentNode.removeChild(elem.parentNode.parentNode);
            }
            function dismissCourseOfStudies(){
            	document.getElementById("input_name_new_course_of_studies").value = "";
            }
            document.querySelector('#btn_addUniversityChair').addEventListener("click", addToUniversityChair);
            function addToUniversityChair(){
            	var listItem = document.createElement("div");
            	listItem.className = "list-group-item";
            	var rowItem = document.createElement("div");
            	rowItem.className = "row";
            	var labelUniversityChair = document.createElement("label");
            	labelUniversityChair.className = "col-sm-9";
            	var labelUnit = document.createElement("label");
            	labelUnit.className = "col-sm-9";
            	var labelOwner = document.createElement("label");
            	labelOwner.className = "col-sm-9";
            	var buttonItem = document.createElement("button");
            	buttonItem.className = "btn btn-sm btn-outline-danger text-center col-sm";
            	buttonItem.innerHTML = "Löschen";
            	buttonItem.onclick = function(){deleteUniversityChair(buttonItem)};
            	var inputItem = document.createElement("input");
            	inputItem.type = "hidden";
            	inputItem.name = "fromDB";
            	inputItem.value = "false";
            	var text = document.getElementById("input_name_new_university_chair").value;
            	var selectedOwner = document.getElementById("input_name_new_university_chair_owner");
            	var owner = selectedOwner.options[selectedOwner.selectedIndex].text;
            	var selectedUnit = document.getElementById("input_name_new_university_chair_unit");
            	var unit = selectedUnit.options[selectedUnit.selectedIndex].text;
            	if(text != "" && text.trim().length != 0 && !elementExists(text, "university_chair", "label")){
            		labelUniversityChair.innerHTML = text;
            		labelUnit.innerHTML = unit;
            		labelOwner.innerHTML = owner;
	            	rowItem.appendChild(labelUniversityChair);
	            	rowItem.appendChild(labelUnit);
	            	rowItem.appendChild(labelOwner);
	            	rowItem.appendChild(buttonItem);
	            	rowItem.appendChild(inputItem);
	            	listItem.appendChild(rowItem);
	            	document.getElementById("university_chair").appendChild(listItem);
	            	
	            	selectedOwner.options[selectedOwner.selectedIndex].remove();
	            	
					if("Lehrstuhl_add" in push_to_db){
						push_to_db["Lehrstuhl_add"] += "%" + text + ":" + owner + ":" + unit;

					}else{
						push_to_db["Lehrstuhl_add"] = text + ":" + owner + ":" + unit;
					}
            	}
            	document.getElementById("input_name_new_university_chair").value = "";
            	document.getElementById("input_name_new_university_chair_owner").selectedIndex = "0";
            }
            function deleteUniversityChair(elem){
            	var unit = elem.parentNode.children[1].innerHTML;
            	var owner = elem.parentNode.children[2].innerHTML;
            	if(elem.parentNode.querySelector('input[name="fromDB"]').value == "true"){
					if("Lehrstuhl_del" in push_to_db){
						push_to_db["Lehrstuhl_del"] += "%" + elem.parentNode.children[0].innerHTML;
	
					}else{
						push_to_db["Lehrstuhl_del"] = elem.parentNode.children[0].innerHTML;
					}
            	}else{
            		if("Lehrstuhl_add" in push_to_db){
            			if(push_to_db["Lehrstuhl_add"].includes("%" + elem.parentNode.children[0].innerHTML + ":" + owner + ":" + unit)){
            				push_to_db["Lehrstuhl_add"] = push_to_db["Lehrstuhl_add"].replace("%" + elem.parentNode.children[0].innerHTML + ":" + owner + ":" + unit, "")
            			}
            			else if(push_to_db["Lehrstuhl_add"].includes(elem.parentNode.children[0].innerHTML + ":" + owner + ":" + unit)){
            				push_to_db["Lehrstuhl_add"] = push_to_db["Lehrstuhl_add"].replace(elem.parentNode.children[0].innerHTML + ":" + owner + ":" + unit, "")
            			}
            		}
            	}
            	
            	elem.parentNode.parentNode.parentNode.removeChild(elem.parentNode.parentNode);
            }
			function dismissUniversityChair(){
            	document.getElementById("input_name_new_university_chair").value = "";
            	document.getElementById("input_name_new_university_chair_owner").selectedIndex = "0";
			}
            document.querySelector('#btn_addMainCriterion').addEventListener("click", addToMainCriterion);
            function addToMainCriterion(){
            	//Hauptkriterium
            	var childs = document.getElementById("list-tab").children.length;
            	var listItem = document.createElement("div");
            	listItem.className = "list-group-item list-group-item-action";
            	listItem.setAttribute("data-toggle", "list");
            	listItem.setAttribute("role", "tab");
            	var rowItem = document.createElement("div");
            	rowItem.className = "row";
            	var aItem = document.createElement("a");
            	aItem.className = "col-sm-9";
            	var buttonItem = document.createElement("button");
            	buttonItem.className = "btn btn-sm btn-outline-danger text-center col-sm";
            	buttonItem.innerHTML = "Löschen";
            	var inputItem = document.createElement("input");
            	inputItem.type = "hidden";
            	inputItem.name = "fromDB";
            	inputItem.value = "false";
            	var text = document.getElementById("input_name_new_main_criterion").value;
            	if(text != "" && text.trim().length != 0 && !elementExists(text, "list-tab", "a")){
            		aItem.innerHTML = text;
            		listItem.id = "list-mainCriterion" + childs + "-list";
            		listItem.setAttribute("href", "#list-mainCriterion" + childs);
	            	rowItem.appendChild(aItem);
	            	rowItem.appendChild(buttonItem);
	            	rowItem.appendChild(inputItem);
	            	listItem.appendChild(rowItem);
	            	document.getElementById("list-tab").appendChild(listItem);
	            	
	            	//Teilkriterium
	            	var subItemList = document.createElement("div");
	            	subItemList.className = "tab-pane fade";
	            	subItemList.id = "list-mainCriterion" + childs;
	            	subItemList.setAttribute("role", "tabpanel");
	            	subItemList.setAttribute("aria-labelledby", listItem.id);
	            	var subGroup = document.createElement("div");
	            	subGroup.className = "list-group";
	            	var subGroupItem = document.createElement("div");
	            	subGroupItem.className = "list-group-item list-group-item-dark";
	            	var subGroupRow = document.createElement("div");
	            	subGroupRow.className = "row";
	            	var subGroupHeader = document.createElement("h5");
	            	subGroupHeader.className = "col-sm-9";
	            	subGroupHeader.innerHTML = "Teilkriterien";
	            	var subGroupButton = document.createElement("button");
	            	subGroupButton.className = "btn btn-sm btn-outline-dark text-center col-sm";
	            	subGroupButton.setAttribute("data-toggle", "modal");
	            	subGroupButton.setAttribute("data-target", "#modal_new_subcriterion");
	            	subGroupButton.innerHTML = "<strong>Neu</strong>";
	            	
	            	subGroupRow.appendChild(subGroupHeader);
	            	subGroupRow.appendChild(subGroupButton);
	            	subGroupItem.appendChild(subGroupRow);
	            	subGroup.appendChild(subGroupItem);
	            	subItemList.appendChild(subGroup);
	            	
	            	document.getElementById("nav-tabContent").appendChild(subItemList);
	            	
	            	buttonItem.onclick = function(){deleteMainCriterion(buttonItem, subItemList.id);}
	            	
					if("Bewertung_add" in push_to_db){
						push_to_db["Bewertung_add"] += "%" + text + ":";

					}else{
						push_to_db["Bewertung_add"] = text + ":";
					}
            	}
            	document.getElementById("input_name_new_main_criterion").value = "";
            	
            }
            function dismissMainCriterion(){
            	document.getElementById("input_name_new_main_criterion").value = "";
            }
            document.querySelector('#btn_addSubCriterion').addEventListener("click", addToSubCriterion);
			function addToSubCriterion(){
				var list = document.getElementById("list-tab").children;
				var selctedCriterion;
				var count = 0;
				for(var i = 0; i < list.length; i++){
					if(list[i].getAttribute("aria-selected") == "true"){
						selectedCriterion = list[i].getAttribute("href").substring(1);
						break;
					}
					count++;
				}
				var childs = document.getElementById(selectedCriterion).children[0].children.length;
            	var listItem = document.createElement("div");
            	listItem.className = "list-group-item";
            	var rowItem = document.createElement("div");
            	rowItem.className = "row";
            	var labelItem = document.createElement("label");
            	labelItem.className = "col-sm-9";
            	var buttonItem = document.createElement("button");
            	buttonItem.className = "btn btn-sm btn-outline-info text-center col-sm";
            	buttonItem.innerHTML = "Mehr";
            	buttonItem.setAttribute("data-toggle", "modal");
            	buttonItem.setAttribute("data-target", "#modal_edit_subcriterion")
            	buttonItem.onclick = function(){editSubCriterion(buttonItem)};
            	var minItem = document.createElement("input");
            	minItem.type = "hidden";
            	minItem.name = "min";
            	minItem.value = document.getElementById("range_min_valuation_scale").value;
            	var maxItem = document.createElement("input");
            	maxItem.type = "hidden";
            	maxItem.name = "max";
            	maxItem.value = document.getElementById("range_max_valuation_scale").value;
            	var inputItem = document.createElement("input");
            	inputItem.type = "hidden";
            	inputItem.name = "fromDB";
            	inputItem.value = "false";
            	var text = document.getElementById("input_name_new_subcriterion").value;
            	if(text != "" && text.trim().length != 0 && !elementExists(text, "nav-tabContent", "label")){
            		labelItem.innerHTML = text;
            		listItem.id = "subCriterion" + childs + "_" + count;
	            	rowItem.appendChild(labelItem);
	            	rowItem.appendChild(buttonItem);
	            	rowItem.appendChild(minItem);
	            	rowItem.appendChild(maxItem);
	            	rowItem.appendChild(inputItem);
	            	listItem.appendChild(rowItem);
	            	document.getElementById(selectedCriterion).children[0].appendChild(listItem);
	            	
					document.getElementById("add_mainCriterion").value = document.getElementById(
							buttonItem.parentNode.parentNode.parentNode.parentNode.id + "-list").children[0].children[0].innerHTML;
					
					if("Bewertung_add" in push_to_db){
						push_to_db["Bewertung_add"] += "%" + document.getElementById("add_mainCriterion").value 
													+ ":"
													+ text
													+ "!"
													+ document.getElementById("range_min_valuation_scale").value
													+ "#"
													+ document.getElementById("range_max_valuation_scale").value;
					}else{
						push_to_db["Bewertung_add"] = document.getElementById("add_mainCriterion").value 
													+ ":"
													+ text
													+ "!"
													+ document.getElementById("range_min_valuation_scale").value
													+ "#"
													+ document.getElementById("range_max_valuation_scale").value;
					}
            	}
				
            	document.getElementById("input_name_new_subcriterion").value = "";
    			document.getElementById("range_min_valuation_scale").value = 0;
				document.getElementById("range_max_valuation_scale").value = 20;
				document.getElementById("lbl_min_valuation_scale").innerHTML = 0;
				document.getElementById("lbl_max_valuation_scale").innerHTML = 20;
			}
			function dismissSubCriterion(){
				document.getElementById("input_name_new_subcriterion").value = "";
				document.getElementById("range_min_valuation_scale").value = 0;
				document.getElementById("range_max_valuation_scale").value = 20;
				document.getElementById("lbl_min_valuation_scale").innerHTML = 0;
				document.getElementById("lbl_max_valuation_scale").innerHTML = 20;
			}
			function deleteMainCriterion(elem, subcriterion){
				if(elem.parentNode.querySelector('input[name="fromDB"]').value == "true"){
					if("Bewertung_del" in push_to_db){
						push_to_db["Bewertung_del"] += "%" + elem.parentNode.children[0].innerHTML + ":";
	
					}else{
						push_to_db["Bewertung_del"] = elem.parentNode.children[0].innerHTML + ":";
					}
				}else{
            		if("Bewertung_add" in push_to_db){
            			if(push_to_db["Bewertung_add"].includes("%")){
            				var split = push_to_db["Bewertung_add"].split("%");
            				push_to_db["Bewertung_add"] = "";
            				for(var i = 0; i < split.length; i++){
            					if(!split[i].includes(elem.parentNode.children[0].innerHTML + ":")){
            						i != split.length-1 ? push_to_db["Bewertung_add"] += split[i] + "%" : push_to_db["Bewertung_add"] += split[i];
            					}
            				}
            			}
            			else if(push_to_db["Bewertung_add"].includes(elem.parentNode.children[0].innerHTML + ":")){
            				push_to_db["Bewertung_add"] = push_to_db["Bewertung_add"].replace(elem.parentNode.children[0].innerHTML + ":", "")
            			}
            		}
            	}
				
				console.log(push_to_db["Bewertung_add"]);
				
				var sub = document.getElementById(subcriterion);
				sub.parentNode.removeChild(sub);
				
				elem.parentNode.parentNode.parentNode.removeChild(elem.parentNode.parentNode);
			}
			function editSubCriterion(button){
				document.getElementById("subCriterion-Id").value = button.parentNode.parentNode.id;
				document.getElementById("update_mainCriterion").value = document.getElementById(
						button.parentNode.parentNode.parentNode.parentNode.id + "-list").children[0].children[0].innerHTML;
				document.getElementById("input_name_subcriterion_editmode").value = button.parentNode.children[0].innerHTML;
				document.getElementById("range_min_valuation_scale_editmode").value = button.parentNode.querySelector("input[name='min']").value;
				document.getElementById("lbl_min_valuation_scale_editmode").innerHTML = button.parentNode.querySelector("input[name='min']").value;
				document.getElementById("range_max_valuation_scale_editmode").value = button.parentNode.querySelector("input[name='max']").value;
				document.getElementById("lbl_max_valuation_scale_editmode").innerHTML = button.parentNode.querySelector("input[name='max']").value;
				
			}
			function deleteSubCriterion(){
				var elem = document.getElementById(document.getElementById("subCriterion-Id").value);
				var mainCriterion = document.getElementById("update_mainCriterion").value;
				var subCriterion = document.getElementById("input_name_subcriterion_editmode").value;
				var minValue = document.getElementById("range_min_valuation_scale").value;
				var maxValue = document.getElementById("range_max_valuation_scale").value;
				
				if(elem.parentNode.parentNode.querySelector('input[name="fromDB"]').value == "true"){
					if("Bewertung_del" in push_to_db){
						push_to_db["Bewertung_del"] += "%" + document.getElementById("update_mainCriterion").value 
														+ ":"
														+ document.getElementById("input_name_subcriterion_editmode").value;
					}else{
						push_to_db["Bewertung_del"] = document.getElementById("update_mainCriterion").value 
														+ ":"
														+ document.getElementById("input_name_subcriterion_editmode").value;
					}
				}else{
					if(push_to_db["Bewertung_add"].includes("%" + mainCriterion + ":" + subCriterion + "!" + minValue + "#" + maxValue)){
						push_to_db["Bewertung_add"] = push_to_db["Bewertung_add"].replace("%" + mainCriterion + ":" + subCriterion + "!" + minValue + "#" + maxValue, "");
					}
					else if(push_to_db["Bewertung_add"].includes(mainCriterion + ":" + subCriterion + "!" + minValue + "#" + maxValue)){
						push_to_db["Bewertung_add"] = push_to_db["Bewertung_add"].replace(mainCriterion + ":" + subCriterion + "!" + minValue + "#" + maxValue, "");
					}
				}
				console.log(push_to_db["Bewertung_add"]);
				elem.parentNode.removeChild(elem);
			}
			function saveSubCriterion(){
				var elem = document.getElementById(document.getElementById("subCriterion-Id").value);
				elem.children[0].children[0].innerHTML = document.getElementById("input_name_subcriterion_editmode").value;
				elem.children[0].querySelector("input[name='min']").value = document.getElementById("range_min_valuation_scale_editmode").value;
				elem.children[0].querySelector("input[name='min']").value = document.getElementById("lbl_min_valuation_scale_editmode").innerHTML;
				elem.children[0].querySelector("input[name='max']").value = document.getElementById("range_max_valuation_scale_editmode").value;
				elem.children[0].querySelector("input[name='max']").value = document.getElementById("lbl_max_valuation_scale_editmode").innerHTML;
				
				if("Bewertung_update" in push_to_db){
					push_to_db["Bewertung_update"] += "%" + document.getElementById("update_mainCriterion").value 
													+ ":"
													+ document.getElementById("input_name_subcriterion_editmode").value
													+ "!"
													+ document.getElementById("range_min_valuation_scale_editmode").value
													+ "#"
													+ document.getElementById("range_max_valuation_scale_editmode").value;
				}else{
					push_to_db["Bewertung_update"] = document.getElementById("update_mainCriterion").value 
													+ ":"
													+ document.getElementById("input_name_subcriterion_editmode").value
													+ "!"
													+ document.getElementById("range_min_valuation_scale_editmode").value
													+ "#"
													+ document.getElementById("range_max_valuation_scale_editmode").value;
				}
			}
			document.querySelector('#btn_submit').addEventListener("click", applySettings);
			function applySettings(){
				push_to_db["Teilnehmer"] = document.getElementById("range_min_participants").value + "#" + document.getElementById("range_max_participants").value;
				push_to_db["Masterkey_tutor"] = document.getElementById("input_masterkey_supervisor").value;
				push_to_db["Masterkey_juror"] = document.getElementById("input_masterkey_juror").value;
				push_to_db["Registrierung"] = document.getElementById("input_start_date_registration_phase").value
												+ "#"
												+ document.getElementById("input_end_date_registration_phase").value;
				push_to_db["AbgabePoster"] = document.getElementById("input_deadline_poster").value;
				push_to_db["AbgabePraesentation"] = document.getElementById("input_deadline_presentation").value;
				push_to_db["AbgabeZusammenfassung"] = document.getElementById("input_deadline_summary").value;
				push_to_db["AbgabeDokument"] = document.getElementById("input_deadline_documentation").value;
				console.log(push_to_db);
				post("/pep/handle_db_write_project_settings", push_to_db);
			}
			function elementExists(text, id, element){
				var elements = document.getElementById(id).getElementsByTagName(element);
				console.log(elements);
				for(var i = 0; i < elements.length; i++){
					if(elements[i].innerHTML == text){
						return true;
					}
				}
				return false;
			}
        </script>
    </body>
</html>
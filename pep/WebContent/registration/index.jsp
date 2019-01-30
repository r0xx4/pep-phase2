<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*, data_management.Driver"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="ISO-8859-1">
       <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Registrierung">
        <meta name="author" content="Gruppe6">
        
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <!--
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        -->

        <title>Registrierung</title>

        <style>
            /* Hier CSS Code */
            html,
            body {
                height: 100%;
            }

            body {
                display: -ms-flexbox;
                display: flex;
                -ms-flex-align: center;
                align-items: center;
                padding-top: 40px;
                padding-bottom: 40px;
                background-color: #f5f5f5;
            }

            .form-register {
                width: 100%;
                max-width: 400px;
                padding: 15px;
                margin: auto;
            }

             .form-register .form-control {
                position: relative;
                box-sizing: border-box;
                height: auto;
                padding: 10px;
                font-size: 16px;
            }

            .form-register .form-control:focus {
                z-index: 2;
            }

            .form-register input[type="masterkey"] {
                margin-bottom: 10px;
                border-top-left-radius: 0;
                border-top-right-radius: 0;
            }

            .form-register button[id="btnRegister"] {
                margin-bottom: 10px;
                border-top-left-radius: 0;
                border-top-right-radius: 0;
            }

            .form-register button[id="btnLogIn"] {
                margin-top: 10px;
                border-top-left-radius: 0;
                border-top-right-radius: 0;
                background-color: rgba(59, 57, 57, 0.123);
                color: black;
            }
        </style>
    </head>

    <body class="text-center">
        <form class="form-register">
            <h1 id="lblHeadline" class="h3 mb-3 font-weight-normal">Bitte geben Sie ihre persönlichen Daten an</h1>
            <select id="inputRole" type="Role" class="custom-select">
                <option selected>Registrieren als</option>
                <%
                Driver datenhaltung = new Driver();
                ArrayList<HashMap<String, String>> rollen = datenhaltung.getSubCat("rolle");
                for (HashMap<String, String> rolle : rollen)
                {
                	if (!(rolle.get("rollename_ID")).equals("Admin")) 
                	{
                		if (!(rolle.get("rollename_ID")).equals("Teamleiter"))
                		{
                			%>
                    		<option><% out.print(rolle.get("rollename_ID")); %></option>
                    		<%
                		}
                	}
                }
                %>
            </select>
            <input id="inputFirstName" type="firstName" class="form-control" placeholder="Vorname">
            <input id="inputLastName" type="lastName" class="form-control" placeholder="Nachname">
            <input id="inputMatriculationNumber" type="matriculationNumber" class="form-control" placeholder="Matrikelnummer">
            <select id="inputCourseOfStudies" type="courseOfStudies" class="custom-select">
                <option selected>Studiengang</option>
                <%
                ArrayList<HashMap<String, String>> studiengaenge = datenhaltung.getSubCat("studiengang");
                for (HashMap<String, String> studiengang : studiengaenge)
				{
					%>
                    <option><% out.print(studiengang.get("studiengangname_ID")); %></option>
                    <%
                }
                %>
            </select>

            
            <input id="inputEmail" type="email" class="form-control" placeholder="E-Mail-Adresse">
            <input id="inputPassword" type="password" class="form-control" placeholder="Passwort">
            <input id="inputPasswordRepeat" type="password" class="form-control" placeholder="Passwort Wiederholung">
            <input id="inputMasterkey" type="password" class="form-control" placeholder="Masterkey (Nur für Betreuer und Juroren)">
            <button id="btnRegister" class="btn btn-lg btn-primary btn-block" type="button">Registrieren</button>
            <h5>oder</h5>
            <button id="btnLogIn" class="btn btn-lg btn-primary btn-block" type="button">Anmelden</button>
        </form>

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
            
            var role;
            var firstName;
            var lastName;
            var matriculationNumber;
            var courseOfStudies;
            var universityChair;
            var email;
            var password;
            var passwordRepeat;
            var masterkey;

            document.getElementById("inputMasterkey").disabled=true;
			document.getElementById("inputMatriculationNumber").disabled=true;
            document.getElementById("inputCourseOfStudies").disabled=true;
            
            document.querySelector('#inputRole').addEventListener("change", inputRoleOninputEvent); 
            function inputRoleOninputEvent(){
                if(document.querySelector("#inputRole").value == "Registrieren als"){
                    document.getElementById("inputMasterkey").disabled=true;
                    document.getElementById("inputMatriculationNumber").disabled=false;
                    document.getElementById("inputCourseOfStudies").disabled=false;
                }
                if(document.querySelector("#inputRole").value == "Teilnehmer"){
                    document.getElementById("inputMasterkey").disabled=true;
					document.getElementById("inputMatriculationNumber").disabled=false;
                    document.getElementById("inputCourseOfStudies").disabled=false;
                }
                if(document.querySelector("#inputRole").value == "Tutor"){
                    document.getElementById("inputMasterkey").disabled=false;
                    document.getElementById("inputMatriculationNumber").disabled=true;
                    document.getElementById("inputCourseOfStudies").disabled=true;
                }
                if(document.querySelector("#inputRole").value == "Juror"){
                    document.getElementById("inputMasterkey").disabled=false;
					document.getElementById("inputMatriculationNumber").disabled=true;
                    document.getElementById("inputCourseOfStudies").disabled=true;
                }
            }
			<%
			if(datenhaltung.checkForCurrentPhase("Registrierungsphase")){
			%>
            document.querySelector('#btnRegister').addEventListener('click', btnRegisterEvent);  
            function btnRegisterEvent(){
                //Hier Code für Btn-Registrieren gedrückt
                universityChair = "";
                matriculationNumber = "";
                courseOfStudies = "";
                masterkey = "";
                role = document.querySelector("#inputRole").value;
                firstName = document.querySelector("#inputFirstName").value;
                lastName = document.querySelector("#inputLastName").value;
                if (role == "Teilnehmer") matriculationNumber = document.querySelector("#inputMatriculationNumber").value;
                if (role == "Teilnehmer") courseOfStudies = document.querySelector("#inputCourseOfStudies").value;
                email = document.querySelector("#inputEmail").value;
                password = document.querySelector("#inputPassword").value;
                passwordRepeat = document.querySelector("#inputPasswordRepeat").value;
                if (role == "Tutor" || role == "Juror") masterkey = document.querySelector("#inputMasterkey").value;
                
                if (passwordRepeat != password)
                	window.alert("Passwörter unterscheiden sich!");
                else if (role == "Registrieren als")
                	window.alert("Bitte Rolle angeben!");
                else if (firstName == "")
                	window.alert("Bitte Vorname angeben!");
                else if (lastName == "")
                	window.alert("Bitte Nachname angeben!");
                else if (role == "Teilnehmer" && matriculationNumber == "")
                	window.alert("Bitte Matrikelnummer angeben!");
                else if (role == "Teilnehmer" && courseOfStudies == "Studiengang")
                	window.alert("Bitte Studiengang angeben!");
                else if (email == "")
                	window.alert("Bitte E-Mail angeben!");
                else if (password == "")
                	window.alert("Bitte Passwort angeben!");
                else if (passwordRepeat == "")
                	window.alert("Bitte Passwort wiederholen!");
                else if ((role == "Tutor" || role == "Juror") && masterkey == "")
                	window.alert("Bitte passenden Masterkey angeben!");
                else
                	var registration_map = {};
                	registration_map["vorname"] = firstName;
                	registration_map["nachname"] = lastName;
                	registration_map["accountname_ID"] = email;
                	registration_map["password"] = password;
                	registration_map["rollename_ID"] = role;
                	registration_map["studiengangname_ID"] = courseOfStudies;
                	registration_map["matrikelnummer"] = matriculationNumber;
                	registration_map["masterkey"] = masterkey;
                	post("/pep/registration/transfer_account_data", registration_map);
            }  
            <%
			}
			else{
			%>
            document.querySelector('#btnRegister').addEventListener('click', btnRegisterEvent);  
            function btnRegisterEvent(){
                alert("Registrierungsphase abgelaufen!");
            } 
            <%
			}
			%>
            document.querySelector('#btnLogIn').addEventListener('click', btnLogInEvent);  
            function btnLogInEvent(){
                //Hier Code für Btn-Anmelden gedrückt 
                window.open("/pep/login", "_self");
            }    
        </script>
       
        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <!--
        <script src="js/bootstrap.bundle.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>
        -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>
package handle_post_requests;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data_management.Driver;

/**
 * Servlet implementation class HandleDBWriteConfirmTeams
 */
@WebServlet("/handle_db_write_confirm_teams")
public class HandleDBWriteConfirmTeams extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleDBWriteConfirmTeams() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HashMap<String, String> push_into_db = new HashMap<>();
		for (String key : request.getParameterMap().keySet())
		{
			push_into_db.put(key, request.getParameterMap().get(key)[0]);
		}
		
		Driver datenhaltung = new Driver();
		HttpSession session = request.getSession();
		String session_ID = (String)(session.getAttribute("session_id"));
		if (session_ID != null)
		{
			try
			{
				String accountname_ID = datenhaltung.getSubCat("sessionmap", session_ID).get(0).get("accountname_ID");
				String rolle = datenhaltung.getSubCat("account", accountname_ID).get(0).get("rollename_ID");
				if (rolle.equals("Admin"))
				{
					PrintWriter out = response.getWriter();
					out.println("<!DOCTYPE html>");
					out.println("<html>");
					out.println("<head>");
					out.println("<meta charset=\"utf-8\">");
					out.println("</head>");
					out.println("<body>");
					out.println("<script>");
					
					ArrayList<HashMap<String, String>> teamData = datenhaltung.getSubCat("tempteam", "tempteamname_ID", push_into_db.get("tempteamname_ID"));
					String lehrstuhlname_ID = datenhaltung.getSubCat("lehrstuhl", "accountname_ID", teamData.get(0).get("betreuer1"), "lehrstuhlname_ID").get(0).get("lehrstuhlname_ID");
					String org_einheit_lehrstuhl = datenhaltung.getSubCat("lehrstuhl", "lehrstuhlname_ID", lehrstuhlname_ID, "organisationseinheitname_ID").get(0).get("organisationseinheitname_ID");
					String kennnummer = datenhaltung.createTeam(lehrstuhlname_ID, teamData.get(0).get("projekttitel"), org_einheit_lehrstuhl, teamData.get(0).get("betreuer1"), teamData.get(0).get("betreuer2"));
					ArrayList<HashMap<String, String>> hits_in_tempteammap = datenhaltung.getSubCat("tempteammap", "tempteamname_ID", push_into_db.get("tempteamname_ID"));
					
					//Teilnehmer von tempteammap in teammap kopieren
					for(int i=0; i<hits_in_tempteammap.size(); i++) {
						if(hits_in_tempteammap.get(i).get("tempteamname_ID").equals(push_into_db.get("tempteamname_ID"))) {
							ArrayList<HashMap<String, String>> teammitglied = datenhaltung.getSubCat("account", "accountname_ID", hits_in_tempteammap.get(i).get("accountname_ID"));
			                ArrayList<HashMap<String, String>> teammap_hits = datenhaltung.getSubCat("teammap", "accountname_ID", hits_in_tempteammap.get(i).get("accountname_ID"), "teamname_ID");
			                if(!teammitglied.isEmpty() && teammitglied.get(0).get("rollename_ID").equals("Teilnehmer") && teammap_hits.isEmpty() && !teamData.get(0).get("antragsteller").equals(hits_in_tempteammap.get(i).get("accountname_ID"))){
			                	HashMap<String, String> insert = new HashMap<>();
			                	insert.put("accountname_ID", hits_in_tempteammap.get(i).get("accountname_ID"));
			                	insert.put("teamname_ID", kennnummer);
			                	datenhaltung.insertHashMap("teammap", insert);
			                }
			                //Alle Einträge in tempteammmap zu bestätigtem tempteam löschen
			                datenhaltung.deleteRow("tempteammap", "tempteamname_ID", push_into_db.get("tempteamname_ID"));
						}
					}
					
					//Antragsteller in teammap kopieren und zum Teamvorsitzenden befördern
					HashMap<String, String> insert = new HashMap<>();
		        	insert.put("accountname_ID", teamData.get(0).get("antragsteller"));
		        	insert.put("teamname_ID", kennnummer);
		        	datenhaltung.insertHashMap("teammap", insert);
		        	datenhaltung.setTeamLeader(teamData.get(0).get("antragsteller"));
				
		        	//tempteam Eintrag in DB löschen
		        	datenhaltung.deleteRow("tempteam", "tempteamname_ID", push_into_db.get("tempteamname_ID"));
		        	
		        	
		        	
					Path path = Paths.get("C:/data" + kennnummer);
					if (!Files.exists(path))
					{
						new File("C:/data/" + kennnummer).mkdirs();
					}
					
					out.println("window.open(\"/pep/home/show_teams\", \"_self\")");
					out.println("</script>");
					out.println("</body>");
					out.close();
				}
				else
				{
					RequestDispatcher rd = request.getRequestDispatcher("/login");
					rd.forward(request,  response);
				}
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
		}
		else
		{
			RequestDispatcher rd = request.getRequestDispatcher("/login");
			rd.forward(request,  response);
		}
	}
}

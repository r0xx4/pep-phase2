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

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		System.out.println(push_into_db);
		
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<meta charset=\"utf-8\">");
		out.println("</head>");
		out.println("<body>");
		out.println("<script>");
		Driver datenhaltung = new Driver();
		
		
		try {
			ArrayList<HashMap<String, String>> teamData = datenhaltung.getSubCat("tempteam", "tempteamname_ID", push_into_db.get("tempteamname_ID"));
			String lehrstuhlname_ID = datenhaltung.getSubCat("lehrstuhl", "accountname_ID", teamData.get(0).get("betreuer1"), "lehrstuhlname_ID").get(0).get("lehrstuhlname_ID");
			String org_einheit_lehrstuhl = datenhaltung.getSubCat("lehrstuhl", "lehrstuhlname_ID", lehrstuhlname_ID, "organisationseinheitname_ID").get(0).get("organisationseinheitname_ID");
			String kennnummer = datenhaltung.createTeam(lehrstuhlname_ID, teamData.get(0).get("projekttitel"), org_einheit_lehrstuhl, teamData.get(0).get("betreuer1"), teamData.get(0).get("betreuer2"));
			
			
		
			Path path = Paths.get("C:/data" + kennnummer);
			if (!Files.exists(path))
			{
				new File("C:/data/" + kennnummer).mkdirs();
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
		out.println("window.open(\"/pep/home/show_teams\", \"_self\")");
		out.println("</script>");
		out.println("</body>");
		out.close();
	}

}

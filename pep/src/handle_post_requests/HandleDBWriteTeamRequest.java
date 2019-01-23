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
import javax.servlet.http.HttpSession;

import com.itextpdf.text.log.SysoCounter;

import data_management.Driver;

/**
 * Servlet implementation class HandleDBWriteTeamRequest
 */
@WebServlet("/handle_db_write_team_request")
public class HandleDBWriteTeamRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleDBWriteTeamRequest() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
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
		
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<meta charset=\"utf-8\">");
		out.println("</head>");
		out.println("<body>");
		out.println("<script>");
		
		Driver datenhaltung = new Driver();
		HttpSession session = request.getSession();
		String session_ID = (String)(session.getAttribute("session_id"));
		
		try 
		{
			String accountname_ID = datenhaltung.getSubCat("sessionmap", session_ID).get(0).get("accountname_ID");
			ArrayList<HashMap<String, String>> lehrstuhl_tut_1 = datenhaltung.getSubCat("lehrstuhl", "accountname_ID", push_into_db.get("betreuer1"), "lehrstuhlname_ID");
			if (!lehrstuhl_tut_1.isEmpty())
			{
				ArrayList<String> teammitglieder = new ArrayList<String>();
				for(int i=0; i<push_into_db.size() - 3; i++) {
					teammitglieder.add(push_into_db.get("teammitglied" + (i+1)));
				}
				//String lehrstuhlname_ID = lehrstuhl_tut_1.get(0).get("lehrstuhlname_ID");
				//String org_einheit_lehrstuhl = datenhaltung.getSubCat("lehrstuhl", "lehrstuhlname_ID", lehrstuhlname_ID, "organisationseinheitname_ID").get(0).get("organisationseinheitname_ID");
				datenhaltung.createTeamRequest(push_into_db.get("betreuer1") , push_into_db.get("betreuer2"), push_into_db.get("projekttitel"), accountname_ID, teammitglieder);
				//String kennnummer = datenhaltung.createTeam(lehrstuhl_tut_1.get(0).get("lehrstuhlname_ID"), push_into_db.get("projekttitel"), org_einheit_lehrstuhl, push_into_db.get("betreuer1"), push_into_db.get("betreuer2"));
			}
			else
			{
				out.println("window.alert(\"Bitte geben Sie einen Lehrstuhlinhaber als Betreuer 1 an!\");");
			}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		out.println("window.open(\"/pep/home/create_team\", \"_self\")");
		out.println("</script>");
		out.println("</body>");
		out.close();
	}

}

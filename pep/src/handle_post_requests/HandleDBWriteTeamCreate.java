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
 * Servlet implementation class HandleDBWriteTeamCreate
 */
@WebServlet("/handle_db_write_create_teams")
public class HandleDBWriteTeamCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleDBWriteTeamCreate() {
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
					
					ArrayList<HashMap<String, String>> lehrstuhl_tut_1 = datenhaltung.getSubCat("lehrstuhl", "accountname_ID", push_into_db.get("betreuer1"), "lehrstuhlname_ID");
					if (!lehrstuhl_tut_1.isEmpty())
					{
						String lehrstuhlname_ID = lehrstuhl_tut_1.get(0).get("lehrstuhlname_ID");
						String org_einheit_lehrstuhl = datenhaltung.getSubCat("lehrstuhl", "lehrstuhlname_ID", lehrstuhlname_ID, "organisationseinheitname_ID").get(0).get("organisationseinheitname_ID");
						String kennnummer = datenhaltung.createTeam(lehrstuhl_tut_1.get(0).get("lehrstuhlname_ID"), push_into_db.get("projekttitel"), org_einheit_lehrstuhl, push_into_db.get("betreuer1"), push_into_db.get("betreuer2"));
						
						Path path = Paths.get("C:/data");
						if (!Files.exists(path))
						{
							new File("C:/data").mkdirs();
							new File("C:/data/" + kennnummer).mkdirs();
						}
						else
						{
							new File("C:/data/" + kennnummer).mkdirs();
						}
					}
					else
					{
						out.println("window.alert(\"Bitte geben Sie einen Lehrstuhlinhaber als Betreuer 1 an!\");");
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

package handle_post_requests;

import java.io.IOException;
import java.io.PrintWriter;
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
 * Servlet implementation class HandleDBWriteTeamEdit
 */
@WebServlet("/handle_db_write_edit_teams")
public class HandleDBWriteTeamEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleDBWriteTeamEdit() {
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
					ArrayList<HashMap<String, String>> lehrstuhl_tut_1 = datenhaltung.getSubCat("lehrstuhl", "accountname_ID", push_into_db.get("betreuer1"), "lehrstuhlname_ID");
					if (!lehrstuhl_tut_1.isEmpty())
					{
						ArrayList<HashMap<String, String>> old_team_mappings_ids = datenhaltung.getSubCat("teammap", "teamname_ID", push_into_db.get("teamname_ID"), "teammapname_ID");
						for (HashMap<String, String> old_team_mappings_id : old_team_mappings_ids)
						{
							String accountname = datenhaltung.getSubCat("teammap", "teammapname_ID", old_team_mappings_id.get("teammapname_ID"), "accountname_ID").get(0).get("accountname_ID");
							String rollename_ID = datenhaltung.getSubCat("account", "accountname_ID", accountname, "rollename_ID").get(0).get("rollename_ID");
							if (rollename_ID.equals("Tutor"))
								datenhaltung.deleteRow("teammap", old_team_mappings_id.get("teammapname_ID"));
						}
						
						HashMap<String, String> new_tutor1 = new HashMap<>();
						new_tutor1.put("accountname_ID", push_into_db.get("betreuer1"));
						new_tutor1.put("teamname_ID", push_into_db.get("teamname_ID"));
						datenhaltung.insertHashMap("teammap", new_tutor1);
						
						HashMap<String, String> new_tutor2 = new HashMap<>();
						new_tutor2.put("accountname_ID", push_into_db.get("betreuer2"));
						new_tutor2.put("teamname_ID", push_into_db.get("teamname_ID"));
						datenhaltung.insertHashMap("teammap", new_tutor2);
						
						HashMap<String, String> update_hm = new HashMap<>();
						update_hm.put("projekttitel", push_into_db.get("projekttitel"));
						datenhaltung.updateTable("team", push_into_db.get("teamname_ID"), update_hm);
						
						PrintWriter out = response.getWriter();
						out.println("<script>");
						out.println("window.open(\"/pep/home/show_teams\", \"_self\")");
						out.println("</script>");
						out.close();
					}
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

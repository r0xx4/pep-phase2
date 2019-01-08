package handle_post_requests;

import java.io.IOException;
import java.io.PrintWriter;
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
 * Servlet implementation class HandleDBWrite
 */
@WebServlet("/handle_db_write_accounts")
public class HandleDBWriteAccounts extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleDBWriteAccounts() {
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
		String mail = push_into_db.get("accountname_ID");
		String team = push_into_db.get("team");
		
		Driver datenhaltung = new Driver();
		
		try 
		{
			if (!team.equals("null"))
			{
				team = team.replaceAll("Team ", "");
				StringBuilder team_sb = new StringBuilder(team);
				team_sb.delete(1, team_sb.length());
				team = team_sb.toString();
				String teamname_ID = datenhaltung.getSubCat("team", "teamnummer", team, "teamname_ID").get(0).get("teamname_ID");
				ArrayList<HashMap<String, String>> teammapname_ID_list = datenhaltung.getSubCat("teammap", "accountname_ID", push_into_db.get("accountname_ID"), "teammapname_ID");
				
				String teammapname_ID = "";
				if (!teammapname_ID_list.isEmpty())
					teammapname_ID = teammapname_ID_list.get(0).get("teammapname_ID");
				else
					teammapname_ID = null;
				
				HashMap<String, String> teammap_row = new HashMap<>();
				teammap_row.put("accountname_ID", push_into_db.get("accountname_ID"));
				teammap_row.put("teamname_ID", teamname_ID);
				if (teammapname_ID != null)
				{
					datenhaltung.updateTable("teammap", teammapname_ID, teammap_row);
				}
				else
				{
					datenhaltung.insertHashMap("teammap", teammap_row);
				}
				push_into_db.remove("accountname_ID");
				push_into_db.remove("team");
				datenhaltung.updateTable("account", mail, push_into_db);
			}
			else
			{
				ArrayList<HashMap<String, String>> teammapname_ID_del_list = datenhaltung.getSubCat("teammap", "accountname_ID", push_into_db.get("accountname_ID"), "teammapname_ID");
				if (!teammapname_ID_del_list.isEmpty())
				{
					String teammapname_ID_del = teammapname_ID_del_list.get(0).get("teammapname_ID");
					datenhaltung.deleteRow("teammap", teammapname_ID_del);
				}
				push_into_db.remove("accountname_ID");
				push_into_db.remove("team");
				datenhaltung.updateTable("account", mail, push_into_db);
			}	
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("window.open(\"/pep/home/show_accounts\", \"_self\")");
		out.println("</script>");
		out.close();
	}

}

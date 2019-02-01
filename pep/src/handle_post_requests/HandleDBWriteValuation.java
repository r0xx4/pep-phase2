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
 * Servlet implementation class HandleDBWriteValuation
 */
@WebServlet("/set_grades")
public class HandleDBWriteValuation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleDBWriteValuation() {
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
				if (rolle.equals("Admin") || rolle.equals("Juror"))
				{
					String teamname_ID = push_into_db.get("teamname_ID");
					String note = push_into_db.get("note_ID");
					
					push_into_db.remove("teamname_ID");
					push_into_db.remove("note_ID");
					
					
					HashMap<String, String> grade = new HashMap<>();
					
					if(!note.equals("")) {
						grade.put("note", note);	
					}
					else {
						grade.put("note", "null");
					}
					
					datenhaltung.updateTable("team", teamname_ID, grade);

					
					for (String attr : push_into_db.keySet())
					{
						ArrayList<HashMap<String, String>> existing_maps;
						existing_maps = datenhaltung.getScoreForCriterion(teamname_ID, attr);
						for(int i=0; i<existing_maps.size(); i++) {
							datenhaltung.deleteRow("kriteriumsmap", existing_maps.get(i).get("kriteriumsmapname_ID"));
						}
						
						if (!push_into_db.get(attr).equals("-"))
						{
							HashMap<String, String> bewertung = new HashMap<>();
							bewertung.put("teamname_ID", teamname_ID);
							bewertung.put("teilkriteriumname_ID", attr);
							bewertung.put("punkte", push_into_db.get(attr));
							
							try 
							{								
								datenhaltung.insertHashMap("kriteriumsmap", bewertung);
							} 
							catch (SQLException e) 
							{
								e.printStackTrace();
							}
						}
					}
					
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("window.open(\"/pep/home/show_teams\", \"_self\")");
					out.println("</script>");
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

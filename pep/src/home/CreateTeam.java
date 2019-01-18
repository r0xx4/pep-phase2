package home;

import java.io.IOException;
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
 * Servlet implementation class CreateTeam
 */
@WebServlet("/home/create_team")
public class CreateTeam extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateTeam() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setHeader("Cache-Control",  "must-revalidate");
		Driver datenhaltung = new Driver();
		HttpSession session = request.getSession();
		String session_ID = (String)(session.getAttribute("session_id"));
		
		try 
		{
			if (session_ID != null)
			{
				String accountname_ID = datenhaltung.getSubCat("sessionmap", session_ID).get(0).get("accountname_ID");
				String rolle = datenhaltung.getSubCat("account", accountname_ID).get(0).get("rollename_ID");
				ArrayList<HashMap<String, String>> team = datenhaltung.getSubCat("teammap", "accountname_ID", accountname_ID, "teamname_ID");
				String currentPhase = datenhaltung.getCurrentPhase();
				System.out.println(rolle);
				System.out.println(session_ID);
				if (rolle.equals("Teilnehmer") || rolle.equals("Teamleiter"))
				{
					if(currentPhase == null || !team.isEmpty()) {
						RequestDispatcher rd = request.getRequestDispatcher("/home");
						rd.forward(request,  response);
					}
					else {
						RequestDispatcher rd = request.getRequestDispatcher("/home/index_team_erstellen_student.jsp");
						rd.forward(request,  response);
					}
				}
				else
				{
					RequestDispatcher rd = request.getRequestDispatcher("/home/logout");
					rd.forward(request,  response);
				}
			}
			else
			{
				RequestDispatcher rd = request.getRequestDispatcher("/login");
				rd.forward(request,  response);
			}
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

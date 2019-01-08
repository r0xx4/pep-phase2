package home;

import java.io.IOException;
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
 * Servlet implementation class ShowGroups
 */
@WebServlet("/home/show_groups")
public class ShowGroups extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowGroups() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
				System.out.println(rolle);
				System.out.println(session_ID);
				if (rolle.equals("Admin"))
				{
					RequestDispatcher rd = request.getRequestDispatcher("/home/index_gruppenansicht_admin.jsp");
					rd.forward(request,  response);
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
		doGet(request, response);
	}

}

package home;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data_management.Driver;

/**
 * Servlet implementation class Logout
 */
@WebServlet("/home/logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Logout() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Driver datenhaltung = new Driver();
		String sessionmapname_ID = (String)(session.getAttribute("session_id"));
		System.out.println(sessionmapname_ID);
		if (sessionmapname_ID != null)
			try 
			{
				datenhaltung.logout(Integer.valueOf(sessionmapname_ID));
			} 
			catch (SQLException e) 
			{
				e.printStackTrace();
			}
			session.invalidate();
		RequestDispatcher rd = request.getRequestDispatcher("/login");
		rd.forward(request,  response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

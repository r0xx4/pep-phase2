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
 * Servlet implementation class DeleteEntry
 */
@WebServlet("/delete_entry")
public class DeleteEntry extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteEntry() {
        super();
        // TODO Auto-generated constructor stub
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
		HashMap<String, String> to_delete = new HashMap<>();
		for (String key : request.getParameterMap().keySet())
		{
			to_delete.put(key, request.getParameterMap().get(key)[0]);
		}
		
		Driver datenhaltung = new Driver();
		HttpSession session = request.getSession();
		String session_ID = (String)(session.getAttribute("session_id"));
		System.out.println(session_ID);
		if (session_ID != null)
		{
			try
			{
				String accountname_ID = datenhaltung.getSubCat("sessionmap", session_ID).get(0).get("accountname_ID");
				String rolle = datenhaltung.getSubCat("account", accountname_ID).get(0).get("rollename_ID");
				if (rolle.equals("Admin"))
				{
					if(to_delete.get("type").equals("team")) 
					{
						ArrayList<HashMap<String, String>> teammap = datenhaltung.getSubCat("teammap", "teamname_ID", to_delete.get("id"));
						for(HashMap<String, String> account : teammap) 
						{
							String rolle2 = datenhaltung.getSubCat("account", "accountname_ID", account.get("accountname_ID"), "rollename_ID").get(0).get("rollename_ID");
							if(rolle2.equals("Teamleiter")) 
							{
								HashMap<String, String> update = new HashMap<String, String>();
								update.put("rollename_ID", "Teilnehmer");
								datenhaltung.updateTable("account", account.get("accountname_ID"), update);
							}
						}
						datenhaltung.deleteRow(to_delete.get("type"), to_delete.get("id"));
					}
					else 
					{
						datenhaltung.deleteRow(to_delete.get("type"), to_delete.get("id"));
					}
					
					PrintWriter out = response.getWriter();
					out.println("<!DOCTYPE html>");
					out.println("<html>");
					out.println("<head>");
					out.println("<meta charset=\"utf-8\">");
					out.println("</head>");
					out.println("<body>");
					out.println("<script>");
					out.println("window.alert(\"Gel�scht!\");");
					out.println("window.open(\"/pep/home\", \"_self\");");
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
		
		
		try
		{
			if(to_delete.get("type").equals("team")) {
				ArrayList<HashMap<String, String>> teammap = datenhaltung.getSubCat("teammap", "teamname_ID", to_delete.get("id"));
				for(HashMap<String, String> account : teammap) {
					String rolle = datenhaltung.getSubCat("account", "accountname_ID", account.get("accountname_ID"), "rollename_ID").get(0).get("rollename_ID");
					if(rolle.equals("Teamleiter")) {
						HashMap<String, String> update = new HashMap<String, String>();
						update.put("rollename_ID", "Teilnehmer");
						datenhaltung.updateTable("account", account.get("accountname_ID"), update);
					}
				}
				datenhaltung.deleteRow(to_delete.get("type"), to_delete.get("id"));

			}
			else {
				datenhaltung.deleteRow(to_delete.get("type"), to_delete.get("id"));
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<meta charset=\"utf-8\">");
		out.println("</head>");
		out.println("<body>");
		out.println("<script>");
		out.println("window.alert(\"Gel�scht!\");");
		out.println("window.open(\"/pep/home\", \"_self\");");
		out.println("</script>");
		out.println("</body>");
		out.close();
	}

}




//HttpSession session = request.getSession();
//String session_ID = (String)(session.getAttribute("session_id"));
//if (session_ID != null)
//{
//	try
//	{
//		String accountname_ID = datenhaltung.getSubCat("sessionmap", session_ID).get(0).get("accountname_ID");
//		String rolle = datenhaltung.getSubCat("account", accountname_ID).get(0).get("rollename_ID");
//		if (rolle.equals("Admin"))
//		{
//			
//		}
//		else
//		{
//			RequestDispatcher rd = request.getRequestDispatcher("/login");
//			rd.forward(request,  response);
//		}
//	}
//	catch (SQLException e)
//	{
//		e.printStackTrace();
//	}
//}
//else
//{
//	RequestDispatcher rd = request.getRequestDispatcher("/login");
//	rd.forward(request,  response);
//}

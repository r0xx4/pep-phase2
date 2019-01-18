package handle_post_requests;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		System.out.println("executed");
		HashMap<String, String> to_delete = new HashMap<>();
		for (String key : request.getParameterMap().keySet())
		{
			to_delete.put(key, request.getParameterMap().get(key)[0]);
		}
		
		Driver datenhaltung = new Driver();
		try
		{
			datenhaltung.deleteRow(to_delete.get("type"), to_delete.get("id"));
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
		out.println("window.alert(\"Gelöscht!\");");
		out.println("window.open(\"/pep/home\", \"_self\");");
		out.println("</script>");
		out.println("</body>");
		out.close();
	}

}

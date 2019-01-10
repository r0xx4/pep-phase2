package login;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data_management.Driver;

/**
 * Servlet implementation class TransferLoginData
 */
@WebServlet("/login/transfer_login_data")
public class TransferLoginData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TransferLoginData() {
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
		HashMap<String, String> account_data = new HashMap<>();
		for (String key : request.getParameterMap().keySet())
		{
			account_data.put(key, request.getParameterMap().get(key)[0]);
		}
		Driver datenhaltung = new Driver();
		
		HttpSession session = request.getSession();
		String sessionmapname_ID = (String)(session.getAttribute("session_id"));
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
			
		try 
		{
			session = request.getSession();
			String pw = Driver.getHash(account_data.get("password").getBytes(StandardCharsets.UTF_8));
			String sessionID = datenhaltung.login(account_data.get("accountname_ID"), pw);
			if (sessionID != null)
			{
				session.setAttribute("session_id", sessionID);
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("window.open(\"/pep/home\", \"_self\")");
				out.println("</script>");
				out.close();
			}
			else
			{
				PrintWriter out = response.getWriter();
				out.println("<!DOCTYPE html>");
				out.println("<html>");
				out.println("<head>");
				out.println("<meta charset=\"utf-8\">");
				out.println("</head>");
				out.println("<body>");
				out.println("<script>");
				out.println("window.alert(\"Login fehlgeschlagen!\");");
				out.println("window.open(\"/pep/login\", \"_self\");");
				out.println("</script>");
				out.println("</body>");
				out.close();
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
}

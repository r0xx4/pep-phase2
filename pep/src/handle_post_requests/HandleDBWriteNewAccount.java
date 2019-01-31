package handle_post_requests;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
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
 * Servlet implementation class HandleDBWriteNewAccount
 */
@WebServlet("/handle_db_write_new_account")
public class HandleDBWriteNewAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleDBWriteNewAccount() {
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
		HashMap<String, String> account_data = new HashMap<>();
		for (String key : request.getParameterMap().keySet())
		{
			if (!request.getParameterMap().get(key)[0].equals("") && !request.getParameterMap().get(key)[0].equals("null"))
				account_data.put(key, request.getParameterMap().get(key)[0]);
			else
				account_data.put(key, null);
		}
		System.out.println(account_data);
		
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
					try 
					{
						account_data.put("password", Driver.getHash(account_data.get("password").getBytes(StandardCharsets.UTF_8)));
					} 
					catch (NoSuchAlgorithmException e1) 
					{
						e1.printStackTrace();
					}
					datenhaltung.insertHashMap("account", account_data);
					PrintWriter out = response.getWriter();
					out.println("<!DOCTYPE html>");
					out.println("<html>");
					out.println("<head>");
					out.println("<meta charset=\"utf-8\">");
					out.println("</head>");
					out.println("<body>");
					out.println("<script>");
					out.println("window.alert(\"Account hinzugefügt!\");");
					out.println("window.open(\"/pep/home/show_accounts\", \"_self\");");
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

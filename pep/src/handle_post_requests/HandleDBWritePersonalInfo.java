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
 * Servlet implementation class HandleDBWritePersonalInfo
 */
@WebServlet("/handle_db_write_personal_info")
public class HandleDBWritePersonalInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HandleDBWritePersonalInfo() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HashMap<String, String> push_into_db = new HashMap<>();
		for (String key : request.getParameterMap().keySet()) {
			push_into_db.put(key, request.getParameterMap().get(key)[0]);
		}

		Driver datenhaltung = new Driver();
		HttpSession session = request.getSession();
		String session_ID = (String)(session.getAttribute("session_id"));
		if (session_ID != null)
		{
			try
			{
				String accountname_ID = push_into_db.get("accountname_ID");
				push_into_db.remove("accountname_ID");
				
				if (push_into_db.containsKey("password_old")) {
					String password_Old = Driver.getHash(push_into_db.get("password_old").getBytes(StandardCharsets.UTF_8));
					String DB_Pw = datenhaltung.getSubCat("account", accountname_ID).get(0).get("password");
					push_into_db.replace("password", Driver.getHash(push_into_db.get("password").getBytes(StandardCharsets.UTF_8)));
					if (!password_Old.equals(DB_Pw)) {
						push_into_db.remove("password_old");
						push_into_db.remove("password");
					} else 
						push_into_db.remove("password_old");
				}
				datenhaltung.updateTable("account", accountname_ID, push_into_db);
				
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("window.open(\"/pep/home/view_personal_info\", \"_self\")");
				out.println("</script>");
				out.close();
			}
			catch (SQLException | NoSuchAlgorithmException e)
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

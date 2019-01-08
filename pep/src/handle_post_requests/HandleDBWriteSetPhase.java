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
 * Servlet implementation class HandleDBWriteSetPhase
 */
@WebServlet("/handle_db_write_set_phase")
public class HandleDBWriteSetPhase extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleDBWriteSetPhase() {
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
		Driver datenhaltung = new Driver();
		HashMap<String, String> push_into_db = new HashMap<>();
		for (String key : request.getParameterMap().keySet())
		{
			push_into_db.put(key, request.getParameterMap().get(key)[0]);
		}
		if(push_into_db.containsKey("startDatum"))
			push_into_db.put("endDatum", "2100-01-01");
		System.out.println(push_into_db);
		try {
			if(push_into_db.containsKey("startDatum"))
				datenhaltung.updateTable("phase", "Projektbewertungsphase", push_into_db);
			else if(push_into_db.containsKey("endDatum"))
				datenhaltung.updateTable("phase", "Projektbewertungsphase", push_into_db);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("window.open(\"/pep/home\", \"_self\")");
		out.println("</script>");
		out.close();
	}

}

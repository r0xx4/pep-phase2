package handle_post_requests;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data_management.Driver;

/**
 * Servlet implementation class HandleDBResetSystem
 */
@WebServlet("/handle_db_reset_system")
public class HandleDBResetSystem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleDBResetSystem() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<meta charset=\"utf-8\">");
		out.println("</head>");
		out.println("<body>");
		out.println("<script>");
		
		Driver datenhaltung = new Driver();
		HttpSession session = request.getSession();
		String session_ID = (String)(session.getAttribute("session_id"));
		
			try 
			{
				if (session_ID != null)
				{
					String accountname_ID = datenhaltung.getSubCat("sessionmap", session_ID).get(0).get("accountname_ID");
					String accountname_ID_rolle = datenhaltung.getSubCat("account", "accountname_ID", accountname_ID, "rollename_ID").get(0).get("rollename_ID");
					if(accountname_ID_rolle.equals("Admin")) {
						deleteDirectory(new File("C:\\data"));
						deleteDirectory(new File("C:\\Backup"));
						deleteDirectory(new File("C:\\Old Backups"));
						
						ArrayList<HashMap<String, String>> sessionmap = datenhaltung.getSubCat("sessionmap");
						for(HashMap<String, String> s:sessionmap) {
							if(!s.get("sessionmapname_ID").equals(session_ID)) {
								datenhaltung.deleteRow("sessionmap", s.get("sessionmapname_ID"));
							}
						}
						datenhaltung.deleteTabelContent("jurormap");
						datenhaltung.deleteTabelContent("lehrstuhl");
						datenhaltung.deleteRow("account", "rollename_ID", "Teilnehmer");
						datenhaltung.deleteRow("account", "rollename_ID", "Teamleiter");
						datenhaltung.deleteRow("account", "rollename_ID", "Tutor");
						datenhaltung.deleteRow("account", "rollename_ID", "Juror");
						datenhaltung.deleteTabelContent("hauptkriterium");
						datenhaltung.deleteTabelContent("studiengang");
						datenhaltung.deleteTabelContent("team");
						datenhaltung.deleteTabelContent("organisationseinheit");
						datenhaltung.deleteTabelContent("tempteam");
						datenhaltung.setPhaseDates("Projektbewertungsphase", "2100-01-01", "2100-01-01");
						
						out.println("window.alert(\"Reset Erfolgreich!\");");
						out.println("window.open(\"/pep/home\", \"_self\")");
						out.println("</script>");
						out.println("</body>");
						out.close();
					}
					else {
						out.println("window.open(\"/pep/login\", \"_self\")");
						out.println("</script>");
						out.println("</body>");
						out.close();
					}
				}
			} 
			catch (SQLException e) 
			{
				e.printStackTrace();
				out.println("window.open(\"/pep/login\", \"_self\")");
				out.println("</script>");
				out.println("</body>");
				out.close();
			}		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	public static boolean deleteDirectory(File dir){
		if (dir.isDirectory()){
			File[] files = dir.listFiles();
			for (File aktFile: files){
				deleteDirectory(aktFile);
			}
		}
		return dir.delete();
	}

}

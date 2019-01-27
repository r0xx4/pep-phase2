package download;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data_management.Driver;
import pdf_creator.Pdfcreator;

/**
 * Servlet implementation class HandleTeamList
 */
@WebServlet("/team_list_pdf")
public class HandleTeamList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleTeamList() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mail = request.getQueryString();
		
		Driver datenhaltung = new Driver();
		try {
			
		ArrayList<HashMap<String, String>> tempTeam = datenhaltung.getSubCat("tempteam", "antragsteller", mail);
		if(!tempTeam.isEmpty()) {
			String projectTitle = tempTeam.get(0).get("projekttitel");
			ArrayList<HashMap<String, String>> teammitglieder = datenhaltung.getSubCat("tempteammap", "tempteamname_ID", tempTeam.get(0).get("tempteamname_ID"), "accountname_ID");
			ArrayList<String> teammitgliednamen = new ArrayList<String>();
			teammitgliednamen.add(tempTeam.get(0).get("antragsteller"));
			for(HashMap<String, String> teammitglied : teammitglieder) {
				teammitgliednamen.add(teammitglied.get("accountname_ID"));
//				HashMap<String, String> accountInfo = datenhaltung.getSubCat("account", teammitglied.get("accountname_ID")).get(0);
//				teammitgliednamen.add(accountInfo.get("vorname") + " " + accountInfo.get("nachname"));
			}
			
			Path path = Paths.get("c:/data/teamlists");
			if(!Files.exists(path)) {
				new File("c:/data/teamlists").mkdirs();
			}
			
			Pdfcreator pdf = new Pdfcreator();
			pdf.createteilnehmerliste(teammitgliednamen, projectTitle, tempTeam.get(0).get("tempteamname_ID"), path.toString());
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			String file = tempTeam.get(0).get("tempteamname_ID") + ".pdf";
			response.setContentType("APPLICATION/OCTET-STREAM");
			response.setHeader("Content-Disposition", "attachment; filename=\""+file+"\"");
			
			FileInputStream fileInputStream = new FileInputStream(path+File.separator+file);
			
			int i;
			while((i = fileInputStream.read()) != -1) {
				out.write(i);
			}
			fileInputStream.close();
			out.close();
		}else {
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("window.open(\"/pep/home\", \"_self\")");
			out.println("</script>");
			out.close();
		}
		
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}

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
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data_management.Driver;
import pdf_creator.*;

/**
 * Servlet implementation class HandleBestRanked
 */
@WebServlet("/best_ranked_pdf")
public class HandleBestRanked extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleBestRanked() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Driver datenhaltung = new Driver();
		
		Path path = Paths.get("c:/data/Abschlusspraesentation");
		if(!Files.exists(path)) {
			new File("c:/data/Abschlusspraesentation").mkdirs();
		}
		
		try {
			int anzahl = datenhaltung.getSubCat("organisationseinheit").size();
			ArrayList<HashMap<String, String>> units = datenhaltung.getSubCat("organisationseinheit");
			LinkedHashMap<String, ArrayList<HashMap<String, String>>> teams = new LinkedHashMap<String, ArrayList<HashMap<String, String>>>();
			for(HashMap<String, String> u : units) {
				teams.put(u.get("organisationseinheitname_ID"), new ArrayList<HashMap<String, String>>());
				for(HashMap<String, String> t : datenhaltung.getSubCat("team")) {
					if(u.get("organisationseinheitname_ID").equals(t.get("organisationseinheitname_ID"))) {
						teams.get(u.get("organisationseinheitname_ID")).add(new HashMap<String, String>(){
							{
								put(t.get("teamname_ID"), t.get("note"));
							}
						});
					}
				}
			}
			
			for(String g : teams.keySet()) {
				Collections.sort(teams.get(g), new Comparator<HashMap<String, String>>() {
					@Override
					public int compare(HashMap<String, String> a, HashMap<String, String> b) {
						return Float.compare(
								Float.parseFloat(a.values().iterator().next()),
								Float.parseFloat(b.values().iterator().next()));
					}
				});
			}
			ArrayList<Integer> winnerTeams = new ArrayList<Integer>();
			ArrayList<String> teamNames = new ArrayList<String>();
			for(String g : teams.keySet()) {
				ArrayList<String> temp = new ArrayList<String>();
				int i = 0;
				for(; i < (teams.get(g).size() < 3 ? teams.get(g).size() : 3); i++) {
					temp.add(teams.get(g).get(i).keySet().iterator().next());
				}
				Collections.reverse(temp);
				teamNames.addAll(temp);
				winnerTeams.add(i);
			}
			
			

			
			System.out.println(teams);
			System.out.println(winnerTeams);
			System.out.println(teamNames);
			
			Pdfcreator pdf = new Pdfcreator();
			pdf.creategewinnerliste(anzahl, winnerTeams, teamNames, path.toString());
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			String file = "Gewinnerliste.pdf";
			response.setContentType("APPLICATION/OCTET-STREAM");
			response.setHeader("Content-Disposition", "attachment; filename=\""+file+"\"");
			
			FileInputStream fileInputStream = new FileInputStream(path+File.separator+file);
			
			int i;
			while((i = fileInputStream.read()) != -1) {
				out.write(i);
			}
			fileInputStream.close();
			out.close();
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

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
 * Servlet implementation class HandlePresentation
 */
@WebServlet("/presentation_pdf")
public class HandlePresentation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandlePresentation() {
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
			
			ArrayList<Gruppe> winner = new ArrayList<Gruppe>();
			ArrayList<Gruppe> place1 = new ArrayList<Gruppe>();
			ArrayList<Gruppe> place2 = new ArrayList<Gruppe>();
			ArrayList<Gruppe> place3 = new ArrayList<Gruppe>();
			
			for(String g : teams.keySet()) {
				int grpNr = Integer.valueOf(g.replaceAll("Gruppe ", ""));
				ArrayList<String> temp = new ArrayList<String>();
				for(int i = 0; i < (teams.get(g).size() < 3 ? teams.get(g).size() : 3); i++) {
					temp.add(teams.get(g).get(i).keySet().iterator().next());
				}
				Collections.reverse(temp);
				int platz = (teams.get(g).size() < 3 ? teams.get(g).size() : 3);
				int i = 1;
				for(String s : temp) {
					Gruppe group = new Gruppe(grpNr, platz--, s);
					switch(i) {
					case 1:
						place3.add(group);
						break;
					case 2:
						place2.add(group);
						break;
					case 3:
						place1.add(group);
						break;
					}
					i++;
				}
			}
			winner.addAll(place3);
			winner.addAll(place2);
			winner.addAll(place1);
			Pdfcreator pdf = new Pdfcreator();
			pdf.createabschlusspraesentation("c:/data/Abschlusspraesentation/t.txt", winner, path.toString());
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			String file = "abschlusspraesentation.pdf";
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

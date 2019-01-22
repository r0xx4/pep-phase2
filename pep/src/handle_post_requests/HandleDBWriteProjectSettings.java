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
 * Servlet implementation class HandleDBWriteProjectSettings
 */
@WebServlet("/handle_db_write_project_settings")
public class HandleDBWriteProjectSettings extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleDBWriteProjectSettings() {
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
		System.out.println(push_into_db);
		try {
			for(String attribute : push_into_db.keySet()) {
				if(attribute.equals("Masterkey_juror")) {
					if(!push_into_db.get(attribute).equals("")) {
						HashMap<String, String> masterkey_juror = new HashMap<String, String>();
						masterkey_juror.put("masterpasswordJuror", push_into_db.get(attribute));
						datenhaltung.updateTable("projectconfiguration", "1", masterkey_juror);
					}
				}
				else if(attribute.equals("Masterkey_tutor")) {
					if(!push_into_db.get(attribute).equals("")) {
						HashMap<String, String> masterkey_tutor = new HashMap<String, String>();
						masterkey_tutor.put("masterpasswordTutor", push_into_db.get(attribute));
						datenhaltung.updateTable("projectconfiguration", "1", masterkey_tutor);
					}
				}
				else if(attribute.equals("Teilnehmer")) {
					HashMap<String, String> teilnehmer_pro_gruppe = new HashMap<String, String>();
					String teilnehmer = push_into_db.get(attribute);
					String[] teilnehmer_splitted = teilnehmer.split("#");
					teilnehmer_pro_gruppe.put("team_Min", teilnehmer_splitted[0]);
					teilnehmer_pro_gruppe.put("team_Max", teilnehmer_splitted[1]);
					datenhaltung.updateTable("projectconfiguration", "1", teilnehmer_pro_gruppe);
				}
				else if(attribute.equals("Registrierung")) {
					HashMap<String, String> registrierungsphasedaten = new HashMap<String, String>();
					String registrierung = push_into_db.get(attribute);
					String[] registrierung_splitted = registrierung.split("#");
					registrierungsphasedaten.put("startDatum", registrierung_splitted[0]);
					registrierungsphasedaten.put("endDatum", registrierung_splitted[1]);
					datenhaltung.updateTable("phase", "Registrierungsphase", registrierungsphasedaten);
				}
				else if(attribute.equals("AbgabePoster")) {
					HashMap<String, String> abgabePosterDaten = new HashMap<String, String>();
					String abgabePoster = push_into_db.get(attribute);
					abgabePosterDaten.put("endDatum", abgabePoster);
					datenhaltung.updateTable("phase", "AbgabePoster", abgabePosterDaten);
				}
				else if(attribute.equals("AbgabePraesentation")) {
					HashMap<String, String> abgabePraesentationDaten = new HashMap<String, String>();
					String abgabePraesentation = push_into_db.get(attribute);
					abgabePraesentationDaten.put("endDatum", abgabePraesentation);
					datenhaltung.updateTable("phase", "AbgabePraesentation", abgabePraesentationDaten);
				}
				else if(attribute.equals("AbgabeZusammenfassung")) {
					HashMap<String, String> abgabeZusammenfassungDaten = new HashMap<String, String>();
					String abgabeZusammenfassung = push_into_db.get(attribute);
					abgabeZusammenfassungDaten.put("endDatum", abgabeZusammenfassung);
					datenhaltung.updateTable("phase", "AbgabeZusammenfassung", abgabeZusammenfassungDaten);
				}
				else if(attribute.equals("AbgabeDokument")) {
					HashMap<String, String> abgabeDokumentDaten = new HashMap<String, String>();
					String abgabeDokument = push_into_db.get(attribute);
					abgabeDokumentDaten.put("endDatum", abgabeDokument);
					datenhaltung.updateTable("phase", "AbgabeDokument", abgabeDokumentDaten);
				}
				else if(attribute.equals("Studiengang_add")) {
					if (!push_into_db.get(attribute).equals("")) {
						String[] studiengaenge = push_into_db.get(attribute).split("%");
						for (String studiengang : studiengaenge)
						{
							HashMap<String, String> plus_studiengang = new HashMap<>();
							plus_studiengang.put("studiengangname_ID", studiengang);
							datenhaltung.insertHashMap("studiengang", plus_studiengang);
						}
					}
				}
				else if(attribute.equals("Lehrstuhl_add")) {
					if (!push_into_db.get(attribute).equals("")) {
						String[] lehrstuehle = push_into_db.get(attribute).split("%");
						for (String lehrstuhl : lehrstuehle)
						{
							HashMap<String, String> plus_lehrstuhl = new HashMap<>();
							String[] lehrstuhlinfo = lehrstuhl.split(":");
							plus_lehrstuhl.put("lehrstuhlname_ID", lehrstuhlinfo[0]);
							plus_lehrstuhl.put("accountname_ID", lehrstuhlinfo[1]);
							plus_lehrstuhl.put("organisationseinheitname_ID", lehrstuhlinfo[2]);
							datenhaltung.insertHashMap("lehrstuhl", plus_lehrstuhl);
						}
					}
				}
				else if(attribute.equals("Studiengang_del")) {
					if (!push_into_db.get(attribute).equals("")) {
						String[] studiengaenge_del = push_into_db.get(attribute).split("%");
						for (String studiengang_del : studiengaenge_del)
						{
							datenhaltung.deleteRow("studiengang", studiengang_del);
						}
					}
				}
				else if(attribute.equals("Lehrstuhl_del")) {
					if (!push_into_db.get(attribute).equals("")) {
						String[] lehrstuehle_del = push_into_db.get(attribute).split("%");
						for (String lehrstuhl_del : lehrstuehle_del)
						{
							datenhaltung.deleteRow("studiengang", lehrstuhl_del);
						}
					}
				}
				else if(attribute.equals("Bewertung_add")) {
					if (!push_into_db.get(attribute).equals("")) {
						String[] plus_bewertungsaspekte = push_into_db.get(attribute).split("%");
						for (String plus_bewertungsaspekt : plus_bewertungsaspekte)
						{
							System.out.println(plus_bewertungsaspekt);
							String[] splitted_stage1 = plus_bewertungsaspekt.split(":");
							if (splitted_stage1.length == 1)
							{
								HashMap<String, String> hauptkriterium = new HashMap<>();
								hauptkriterium.put("hauptkriteriumname_ID", splitted_stage1[0]);
								datenhaltung.insertHashMap("hauptkriterium", hauptkriterium);
							}
							else
							{
								String[] splitted_stage2 = splitted_stage1[1].split("!");
								String[] splitted_stage3 = splitted_stage2[1].split("#");
								HashMap<String, String> teilkriterium = new HashMap<>();
								teilkriterium.put("hauptkriteriumname_ID", splitted_stage1[0]);
								teilkriterium.put("skala_Min", splitted_stage3[0]);
								teilkriterium.put("skala_Max", splitted_stage3[1]);
								teilkriterium.put("teilkriteriumname_ID", splitted_stage2[0]);
								datenhaltung.insertHashMap("teilkriterium", teilkriterium);
							}
						}
					}
				}
				else if(attribute.equals("Bewertung_del")) {
					if (!push_into_db.get(attribute).equals("")) {
						String[] plus_bewertungsaspekte = push_into_db.get(attribute).split("%");
						for (String plus_bewertungsaspekt : plus_bewertungsaspekte)
						{
							String[] splitted_stage1 = plus_bewertungsaspekt.split(":");
							if (splitted_stage1.length == 1)
							{
								datenhaltung.deleteRow("hauptkriterium", splitted_stage1[0]);
							}
							else
							{
								datenhaltung.deleteRow("teilkriterium", splitted_stage1[1]);
							}
						}
					}
				}
				else if(attribute.equals("Bewertung_update")) {
					if (!push_into_db.get(attribute).equals("")) {
						String[] plus_bewertungsaspekte = push_into_db.get(attribute).split("%");
						for (String plus_bewertungsaspekt : plus_bewertungsaspekte)
						{
							String[] splitted_stage1 = plus_bewertungsaspekt.split(":");
							String[] splitted_stage2 = splitted_stage1[1].split("!");
							String[] splitted_stage3 = splitted_stage2[1].split("#");
							HashMap<String, String> teilkriterium = new HashMap<>();
							teilkriterium.put("hauptkriteriumname_ID", splitted_stage1[0]);
							teilkriterium.put("skala_Min", splitted_stage3[0]);
							teilkriterium.put("skala_Max", splitted_stage3[1]);
							datenhaltung.updateTable("teilkriterium", splitted_stage2[0], teilkriterium);
						}
					}
				}
			}
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("window.open(\"/pep/home/show_project_settings\", \"_self\")");
		out.println("</script>");
		out.close();
	}
}

package data_management;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Collections;
import java.util.Set;
import java.util.stream.Collectors;

import javax.xml.bind.DatatypeConverter;

public class Driver {

	private static final byte salt[] = DatatypeConverter.parseHexBinary("DE358A58A8769EB4A370A7EE9EC54CDE76CE64C2");

	
	//Methode getTutorTeams
	public ArrayList<HashMap<String,String>> getTutorTeams(String user) throws SQLException{
		StringBuilder sql=new StringBuilder("SELECT team.* FROM team ");
		sql.append("INNER JOIN teammap ON team.teamname_ID=teammap.teamname_ID ");
		sql.append("WHERE teammap.accountname_ID LIKE '");
		sql.append(user);
		sql.append("';");

		return returnArrayList(sql.toString());
	}
	// Method createTeam
	public String createTeam(String lehrstuhl, String projekttitel, String organisationseinheit, String betreuer1,
			String betreuer2) throws SQLException {

		String kennnummer = generateKennnummer(lehrstuhl);
		String sql = "Insert Into team (teamname_ID,teamnummer,projekttitel,projektpfad,organisationseinheitname_ID) Values('"
				+ kennnummer + "','" + kennnummer.substring(2, 4) + "','" + projekttitel + "','" + "/" + kennnummer
				+ "','" + organisationseinheit + "')";
		
		executeUpdate(sql);

		HashMap<String, String> teammap_row = new HashMap<>();
		teammap_row.put("accountname_ID", betreuer1);
		teammap_row.put("teamname_ID", kennnummer);
		this.insertHashMap("teammap", teammap_row);

		HashMap<String, String> teammap_row2 = new HashMap<>();
		teammap_row2.put("accountname_ID", betreuer2);
		teammap_row2.put("teamname_ID", kennnummer);
		this.insertHashMap("teammap", teammap_row2);

		return kennnummer;
	}
	
	//Method createTeamRequest
	public boolean createTeamRequest(String betreuer1, String betreuer2, String projekttitel, String teamvorsitzender, 
			ArrayList<String> teammitglieder)throws SQLException {
		
		LocalDate localDate = LocalDate.now();
		String sql = "INSERT INTO `tempteam`( `datum`, `antragsteller`, `betreuer1`, `betreuer2`, `projekttitel`) VALUES ('"
				+ localDate +"','"+ teamvorsitzender + "','" + betreuer1 + "','" + betreuer2 + "','" + projekttitel + "')";

		if(!executeUpdate(sql))
			return false;
		System.out.println(getSubCat("tempteam", "antragsteller", teamvorsitzender, "tempteamname_ID").get(0));
		String s=getSubCat("tempteam", "antragsteller", teamvorsitzender, "tempteamname_ID").get(0).get("tempteamname_ID");
		System.out.println(s);
		HashMap<String, String> h;
		for(String str:teammitglieder) {
			h = new HashMap();
			h.put("accountname_ID", str);
			h.put("tempteamname_ID", s);
			insertHashMap("tempteammap", h);
		}
		return true;
	}

	// Method setTeamLeader
	public boolean setTeamLeader(String mail) throws SQLException {
		String sql = "UPDATE account SET rollename_ID='Teamleiter' Where accountname_ID Like '" + mail + "'";
		return executeUpdate(sql);
	}

	// Method setPhaseDates
	public boolean setPhaseDates(String phasenName, String startDate, String endDate) throws SQLException {
		String sql = "UPDATE phase SET startDatum='" + startDate + "', endDatum='" + endDate + "' "
				+ "Where phasenname_ID Like '" + phasenName + "'";
		return executeUpdate(sql);
	}

	public boolean updateTable(String table, String iDV, HashMap<String, String> hashMap) throws SQLException {
		Set<String> keys = hashMap.keySet();
		StringBuilder sql = new StringBuilder("UPDATE ");
		sql.append(table);
		sql.append(" SET ");
		for (String s : keys)
			if (!hashMap.get(s).equals("null"))
				sql.append(s + " = '" + hashMap.get(s) + "' ,");
			else
				sql.append(s + " = " + hashMap.get(s) + " ,");
		sql.setLength(sql.length() - 1);
		sql.append("WHERE ");
		sql.append(table);
		sql.append("name_ID LIKE '");
		sql.append(iDV);
		sql.append("';");
		return executeUpdate(sql.toString());
		/*
		 * sql.append(s+" = ? ,");
		 * 
		 * sql.setLength(sql.length()-1); sql.append("WHERE "); sql.append(table);
		 * sql.append("name_ID LIKE "); sql.append(iDV); sql.append(";"); return
		 * executeUpdate(sql.toString(), hashMap, keys);
		 */
	}

	public String getSessionUser(String session_id) throws SQLException {
		StringBuilder sql = new StringBuilder("SELECT accountname_ID FROM sessionmap WHERE sessionmapname_ID = ");
		sql.append(session_id);
		sql.append(" ;");
		if (returnArrayList(sql.toString()).isEmpty())
			return null;
		return returnArrayList(sql.toString()).get(0).get("accountname_ID");
	}

	public boolean deleteRow(String table, String iDV) throws SQLException {
		StringBuilder sql = new StringBuilder("DELETE FROM ");
		sql.append(table);
		sql.append(" WHERE ");
		sql.append(table);
		sql.append("name_ID LIKE '");
		sql.append(iDV);
		sql.append("';");
		return executeUpdate(sql.toString());
	}

	public boolean deleteRow(String table, String iDA, String iDV) throws SQLException {
		StringBuilder sql = new StringBuilder("DELETE FROM ");
		sql.append(table);
		sql.append(" WHERE ");
		sql.append(iDA);
		sql.append(" LIKE '");
		sql.append(iDV);
		sql.append("';");
		return executeUpdate(sql.toString());
	}

	public boolean insertHashMap(String table, HashMap<String, String> hashMap) throws SQLException {
		Set<String> keys = hashMap.keySet();
		StringBuilder sql = new StringBuilder("INSERT INTO ");

		sql.append(table);
		sql.append(" (");
		sql.append(keys.stream().collect(Collectors.joining(",")));
		sql.append(") VALUES (");
		sql.append(String.join(",", Collections.nCopies(hashMap.size(), "?")));
		sql.append(");");

		return executeUpdate(sql.toString(), hashMap, keys);
	}

	// Method getMasterPassword

	public String getMasterPassword(String role) throws SQLException {
		if (role.equals("Juror"))
			return returnArrayList("Select masterpasswordJuror From projectconfiguration").get(0)
					.get("masterpasswordJuror");
		else if (role.equals("Tutor"))
			return returnArrayList("Select masterpasswordTutor From projectconfiguration").get(0)
					.get("masterpasswordTutor");
		else
			return null;
	}

	// Method logout
	public boolean logout(int sessionID) throws SQLException {
		String sql = "Delete From sessionmap Where sessionmapname_ID=" + sessionID;
		return executeUpdate(sql);
	}

	// Method login
	public String login(String mail, String password) throws SQLException {
		String sql = "Select activated From account Where accountname_ID Like '" + mail + "' And password Like '"
				+ password + "'";
		ArrayList<HashMap<String, String>> a = returnArrayList(sql);
		if (a.isEmpty()/* ||!Boolean.parseBoolean(a.get(0).get("activated")) */)
			return null;
		sql = "Insert Into sessionmap (accountname_ID) Values('" + mail + "')";
		executeUpdate(sql);
		sql = "Select sessionmapname_ID From sessionmap Where accountname_ID Like '" + mail + "'";
		return returnArrayList(sql).get(0).get("sessionmapname_ID");

	}

	// Method getRights
	public HashMap<String, String> getRights(int sessionID) throws SQLException {
		StringBuilder sql = new StringBuilder();
		sql.append("Select rolle.accessMarks,rolle.manageProject,rolle.seeAllGroupInformation,rolle.setupGroup ");
		sql.append("From sessionmap Inner Join account on sessionmap.accountname_ID = account.accountname_ID ");
		sql.append("Inner Join rolle on account.rollename_ID=rolle.rollename_ID Where sessionmapname_ID=");
		sql.append(sessionID);
		return returnArrayList(sql.toString()).get(0);
	}

	// Method getSubCat
	public ArrayList<HashMap<String, String>> getSubCat(String table, String iDA, String iDV, String column)
			throws SQLException {
		String sql = "Select " + column + " From " + table + " Where " + iDA + " Like '" + iDV + "'";
		return returnArrayList(sql);
	}

	public ArrayList<HashMap<String, String>> getSubCat(String table, String iDA, String iDV) throws SQLException {
		String sql = "Select * From " + table + " Where " + iDA + " Like '" + iDV + "'";
		return returnArrayList(sql);
	}

	public ArrayList<HashMap<String, String>> getSubCat(String table, String iD) throws SQLException {
		String sql = "Select * From " + table + " Where " + table + "name_ID Like '" + iD + "'";
		return returnArrayList(sql);
	}

	public ArrayList<HashMap<String, String>> getSubCat(String table) throws SQLException {
		String sql = "Select * From " + table + " Where 1";
		return returnArrayList(sql);
	}

	// Method get

	public ArrayList<HashMap<String, String>> getScoreForCriterion(String teamname, String teilkriterium)
			throws SQLException {
		StringBuilder sql = new StringBuilder("SELECT * ");
		sql.append("FROM kriteriumsmap ");
		sql.append("WHERE kriteriumsmap.teamname_ID LIKE '");
		sql.append(teamname);
		sql.append("' AND kriteriumsmap.teilkriteriumname_ID = '");
		sql.append(teilkriterium);
		sql.append("';");
		return returnArrayList(sql.toString());

	}

	// Method getAccountsInGroup
	public ArrayList<HashMap<String, String>> getAccountsInGroup(String group) throws SQLException {
		StringBuilder sql = new StringBuilder("SELECT account.accountname_ID FROM account  ");
		sql.append("INNER JOIN teammap ON account.accountname_ID=teammap.accountname_ID ");
		sql.append("INNER JOIN team ON teammap.teamname_ID=team.teamname_ID ");
		sql.append(
				"INNER JOIN organisationseinheit ON team.organisationseinheitname_ID=organisationseinheit.organisationseinheitname_ID ");
		sql.append(
				"WHERE account.rollename_ID LIKE 'Teilnehmer' AND organisationseinheit.organisationseinheitname_ID LIKE '");
		sql.append(group);
		sql.append(
				"' OR account.rollename_ID LIKE 'Teamleiter' AND organisationseinheit.organisationseinheitname_ID LIKE '");
		sql.append(group);
		sql.append("';");
		return returnArrayList(sql.toString());
	}

	// Method getJurorForGroup()
	public ArrayList<HashMap<String, String>> getJurorsInGroup(String group) throws SQLException {
		StringBuilder sql = new StringBuilder("SELECT account.* FROM account ");
		sql.append("INNER JOIN jurormap ON account.accountname_ID=jurormap.accountname_ID ");
		sql.append(
				"INNER JOIN organisationseinheit ON jurormap.organisationseinheitname_ID=organisationseinheit.organisationseinheitname_ID ");
		sql.append("WHERE account.rollename_ID LIKE 'Juror' ");
		sql.append("AND organisationseinheit.organisationseinheitname_ID LIKE '");
		sql.append(group);
		sql.append("';");
		return returnArrayList(sql.toString());
	}

	// Method getCurrentPhase
	public String getCurrentPhase() throws SQLException {
		LocalDate localDate = LocalDate.now();
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT phasename_ID FROM phase Where startDatum <= '");
		sql.append(localDate);
		sql.append("'And endDatum > '");
		sql.append(localDate);
		sql.append("'");
		ArrayList<HashMap<String, String>> list = returnArrayList(sql.toString());
		return list.isEmpty() ? null : list.get(0).get("phasename_ID");
	}
	
	// Method checkForCurrendPhase
    public boolean checkForCurrentPhase(String phase) throws SQLException {
        LocalDate localDate = LocalDate.now();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT phasename_ID FROM phase Where startDatum <= '");
        sql.append(localDate);
        sql.append("'And endDatum > '");
        sql.append(localDate);
        sql.append("'");
        ArrayList<HashMap<String, String>> list = returnArrayList(sql.toString());

        for(HashMap h:list) {
            if(h.get("phasename_ID").equals(phase))
                return true;
            }
        return false;
    }

	// Method insertNewGroup
	public boolean insertNewGroup(ArrayList<HashMap<String, String>> juroren) throws SQLException {
		StringBuilder sql = new StringBuilder("SELECT organisationseinheitname_ID FROM organisationseinheit;");
		ArrayList<HashMap<String, String>> gruppen = returnArrayList(sql.toString());
		sql.setLength(0);
		sql.append("INSERT INTO organisationseinheit ");
		sql.append("(organisationseinheitname_ID) VALUES ('");
		int i = 0;
		boolean clause = false;
		for (HashMap<String, String> gruppe : gruppen) {
			i++;
			if (!gruppe.get("organisationseinheitname_ID").contains(i + "")) {
				sql.append("Gruppe " + i);
				sql.append("');");
				executeUpdate(sql.toString());
				clause = true;
				break;
			}
		}
		if (!clause) {
			i++;
			sql.append("Gruppe " + i);
			sql.append("');");
			executeUpdate(sql.toString());
		}
		for(HashMap<String, String> juror:juroren) {
			juror.put("organisationseinheitname_ID", "Gruppe "+i);
			insertHashMap("jurormap",juror);
		}
			
		return true;
	}

	////////////// Hilfsmethoden//////////////////////////////////
	// Method getConnection
	public Connection getConnection() throws SQLException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		Connection conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/pep_2018_sose_1?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
				"pep", "XO47mVNIr1qNrECj");
		return conn;
	}

	// Method returnArrayList
	public ArrayList<HashMap<String, String>> returnArrayList(String sql) throws SQLException {
		try (Connection c = getConnection();
				Statement statement = c.createStatement();
				ResultSet result = statement.executeQuery(sql)) {

			ResultSetMetaData resultSetMetaData = result.getMetaData();
			int r = resultSetMetaData.getColumnCount();
			ArrayList<HashMap<String, String>> arrayList = new ArrayList<>();
			HashMap<String, String> hashMap;
			while (result.next()) {
				hashMap = new HashMap<>();
				for (int i = 1; i <= r; i++)
					hashMap.put(resultSetMetaData.getColumnLabel(i), result.getString(i));

				arrayList.add(hashMap);
			}
			return arrayList;
		}
	}

	// Method formatSessionID
	public String formatSessionID(String sessionID) {
		while (sessionID.length() != 8)
			sessionID = "0" + sessionID;
		return sessionID;
	}

	// Method executeUpdate
	public boolean executeUpdate(String sql) throws SQLException {
		try (Connection c = getConnection(); Statement statement = c.createStatement();) {
			statement.executeUpdate(sql);
			return true;
		}
	}

	public boolean executeUpdate(String sql, HashMap<String, String> hashMap, Set<String> keys) throws SQLException {
		try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			int i = 1;
			for (String key : keys)
				stmt.setString(i++, hashMap.get(key));

			stmt.execute();
			return true;
		}
	}

	// Method generateKennnummer
	public String generateKennnummer(String lehrstuhlName) throws SQLException {
		// Get Lehrstuhl
		String sql = "Select lehrstuhlnummer From lehrstuhl Where lehrstuhlname_ID like '" + lehrstuhlName + "'";
		String lehrstuhl = returnArrayList(sql).get(0).get("lehrstuhlnummer");
		//
		// getTeam
		sql = "Select count(*) As anzahl From team Where 1";
		String teamnummer = returnArrayList(sql).get(0).get("anzahl");
		int i = Integer.parseInt(teamnummer);
		while ((i + "").equals(teamnummer))
			i++;
		teamnummer = i + "";
		//
		return printKennnummer(lehrstuhl, teamnummer);
	}

	// Method printKennnummer
	public String printKennnummer(String lehrstuhl, String teamnummer) {
		LocalDate localDate = LocalDate.now();
		int l, t;
		l = Integer.parseInt(lehrstuhl);
		t = Integer.parseInt(teamnummer);
		return ""+(l < 10 ? "0" + l : l) + "" + (t < 10 ? "0" + t : t) + "" + localDate.getYear();
	}

	public static String getHash(byte inputBytes[]) throws NoSuchAlgorithmException {
		MessageDigest messageDigest = MessageDigest.getInstance("SHA-512");
		messageDigest.reset();
		messageDigest.update(inputBytes);
		messageDigest.update(salt);
		byte digestedBytes[] = messageDigest.digest();
		return DatatypeConverter.printHexBinary(digestedBytes);
	}
}

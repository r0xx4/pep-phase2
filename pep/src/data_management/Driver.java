package data_management;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Collections;
import java.util.Set;
import java.util.stream.Collectors;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;
import sun.misc.BASE64Encoder;

public class Driver {

	private static final byte salt[] = DatatypeConverter.parseHexBinary("DE358A58A8769EB4A370A7EE9EC54CDE76CE64C2");
	private static final byte aes[] = "Tb7pfVzbxd1SLIN4".getBytes();
	private ArrayList<String> persData = new ArrayList<>();

	public Driver() {
		persData.add("accountname_ID");
		persData.add("accountname_ID_Bericht");
		persData.add("accountname_ID_Praesentation");
		persData.add("accountname_ID_Poster");
		persData.add("accountname_ID_Zusammenfassung");
		persData.add("vorname");
		persData.add("nachname");
		persData.add("matrikelnummer");
		persData.add("antragsteller");
		persData.add("betreuer1");
		persData.add("betreuer2");
		persData.add("rollename_ID");
		persData.add("studiengangname_ID");
		persData.add("lehrstuhlname_ID");
	}

	public static void main(String[] args) throws IOException, InterruptedException {
		Driver d = new Driver();
		System.out.println(d.backupDatabase());
	}

	public boolean backupDatabase() throws IOException, InterruptedException {
		String dbName = "pep_2018_sose_1";
		String dbUser = "pep";
		String dbPass = "XO47mVNIr1qNrECj";
		String dbPathIn = "C:\\xampp\\mysql\\bin\\mysqldump.exe";
		String dbPathOut = "C:\\Backup\\backup.sql";

		String executeCmd = dbPathIn + " -u " + dbUser + " -p" + dbPass + " " + dbName + " -r " + dbPathOut;
		Process runtimeProcess = Runtime.getRuntime().exec(executeCmd);
		int processComplete = runtimeProcess.waitFor();
		if (processComplete == 0)
			return true;
		else
			return false;
	}

	// Methode getTutorTeams
	public ArrayList<HashMap<String, String>> getTutorTeams(String user) throws SQLException {
		StringBuilder sql = new StringBuilder("SELECT team.* FROM team ");
		sql.append("INNER JOIN teammap ON team.teamname_ID=teammap.teamname_ID ");
		sql.append("WHERE teammap.accountname_ID LIKE ?;");

		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		Set<String> k = h.keySet();
		h.put("accountname_ID", user);
		return returnArrayList(sql.toString(), h, k);
	}

	public boolean activateAccount(int anonymeID) throws SQLException {
		String s = String.valueOf(anonymeID);
		String sql = "SELECT anonyme_ID FROM account WHERE anonyme_ID LIKE ? ;";
		HashMap<String, String> h = new HashMap<>();
		h.put("anonyme_ID", s);
		Set<String> k = h.keySet();
		ArrayList<HashMap<String, String>> a = returnArrayList(sql, h, k);
		if (a == null || a.isEmpty())
			return false;
		else if (a.get(0).get("anonyme_ID").equals(s)) {
			sql = "UPDATE account SET activated=1 WHERE anonyme_ID= ? ;";
			LinkedHashMap<String, String> hashMap = new LinkedHashMap<>();
			hashMap.put("anonyme_ID", s);
			Set<String> set = hashMap.keySet();
			executeUpdate(sql, hashMap, set);
			return true;
		} else
			return false;
	}

	// Method createTeam
	public String createTeam(String lehrstuhl, String projekttitel, String organisationseinheit, String betreuer1,
			String betreuer2) throws SQLException {

		String kennnummer = generateKennnummer(lehrstuhl);

		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put("teamname_ID", kennnummer);
		h.put("teamnummer", kennnummer.substring(2, 4));
		h.put("projekttitel", projekttitel);
		h.put("projektpfad", "/" + kennnummer);
		h.put("organisationseinheitname_ID", organisationseinheit);
		insertHashMap("team", h);

		h = new LinkedHashMap<>();
		h.put("accountname_ID", betreuer1);
		h.put("teamname_ID", kennnummer);
		insertHashMap("teammap", h);

		h = new LinkedHashMap<>();
		h.put("accountname_ID", betreuer2);
		h.put("teamname_ID", kennnummer);
		insertHashMap("teammap", h);

		return kennnummer;
	}

	public boolean deleteTabelContent(String table) throws SQLException {
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		Set<String> k = h.keySet();
		StringBuilder sql = new StringBuilder("DELETE FROM ");
		sql.append(table);
		sql.append(";");
		return executeUpdate(sql.toString(), h, k);
	}

	// Method createTeamRequest
	public boolean createTeamRequest(String betreuer1, String betreuer2, String projekttitel, String teamvorsitzender,
			ArrayList<String> teammitglieder) throws SQLException {

		LocalDate localDate = LocalDate.now();
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put("datum", localDate.toString());
		h.put("antragsteller", teamvorsitzender);
		h.put("betreuer1", betreuer1);
		h.put("betreuer2", betreuer2);
		h.put("projekttitel", projekttitel);

		if (!insertHashMap("tempteam", h))
			return false;
		String s = getSubCat("tempteam", "antragsteller", teamvorsitzender, "tempteamname_ID").get(0)
				.get("tempteamname_ID");

		for (String str : teammitglieder) {
			h = new LinkedHashMap<>();
			h.put("accountname_ID", str);
			h.put("tempteamname_ID", s);
			insertHashMap("tempteammap", h);
		}
		return true;
	}

	// Method setTeamLeader
	public boolean setTeamLeader(String mail) throws SQLException {
		String sql = "UPDATE account SET rollename_ID='Teamleiter' Where accountname_ID Like ? ;";
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put("accountname_ID", mail);
		Set<String> k = h.keySet();
		return executeUpdate(sql, h, k);
	}

	// Method setPhaseDates
	public boolean setPhaseDates(String phasenName, String startDate, String endDate) throws SQLException {
		String sql = "UPDATE phase SET startDatum = ? , endDatum = ? Where phasename_ID Like ? ;";
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put("startDatum", startDate);
		h.put("endDatum", endDate);
		h.put("phasenname_ID", phasenName);
		Set<String> k = h.keySet();

		return executeUpdate(sql, h, k);
	}

	public boolean updateTable(String table, String iDV, HashMap<String, String> hashMap) throws SQLException {
		Set<String> keys = hashMap.keySet();
		StringBuilder sql = new StringBuilder("UPDATE ");
		sql.append(table);
		sql.append(" SET ");
		for (String s : keys)
			sql.append(s + " = ? ,");

		sql.setLength(sql.length() - 1);

		String temp = table + "name_ID";
		hashMap.put(temp, iDV);
		keys = hashMap.keySet();
		sql.append("WHERE ");
		sql.append(table);
		sql.append("name_ID LIKE ? ;");

		return executeUpdate(sql.toString(), hashMap, keys);
	}

	public String getSessionUser(String session_id) throws SQLException {
		String sql = "SELECT accountname_ID FROM sessionmap WHERE sessionmapname_ID = ? ;";
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put("sessionmapname_ID", session_id);
		Set<String> k = h.keySet();
		ArrayList<HashMap<String, String>> a = returnArrayList(sql, h, k);
		if (a.isEmpty())
			return null;
		return a.get(0).get("accountname_ID");
	}

	public boolean deleteRow(String table, String iDV) throws SQLException {
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put(table + "name_ID", iDV);
		Set<String> k = h.keySet();
		StringBuilder sql = new StringBuilder("DELETE FROM ");
		sql.append(table);
		sql.append(" WHERE ");
		sql.append(table);
		sql.append("name_ID LIKE ?");

		return executeUpdate(sql.toString(), h, k);
	}

	public boolean deleteRow(String table, String iDA, String iDV) throws SQLException {
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put(iDA, iDV);
		Set<String> k = h.keySet();
		StringBuilder sql = new StringBuilder("DELETE FROM ");
		sql.append(table);
		sql.append(" WHERE ");
		sql.append(iDA);
		sql.append(" LIKE ? ;");

		return executeUpdate(sql.toString(), h, k);
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

	public String getMasterPassword(String role) throws SQLException {
		HashMap<String, String> h = new HashMap<>();
		Set<String> k = h.keySet();
		if (role.equals("Juror"))
			return returnArrayList("Select masterpasswordJuror From projectconfiguration", h, k).get(0)
					.get("masterpasswordJuror");
		else if (role.equals("Tutor"))
			return returnArrayList("Select masterpasswordTutor From projectconfiguration", h, k).get(0)
					.get("masterpasswordTutor");
		else
			return null;
	}

	// Method logout
	public boolean logout(int sessionID) throws SQLException {
		String sql = "Delete From sessionmap Where sessionmapname_ID= ? ;";
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put("sessionmapname_ID", String.valueOf(sessionID));
		Set<String> k = h.keySet();
		return executeUpdate(sql, h, k);
	}

	// Method login
	public String login(String mail, String password) throws SQLException {
		String sql = "Select activated From account Where accountname_ID Like ? And password Like ? ;";
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put("accountname_ID", mail);
		h.put("password", password);
		Set<String> k = h.keySet();
		ArrayList<HashMap<String, String>> a = returnArrayList(sql, h, k);
		if (a == null || a.isEmpty()/* ||!Boolean.parseBoolean(a.get(0).get("activated")) */)
			return null;
		sql = "Insert Into sessionmap (accountname_ID) Values(?) ;";
		h = new LinkedHashMap<>();
		h.put("accountname_ID", mail);
		k = h.keySet();
		executeUpdate(sql, h, k);
		sql = "Select sessionmapname_ID From sessionmap Where accountname_ID Like ? ;";
		return returnArrayList(sql, h, k).get(0).get("sessionmapname_ID");

	}

	// Method getRights
	public HashMap<String, String> getRights(int sessionID) throws SQLException {
		StringBuilder sql = new StringBuilder();
		sql.append("Select rolle.accessMarks,rolle.manageProject,rolle.seeAllGroupInformation,rolle.setupGroup ");
		sql.append("From sessionmap Inner Join account on sessionmap.accountname_ID = account.accountname_ID ");
		sql.append("Inner Join rolle on account.rollename_ID=rolle.rollename_ID Where sessionmapname_ID= ? ;");
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put("sessionmapname_ID", String.valueOf(sessionID));
		Set<String> k = h.keySet();
		return returnArrayList(sql.toString(), h, k).get(0);
	}

	// Method getSubCat
	public ArrayList<HashMap<String, String>> getSubCat(String table, String iDA, String iDV, String column)
			throws SQLException {
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put(iDA, iDV);
		Set<String> k = h.keySet();
		String sql = "Select " + column + " From " + table + " Where " + iDA + " Like ? ;";
		return returnArrayList(sql, h, k);
	}

	public ArrayList<HashMap<String, String>> getSubCat(String table, String iDA, String iDV) throws SQLException {
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put(iDA, iDV);
		Set<String> k = h.keySet();
		String sql = "Select * From " + table + " Where " + iDA + " Like ? ;";
		return returnArrayList(sql, h, k);
	}

	public ArrayList<HashMap<String, String>> getSubCat(String table, String iD) throws SQLException {
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put(table + "name_ID", iD);
		Set<String> k = h.keySet();
		String sql = "Select * From " + table + " Where " + table + "name_ID Like ? ;";
		return returnArrayList(sql, h, k);
	}

	public ArrayList<HashMap<String, String>> getSubCat(String table) throws SQLException {
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		Set<String> k = h.keySet();
		String sql = "Select * From " + table + " Where 1";
		return returnArrayList(sql, h, k);
	}

	// Method get

	public ArrayList<HashMap<String, String>> getScoreForCriterion(String teamname, String teilkriterium)
			throws SQLException {
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put("teamname_ID", teamname);
		h.put("teilkriteriumname_ID", teilkriterium);
		Set<String> k = h.keySet();
		StringBuilder sql = new StringBuilder("SELECT * ");
		sql.append("FROM kriteriumsmap ");
		sql.append("WHERE kriteriumsmap.teamname_ID LIKE ?");
		sql.append(" AND kriteriumsmap.teilkriteriumname_ID = ? ;");

		return returnArrayList(sql.toString(), h, k);

	}

	// Method getAccountsInGroup
	public ArrayList<HashMap<String, String>> getAccountsInGroup(String group) throws SQLException {
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put("organisationseinheitname_ID", group);
		h.put("organisationseinheitname_ID2", group);
		Set<String> k = h.keySet();
		StringBuilder sql = new StringBuilder("SELECT account.accountname_ID FROM account  ");
		sql.append("INNER JOIN teammap ON account.accountname_ID=teammap.accountname_ID ");
		sql.append("INNER JOIN team ON teammap.teamname_ID=team.teamname_ID ");
		sql.append(
				"INNER JOIN organisationseinheit ON team.organisationseinheitname_ID=organisationseinheit.organisationseinheitname_ID ");
		sql.append(
				"WHERE account.rollename_ID LIKE 'Teilnehmer' AND organisationseinheit.organisationseinheitname_ID LIKE ? ");
		sql.append(
				"OR account.rollename_ID LIKE 'Teamleiter' AND organisationseinheit.organisationseinheitname_ID LIKE ? ;");
		return returnArrayList(sql.toString(), h, k);
	}

	// Method getJurorForGroup()
	public ArrayList<HashMap<String, String>> getJurorsInGroup(String group) throws SQLException {
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put("organisationseinheitname_ID", group);
		Set<String> k = h.keySet();
		StringBuilder sql = new StringBuilder("SELECT account.* FROM account ");
		sql.append("INNER JOIN jurormap ON account.accountname_ID=jurormap.accountname_ID ");
		sql.append(
				"INNER JOIN organisationseinheit ON jurormap.organisationseinheitname_ID=organisationseinheit.organisationseinheitname_ID ");
		sql.append("WHERE account.rollename_ID LIKE 'Juror' ");
		sql.append("AND organisationseinheit.organisationseinheitname_ID LIKE ? ;");
		return returnArrayList(sql.toString(), h, k);
	}

	// Method checkForCurrendPhase
	public boolean checkForCurrentPhase(String phase) throws SQLException {
		LocalDate localDate = LocalDate.now();
		StringBuilder sql = new StringBuilder();
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put("localdate", phase);
		h.put("localdate1", phase);
		Set<String> k = h.keySet();
		sql.append("SELECT phasename_ID FROM phase Where startDatum <= ? ");
		sql.append("And endDatum > ? ;");
		ArrayList<HashMap<String, String>> list = returnArrayList(sql.toString(), h, k);

		for (HashMap<String, String> hMap : list) {
			if (hMap.get("phasename_ID").equals(phase))
				return true;
		}
		return false;
	}

	// Method insertNewGroup
	public boolean insertNewGroup(ArrayList<HashMap<String, String>> juroren) throws SQLException {
		StringBuilder sql = new StringBuilder("SELECT organisationseinheitname_ID FROM organisationseinheit;");
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		Set<String> k = h.keySet();
		ArrayList<HashMap<String, String>> gruppen = returnArrayList(sql.toString(), h, k);
		int i = 0;
		boolean clause = false;
		for (HashMap<String, String> gruppe : gruppen) {
			i++;
			if (!gruppe.get("organisationseinheitname_ID").contains(i + "")) {
				h = new LinkedHashMap<>();
				h.put("organisationseinheitname_ID", "Gruppe " + i);
				insertHashMap("organisationseinheit", h);
				clause = true;
				break;
			}
		}
		if (!clause) {
			i++;
			h = new LinkedHashMap<>();
			h.put("organisationseinheitname_ID", "Gruppe " + i);
			insertHashMap("organisationseinheit", h);
		}
		for (HashMap<String, String> juror : juroren) {
			juror.put("organisationseinheitname_ID", "Gruppe " + i);
			insertHashMap("jurormap", juror);
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

	// returnArrayList
	public ArrayList<HashMap<String, String>> returnArrayList(String sql, HashMap<String, String> h, Set<String> keys)
			throws SQLException {
		try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			int i = 1;
			for (String key : keys)
				if (persData.contains(key))
					stmt.setString(i++, encryptData(h.get(key)));
				else
					stmt.setString(i++, h.get(key));

			try (ResultSet result = stmt.executeQuery()) {
				ResultSetMetaData resultSetMetaData = result.getMetaData();
				int r = resultSetMetaData.getColumnCount();
				ArrayList<HashMap<String, String>> arrayList = new ArrayList<>();
				HashMap<String, String> hashMap;
				while (result.next()) {
					hashMap = new HashMap<>();
					for (i = 1; i <= r; i++) {
						String column = resultSetMetaData.getColumnLabel(i);
						String data = result.getString(i);
						if (persData.contains(column) && data != null)
							hashMap.put(column, decryptData(data));
						else
							hashMap.put(column, data);
					}
					arrayList.add(hashMap);
				}
				return arrayList;
			}
		}
	}

	// Method executeUpdate

	public boolean executeUpdate(String sql, HashMap<String, String> hashMap, Set<String> keys) throws SQLException {
		try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			int i = 1;
			for (String key : keys)
				if (persData.contains(key) && hashMap.get(key) != null)
					stmt.setString(i++, encryptData(hashMap.get(key)));
				else
					stmt.setString(i++, hashMap.get(key));

			stmt.execute();
			return true;
		}
	}

	// Method generateKennnummer
	public String generateKennnummer(String lehrstuhlName) throws SQLException {
		// Get Lehrstuhl
		LinkedHashMap<String, String> h = new LinkedHashMap<>();
		h.put("lehrstuhlname_ID", lehrstuhlName);
		Set<String> k = h.keySet();
		String sql = "Select lehrstuhlnummer From lehrstuhl Where lehrstuhlname_ID like ?";
		String lehrstuhl = returnArrayList(sql, h, k).get(0).get("lehrstuhlnummer");
		//
		// getTeam
		sql = "Select count(*) As anzahl From team Where 1";
		h = new LinkedHashMap<>();
		k = h.keySet();
		String teamnummer = returnArrayList(sql, h, k).get(0).get("anzahl");
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
		return "" + (l < 10 ? "0" + l : l) + "" + (t < 10 ? "0" + t : t) + "" + localDate.getYear();
	}

	public static String getHash(byte inputBytes[]) throws NoSuchAlgorithmException {
		MessageDigest messageDigest = MessageDigest.getInstance("SHA-512");
		messageDigest.reset();
		messageDigest.update(inputBytes);
		messageDigest.update(salt);
		byte digestedBytes[] = messageDigest.digest();
		return DatatypeConverter.printHexBinary(digestedBytes);
	}

	public String encryptData(String s) {
		try {
			Cipher c = Cipher.getInstance("AES");
			SecretKeySpec key = new SecretKeySpec(aes, "AES");
			c.init(Cipher.ENCRYPT_MODE, key);
			byte b[] = c.doFinal(s.getBytes());
			s = new BASE64Encoder().encode(b);
			return s;
		} catch (NoSuchAlgorithmException | NoSuchPaddingException | IllegalBlockSizeException | BadPaddingException
				| InvalidKeyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}

	public String decryptData(String s) {
		Cipher cipher;
		try {
			cipher = Cipher.getInstance("AES");
			SecretKeySpec key = new SecretKeySpec(aes, "AES");
			cipher.init(Cipher.DECRYPT_MODE, key);
			// _"CHTC#E !
			byte decodedString[] = Base64.getDecoder().decode(s.getBytes());
			// byte decodedString[]=new BASE64Decoder().decodeBuffer(s);
			byte b[] = cipher.doFinal(decodedString);
			s = new String(b);
			return s;
			// return DatatypeConverter.printBase64Binary(b);
		} catch (NoSuchAlgorithmException | NoSuchPaddingException | IllegalBlockSizeException | BadPaddingException
				| InvalidKeyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return s;
		} catch (IllegalArgumentException e) {
			System.out.println("Base64 Error");
			return s;
		}
	}

}

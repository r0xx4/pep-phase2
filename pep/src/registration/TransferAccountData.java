package registration;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data_management.Driver;

/**
 * Servlet implementation class TransferLoginData
 */
@WebServlet("/registration/transfer_account_data")
public class TransferAccountData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TransferAccountData() {
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
		HashMap<String, String> account_data = new HashMap<>();
		for (String key : request.getParameterMap().keySet())
		{
			if (!request.getParameterMap().get(key)[0].equals(""))
				account_data.put(key, request.getParameterMap().get(key)[0]);
			else
				account_data.put(key, null);
		}
		Driver datenhaltung = new Driver();
		try 
		{
			account_data.put("password", Driver.getHash(account_data.get("password").getBytes(StandardCharsets.UTF_8)));
		} 
		catch (NoSuchAlgorithmException e1) 
		{
			e1.printStackTrace();
		}
		try 
		{
			if (account_data.get("rollename_ID").equals("Teilnehmer") || account_data.get("masterkey").equals(datenhaltung.getMasterPassword(account_data.get("rollename_ID"))))
			{
				account_data.remove("masterkey");
				datenhaltung.insertHashMap("account", account_data);
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("window.open(\"/pep/login\", \"_self\")");
				out.println("</script>");
				out.close();
			}
			else
			{
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("window.open(\"/pep/registration\", \"_self\")");
				out.println("</script>");
				out.close();
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
}

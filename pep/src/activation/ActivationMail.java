package activation;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
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
 * Servlet implementation class ActivationMail
 */
@WebServlet("/activation_mail")
public class ActivationMail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ActivationMail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("hi");
		
		Driver datenhaltung = new Driver();
		try {
			
		String query = request.getQueryString();
		String id=query.split("&")[0].split("=")[1];
		String pw=query.split("&")[1].split("=")[1];
		
		ArrayList<HashMap<String, String>> user =datenhaltung.getSubCat("account", "anonyme_ID", id);
		String pworg=user.get(0).get("bestaetigungspasswort");
		if(pw.equals(pworg))
		{
			System.out.println("lol");
			//datenhaltung.activate(id);
			PrintWriter out = response.getWriter();
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<meta charset=\"utf-8\">");
			out.println("</head>");
			out.println("<body>");
			out.println("<script>");
			out.println("window.alert(\"Aktivierung  Erfolgreich\");");
			out.println("</script>");
			out.println("</body>");
			out.close();
		}
		else
		{
			PrintWriter out = response.getWriter();
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<meta charset=\"utf-8\">");
			out.println("</head>");
			out.println("<body>");
			out.println("<script>");
			out.println("window.alert(\"Aktivierung  fehlgeschlagen bitte versuchen sie es erneut oder wenden sie sich an den Administrator!\");");
				out.println("</script>");
			out.println("</body>");
			out.close();
		}
		}
		catch (Exception e)
		{
			PrintWriter out = response.getWriter();
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<meta charset=\"utf-8\">");
			out.println("</head>");
			out.println("<body>");
			out.println("<script>");
			out.println("window.alert(\"Aktivierungs fehler bitte versuchen sie es erneut oder wenden sie sich an den Administrator\");");
			out.println("</script>");
			out.println("</body>");
			out.close();
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

}

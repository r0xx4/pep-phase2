package download;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.log.SysoCounter;

import data_management.Driver;

/**
 * Servlet implementation class ProvideProjectFileDownload
 */
@WebServlet("/provide_project_file_download")
public class ProvideProjectFileDownload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProvideProjectFileDownload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Driver datenhaltung = new Driver();
		
        String file = "";
        String path;
		
		String query = request.getQueryString();
		String split1 = query.split("&")[0];
		String split2 = query.split("&")[1];
		String filetype = split1.split("=")[1];
		String team = split2.split("=")[1];
		String teamPath = "";
		if(filetype.equals("documentation")){
			file = "Bericht.pdf";
		}
		else if(filetype.equals("presentation")){
			file = "Praesentation.pdf";
		}
		else if(filetype.equals("poster")){
			file = "Poster.pdf";
		}
		else if(filetype.equals("summary")){
			file = "Zusammenfassung.pdf";
		}
		else {
			file = "null";
		}
		
		
		
		try {
			teamPath = datenhaltung.getSubCat("team", "teamname_ID", team, "projektpfad").get(0).get("projektpfad");
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        path = "C:/data"+ teamPath +"/";

        PrintWriter out = response.getWriter();

        try {
        	
        	File datei = new File(path+file);
        	if(datei.exists()) {
        		response.setContentType("application/pdf");
        		response.setContentType("APPLICATION/OCTET-STREAM");
                response.setHeader("Content-Disposition", "attachment; filename=\""+file+"\"");
        		
            	FileInputStream fileInputStream;
            	fileInputStream = new FileInputStream(path+file);
            	System.out.println(path+file);
            	
        		int i;
                while((i = fileInputStream.read()) != -1) {
                    out.write(i);
                }
                
                fileInputStream.close();
                out.close();
        	}
        	else {
        		out.println("<script>");
        		out.println("window.open(\"/pep/home/show_teams\", \"_self\")");
        		out.println("</script>");
        		out.close();
        	}
        	
        }catch(FileNotFoundException e) {
        	
        }
		
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

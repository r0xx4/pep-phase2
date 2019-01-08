package handle_post_requests;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


import data_management.Driver;

/**
 * Servlet implementation class HandleFileUpload
 */
@WebServlet("/file_upload")
@MultipartConfig
public class HandleFileUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ServletFileUpload uploader;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleFileUpload() {
        super();
    }
    
    @Override 
    public void init() throws ServletException{
		DiskFileItemFactory filefactory = new DiskFileItemFactory();
		filefactory.setRepository((File) getServletContext().getAttribute("FILES_DIR_FILE"));
		this.uploader = new ServletFileUpload(filefactory);
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
		HttpSession session = request.getSession();
		String session_ID = (String)(session.getAttribute("session_id"));
		try
		{
			String accountname_ID = datenhaltung.getSubCat("sessionmap", session_ID).get(0).get("accountname_ID");
			ArrayList<HashMap<String, String>> team_db_format = datenhaltung.getSubCat("teammap", "accountname_ID", accountname_ID, "teamname_ID");
			if (team_db_format.isEmpty())
			{
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("window.open(\"/pep/home\", \"_self\")");
				out.println("</script>");
				out.close();
			}
			else
			{
				String team = team_db_format.get(0).get("teamname_ID");
				String dateipfad_team = datenhaltung.getSubCat("team", "teamname_ID", team, "projektpfad").get(0).get("projektpfad");
				try
				{
					List<FileItem> fileItemsList = uploader.parseRequest(request);
					Iterator<FileItem> fileItemsIterator = fileItemsList.iterator();
					while(fileItemsIterator.hasNext())
					{
						FileItem fileItem = fileItemsIterator.next();
						String pathname = "C:/data" + dateipfad_team + "/" + fileItem.getFieldName() + ".pdf";
						File target = new File(pathname);
						System.out.println(fileItem);
						fileItem.write(target);
					}
				}
				catch (Exception e) 
				{
					e.printStackTrace();
				}
				
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("window.open(\"/pep/home/show_project\", \"_self\")");
				out.println("</script>");
				out.close();
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
}

package download;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ProvideSystemBackupDownload
 */
@WebServlet("/provide_system_backup_download")
public class ProvideSystemBackupDownload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProvideSystemBackupDownload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Ordner C:\Backup\ und C:\backup.zip löschen wenn existent 
		File f1 = new File("C:\\Backup\\");
		File f2 = new File("C:\\backup.zip");
		deleteDirectory(f1);
		if(f2.exists()){
			f2.delete();
		}
		
		//"Backup"-Ordner C:\Backup\ erstellen
		new File("C:\\Backup").mkdir();
		
		//data-Ordner kopieren und unter C:\Backup\ einfügen
		copyFolder(new File("C:\\data\\"), new File("C:\\Backup\\"));
		
		//Datenbank unter C:\Backup\ speichern
			//   @IVAN BITTE FUNKTION ERSTELLEN
		
		//Ordner C:\Backup\ zippen und unter C:\backup.zip speichern
		FileOutputStream fos = new FileOutputStream("C:\\Old Backups\\backup.zip");
        File d = new File("C:\\Backup");
        File[] srcFiles = d.listFiles();
        
        ZipOutputStream zipOut = new ZipOutputStream(fos);
        for(int i=0; i<srcFiles.length; i++) {
            File fileToZip = srcFiles[i];
            FileInputStream fis = new FileInputStream(fileToZip);
            ZipEntry zipEntry = new ZipEntry(fileToZip.getName());
            zipOut.putNextEntry(zipEntry);
 
            byte[] bytes = new byte[1024];
            int length;
            while((length = fis.read(bytes)) >= 0) {
                zipOut.write(bytes, 0, length);
            }
            fis.close();
        }
        zipOut.close();
        fos.close();
		
		//Zip datei übertragenzu Client
		
		
		RequestDispatcher rd = request.getRequestDispatcher("/home/index_startseite_admin.jsp");
		rd.forward(request,  response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public static boolean deleteDirectory(File dir){
		if (dir.isDirectory()){
		File[] files = dir.listFiles();
		for (File aktFile: files){
		deleteDirectory(aktFile);
		}

		}
		return dir.delete();
	}

	private static void copyFolder(File source, File destination) throws IOException {
		 if (source.isDirectory())
		    {
		        if (!destination.exists())
		        {
		            destination.mkdirs();
		        }

		        String files[] = source.list();

		        for (String file : files)
		        {
		            File srcFile = new File(source, file);
		            File destFile = new File(destination, file);

		            copyFolder(srcFile, destFile);
		        }
		    }
		    else
		    {
		        InputStream in = null;
		        OutputStream out = null;

		        try
		        {
		            in = new FileInputStream(source);
		            out = new FileOutputStream(destination);

		            byte[] buffer = new byte[1024];

		            int length;
		            while ((length = in.read(buffer)) > 0)
		            {
		                out.write(buffer, 0, length);
		            }
		        }
		        catch (Exception e)
		        {
		            try
		            {
		                in.close();
		            }
		            catch (IOException e1)
		            {
		                e1.printStackTrace();
		            }

		            try
		            {
		                out.close();
		            }
		            catch (IOException e1)
		            {
		                e1.printStackTrace();
		            }
		        }
		    }
	}
}

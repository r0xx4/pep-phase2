package download;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
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

import data_management.Driver;

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
		
		//"Backup"-Ordner C:\Backup\ und C:\Old Backups\ erstellen
		new File("C:\\Backup").mkdir();
		new File("C:\\Old Backups").mkdir();
		
		//data-Ordner kopieren und unter C:\Backup\ einfügen
		try {
			copyFolder(new File("C:\\data\\"), new File("C:\\Backup\\Projektdaten\\"));
		}catch(FileNotFoundException e) {
			
		}
		
		//Datenbank unter C:\Backup\ speichern
			//   @IVAN BITTE FUNKTION ERSTELLEN
		Driver datenhaltung = new Driver();
		// dbPathIn muss in backupDatabase noch auf Server Path geändert werden
		try {
			datenhaltung.backupDatabase();
		} catch (InterruptedException e1) {
			e1.printStackTrace();
		}
		//Ordner C:\Backup\ zippen und unter C:\backup.zip speichern      
        try {
			zipFolder("C:\\Backup", "C:\\Old Backups\\backup.zip");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//Zip datei übertragenzu Client
        PrintWriter out = response.getWriter();

        try {
        	
        	File datei = new File("C:\\Old Backups\\backup.zip");
        	if(datei.exists()) {
        		response.setContentType("application/pdf");
        		response.setContentType("APPLICATION/OCTET-STREAM");
                response.setHeader("Content-Disposition", "attachment; filename=\""+"backup.zip"+"\"");
        		
            	FileInputStream fileInputStream;
            	fileInputStream = new FileInputStream("C:\\Old Backups\\backup.zip");
            	
        		int i;
                while((i = fileInputStream.read()) != -1) {
                    out.write(i);
                }
                
                fileInputStream.close();
                out.close();
        	}
        	else {
        		out.println("<script>");
        		out.println("window.open(\"/pep/home\", \"_self\")");
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
		if (source.isDirectory()) {
	        if (!destination.exists()) {
	            destination.mkdirs();
	        }

	        String files[] = source.list();

	        for (String file : files) {
	            File srcFile = new File(source, file);
	            File destFile = new File(destination, file);

	            copyFolder(srcFile, destFile);
	        }
	    }
	    else {
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
	            in.close();
	            out.close();
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
	
	
	static public void zipFolder(String srcFolder, String destZipFile) throws Exception {
	    ZipOutputStream zip = null;
	    FileOutputStream fileWriter = null;
	    fileWriter = new FileOutputStream(destZipFile);
	    zip = new ZipOutputStream(fileWriter);
	    addFolderToZip("", srcFolder, zip);
	    zip.flush();
	    zip.close();
	  }
	  static private void addFileToZip(String path, String srcFile, ZipOutputStream zip)
	      throws Exception {
	    File folder = new File(srcFile);
	    if (folder.isDirectory()) {
	      addFolderToZip(path, srcFile, zip);
	    } else {
	      byte[] buf = new byte[1024];
	      int len;
	      FileInputStream in = new FileInputStream(srcFile);
	      zip.putNextEntry(new ZipEntry(path + "/" + folder.getName()));
	      while ((len = in.read(buf)) > 0) {
	        zip.write(buf, 0, len);
	      }
	    }
	  }

	  static private void addFolderToZip(String path, String srcFolder, ZipOutputStream zip)
	      throws Exception {
	    File folder = new File(srcFolder);

	    for (String fileName : folder.list()) {
	      if (path.equals("")) {
	        addFileToZip(folder.getName(), srcFolder + "/" + fileName, zip);
	      } else {
	        addFileToZip(path + "/" + folder.getName(), srcFolder + "/" +   fileName, zip);
	      }
	    }
	  }

	
}

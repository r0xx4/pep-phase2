package activation;
import com.sun.mail.smtp.SMTPTransport;
import java.security.Security;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.*;

import data_management.Driver;

import javax.activation.*;

public class SendMail {
	
	
	public static void sendGMX(String receiver) throws MessagingException
	{
		try {
		
	    String sender = "AktivierungPeP@gmx.de ";
	    String password = "Adgjl@12";
	   
	    Properties properties = new Properties();

	    properties.put("mail.transport.protocol", "smtp");
	    properties.put("mail.smtp.host", "mail.gmx.net");
	    properties.put("mail.smtp.ssl.trust", "mail.gmx.net");
	    properties.put("mail.smtp.starttls.enable", "true");
	    properties.put("mail.smtp.port", "25");
	    properties.put("mail.smtp.auth", "true");
	    properties.put("mail.smtp.user", sender);
	    properties.put("mail.smtp.password", password);
	    properties.put("mail.smtp.starttls.enable", "true");

	    Session mailSession = Session.getInstance(properties, new Authenticator()
	    {
	        @Override
	        protected PasswordAuthentication getPasswordAuthentication()
	        {
	            return new PasswordAuthentication(properties.getProperty("mail.smtp.user"),
	                    properties.getProperty("mail.smtp.password"));
	        }
	    });

	    Message message = new MimeMessage(mailSession);
	    InternetAddress addressTo = new InternetAddress(receiver);
	    message.setRecipient(Message.RecipientType.TO, addressTo);
	    message.setFrom(new InternetAddress(sender));
	    message.setSubject("Aktivierungsmail für das PeP");
		 //to-Do mit driver
		Driver datenhaltung = new Driver();
		ArrayList<HashMap<String, String>> user=getSubCat("account", "accountname_ID", to);
		String pw=user.get(0).get("bestaetigungspasswort");
		String id=user.get(0).get("anonyme_ID");
		String msg = "Bitte klicken sie auf den folgenden Link um ihren account zu aktivieren: /n "+ "http://localhost:8080/pep/Activation_Mail?ID="+"id"+"&Password="+"pw";
		
	    Transport.send(message);
		}
		catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		}
}


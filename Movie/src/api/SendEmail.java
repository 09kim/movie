package api;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Properties;
import java.util.Random;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


/**
 * @class ExampleSend
 * @brief This sample code demonstrate how to send sms through CoolSMS Rest API PHP
 */
public class SendEmail {
	
	public String getCertificationNum(String email) {

		Random r = new Random();
		String certificationNum_email = String.valueOf(r.nextInt(10)) + String.valueOf(r.nextInt(10)) +  String.valueOf(r.nextInt(10)) + String.valueOf(r.nextInt(10)) + String.valueOf(r.nextInt(10)) + String.valueOf(r.nextInt(10));
		String host = "http://localhost:8080/MVC_EmailTest/";
		String from = "lineage900000@gmail.com";
		String to = email;
		String subject = "이메일 인증 테스트입니다.";
		String content = "인증코드입니다.<br>" + certificationNum_email ;
		Properties p = new Properties();
		p.put("mail.smtp.user", from);
		p.put("mail.smtp.host", "smtp.googlemail.com");
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		
		try{
			Authenticator auth = new Gmail();
			Session ses = Session.getInstance(p,auth);
			ses.setDebug(true);
			MimeMessage msg = new MimeMessage(ses);
			msg.setSubject(subject);
			Address fromAddr = new InternetAddress(from);
			msg.setFrom(fromAddr);
			Address toAddr = new InternetAddress(to);
			msg.addRecipient(Message.RecipientType.TO,toAddr);
			msg.setContent(content,"text/html;charset=UTF8");
			Transport.send(msg);
			
			
			
		} catch (Exception e){
			e.printStackTrace();
		}
		return certificationNum_email;
	}
	
}



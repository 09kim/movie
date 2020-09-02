package api;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SendEmailForget {
	
	
	public static String randNum() {
		Random rand = new Random();
		String numStr = ""; //난수가 저장될 변수
		for(int i=0;i<6;i++) {
			//0~9 까지 난수 생성
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}
		return numStr;
	}
	
	
	public static void gmailSend(String email) {
        String user = "itwbs.jspmail@gmail.com"; // gmail 계정
        String password = "itwill192837";   // 패스워드

        // SMTP 서버 정보를 설정한다.
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com"); 
        prop.put("mail.smtp.port", 465); 
        prop.put("mail.smtp.auth", "true"); 
        prop.put("mail.smtp.ssl.enable", "true"); 
        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        
        Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            

            //수신자메일주소
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email)); 

            // Subject
            message.setSubject("인증메일입니다."); //메일 제목을 입력

            // Text
            message.setText(randNum());    //메일 내용을 입력

            // send the message
            Transport.send(message); ////전송
            System.out.println("인증메일을 보냈습니다.");
        } catch (AddressException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (MessagingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

}

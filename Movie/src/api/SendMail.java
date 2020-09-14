package api;
import java.security.MessageDigest;
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


/**
 * @class ExampleSend
 * @brief This sample code demonstrate how to send sms through CoolSMS Rest API PHP
 */
public class SendMail { // 낙원(0902:SendMessage.java를 기능별[SendMail,SendSMS]로 분류 및 삭제)
	
	private static String subject;
    private static String content;
    private static String to;
    private static String from;
    private static String certificationNum;
    private static String password;   // 패스워드
    
 // 인증코드 생성 메서드
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
	
    private SendMail(String email) {
    	this.subject = "[갓챠]이메일 인증 코드입니다.";
		this.certificationNum = randNum();
		this.content = "이메일 확인을 위해서 다음 코드를 입력해주세요.<br>" + certificationNum ;
		this.to = email;
		this.from = "lineage900000@gmail.com";
		this.password = "lineage900001!";
	};

	private static SendMail instance;
	
	public static SendMail getInstance(String email) {
		if(instance==null) {
			instance = new SendMail(email);
		} else {
			// 낙원(0902:싱글톤 패턴으로 인스턴스를 여러개 생성하지 못하게 제어 및 재 인증 시 새로운 인증번호가 적용되도록하는 갱신 기능 추가)
			// 싱글톤 패턴이므로 SendMail 객체가 존재하는경우 인증번호/인증번호가 포함된 메세지내용/email주소는 새로 갱신되어야 하므로
			// 변수 초기화 추가
			instance.certificationNum = randNum();
			instance.content = "이메일 확인을 위해서 다음 코드를 입력해주세요.<br>" + certificationNum ;
			instance.to = email;
		}
		return instance;
	}
	
	
	
	
	
	// 해쉬 코드 방식 인증코드 생성 메서드
	public static String getSHA256(String input) {
		StringBuffer result = new StringBuffer();
	
	try {
		MessageDigest digest=MessageDigest.getInstance("SHA-256");
		byte[] salt = "Hello! This is Salt.".getBytes();
		digest.reset();
		digest.update(salt);
		byte[] chars = digest.digest(input.getBytes("UTF-8"));
		for(int i = 0; i< chars.length;i++) {
			String hex = Integer.toHexString(0xff & chars[i]);
			if(hex.length()==1) result.append("0");
			result.append(hex);
		}
	}catch(Exception e) {
		e.printStackTrace();
	}
	return result.toString();
}
	
	
	
	
	
	
	public static String mailSend() {
        String user = from; // gmail 계정

        // SMTP 서버 정보를 설정한다.
        Properties prop = new Properties();
        
        prop.put("mail.smtp.user", user);
		prop.put("mail.smtp.host", "smtp.googlemail.com");
		prop.put("mail.smtp.port", "465");
		prop.put("mail.smtp.starttls.enable", "true");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true"); 
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		prop.put("mail.smtp.debug", "true");
		prop.put("mail.smtp.socketFactory.port", "465");
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		prop.put("mail.smtp.socketFactory.fallback", "false");
        
        Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });
        

        try {
    		
    		session.setDebug(true);
    		
            MimeMessage message = new MimeMessage(session);
            
            message.setFrom(new InternetAddress(user));
            
            //수신자메일주소
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to)); 

            // Subject
            message.setSubject(subject); //메일 제목을 입력

            // Text
            message.setContent(content,"text/html;charset=UTF8");

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
        return certificationNum;
    }
}







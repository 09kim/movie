package api;
import java.util.HashMap;
import java.util.Random;

import org.json.simple.JSONObject;

import net.nurigo.java_sdk.exceptions.CoolsmsException;


/**
 * @class ExampleSend
 * @brief This sample code demonstrate how to send sms through CoolSMS Rest API PHP
 */
public class SendSMS { // 낙원(0902:SendMessage.java를 기능별[SendMail,SendSMS]로 분류 및 삭제)
	private static String api_key = "NCSBLSZUNYTRLHOV";
    private static String api_secret = "LK2HBIOS9FOBMPZYKQ0JGXOVNYG46SCF";
//    String api_key = "NCSBLSZUNYTRLHOV";
//    String api_secret = "LK2HBIOS9FOBMPZYKQ0JGXOVNYG46SCF";
//    String subject = messageBean.getSubject();
//	String content = messageBean.getContent();
//	String to = messageBean.getTo();
//	String from = messageBean.getFrom();
    private static String subject;
    private static String content;
    private static String to;
    private static String from;
    private static String certificationNum;
	
    private SendSMS(String phone) {
    	this.subject = "[갓챠]핸드폰 인증 코드입니다.";
		this.certificationNum = randNum();
		this.content = "핸드폰번호 확인을 위해서 다음 코드를 입력해주세요." + certificationNum;
		this.to = phone;
		this.from = "010-9510-2042";
	};

	private static SendSMS instance;
	
	public static SendSMS getInstance(String phone) {
		if(instance==null) {
			instance = new SendSMS(phone);
		} else {
			// 낙원(0902:싱글톤 패턴으로 인스턴스를 여러개 생성하지 못하게 제어 및 재 인증 시 새로운 인증번호가 적용되도록하는 갱신 기능 추가)
			// 싱글톤 패턴이므로 SendSMS 객체가 존재하는경우 인증번호/인증번호가 포함된 메세지내용/phone번호는 새로 갱신되어야 하므로
			// 변수 초기화 추가
			instance.certificationNum = randNum();
			instance.content = "핸드폰번호 확인을 위해서 다음 코드를 입력해주세요." + certificationNum;
			instance.to = phone;
		}
		return instance;
	}
   
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
    

//public SendSMS(MessageBean messageBean) {
//		super();
//		this.subject = messageBean.getSubject();
//		this.certificationNum = randNum();
//		this.content = "핸드폰번호 확인을 위해서 다음 코드를 입력해주세요." + certificationNum;
//		this.to = messageBean.getTo();
//		this.from = messageBean.getFrom();
//	}

// 4 params(to, from, type, text) are mandatory. must be filled
//    HashMap<String, String> params = new HashMap<String, String>();
//    params.put("to", to); // 수신번호
//    params.put("from", from); // 발신번호
//    params.put("type", "SMS"); // Message type ( SMS, LMS, MMS, ATA )
//    params.put("text", content); // 문자내용    
//    params.put("app_version", "JAVA SDK v1.2"); // application name and version
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	public static String messageSend(MessageBean messageBean) {
//		String to = messageBean.getTo();
//		String certificationNum = randNum();
//		String content = "핸드폰번호 확인을 위해서 다음 코드를 입력해주세요." + certificationNum ;
//		messageBean.setTo(to);
//		messageBean.setCertificationNum(certificationNum);
//		messageBean.setContent(content);
//		smsSend(messageBean);
//		return certificationNum;
//	}
	
	public static String smsSend() {

	    net.nurigo.java_sdk.api.Message coolsms = new net.nurigo.java_sdk.api.Message(api_key, api_secret);
	    
	 // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", to); // 수신번호
	    params.put("from", from); // 발신번호
	    params.put("type", "SMS"); // Message type ( SMS, LMS, MMS, ATA )
	    params.put("text", content); // 문자내용    
	    params.put("app_version", "JAVA SDK v1.2"); // application name and version
	    // Optional parameters for your own needs
	    // params.put("image", "desert.jpg"); // image for MMS. type must be set as "MMS"
	    // params.put("image_encoding", "binary"); // image encoding binary(default), base64 
	    // params.put("mode", "test"); // 'test' 모드. 실제로 발송되지 않으며 전송내역에 60 오류코드로 뜹니다. 차감된 캐쉬는 다음날 새벽에 충전 됩니다.
	    // params.put("delay", "10"); // 0~20사이의 값으로 전송지연 시간을 줄 수 있습니다.
	    // params.put("force_sms", "true"); // 푸시 및 알림톡 이용시에도 강제로 SMS로 발송되도록 할 수 있습니다.
	    // params.put("refname", ""); // Reference name
	    // params.put("country", "KR"); // Korea(KR) Japan(JP) America(USA) China(CN) Default is Korea
	    // params.put("sender_key", "5554025sa8e61072frrrd5d4cc2rrrr65e15bb64"); // 알림톡 사용을 위해 필요합니다. 신청방법 : http://www.coolsms.co.kr/AboutAlimTalk
	    // params.put("template_code", "C004"); // 알림톡 template code 입니다. 자세한 설명은 http://www.coolsms.co.kr/AboutAlimTalk을 참조해주세요. 
	    // params.put("datetime", "20140106153000"); // Format must be(YYYYMMDDHHMISS) 2014 01 06 15 30 00 (2014 Jan 06th 3pm 30 00)
	    // params.put("mid", "mymsgid01"); // set message id. Server creates automatically if empty
	    // params.put("gid", "mymsg_group_id01"); // set group id. Server creates automatically if empty
	    // params.put("subject", "Message Title"); // set msg title for LMS and MMS
	    // params.put("charset", "euckr"); // For Korean language, set euckr or utf-8
	    // params.put("app_version", "Purplebook 4.1") // 어플리케이션 버전

	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
	      System.out.println(obj.toString());
	    } catch (CoolsmsException e) {
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	    }
	    return certificationNum;
	  }
}







package api;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	PasswordAuthentication passAuth;

	public GoogleAuthentication() {
		passAuth = new PasswordAuthentication("itwbs.jspmail", "itwill192837");
	}
	
	public PasswordAuthentication getPasswordAuthentication() {
		return passAuth;
	}

}

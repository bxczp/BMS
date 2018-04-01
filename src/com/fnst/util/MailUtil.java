package com.fnst.util;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import com.fnst.mail.SimpleMail;
import com.fnst.mail.SimpleMailSender;

public class MailUtil {
	
	public static void sendMail(String fromAddress, String fromPassword, String toAddress, String title, String context) throws AddressException, MessagingException {
        SimpleMail sm = new SimpleMail();
		sm.setSubject(title);
		sm.setContent(context);
		SimpleMailSender sms = new SimpleMailSender(fromAddress, fromPassword);
	    sms.send(toAddress, sm);
	}

}

package com.fnst.mail;

import java.util.Properties;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.mail.internet.MimeMultipart;

/**
 * 简单的邮件发送 可单发 群发
 * 
 * @author bxczp
 *
 */

public class SimpleMailSender {
    // 发送邮件的 props 文件
    private final transient Properties props = System.getProperties();
    
    // 邮件服务器登录验证
    private transient MailAuthenticator authenticator;
    
    // 邮箱 session
    private transient Session session;
    
    /**
     * 初始化邮件发送器
     * 
     * @param smtpHostName
     *            SMTP 邮件服务器地址
     * @param username
     *            发送邮件的用户名(地址)
     * @param password
     *            发送邮件的密码
     */
    public SimpleMailSender(final String smtpHostName, final String userName, final String password) {
        init(userName, password, smtpHostName);
    }
    
    /**
     * 初始化邮件发送器
     * 
     * @param username
     *            发送邮件的用户名(地址)，并以此解析 SMTP 服务器地址
     * @param password
     *            发送邮件的密码
     */
    public SimpleMailSender(final String username, final String password) {
        // 通过邮箱地址解析出 smtp 服务器，对大多数邮箱都管用
        final String smtpHostName = "smtp." + username.split("@")[1];
        init(username, password, smtpHostName);
    }
    
    /**
     * 初始化
     * 
     * @param username
     *            发送邮件的用户名(地址)
     * @param password
     *            密码
     * @param smtpHostName
     *            SMTP 主机地址
     */
    private void init(String username, String password, String smtpHostName) {
        // 初始化 props
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", smtpHostName);
        // 验证
        authenticator = new MailAuthenticator(username, password);
        // 创建 session
        session = Session.getInstance(props, authenticator);
    }
    
    /**
     * 发送邮件
     * 
     * @param recipient
     *            收件人邮箱地址
     * @param subject
     *            邮件主题
     * @param content
     *            邮件内容
     * @throws AddressException
     * @throws MessagingException
     */
    public void send(String recipient, String subject, String content) throws AddressException, MessagingException {
        // 创建 mime 类型邮件
        final MimeMessage message = new MimeMessage(session);
        // 设置发信人
        message.setFrom(new InternetAddress(authenticator.getUserName()));
        // 设置收件人
        message.setRecipient(RecipientType.TO, new InternetAddress(recipient));
        // 设置主题
        message.setSubject(subject);
        // 设置邮件内容
        Multipart mp = new MimeMultipart("related");
        MimeBodyPart mbp = new MimeBodyPart();
        mbp.setContent(content.toString(), "text/html;charset=utf-8");
        mp.addBodyPart(mbp);
        message.setContent(mp);
        // 设置邮件内容
        // message.setContent(content.toString(), "text/html;charset=utf-8");
        // 发送
        Transport.send(message);
    }
    
    /**
     * 发送邮件
     * 
     * @param recipient
     *            收件人邮箱地址
     * @param mail
     *            邮件对象
     * @throws AddressException
     * @throws MessagingException
     *
     */
    public void send(String recipient, SimpleMail mail) throws AddressException, MessagingException {
        send(recipient, mail.getSubject(), mail.getContent());
    }
    
}

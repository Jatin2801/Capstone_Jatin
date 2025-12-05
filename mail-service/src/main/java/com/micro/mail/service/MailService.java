package com.micro.mail.service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {

    private final JavaMailSender sender;

    public MailService(JavaMailSender sender) {
        this.sender = sender;
    }

    public void send(String email, String subject, String body) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject(subject);
        message.setText(body);
        sender.send(message);
    }

    public void sendUserAccountCreated(String email, String username) {
        String subject = "Welcome " + username;
        String body = "Your user account has been created successfully.";
        send(email, subject, body);
    }

    public void sendAdminAccountCreated(String email, String adminName) {
        String subject = "Admin Account Created";
        String body = "Hello " + adminName + ", your admin account is created sucessfully.";
        send(email, subject, body);
    }

    public void sendSongAdded(String email, String songTitle) {
        String subject = "New Song Added";
        String body = "A new song has been uploaded: " + songTitle + ".";
        send(email, subject, body);
    }
}

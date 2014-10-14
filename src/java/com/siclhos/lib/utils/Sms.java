/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.siclhos.lib.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Yasbaby
 */
public class Sms {
    final String username;
    final String password;
    Properties props;
    Session session;
    
    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }
    
    public Sms() {

                    
        // load the inputStream using the Properties
        
        props = Configuration.getInstance().getProperties();
        
        this.username = props.getProperty("mail.smtp.username");
        this.password = props.getProperty("mail.smtp.password");;
    
        session = autenticar(props);

    
    }

    public Properties getProps() {
        return props;
    }

    public void setProps(Properties props) {
        this.props = props;
    }
    
    public Session autenticar(Properties props) {
           Session session = Session.getInstance(getProps(),
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(getUsername(),getPassword());
                    }
                });
        return session;   
    }
    
    
    public boolean enviarSMS(String destinatario, String asunto, String mensaje) {
    
        boolean result =false;

        try {            
                        
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(getProps().getProperty("mail.smtp.username")));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(destinatario));
            message.setSubject(asunto);
            message.setText(mensaje);

            Transport.send(message);
            
            result = true;
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
        
        return result;
    }
<<<<<<< HEAD
}        
=======
}

        
>>>>>>> bd8e5c5211e0da5ea12d55f8785dceb2024284f9

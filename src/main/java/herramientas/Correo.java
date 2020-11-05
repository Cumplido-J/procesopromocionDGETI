/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import java.io.FileReader;
import java.util.Properties;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
/**
 *
 * @author David Reyna
 */
public class Correo {
        private final static String rutaConfig=RutaConfig.getRutaConfig();
        
        
        public void enviarCorreo(String asunto,String cuerpo,String destino) {
            Properties p = new Properties();     
            try {
                p.load(new FileReader(rutaConfig));
                String remitente = p.getProperty("correoNotificacion");
                String clave = p.getProperty("passNotificacion");
                //String destino = destinatario;

                Properties props = new Properties();
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.user", remitente);
                props.put("mail.smtp.clave", clave);

                Session session = Session.getDefaultInstance(props);
                session.setDebug(true);
                MimeMessage mensaje = new MimeMessage(session);
                BodyPart mbp = new MimeBodyPart();
                mbp.setHeader("Content-Type", "text/html");
                mbp.setContent(cuerpo, "text/html");
                Multipart mp = new MimeMultipart();
                mp.addBodyPart(mbp);                
                
                mensaje.addRecipient(Message.RecipientType.TO, new InternetAddress(destino));
                mensaje.setSubject(asunto);
                mensaje.setText(cuerpo);
                mensaje.setContent(mp);
                Transport transport = session.getTransport("smtp");
                transport.connect("smtp.gmail.com", remitente, clave);
                transport.sendMessage(mensaje, mensaje.getAllRecipients());
                transport.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        /*public void inicializar() {
            Properties p = new Properties(); 
            try {
                p.load(new FileReader(rutaConfig));
                correo=p.getProperty("correoNotificacion");
                contrasena=p.getProperty("passNotificacion");
                String[] aux=correo.split("@");
                properties.put("mail.smtp.host", "smtp.gmail.com");
                properties.put("mail.smtp.starttls.enable", "true");
                properties.put("mail.smtp.port",587);
                properties.put("mail.smtp.mail.sender",correo);
                properties.put("mail.smtp.user", aux[0]);
                properties.put("mail.smtp.auth", "true");

                session = Session.getDefaultInstance(properties);
                session.setDebug(true);
            }catch(Exception e){
                System.out.println(e.toString());
            }
        }
         
	public void enviarCorreo(String asunto,String mensaje,String destinatario){
            try{
                System.out.println(correo+"-"+contrasena);
                System.out.println(asunto+"-"+mensaje+"-"+destinatario);
                inicializar();
                
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress((String)properties.get("mail.smtp.mail.sender")));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(destinatario));
                message.setSubject(asunto);
                message.setText(mensaje);
                Transport t = session.getTransport("smtp");
                t.connect((String)properties.get("mail.smtp.user"), contrasena);
                t.sendMessage(message, message.getAllRecipients());
                t.close();
            }catch (Exception e){
                System.out.println(e.toString());                        
                return;
            }
		
	}*/
 
}    
    


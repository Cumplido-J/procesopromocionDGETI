/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import java.io.FileReader;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
/**
 *
 * @author David Reyna
 */
public class Correo {
    	private final Properties properties = new Properties();	
	private Session session; 
        private String correo;
        private String contrasena;

        public void inicializar() {
            Properties p = new Properties(); 
            try {
                p.load(new FileReader("C:/ArchivosPromocion/config.properties"));
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
		
	}
 
}    
    


package correos;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class Enviar_clave {

    public void enviar_correo(String claveDesencriptada, String correo) {
        String remitente = "notificaciones1@cecyte.edu.mx";
        String clave = "R6qUC6Sv7JCfUn9";
        String destino = correo;

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.user", remitente);
        props.put("mail.smtp.clave", clave);

        Session session = Session.getDefaultInstance(props);
        MimeMessage mensaje = new MimeMessage(session);

        try {
            System.out.println("Enviando clave");
            mensaje.addRecipient(Message.RecipientType.TO, new InternetAddress(destino));
            mensaje.setSubject("Recuperacion de Contraseña");
            mensaje.setText("Tu contraseña es: "+claveDesencriptada);
            Transport transport = session.getTransport("smtp");
            transport.connect("smtp.gmail.com", remitente, clave);
            transport.sendMessage(mensaje, mensaje.getAllRecipients());
            transport.close();
            System.out.println("Fin Enviando clave");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

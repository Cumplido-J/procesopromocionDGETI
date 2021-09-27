/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import constants.ConstantsWS;
import herramientas.Correo;
import herramientas.Pin;
import herramientas.UtileriasHelper;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
@WebServlet(name = "RegistrarUsuario", urlPatterns = {"/RegistrarUsuario"})
public class Servlet_registrarUsuario extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_registrarUsuario</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_registrarUsuario at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ServletContext sc = getServletContext();
        RequestDispatcher rd;
        PrintWriter out = response.getWriter();
        try {  
            HttpSession session = (HttpSession) request.getSession(true);
            String id;
            if(request.getParameter("idUsuario")!=null){
                id=request.getParameter("idUsuario");
            }else{
                id="";
            }            
            
            String permisoEdicion_ = session.getAttribute("permisoEdicion").toString();
            
            if(permisoEdicion_.equals("V")){
                String programa=request.getParameter("programa");
                String subsistema=request.getParameter("subsistema");
                String nivel=request.getParameter("nivel");            
                String usuario=request.getParameter("usuario");
                String nombre=request.getParameter("nombre");
                String apellido1=request.getParameter("apellido1");
                String apellido2=request.getParameter("apellido2");
                String entidad=request.getParameter("entidad");
                String plantel=request.getParameter("plantel");
                String fijo=request.getParameter("fijo"); 
                String movil=request.getParameter("movil"); 
                String correo=request.getParameter("correo");
                String pass=request.getParameter("pass");
                String perfil=request.getParameter("tusuario");
                String permisosReq=request.getParameter("permisos");
                
                String consideraciones=""; 
                String contrasena;
                
                if (!(request.getParameter("permisos")==null))
                {
                    if (permisosReq.equals("")) {permisosReq=null;}
                }
                                
                if(id.equals("")){
                    contrasena=Pin.generaPin();
                }else{
                    contrasena="";
                }
                UtileriasHelper utilerias = new UtileriasHelper();
                if(!contrasena.isEmpty()){
                    String encriptarPass = utilerias.encriptarCodigo(contrasena, ConstantsWS.LLAVE_CIFRADO);
                    pass=encriptarPass;
                }
                
                if(!pass.isEmpty()){
                    String encriptarPass = utilerias.encriptarCodigo(pass, ConstantsWS.LLAVE_CIFRADO);
                    pass=encriptarPass;
                }
                
                if(permisosReq==null && perfil.equals("D")){
                    //perfil="D";
                    Metodos_sql metodo = new Metodos_sql();
                    List<String[]> datos;            
                    String[] parametros={entidad,plantel,nombre,apellido1,apellido2,correo,pass,usuario,fijo,movil,perfil,consideraciones,nivel,subsistema,programa,id};                                      
                    datos=metodo.ejecutaSP("sp_insertUsuario",parametros);
                    String respuesta1="";
                    respuesta1=datos.get(0)[0];
                    if(respuesta1.equals("ok")){
                        if(!pass.isEmpty()){
                            Correo c=new Correo();
                            String passDecrypt=utilerias.desencriptarCodigo(pass, ConstantsWS.LLAVE_CIFRADO);
                            c.enviarCorreo("Envío de contraseña","Usted ha sido registrado en el Sistema de Promoción Docente disponible en https://www.promociondocente.sep.gob.mx <br/> Sus datos de acceso son: <br/> Usuario: <b>"+usuario+"</b><br/>Contrase&ntilde;a:<b>"+passDecrypt+"</b>", correo);
                        }
                        out.print(respuesta1);
                    }else{
                        out.print("Error en almacenamiento de datos, intente nuevamente");
                    }
                }else if (permisosReq!=null && perfil.equals("D")) {
                    out.print("Al tipo de usuario Docente no se le asignan permisos");
                }else{
                    String permisos=request.getParameter("permisos");
                    String[] aux=permisos.split(";");
                

                    //perfil="A";
                    String respuesta="Error en almacenamiento de datos, intente nuevamente";
                    Metodos_sql metodo = new Metodos_sql();
                    List<String[]> datos;            
                    String[] parametros={entidad,plantel,nombre,apellido1,apellido2,correo,pass,usuario,fijo,movil,perfil,consideraciones,nivel,subsistema,programa,id};                                      
                    datos=metodo.ejecutaSP("sp_insertUsuario",parametros);            
                    if(!datos.isEmpty()){
                        respuesta=datos.get(0)[0]; 
                        parametros=new String[4];
                        parametros[0]="";
                        parametros[1]=usuario;                
                        if(respuesta.equals("ok")){
                            if(id.equals("")){
                                Correo c=new Correo();
                                c.enviarCorreo("Envío de contraseña","Usted ha sido registrado en el Sistema de Promoción Docente disponible en https://www.promociondocente.sep.gob.mx <br/> Sus datos de acceso son: <br/> Usuario: <b>"+usuario+"</b><br/>Contrase&ntilde;a:<b>"+contrasena+"</b>", correo);
                            }
                            for (String i : aux) {
                                String[] aux2=i.split(",");
                                parametros[2]=aux2[0];
                                if(aux2[1].equals("true")){
                                    parametros[3]="V";
                                }else{
                                    parametros[3]="F";
                                }

                                datos=metodo.ejecutaSP("sp_insertUsuarioPermiso",parametros);                        
                            }
                        }
                    }
                    out.print(respuesta);
                }
            }else{
                out.print("El usuario no tiene permisos para guardar");
            }
        } finally {
            out.close();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import constants.ConstantsWS;
import herramientas.UtileriasHelper;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
@WebServlet(name = "Preregistro", urlPatterns = {"/Preregistro"})
public class Servlet_preregistro extends HttpServlet {

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
            out.println("<title>Servlet Servlet_preregistro</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_preregistro at " + request.getContextPath() + "</h1>");
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
        
        String parametro = request.getParameter("accion");
        parametro= (parametro==null) ? "preregistro": parametro;
        try{
        switch(parametro){
                case "preregistro": 
                    registroPreRegistro(request,response);    
                    break;
                case "preregistroRFC":
                    registroPreRegistroRFC(request, response);
                    break;   
            }
        }catch(IOException | ServletException e){
            System.out.println("Error: Servlet_preregistro --> "+e);
        }
                
        /*PrintWriter out = response.getWriter();
        UtileriasHelper utilerias = new UtileriasHelper();
        try {    
            String programa=request.getParameter("programa");
            String subsistema=request.getParameter("subsistema");
            String rfc=request.getParameter("rfc");
            String nombre=request.getParameter("nombre");
            String apellido1=request.getParameter("apellido1");
            String apellido2=request.getParameter("apellido2");
            String entidad=request.getParameter("entidad");
            String plantel=request.getParameter("plantel");
            String fijo=request.getParameter("fijo"); 
            String movil=request.getParameter("movil"); 
            String correo=request.getParameter("correo");
            String consideraciones=request.getParameter("consideraciones"); 
            
            String pass_=request.getParameter("pass1");
            String encriptarPass = utilerias.encriptarCodigo(pass_, ConstantsWS.LLAVE_CIFRADO);
            String pass1=encriptarPass;
            
            String perfil="D";
            String respuesta="Error en almacenamiento de datos, intente nuevamente";
            Metodos_sql metodo = new Metodos_sql();
            List<String[]> datos; 
            String[] parametros1={plantel,programa};
            datos=metodo.ejecutaSP("sp_countRegistrosVacancia",parametros1);
            if(!datos.isEmpty()){
                if(!datos.get(0)[0].equals("0")){
                    String[] parametros3={plantel,programa,subsistema,"D"};
                    List<String[]> datos1=metodo.ejecutaSP(ConstantsWS.SP_FECHAS_CONVOCATORIA,parametros3);
                    if(datos1.get(0)[0].equals("1")){
                        String[] parametros2={entidad,plantel,nombre,apellido1,apellido2,correo,pass1,rfc,fijo,movil,perfil,consideraciones,"P",subsistema,programa,""};                                      
                        datos=metodo.ejecutaSP("sp_insertUsuario",parametros2);            
                        if(!datos.isEmpty()){
                            respuesta=datos.get(0)[0];                    
                        }   
                    }else{
                       respuesta="De acuerdo a las fechas de la convocatoria ya no es posible registrarse"; 
                    }
                }else{
                    respuesta="No existe convocatoria abierta para esta solicitud";
                }
            }
            out.print(respuesta);
        } finally {
            out.close();
        }*/
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

    private void registroPreRegistro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        UtileriasHelper utilerias = new UtileriasHelper();
        try {    
            String programa=request.getParameter("programa");
            String subsistema=request.getParameter("subsistema");
            String rfc=request.getParameter("rfc");
            String nombre=request.getParameter("nombre");
            String apellido1=request.getParameter("apellido1");
            String apellido2=request.getParameter("apellido2");
            String entidad=request.getParameter("entidad");
            String plantel=request.getParameter("plantel");
            String fijo=request.getParameter("fijo"); 
            String movil=request.getParameter("movil"); 
            String correo=request.getParameter("correo");
            String consideraciones=request.getParameter("consideraciones"); 
            
            String pass_=request.getParameter("pass1");
            String encriptarPass = utilerias.encriptarCodigo(pass_, ConstantsWS.LLAVE_CIFRADO);
            String pass1=encriptarPass;
            
            String perfil="D";
            String respuesta="Error en almacenamiento de datos, intente nuevamente";
            Metodos_sql metodo = new Metodos_sql();
            List<String[]> datos; 
            String[] parametros1={plantel,programa};
            datos=metodo.ejecutaSP("sp_countRegistrosVacancia",parametros1);
            if(!datos.isEmpty()){
                if(!datos.get(0)[0].equals("0")){
                    String[] parametros3={plantel,programa,subsistema,"D"};
                    List<String[]> datos1=metodo.ejecutaSP(ConstantsWS.SP_FECHAS_CONVOCATORIA,parametros3);
                    if(datos1.get(0)[0].equals("1")){
                        String[] parametros2={entidad,plantel,nombre,apellido1,apellido2,correo,pass1,rfc,fijo,movil,perfil,consideraciones,"P",subsistema,programa,""};                                      
                        datos=metodo.ejecutaSP("sp_insertUsuario",parametros2);            
                        if(!datos.isEmpty()){
                            respuesta=datos.get(0)[0];                    
                        }   
                    }else{
                       respuesta="De acuerdo a las fechas de la convocatoria ya no es posible registrarse"; 
                    }
                }else{
                    respuesta="No existe convocatoria abierta para esta solicitud";
                }
            }
            out.print(respuesta);
        } finally {
            out.close();
        }
    }
    
    private void registroPreRegistroRFC(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        PrintWriter out = response.getWriter();
        try {
            UtileriasHelper utilerias = new UtileriasHelper();
            Metodos_sql metodo = new Metodos_sql();
            String rfc=request.getParameter("rfc-02").toUpperCase();
            //String pass_=request.getParameter("pass01-p");
            //String encriptarPass = utilerias.encriptarCodigo(pass_, ConstantsWS.LLAVE_CIFRADO);
            //String pass1=encriptarPass;
            List<String[]> datos;
            List<String[]> condicionResp;
            String respuesta="Error en almacenamiento de datos, intente nuevamente";
            
            String[] parametros0={rfc};
            condicionResp=metodo.ejecutaSP("sp_insertPreAspirante2ValidacionConvocatoria",parametros0);
            String[] parametros1={condicionResp.get(0)[2],condicionResp.get(0)[15]};
            datos=metodo.ejecutaSP("sp_countRegistrosVacancia",parametros1);
            if(!datos.isEmpty()){
                if(!datos.get(0)[0].equals("0")){
                    String[] parametros3={condicionResp.get(0)[2],condicionResp.get(0)[15],condicionResp.get(0)[14],"D"};
                    List<String[]> datos1=metodo.ejecutaSP(ConstantsWS.SP_FECHAS_CONVOCATORIA,parametros3);
                    if(datos1.get(0)[0].equals("1")){
                            String[] parametros2={rfc};                                      
                            datos=metodo.ejecutaSP("sp_insertPreAspirante2",parametros2);            
                            if(!datos.isEmpty()){
                                respuesta=datos.get(0)[0];                    
                            }
                    }else{
                       respuesta="De acuerdo a las fechas de la convocatoria ya no es posible registrarse"; 
                    }        
                }else{
                    respuesta="No existe convocatoria abierta para mantener tu registro, deberas registrarte como un usuario nuevo";
                }            
            }
            out.print(respuesta);
        } finally {
            out.close();
        }
        
    }
    
}

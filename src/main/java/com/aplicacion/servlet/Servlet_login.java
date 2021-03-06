/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import constants.ConstantsWS;
import herramientas.RutaConfig;
import herramientas.UtileriasHelper;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import metodos_sql.Metodos_sql;
import seguridad.VerificarRecaptcha;

/**
 *
 * @author David Reyna
 */
public class Servlet_login extends HttpServlet {

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
            out.println("<title>Servlet Servlet_login</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_login at " + request.getContextPath() + "</h1>");
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
        try (PrintWriter out = response.getWriter()) {
            String rfc = request.getParameter("rfc");
            String clave = request.getParameter("clave");
            
            String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
            System.out.println("info captcha"+gRecaptchaResponse);
            String rutaConfig = RutaConfig.getRutaConfig();
            Properties p = new Properties(); 
            p.load(new FileReader(rutaConfig));            
            Boolean consultaCaptcha= Boolean.parseBoolean(p.getProperty("consultaCaptcha"));
            boolean verificado;
            if(consultaCaptcha){
                verificado = VerificarRecaptcha.verificar(gRecaptchaResponse);
                System.out.println("captcha verificado"+verificado);
            }else{
                verificado=true;
            }            
            if(verificado == true){
                UtileriasHelper utilerias = new UtileriasHelper();
            Metodos_sql metodos=new Metodos_sql();
            String[] parametros={rfc};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaInfoLogin",parametros);
            
            if(!datos.isEmpty()){
                
                String clave_ = datos.get(0)[5];
                String cadenaDencriptada = utilerias.desencriptarCodigo(clave_, ConstantsWS.LLAVE_CIFRADO);
                
                if(cadenaDencriptada.equals(clave)){
                    
                    String ipUser = request.getRemoteAddr();
                    System.out.println("IP"+ipUser);
                    String idUser = datos.get(0)[0];
                    String[] params={idUser, ipUser};
                    
                    List<String[]> datosConexion = metodos.ejecutaSP(ConstantsWS.BITACORA_LOGIN, params);
                    if(!datosConexion.isEmpty()){
                        System.out.println("Se guardo correctamente los datos de la conexion");
                    }
                    
                    HttpSession session = (HttpSession) request.getSession(true);
                    session.setAttribute("idUsuario", datos.get(0)[0]);
                    session.setAttribute("subsistema", datos.get(0)[1]);
                    session.setAttribute("entidad", datos.get(0)[2]);
                    session.setAttribute("plantel", datos.get(0)[3]);
                    session.setAttribute("rfc", datos.get(0)[6]);
                    session.setAttribute("nombre", datos.get(0)[4]);
                    session.setAttribute("rol", datos.get(0)[7]);
                    session.setAttribute("programa", datos.get(0)[11]);
                    session.setAttribute("nivel", datos.get(0)[12]);
                    session.setAttribute("permisoEdicion", datos.get(0)[14]);
                    session.setAttribute("permisoActual","");
                    session.setAttribute("permisoActualEdicion","");
                    session.setAttribute("fechaDictaminacion",0);
                    session.setAttribute("idPeriodoActivo", datos.get(0)[15]);
                    session.setAttribute("permisoTablaUsuarioEdicion",datos.get(0)[16]);
                    session.setAttribute("permisoActualEliminar","");
                    if(datos.get(0)[7].equals("D")){
                        String[] parametros1={datos.get(0)[3],datos.get(0)[11],datos.get(0)[1],"D"};
                        List<String[]> datos1=metodos.ejecutaSP(ConstantsWS.SP_FECHAS_CONVOCATORIA,parametros1);
                        if(datos1.get(0)[0].equals("1")){
                                response.sendRedirect("SesionDocente");
                        }else{
                        	List<String[]> datos2=metodos.ejecutaSP(ConstantsWS.SP_FECHAS_DICTAMINACION,parametros1);
                            if(datos2.get(0)[0].equals("1")){
                                session.setAttribute("fechaDictaminacion",1);
                                response.sendRedirect("SesionDocente"); 
                            }
                            request.setAttribute("error", "De acuerdo a las fechas de la convocatoria ya no es posible inciar sesi??n");
                            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                            rd.forward(request, response);
                        }
                    }else{
                        if(datos.get(0)[7].equals("A") && datos.size()==1 && datos.get(0)[8].equals("5") && datos.get(0)[14].equals("V")){
                            String[] parametros2={datos.get(0)[3],datos.get(0)[11],datos.get(0)[1],"A"};
                            List<String[]> datos1=metodos.ejecutaSP(ConstantsWS.SP_FECHAS_CONVOCATORIA,parametros2);
                            
                            if(datos1.get(0)[0].equals("1")){
                                List<String[]> vinculos = new ArrayList<String[]>();
                                String[] vinculo = null;
                                for(String[] dato:datos){
                                    //System.out.println(dato[8]+"-"+dato[9]+"-"+dato[10]);
                                    vinculo=new String[4];
                                    vinculo[0]=dato[8];
                                    vinculo[1]=dato[9];
                                    vinculo[2]=dato[10];
                                    vinculo[3]=dato[14];
                                    vinculos.add(vinculo);
                                }

                                if (vinculos.size()== 1)
                                { session.setAttribute("permisoActual",(vinculos.get(0))[0]); 
                                  session.setAttribute("permisoActualEdicion",(vinculos.get(0))[3]);
                                }                        

                                session.setAttribute("vinculos",vinculos);
                                response.sendRedirect("SesionAdministrador"); 
                            }else{
                                request.setAttribute("error", "De acuerdo a las fechas de la convocatoria ya no es posible inciar sesi??n");
                                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                                rd.forward(request, response);
                            }  
                        }else{
                            List<String[]> vinculos = new ArrayList<String[]>();
                            String[] vinculo = null;
                            for(String[] dato:datos){
                                //System.out.println(dato[8]+"-"+dato[9]+"-"+dato[10]);
                                vinculo=new String[5];
                                vinculo[0]=dato[8];
                                vinculo[1]=dato[9];
                                vinculo[2]=dato[10];
                                vinculo[3]=dato[14];
                                vinculo[4]=dato[17];
                                vinculos.add(vinculo);
                            }

                            if (vinculos.size()== 1)
                            { session.setAttribute("permisoActual",(vinculos.get(0))[0]); 
                              session.setAttribute("permisoActualEdicion",(vinculos.get(0))[3]);
                              session.setAttribute("permisoActualEliminar",(vinculos.get(0))[4]);
                            }                        

                            session.setAttribute("vinculos",vinculos);
                            response.sendRedirect("SesionAdministrador");   
                        }
                    }
                }else{
                    request.setAttribute("error", "Contrase??a incorrecta");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                }
            }
            else {
                request.setAttribute("error", "El usuario no existe");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }
            }else{
                request.setAttribute("error", "Seleccionar casilla para validar identidad");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }
        }catch(Exception e){
            System.out.println(e.toString());
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

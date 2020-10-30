/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import metodos_sql.Metodos_sql;

/**
 *
 * @author charl
 */
@WebServlet(name = "Servlet_buscar_convocatoria", urlPatterns = {"/Servlet_buscar_convocatoria"})
public class Servlet_buscar_convocatoria extends HttpServlet {

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
        try {
            PrintWriter out = response.getWriter();
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_buscar_convocatoria</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_buscar_convocatoria at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } catch (Exception e) {
            System.out.println(e.toString());
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
    Metodos_sql metodos = new Metodos_sql();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            //out.println("<title>Servlet Servlet</title>");
            out.println("</head>");
            out.println("<body>");
            HttpSession session = (HttpSession) request.getSession(true);
            String idUsuario = "";
            String rfc = "";
            if (session.getAttribute("idUsuario") != null && session.getAttribute("rfc") != null) {
                idUsuario = session.getAttribute("idUsuario").toString();
                rfc = session.getAttribute("rfc").toString();
                
                String cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id;";
                String control_combobox = request.getParameter("control_combobox");
                String nac1 = request.getParameter("nacional");//AGREGAR---------------------------
                String per1 = request.getParameter("permiso1");
                String per2 = request.getParameter("permiso2");
                String per4 = request.getParameter("permiso4");
                String nom1 = request.getParameter("nombre");
                String ent1 = request.getParameter("dato_ent");
                String pla1 = request.getParameter("dato_pla");
                String rfc1 = request.getParameter("dato_rfc");
                String subsistema = request.getParameter("subsistema");
                String sub = request.getParameter("sub1");
                String entidad = request.getParameter("entidad");
                String plantel = request.getParameter("n_plantel");
                String publicacion = request.getParameter("publicacion");
                String resultados = request.getParameter("resultados");
                String estatus = request.getParameter("estatus");
                
                String btnconvocatoria = request.getParameter("buscar_convocatoria");
                
                if (btnconvocatoria != null) {

                    if (control_combobox.equals("false") || control_combobox.equals("true") && nac1.equals("1")) {
                        if (entidad.equals("0") && plantel.equals("0") && estatus.equals("0") && publicacion.equals("") && resultados.equals("")) {
                            request.setAttribute("consulta", "0");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462";
                            }
//                        out.print("caso 0"); //nada
                        } else if (entidad.equals("0") && plantel.equals("0") && estatus.equals("0") && publicacion.equals("") && resultados != ("")) {
                            request.setAttribute("consulta", "1");
                             if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462 && resultados='"+ resultados + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462 && resultados='" + resultados + "'";
                            }
//                        out.print("caso 1");//
                        } else if (entidad.equals("0") && plantel.equals("0") && estatus.equals("0") && publicacion != ("") && resultados.equals("")) {
                            request.setAttribute("consulta", "2");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462 && publicacion='" + publicacion + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462 && publicacion='" + publicacion + "'";
                            }
//                        out.print("caso 2");//
                        } else if (entidad.equals("0") && plantel.equals("0") && estatus.equals("0") && publicacion != ("") && resultados != ("")) {
                            request.setAttribute("consulta", "3");
                             if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462 && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462 && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 3");//
                        } else if (entidad.equals("0") && plantel.equals("0") && estatus != ("0") && publicacion.equals("") && resultados.equals("")) {
                            request.setAttribute("consulta", "4");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462 && estatus='" + estatus + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462 && estatus='" + estatus + "'";
                            }
//                        out.print("caso 4");//
                        } else if (entidad.equals("0") && plantel.equals("0") && estatus != ("0") && publicacion.equals("") && resultados != ("")) {
                            request.setAttribute("consulta", "5");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462 && estatus='" + estatus + "' && resultados='" + resultados + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462 && estatus='" + estatus + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 5");//
                        } else if (entidad.equals("0") && plantel.equals("0") && estatus != ("0") && publicacion != ("") && resultados.equals("")) {
                            request.setAttribute("consulta", "6");
                             if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462 && estatus='" + estatus + "' && publicacion='" + publicacion + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462 && estatus='" + estatus + "' && publicacion='" + publicacion + "'";
                            }
//                        out.print("caso 6");//
                        } else if (entidad.equals("0") && plantel.equals("0") && estatus != ("0") && publicacion != ("") && resultados != ("")) {
                            request.setAttribute("consulta", "7");
                             if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462 && estatus='" + estatus + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462 && estatus='" + estatus + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 7");//
                        } else if (entidad != ("0") && Integer.parseInt(plantel) != 0 && estatus.equals("0") && publicacion.equals("") && resultados.equals("")) {
                            request.setAttribute("consulta", "8");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462 && idPlantel='" + plantel + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462 && idPlantel='" + plantel + "'";
                            }
//                        out.print("caso 8");//
                        } else if (entidad != ("0") && Integer.parseInt(plantel) != 0  && estatus.equals("0") && publicacion.equals("") && resultados != ("")) {
                            request.setAttribute("consulta", "9");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462 && idPlantel='" + plantel + "' && resultados='" + resultados + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462 && idPlantel='" + plantel + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 9");//
                        } else if (entidad != ("0") && Integer.parseInt(plantel) != 0  && estatus.equals("0") && publicacion != ("") && resultados.equals("")) {
                            request.setAttribute("consulta", "10");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462 && idPlantel='" + plantel + "' && publicacion='" + publicacion + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462 && idPlantel='" + plantel + "' && publicacion='" + publicacion + "'";
                            }
//                        out.print("caso 10");//
                        } else if (entidad != ("0") && Integer.parseInt(plantel) != 0  && estatus.equals("0") && publicacion != ("") && resultados != ("")) {
                            request.setAttribute("consulta", "11");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462 && idPlantel='" + plantel + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462 && idPlantel='" + plantel + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 11");//
                        } else if (entidad != ("0") && Integer.parseInt(plantel) != 0  && estatus != ("0") && publicacion.equals("") && resultados.equals("")) {
                            request.setAttribute("consulta", "12");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462 && idPlantel='" + plantel + "' && estatus='" + estatus + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462 && idPlantel='" + plantel + "' && estatus='" + estatus + "'";
                            }
//                        out.print("caso 12");//
                        } else if (entidad != ("0") && Integer.parseInt(plantel) != 0  && estatus != ("0") && publicacion.equals("") && resultados != ("")) {
                            request.setAttribute("consulta", "13");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462 && idPlantel='" + plantel + "' && estatus='" + estatus + "' && resultados='" + resultados + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462 && idPlantel='" + plantel + "' && estatus='" + estatus + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 13");//
                        } else if (entidad != ("0") && Integer.parseInt(plantel) != 0  && estatus != ("0") && publicacion != ("") && resultados.equals("")) {
                            request.setAttribute("consulta", "14");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462 && idPlantel='" + plantel + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462 && idPlantel='" + plantel + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "'";
                            }
//                        out.print("caso 14");//
                        } else if (entidad != ("0") && Integer.parseInt(plantel) != 0  && estatus != ("0") && publicacion != ("") && resultados != ("")) {
                            request.setAttribute("consulta", "15");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel < 462 && idPlantel='" + plantel + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id WHERE a.idPlantel >= 462 && idPlantel='" + plantel + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 15");//
                        } else if (entidad != ("0") && plantel.equals("0") && estatus.equals("0") && publicacion.equals("") && resultados.equals("")) {
                            request.setAttribute("consulta", "16");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + entidad + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + entidad + "'";
                            }
//                        out.print("caso 16");//
                        } else if (entidad != ("0") && plantel.equals("0") && estatus.equals("0") && publicacion.equals("") && resultados != ("")) {
                            request.setAttribute("consulta", "17");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + entidad + "' && resultados='" + resultados + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + entidad + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 17");//
                        } else if (entidad != ("0") && plantel.equals("0") && estatus.equals("0") && publicacion != ("") && resultados.equals("")) {
                            request.setAttribute("consulta", "18");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + entidad + "' && publicacion='" + publicacion + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + entidad + "' && publicacion='" + publicacion + "'";
                            }
//                        out.print("caso 17");//
                        } else if (entidad != ("0") && plantel.equals("0") && estatus.equals("0") && publicacion != ("") && resultados != ("")) {
                            request.setAttribute("consulta", "19");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + entidad + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + entidad + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 17");//
                        } else if (entidad != ("0") && plantel.equals("0") && estatus != ("0") && publicacion.equals("") && resultados.equals("")) {
                            request.setAttribute("consulta", "20");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + entidad + "' && estatus='" + estatus + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + entidad + "' && estatus='" + estatus + "'";
                            }
//                        out.print("caso 16");//
                        } else if (entidad != ("0") && plantel.equals("0") && estatus != ("0") && publicacion.equals("") && resultados != ("")) {
                            request.setAttribute("consulta", "21");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + entidad + "' && estatus='" + estatus + "' && resultados='" + resultados + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + entidad + "' && estatus='" + estatus + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 16");//
                        } else if (entidad != ("0") && plantel.equals("0") && estatus != ("0") && publicacion != ("") && resultados.equals("")) {
                            request.setAttribute("consulta", "22");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + entidad + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + entidad + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "'";
                            }
//                        out.print("caso 16");//
                        } else if (entidad != ("0") && plantel.equals("0") && estatus != ("0") && publicacion != ("") && resultados != ("")) {
                            request.setAttribute("consulta", "23");
                            if(subsistema.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + entidad + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }else if(subsistema.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + entidad + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 16");//
                        }
                    }//fin opcion super usuario y administrador nacionales
             
                    if (control_combobox.equals("true") && nac1.equals("2")) {
                         if (plantel.equals("0") && estatus.equals("0") && publicacion.equals("") && resultados.equals("")) {
                            request.setAttribute("consulta", "0");
                             if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "'";
                            }
//                        out.print("caso 0"); //nada
                        } else if (plantel.equals("0") && estatus.equals("0") && publicacion.equals("") && resultados != ("")) {
                            request.setAttribute("consulta", "1");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && resultados='" + resultados + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 1");//
                        } else if (plantel.equals("0") && estatus.equals("0") && publicacion != ("") && resultados.equals("")) {
                            request.setAttribute("consulta", "2");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && publicacion='" + publicacion + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && publicacion='" + publicacion + "'";
                            }
//                        out.print("caso 2");//
                        } else if (plantel.equals("0") && estatus.equals("0") && publicacion != ("") && resultados != ("")) {
                            request.setAttribute("consulta", "3");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 3");//
                        } else if (plantel.equals("0") && estatus != ("0") && publicacion.equals("") && resultados.equals("")) {
                            request.setAttribute("consulta", "4");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && estatus='" + estatus + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && estatus='" + estatus + "'";
                            }
//                        out.print("caso 4");//
                        } else if (plantel.equals("0") && estatus != ("0") && publicacion.equals("") && resultados != ("")) {
                            request.setAttribute("consulta", "5");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && estatus='" + estatus + "' && resultados='" + resultados + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && estatus='" + estatus + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 5");//
                        } else if (plantel.equals("0") && estatus != ("0") && publicacion != ("") && resultados.equals("")) {
                            request.setAttribute("consulta", "6");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "'";
                            }
//                        out.print("caso 6");//
                        } else if (plantel.equals("0") && estatus != ("0") && publicacion != ("") && resultados != ("")) {
                            request.setAttribute("consulta", "7");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 7");//
                        } else if (Integer.parseInt(plantel) != 0 && estatus.equals("0") && publicacion.equals("") && resultados.equals("")) {
                            request.setAttribute("consulta", "8");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "'";
                            }
//                        out.print("caso 8");//
                        } else if (Integer.parseInt(plantel) != 0  && estatus.equals("0") && publicacion.equals("") && resultados != ("")) {
                            request.setAttribute("consulta", "9");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "' && resultados='" + resultados + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 9");//
                        } else if (Integer.parseInt(plantel) != 0  && estatus.equals("0") && publicacion != ("") && resultados.equals("")) {
                            request.setAttribute("consulta", "10");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "' && publicacion='" + publicacion + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "' && publicacion='" + publicacion + "'";
                            }
//                        out.print("caso 10");//
                        } else if (Integer.parseInt(plantel) != 0  && estatus.equals("0") && publicacion != ("") && resultados != ("")) {
                            request.setAttribute("consulta", "11");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 11");//
                        } else if (Integer.parseInt(plantel) != 0  && estatus != ("0") && publicacion.equals("") && resultados.equals("")) {
                            request.setAttribute("consulta", "12");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "' && estatus='" + estatus + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "' && estatus='" + estatus + "'";
                            }
//                        out.print("caso 12");//
                        } else if (Integer.parseInt(plantel) != 0  && estatus != ("0") && publicacion.equals("") && resultados != ("")) {
                            request.setAttribute("consulta", "13");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "' && estatus='" + estatus + "' && resultados='" + resultados + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "' && estatus='" + estatus + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 13");//
                        } else if (Integer.parseInt(plantel) != 0  && estatus != ("0") && publicacion != ("") && resultados.equals("")) {
                            request.setAttribute("consulta", "14");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "'";
                            }
//                        out.print("caso 14");//
                        } else if (Integer.parseInt(plantel) != 0  && estatus != ("0") && publicacion != ("") && resultados != ("")) {
                            request.setAttribute("consulta", "15");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + plantel + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 15");//
                        }
                    }

                    if (control_combobox.equals("true") && nac1.equals("3")) {
                         if (estatus.equals("0") && publicacion.equals("") && resultados.equals("")) {
                            request.setAttribute("consulta", "0");
                             if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "'";
                            }
//                        out.print("caso 0"); //nada
                        } else if (estatus.equals("0") && publicacion.equals("") && resultados != ("")) {
                            request.setAttribute("consulta", "1");
                            if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "' && resultados='" + resultados + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 1");//
                        } else if (estatus.equals("0") && publicacion != ("") && resultados.equals("")) {
                            request.setAttribute("consulta", "2");
                             if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "' && publicacion='" + publicacion + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "' && publicacion='" + publicacion + "'";
                            }
//                        out.print("caso 2");//
                        } else if (estatus.equals("0") && publicacion != ("") && resultados != ("")) {
                            request.setAttribute("consulta", "3");
                             if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 3");//
                        } else if (estatus != ("0") && publicacion.equals("") && resultados.equals("")) {
                            request.setAttribute("consulta", "4");
                             if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "' && estatus='" + estatus + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "' && estatus='" + estatus + "'";
                            }
//                        out.print("caso 4");//
                        } else if (estatus != ("0") && publicacion.equals("") && resultados != ("")) {
                            request.setAttribute("consulta", "5");
                             if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "' && estatus='" + estatus + "' && resultados='" + resultados + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "' && estatus='" + estatus + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 5");//
                        } else if (estatus != ("0") && publicacion != ("") && resultados.equals("")) {
                            request.setAttribute("consulta", "6");
                             if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "'";
                            }
//                        out.print("caso 6");//
                        } else if (estatus != ("0") && publicacion != ("") && resultados != ("")) {
                            request.setAttribute("consulta", "7");
                             if(sub.equals("1")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel < 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }else if(sub.equals("2")){
                                cadena="SELECT a.*,b.programa, d.idEntidad,e.subsistema,f.entidad,d.plantel FROM convocatoria a join catprogramas b on a.idPrograma=b.id join catplanteles d on a.idPlantel=d.id join catsubsistema e on d.idSubsistema=e.id join catentidades f on d.idEntidad=f.id where a.idPlantel >= 462 && d.idEntidad='" + ent1 + "' && idPlantel='" + pla1 + "' && estatus='" + estatus + "' && publicacion='" + publicacion + "' && resultados='" + resultados + "'";
                            }
//                        out.print("caso 7");//
                        } 
                    }
                    
                    
                    request.setAttribute("control_combobox", control_combobox);
                    request.setAttribute("nacional", nac1);//AGREGAR-------------------------------
                    request.setAttribute("subsistema", subsistema);
                    request.setAttribute("cadena", cadena);
                    request.setAttribute("opc", "1");
                    request.setAttribute("nom", nom1);
                    request.setAttribute("dato_ent", ent1);
                    request.setAttribute("dato_pla", pla1);
                    request.setAttribute("dato_rfc", rfc1);
                    request.setAttribute("per1", per1);
                    request.setAttribute("per2", per2);
                    request.setAttribute("per4", per4);

                    request.setAttribute("ent", entidad);
                    request.setAttribute("pla", plantel);
                    request.setAttribute("est", estatus);
                    request.setAttribute("pub", publicacion);
                    request.setAttribute("res", resultados);
                    session.setAttribute("idUsuario", idUsuario);
                    session.setAttribute("rfc", rfc);
                    RequestDispatcher rd = request.getRequestDispatcher("convocatoria.jsp");
                    rd.forward(request, response);
                } else {
                    request.setAttribute("error", "Vacante No Registrado");
                    RequestDispatcher rd = request.getRequestDispatcher("vacantes.jsp");
                    rd.forward(request, response);
                    //out.println("USUARIO NO REGISTRADOs");
                }
            } else {
                response.sendRedirect("login.jsp");
            }

            //out.println("<h1>Servlet Servlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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

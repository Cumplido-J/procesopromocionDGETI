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
@WebServlet(name = "Servlet_buscar_vacancia", urlPatterns = {"/Servlet_buscar_vacancia"})
public class Servlet_buscar_vacancia extends HttpServlet {

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
            out.println("<title>Servlet Servlet_buscar_vacancia</title>");
            out.println("</head>");
            out.println("<body>");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
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
            String subsistema = "";
            if (session.getAttribute("idUsuario").toString() != null && session.getAttribute("rfc").toString() != null) {
                idUsuario = session.getAttribute("idUsuario").toString();
                rfc = session.getAttribute("rfc").toString();

                String cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.id";
                String num_sub = "";
                String control_combobox = request.getParameter("control_combobox");
                String nac1 = request.getParameter("nacional");//AGREGAR----------------------------------
                String per1 = request.getParameter("permiso1");
                String per2 = request.getParameter("permiso2");
                String per4 = request.getParameter("permiso4");
                String nom1 = request.getParameter("nombre");
                String ent1 = request.getParameter("dato_ent");
                String pla1 = request.getParameter("dato_pla");
                String rfc1 = request.getParameter("dato_rfc");
                num_sub = request.getParameter("num_sub");
                subsistema = request.getParameter("subsistema");
                String entidadt = request.getParameter("campoentidad70");
                String entidad = request.getParameter("entidad");
                String n_plantel = request.getParameter("n_plantel");
                String categoria = request.getParameter("categoria");
                
                String btnvacancia = request.getParameter("buscarvacancia");
                if (btnvacancia != null) {

                    if (control_combobox.equals("false") || control_combobox.equals("true") && nac1.equals("1")) {
                        if (entidad.equals("0") && n_plantel.equals("0") && categoria.equals("0")) {
                            request.setAttribute("consulta", "1");
                            if (subsistema.equals("1")) {
                                cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.id  WHERE a.plantel < 462";
                            } else if (subsistema.equals("2")) {
                                cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.id WHERE a.plantel >= 462";
                            }
//                            out.print("caso 1"); //nada
                        } else if (entidad != ("0") && n_plantel != ("0") && categoria.equals("0")) {
                            if (n_plantel.equals("0")) {
                                request.setAttribute("consulta", "2");
//                                out.print("caso 2");//entidad
                                if (subsistema.equals("1")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.id WHERE a.plantel < 462 && entidad='" + entidad + "'";
                                } else if (subsistema.equals("2")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.id WHERE a.plantel >= 462 && entidad='" + entidad + "'";
                                }
                            } else {
                                request.setAttribute("consulta", "3");
//                                out.print("caso 3"); //entidad y plantel  
                                if (subsistema.equals("1")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.id WHERE a.plantel < 462 && entidad='" + entidad + "'  && a.plantel='" + n_plantel + "'";
                                } else if (subsistema.equals("2")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.id WHERE a.plantel >= 462 && entidad='" + entidad + "'  && a.plantel='" + n_plantel + "'";
                                }
                            }

                        } else if (entidad.equals("0") && n_plantel.equals("0") && categoria != "0") {
                            request.setAttribute("consulta", "4");
//                            out.print("caso 4");   //usuario
                            if (subsistema.equals("1")) {
                                cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.id WHERE a.plantel < 462 && plaza='" + categoria + "'";
                            } else if (subsistema.equals("2")) {
                                cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.id WHERE a.plantel >= 462 && plaza='" + categoria + "'";
                            }
                        } else if (entidad != "0" && n_plantel != ("0") && categoria != "0") {
                            if (n_plantel.equals("0")) {
                                request.setAttribute("consulta", "5");
//                                out.print("caso 5");//entidad y usuario
                                if (subsistema.equals("1")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.id WHERE a.plantel < 462 && entidad='" + entidad + "' && plaza='" + categoria + "'";
                                } else if (subsistema.equals("2")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.id WHERE a.plantel >= 462 && entidad='" + entidad + "' && plaza='" + categoria + "'";
                                }
                            } else {
                                request.setAttribute("consulta", "6");
//                                out.print("caso 6"); //todos
                                if (subsistema.equals("1")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.id WHERE a.plantel < 462 && entidad='" + entidad + "'  && a.plantel='"+ n_plantel +"' && plaza='" + categoria + "'";
                                } else if (subsistema.equals("2")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.id WHERE a.plantel >= 462 && entidad='" + entidad + "'  && a.plantel='"+ n_plantel +"' && plaza='" + categoria + "'";
                                }
                            }

                            //request.setAttribute("consulta", "4");
                        }
                    }//fin comparacion combobox
                    if (control_combobox.equals("true") && nac1.equals("2")) {
                        if (n_plantel.equals("0") && categoria.equals("0")) {
                            request.setAttribute("consulta", "1");
                            //out.print("caso 1"); //nada                            
                             if (num_sub.equals("1")) {                                
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.idWHERE entidad='" + ent1 + "'  && a.plantel < 462";
                                } else if (num_sub.equals("2")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.idWHERE entidad='" + ent1 + "'  && a.plantel >= 462";
                                }
                        } else if (n_plantel != ("0") && categoria.equals("0")) {
                            request.setAttribute("consulta", "3");
                            //out.print("caso 1"); //nada                            
                             if (num_sub.equals("1")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.idWHERE entidad='" + ent1 + "'  && a.plantel='" + n_plantel + "'  && a.plantel < 462";
                                } else if (num_sub.equals("2")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.idWHERE entidad='" + ent1 + "'  && a.plantel='" + n_plantel + "'  && a.plantel >= 462"; 
                                }
                        } else if (n_plantel.equals("0") && categoria != ("0")) {
                            request.setAttribute("consulta", "5");
                            //out.print("caso 1"); //nada
                             if (num_sub.equals("1")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.idWHERE entidad='" + ent1 + "' && plaza='" + categoria + "'  && a.plantel < 462";
                                } else if (num_sub.equals("2")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.idWHERE entidad='" + ent1 + "' && plaza='" + categoria + "'  && a.plantel >= 462";
                                }
                        } else if (n_plantel != ("0") && categoria != ("0")) {
                            request.setAttribute("consulta", "6");
                            //out.print("caso 1"); //nada
                             if (num_sub.equals("1")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.idWHERE entidad='" + ent1 + "'  && a.plantel='" + n_plantel + "' && plaza='" + categoria + "'  && a.plantel < 462";
                                } else if (num_sub.equals("2")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.idWHERE entidad='" + ent1 + "'  && a.plantel='" + n_plantel + "' && plaza='" + categoria + "'  && a.plantel >= 462";
                                }
                        }
                    }

                    if (control_combobox.equals("true") && nac1.equals("3")) {
                        if (categoria.equals("0")) {
                            request.setAttribute("consulta", "1");
                            //out.print("caso 1"); //nada
                             if (num_sub.equals("1")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.idWHERE entidad='" + ent1 + "'  && a.plantel='" + pla1 + "'  && a.plantel < 462";
                                } else if (num_sub.equals("2")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.idWHERE entidad='" + ent1 + "'  && a.plantel='" + pla1 + "'  && a.plantel >= 462";
                                }
                        } else if (categoria != ("0")) {
                            request.setAttribute("consulta", "2");
                            //out.print("caso 1"); //nada
                             if (num_sub.equals("1")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.idWHERE entidad='" + ent1 + "'  && a.plantel='" + pla1 + "' && plaza='"+ categoria +"'  && a.plantel < 462";
                                } else if (num_sub.equals("2")) {
                                    cadena = "SELECT a.*,c.subsistema FROM vacancia a join catplanteles b on a.plantel=b.id join catsubsistema c on b.idSubsistema=c.idWHERE entidad='" + ent1 + "'  && a.plantel='" + pla1 + "' && plaza='"+ categoria +"'  && a.plantel >= 462";
                                }
                        }

                    }
//----------------------------------------------------------AGREGAR-------------------------------------------------
                    request.setAttribute("control_combobox", control_combobox);
                    request.setAttribute("nacional", nac1);
                    request.setAttribute("subsistema", subsistema);
                    request.setAttribute("cadena", cadena);
                    request.setAttribute("est", entidad);
                    request.setAttribute("pla", n_plantel);
                    request.setAttribute("cat", categoria);
                    request.setAttribute("opc", "1");
                    request.setAttribute("nom", nom1);
                    request.setAttribute("dato_ent", ent1);
                    request.setAttribute("dato_pla", pla1);
                    request.setAttribute("dato_rfc", rfc1);
                    request.setAttribute("per1", per1);
                    request.setAttribute("per2", per2);
                    request.setAttribute("per4", per4);
                    session.setAttribute("idUsuario", idUsuario);
                    session.setAttribute("rfc", rfc);

                    RequestDispatcher rd = request.getRequestDispatcher("vacantes.jsp");
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.servlet;

import herramientas.Datos;
import herramientas.Fecha;
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
import constants.ConstantsWS;
import java.util.ArrayList;
import java.util.Arrays;

/**
 *
 * @author David Reyna
 */
@WebServlet(name = "RegistroInfoLaboral", urlPatterns = {"/RegistroInfoLaboral"})
public class Servlet_registroInfoLaboral extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_registroInfoLaboral</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_registroInfoLaboral at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
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
        PrintWriter out = response.getWriter();
        try {
            HttpSession session= (HttpSession) request.getSession();
            String idUsuario="",rfc="",programa="",idEntidad="",idPlantel="",numhoras="0";
            if(session.getAttribute("rol").toString().equals("D")){
                idUsuario=session.getAttribute("idUsuario").toString();
                rfc=session.getAttribute("rfc").toString();
            }else{
                idUsuario=session.getAttribute("idDocente").toString();                
                rfc=session.getAttribute("rfcDocente").toString();
            }
            
            programa=session.getAttribute("programa").toString();
            
            if(programa.equals("2")){
                numhoras=request.getParameter("numhoras");
            }
            
            //out.println(idUsuario);
            Fecha fecha=new Fecha();
            String activo,ingresoSubsistema="",ingresoPlantel="",idJornada="",fechaPlaza="",idTipoNombramiento="",fechaUltimaPromocion="",idJornadaAspira="",idPerfilRequerido="",notaSancion="N",idCategoria="",idCategoriaAspira="",nombreVacancia="", idVacancia=null;
            if(request.getParameter("activoServicio")!=null){
                activo="S";
                ingresoSubsistema=fecha.formatoAlmacenar(request.getParameter("ingresoSubsistema"));
                ingresoPlantel=fecha.formatoAlmacenar(request.getParameter("ingresoPlantel")); 
                /*idCategoria=request.getParameter("categoria");
                idJornada=request.getParameter("jornada");
                fechaPlaza=fecha.formatoAlmacenar(request.getParameter("fechaPlaza"));
                idTipoNombramiento=request.getParameter("tipoNombramiento");*/
                if(request.getParameter("cbUP")==null){
                    fechaUltimaPromocion=fecha.formatoAlmacenar(request.getParameter("fechaPromocion"));
                }else{
                    fechaUltimaPromocion="";
                }
                String categoriaNombre=request.getParameter("categoriaAspira");

                if(programa.equals("2")){
                    categoriaNombre=  categoriaNombre.isEmpty() ? "3-Real-22328" : categoriaNombre;
                }
                String[] categoria;
                categoria = categoriaNombre.split("-");
                idCategoriaAspira=categoria[0];
                nombreVacancia=categoria[1];
                if(programa.equals("1")){idVacancia=categoria[2];}
               
                
                idJornadaAspira=request.getParameter("jornadaAspira");
                if(idJornadaAspira.equals("")){
                    idJornadaAspira="0";
                }
                
                idPerfilRequerido=request.getParameter("opReqCat");                
                if(request.getParameter("notaDesfavorable")!=null){
                    notaSancion="S";
                }
            }else{
                activo="N";
            }
            String horas="0";
            if(programa.equals("1")){
                String respuesta=new Datos().validarSeleccionadas(idUsuario);
                System.out.println("respuesta"+respuesta);
                if(respuesta.contains(",")){
                    String[] aux=respuesta.split(",");
                    System.out.println("longitud"+aux.length);
                    idCategoria=aux[0];
                    idJornada=aux[1];
                    horas=aux[2];
                    if(aux.length==4){
                        idTipoNombramiento=aux[3];   
                    }
                }  
            }else if(programa.equals("2")){
                String respuesta=new Datos().validarSeleccionadasAdd(idUsuario);
                System.out.println("respuesta"+respuesta);
                if(respuesta.contains(",")){
                    String[] aux=respuesta.split(",");
                    System.out.println("longitud"+aux.length);
                    idCategoria=aux[0];
                    idJornada=aux[1];
                    idTipoNombramiento=aux[3];
                    horas=aux[4];
                }
            }
            System.out.println("cat"+idCategoria);
            System.out.println("jor"+idJornada);

            if(idPerfilRequerido.equals("0") || notaSancion.equals("S") || activo.equals("N")){
                Metodos_sql metodo=new Metodos_sql();
                String[] parametros={idUsuario,"",""};
                List<String[]> datos;
                datos=metodo.ejecutaSP("sp_finRegistro",parametros);
                                
                if(!datos.isEmpty()){
                if(datos.get(0)[0].equals("ok")){
                    out.print("fin");
                }
                }
            }else{
                if(idCategoria.equals("-1")||idJornada.equals("-1")){
                out.print("Debe seleccionar la plaza con la que participará");
            }else{
                if(idTipoNombramiento.equals(ConstantsWS.ALTA_DEFINITIVA) || idTipoNombramiento.equals(ConstantsWS.ALTA_PROVICIONAL)){
                    int categoriaActual=Integer.parseInt(idCategoria);
                    int categoriaAspira=Integer.parseInt(idCategoriaAspira);
                    int jornadaActual=Integer.parseInt(idJornada);
                    int jornadaAspira=Integer.parseInt(idJornadaAspira);
                    int totalHoras=0;
                    boolean bandera=false;
                    
                    String[] catAsignatura = {"1", "2", "3"};
                    String[] catCarAsociado = {"4", "5", "6"};
                    String[] catCarTitular = {"7", "8", "9"};
                    String[] catDocAsignatura = {"10", "11"};
                    String[] catDocAsociado = {"12", "13", "14"};
                    String[] catDocTtitular = {"15", "16", "17"};

                    List<String> list1 = new ArrayList<>(Arrays.asList(catAsignatura));
                    List<String> list2 = new ArrayList<>(Arrays.asList(catCarAsociado));
                    List<String> list3 = new ArrayList<>(Arrays.asList(catCarTitular));
                    List<String> list4 = new ArrayList<>(Arrays.asList(catDocAsignatura));
                    List<String> list5 = new ArrayList<>(Arrays.asList(catDocAsociado));
                    List<String> list6 = new ArrayList<>(Arrays.asList(catDocTtitular));
                    
                    if(programa.equals("1")){
                        String respuestaValidacionCDC=new Datos().validarSeleccionadasCambioDeCategoria(idUsuario);
                        if((categoriaActual==3 && categoriaAspira==4 && idJornadaAspira.equals("2"))||
                          (categoriaActual==2 && categoriaAspira==4 && idJornadaAspira.equals("2")) ||
                          (categoriaActual==1 && categoriaAspira==4 && idJornadaAspira.equals("2"))
                            //((categoriaActual==11 && categoriaAspira==12))
                          ){
                            if(Integer.parseInt(horas)>=18 && Integer.parseInt(horas)<=19){
                                bandera=true;
                            }
                        }else{
                            if(categoriaAspira==categoriaActual && jornadaAspira==jornadaActual+1){
                                bandera=true;
                            }else if(categoriaAspira==categoriaActual+1 && jornadaAspira==jornadaActual){
                                bandera=true;
                            }else if(categoriaAspira==categoriaActual+1 && jornadaAspira==jornadaActual+1){
                                bandera=true;
                            }
                        }
                        totalHoras=Integer.parseInt(numhoras)+Integer.parseInt(horas);
                        if(totalHoras>18 && (jornadaAspira==3 || jornadaAspira==4)){
                            bandera=false;
                        }else if(respuestaValidacionCDC.equals("1A-E4523")){
                            //out.println("Solo puede seleccionar plazas de horas C E4523");
                            bandera=false;
                        }
                        
                        
                        
                        /*
                        if((categoriaActual==3 && categoriaAspira==4)||((categoriaActual==11 && categoriaAspira==12))){
                            if(Integer.parseInt(horas)>=18){
                                bandera=true;
                            }
                        }else{
                            if(list1.contains(Integer.toString(categoriaAspira)) && list1.contains(Integer.toString(categoriaActual)) && jornadaAspira==jornadaActual && jornadaAspira==1){
                                totalHoras=Integer.parseInt(numhoras)+Integer.parseInt(horas);
                                if(totalHoras<=19){
                                    bandera=true;
                                }else{
                                    bandera=false;
                                }
                            }else if(list2.contains(categoriaAspira) && list2.contains(categoriaActual) && jornadaAspira==jornadaActual && jornadaAspira==1){
                                totalHoras=Integer.parseInt(numhoras)+Integer.parseInt(horas);
                                if(totalHoras<=19){
                                    bandera=true;
                                }else{
                                    bandera=false;
                                }
                            }else if(list3.contains(categoriaAspira) && list3.contains(categoriaActual) && jornadaAspira==jornadaActual && jornadaAspira==1){
                                totalHoras=Integer.parseInt(numhoras)+Integer.parseInt(horas);
                                if(totalHoras<=19){
                                    bandera=true;
                                }else{
                                    bandera=false;
                                }
                            }else if(list4.contains(categoriaAspira) && list4.contains(categoriaActual) && jornadaAspira==jornadaActual && jornadaAspira==1){
                                totalHoras=Integer.parseInt(numhoras)+Integer.parseInt(horas);
                                if(totalHoras<=19){
                                    bandera=true;
                                }else{
                                    bandera=false;
                                }
                            }else if(list5.contains(categoriaAspira) && list5.contains(categoriaActual) && jornadaAspira==jornadaActual && jornadaAspira==1){
                                totalHoras=Integer.parseInt(numhoras)+Integer.parseInt(horas);
                                if(totalHoras<=19){
                                    bandera=true;
                                }else{
                                    bandera=false;
                                }
                            }else if(list6.contains(categoriaAspira) && list6.contains(categoriaActual) && jornadaAspira==jornadaActual && jornadaAspira==1){
                                totalHoras=Integer.parseInt(numhoras)+Integer.parseInt(horas);
                                if(totalHoras<=19){
                                    bandera=true;
                                }else{
                                    bandera=false;
                                }
                            }else{
                                bandera=false;
                            }
                        
//                        if(categoriaAspira==categoriaActual && jornadaAspira==jornadaActual+1){
//                            bandera=true;
//                        }else if(categoriaAspira==categoriaActual+1 && jornadaAspira==jornadaActual){
//                            bandera=true;
//                        }else if(categoriaAspira==categoriaActual+1 && jornadaAspira==jornadaActual+1){
//                            bandera=true;
//                        }
                    }
                    
                    totalHoras=Integer.parseInt(numhoras)+Integer.parseInt(horas);
                    if(totalHoras>18 && (jornadaAspira==3 || jornadaAspira==4)){
                        bandera=false;
                    }
                    */
                }else if(programa.equals("2")){
                    String validarRespuesta=new Datos().validarSeleccionadasAdd(idUsuario);
                    String validarRespuesta1=new Datos().validarSeleccionadasAdd1(idUsuario);
                    String HorasAspiraDocente= new Datos().validarHorasAspira(idUsuario);
                    
                    String idJornadaHoras="";
                    
                    
                    if(validarRespuesta.contains(",")){
                        String[] auxRespuesta=validarRespuesta.split(",");
                        validarRespuesta=auxRespuesta[4];
                        idJornadaHoras=auxRespuesta[4];
                    }
                    totalHoras+= Integer.parseInt(validarRespuesta);
                    //int totalHorasCapturadas=Integer.parseInt(validarRespuesta)+Integer.parseInt(horas);
                    int totalHorasCapturadas=Integer.parseInt(validarRespuesta)+Integer.parseInt(HorasAspiraDocente);
                    if(totalHorasCapturadas<=19 && validarRespuesta1.contains("0")){
                        bandera=true;
                    }else{
                        bandera=false;
                        if(validarRespuesta1.contains("1")){
                            out.println("e1");

                        }else if(totalHorasCapturadas>19){
                            out.println("Excede el número de horas permitidas tu registro sera procesado como ficha incompleta. ¿Deseas continuar?");
                        }
                    }
                    
                    if((categoriaActual==3 && categoriaAspira==4)||((categoriaActual==11 && categoriaAspira==12))){
                            if(Integer.parseInt(horas)>=18){
                                bandera=true;
                            }
                    }
                    if(HorasAspiraDocente.equals("0")){
                      out.print("Debe registrar una categoria");
                      bandera=false;
                    }
                }
  
                if(programa.equals("1")){
                    totalHoras=0;
                }else if(programa.equals("2")){
                    String[] parametros={idUsuario};  
                    List<String[]> infoPlazasAspira=new Metodos_sql().ejecutaSP("sp_consultaUsuarioCategoriaAspira",parametros);
                    for(String[] dato:infoPlazasAspira){
                        totalHoras +=dato[6]!= null ? Integer.parseInt(dato[6]) : 0;
                    }
                    /*String validarRespuesta=new Datos().validarSeleccionadasAdd(idUsuario);
                    if(validarRespuesta.contains(",")){
                            String[] auxRespuesta=validarRespuesta.split(",");
                            
                            totalHoras= auxRespuesta[2]!= null ? Integer.parseInt(auxRespuesta[2]) : 0;
                    }*/
                     
                }  
                
                if(bandera){
                //out.println(notaSancion);
                    Metodos_sql metodo = new Metodos_sql();
                     List<String[]> datos=null;  
                    if(programa.equals("1")){
                        String[] parametros={idUsuario,activo,ingresoSubsistema,ingresoPlantel,idCategoria,idJornada,fechaPlaza,idTipoNombramiento,fechaUltimaPromocion,idCategoriaAspira,idJornadaAspira,idPerfilRequerido,notaSancion,nombreVacancia,String.valueOf(totalHoras),idVacancia};                        
                        datos=metodo.ejecutaSP("sp_registroInfoLaboral",parametros);   
                    }else if(programa.equals("2")){
                        String[] parametros={idUsuario,activo,ingresoSubsistema,ingresoPlantel,idCategoria,idJornada,fechaPlaza,idTipoNombramiento,fechaUltimaPromocion,idCategoriaAspira,idJornadaAspira,idPerfilRequerido,notaSancion,nombreVacancia,String.valueOf(totalHoras)};                        
                        datos=metodo.ejecutaSP("sp_registroInfoLaboralHoras",parametros); 
                    }
                    if(!datos.isEmpty()){
                        if(datos.get(0)[0].contains("-")){
                            out.print("No puede aplicar a esa combinación de categoria y jornada-");
                        }else{
                            out.print("ok");
                        }
                    }else{
                        out.print("Error en almacenamiento de datos, intente nuevamente");
                    }
                }else{
                    if(programa.equals("2")){
                        if(totalHoras>19){
                            out.println("Excede el número de horas permitidas");
                        }
                    }else{
                        out.print("No puede aplicar a esa combinación de categoria y jornada");
                    }
                }
                }else{
                    if(programa.equals("1")){
                        out.print("-El tipo de nombramiento no es valido para esta convocatoria solo puedes partipar con Alta definitiva o Alta provisional-");
                    }
                }
            }
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

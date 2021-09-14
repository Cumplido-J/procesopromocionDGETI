/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import metodos_sql.Metodos_sql;

/**
 *
 * @author David Reyna
 */
public class Catalogos {
    Metodos_sql metodos;

    public Catalogos() {
        metodos = new Metodos_sql();
    }
    
    
    public  String desplegarOpcionesEstado(){        
        String respuesta="<option value=''>-Seleccione-</option>";        
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatEntidades");
            for(String[] dato:datos)
            {
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String desplegarOpcionesEstado2(String idEstado){        
        String respuesta="<option value=''>-Seleccione-</option>";        
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatEntidades");
            for(String[] dato:datos)
            {
                if(idEstado.equals(dato[0])){respuesta+="<option value='"+dato[0]+"' selected>"+dato[1]+"</option>";}
                else{respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";}
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesEstado(String id){
        
        String respuesta=desplegarOpcionesEstado();
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
            
        return respuesta;
    }    
    public String desplegarOpcionesGrado(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatGradosAcademicos");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesGrado(String id){
        String respuesta=desplegarOpcionesGrado();
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;  
    }
    
    public String desplegarOpcionesModalidadTitulacion(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatModalidadesTitulacion");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesModalidadTitulacion(String id){
        String respuesta=desplegarOpcionesModalidadTitulacion();
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;  
    }
    
    public String desplegarOpcionesPlanteles(String idEstado){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            String[] parametros={"1",idEstado};
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatPlanteles",parametros);
            for(String[] dato:datos){
                respuesta+="<option marginacion='"+dato[3]+"' cct='"+dato[1]+"' value='"+dato[0]+"'>"+dato[2]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    
    public String desplegarOpcionesPlanteles(String idEstado,String id){
        String respuesta=desplegarOpcionesPlanteles(idEstado);
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;  
    }
    
    
    public String desplegarOpcionesTipoInstitucion(String idEstado){        
        String respuesta="<option value=''>-Seleccione-</option>";
        String[] parametros={idEstado};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaTiposInstitucion",parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesTipoInstitucion(String idEstado,String id){
        String respuesta=desplegarOpcionesTipoInstitucion(idEstado);
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;  
    }
    public String desplegarOpcionesInstituciones(String idEntidad,String idTipo){        
        String respuesta="<option value=''>-Seleccione-</option>";
        String[] parametros={idEntidad,idTipo};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatInstituciones",parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
            respuesta+="<option value='-1'>Otra</option>";
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesInstituciones(String idEntidad,String idTipo,String id){
        String respuesta=desplegarOpcionesInstituciones(idEntidad,idTipo);
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;  
    }
    public String desplegarOpcionesCCT(String idInstitucion){        
        String respuesta="<option value=''>-Seleccione-</option>";
        String[] parametros={idInstitucion};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatInstitucionCCT",parametros);
            for(String[] dato:datos){
                respuesta+="<option  value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
            respuesta+="<option value='-1'>Otro</option>";
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesCCT(String idInstitucion,String id){
        String respuesta=desplegarOpcionesCCT(idInstitucion);
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;  
    }
    public String desplegarOpcionesEscuelas(String idInstitucion){        
        String respuesta="<option value=''>-Seleccione-</option>";
        String[] parametros={idInstitucion};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatEscuelas",parametros);
            for(String[] dato:datos){
                respuesta+="<option clave='"+dato[1]+"' value='"+dato[0]+"'>"+dato[2]+"</option>";
            }
            respuesta+="<option clave='-1' value='-1'>Otra</option>";
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesEscuelas(String idInstitucion,String id){
        String respuesta=desplegarOpcionesEscuelas(idInstitucion);
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;  
    }
    public String desplegarOpcionesCategorias(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatCategoriasPlaza");
            for(String[] dato:datos){
                respuesta+="<option tipo='"+dato[2]+"' value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesCategoriasHoras(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatCategoriasPlazaHoras");
            for(String[] dato:datos){
                respuesta+="<option tipo='"+dato[2]+"' value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;
        }
    }
    public String desplegarOpcionesCategorias(String id){
        String respuesta=desplegarOpcionesCategorias();
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;
    }
    public String desplegarCategoriasPresupuestales(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatCategoriasPresupuestales");
            for(String[] dato:datos){
                respuesta+="<option ClavePresupuestal='"+dato[1]+"' idCategoriaPlazaCP='"+dato[2]+"' idJornadaCP='"+dato[3]+"' value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarCategoriasPresupuestales(String id){
        String respuesta=desplegarCategoriasPresupuestales();
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;  
    }
    public String desplegarOpcionesTipoNombramiento(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatTiposNombramiento");
            for(String[] dato:datos){
                respuesta+="<option codigo='"+dato[1]+"' value='"+dato[0]+"'>"+dato[1]+":"+dato[2]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesTipoNombramiento(String id){
        String respuesta=desplegarOpcionesTipoNombramiento();
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;  
    }
     public String desplegarVersionesCompBP(String idSubsistema){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaVersionCBP");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
            if(idSubsistema.contains("2")){
                respuesta+="<option value='-1'>Otro</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
     public String desplegarVersionesCompP(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaVersionCP");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarAsignaturasCompBP(String idVersion,String semestre,String idSubsistema){        
        String respuesta="<option value=''>-Seleccione-</option>";
        String[] parametros={idVersion,semestre};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaAsignaturaCBP", parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"' clave='"+dato[2]+"' horas='"+dato[4]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarCarrerasCompP(String idVersion,String semestre ){        
        String respuesta="<option value=''>-Seleccione-</option>";  
        String[] param={idVersion,semestre};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaCarreraCP",param);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"' clave='"+dato[2]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarModulosCompP(String idVersion,String semestre,String idCarrera ){        
        String respuesta="<option value=''>-Seleccione-</option>";
        String[] parametros={idVersion,semestre,idCarrera};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaModuloCP", parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"' clave='"+dato[2]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarSubmodulosCompP(String idVersion,String semestre,String idCarrera,String idModulo ){        
        String respuesta="<option value=''>-Seleccione-</option>";
        String[] parametros={idVersion,semestre,idCarrera,idModulo};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaSubModuloCP",parametros);
            for(String[] dato:datos){
                respuesta+="<option clave='"+dato[2]+"' horas='"+dato[4]+"' value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarTalleres(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        respuesta+="<option value='0'> NA </option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatTalleresLaboratorios");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String consultarCarreras(){        
        String respuesta="";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatCarreras");
            for(String[] dato:datos){
                respuesta+="'"+dato[1]+"',";
            }
            if(respuesta!=""){
                respuesta=respuesta.substring(0, respuesta.length() - 1);
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesJornada(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaCatJornadas");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }    
    public String desplegarOpcionesJornada(String idCategoria){        
        String respuesta="<option value=''>-Seleccione-</option>";
        String[] parametros={idCategoria};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaJornadas",parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"' clave='"+dato[1]+"'>"+dato[2]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesJornada(String idCategoria,String id){
        String respuesta=desplegarOpcionesJornada(idCategoria);
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");        
        return respuesta;  
    }
    public String desplegarRequisitosCategoria(String idCategoria){
        if(idCategoria.contains("R") || idCategoria.contains("C")){
            String[] categoria;
		categoria = idCategoria.split("-");
                idCategoria=categoria[0];
        }
        String respuesta="";
        String[] parametros={idCategoria};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaRequisitosCategoria",parametros);
            for(String[] dato:datos){
                respuesta+="<label class='control-label'><input type='radio' name='opReqCat' value='"+dato[0]+"' required>&nbsp;"+dato[1]+"</label><br/>";
            }
            respuesta+="<label><input type='radio' name='opReqCat' value='0' required>&nbsp;Ninguno</label>";
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarRequisitosCategoria(String idCategoria,String id){
        
        if(idCategoria.contains("R") || idCategoria.contains("C")){
            String[] categoria;
		categoria = idCategoria.split("-");
                idCategoria=categoria[0];
        }
        
        String respuesta=desplegarRequisitosCategoria(idCategoria);
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst("checked","");
        respuesta=respuesta.replaceFirst(aux, aux+" checked");
        return respuesta;  
    }
    public String desplegarOpcionesPeriodos(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatPeriodos");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesPeriodos(String id){
        String respuesta=desplegarOpcionesPeriodos();
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;  
    }
    public String desplegarOpcionesProgramas(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatProgramas");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesProgramas2(String idPrograma){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatProgramas");
            for(String[] dato:datos){
                if (dato[0].equals(idPrograma)) {
                     respuesta+="<option value='"+dato[0]+"' selected>"+dato[1]+"</option>"; 
                }else{
                     respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>"; 
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesProgramas(String id){
        String respuesta=desplegarOpcionesProgramas();
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta; 
    }
    public String desplegarOpcionesPuntaje(String idCriterio, String idUsuario){        
        String respuesta="<option value='' puntaje='0'>-Seleccione-</option>";
        try{
            String[] parametros={idCriterio, idUsuario};
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatPuntaje_v2",parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"' puntaje='"+dato[2]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesPuntaje(String idCriterio,String id,String idUsuario){        
        String respuesta=desplegarOpcionesPuntaje(idCriterio, idUsuario);
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;  
    }
    public String desplegarOpcionesPuntajeAdmin(String idCriterio,String idUsuario){        
        String respuesta="<option value='' puntaje='0'>-Seleccione-</option>";
        respuesta+="<option value='0' puntaje='0'>No cumple el criterio</option>";
        try{
            String[] parametros={idCriterio, idUsuario};
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatPuntaje_v2",parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"' puntaje='"+dato[2]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesPuntajeAdmin(String idCriterio,String id,String idUsuario){        
        String respuesta=desplegarOpcionesPuntajeAdmin(idCriterio, idUsuario);
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;  
    }
    public String desplegarOpcionesCategoriasVacantes(String idPlantel,String idPrograma){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            String[] parametros={idPlantel,idPrograma};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaCategoriasVacantes",parametros);
            for(String[] dato:datos){
                //respuesta+="<option tipo='"+dato[3]+"' aux='"+dato[1]+"' value='"+dato[1]+"-"+dato[4]+"'>"+dato[2]+"-"+dato[4]+"</option>";
                respuesta+="<option tipo='"+dato[2]+"' idCategoria='"+dato[3]+"' aux='"+dato[0]+"' value='"+dato[0]+"-"+dato[2]+"'>"+dato[1]+"-"+dato[2]+"-"+dato[5]+"-"+dato[6]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;       
        }
    }
        public String desplegarOpcionesCategoriasVacantes(String idPlantel,String idPrograma,String id,String idTipoVacancia,String idJornada,String idSubsistema){
        String respuesta=desplegarOpcionesCategoriasVacantes(idPlantel,idPrograma);
//        String[] parametros={idPlantel,id,idJornada};
        String[] parametros={idPlantel,idPrograma,idSubsistema};
        //
        List<String[]> datos=metodos.ejecutaSP("sp_consultaCategoriaTipoVacante",parametros);
        String tipoVacancia="";
        if(!datos.isEmpty()){
            tipoVacancia=datos.get(0)[0];
        }
        String aux="value='"+id+"-"+tipoVacancia+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;  
    }
    public String desplegarOpcionesJornadaVacante(String idCategoria,String idPlantel,String idPrograma){        
        String respuesta="<option value=''>-Seleccione-</option>";
        if(idCategoria.contains("R") || idCategoria.contains("C")){
            String[] categoria;
		categoria = idCategoria.split("-");
                idCategoria=categoria[0];
        }
        String[] parametros={idCategoria,idPlantel,idPrograma};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaJornadaVacante",parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[1]+"' clave='"+dato[2]+"'>"+dato[3]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesJornadaVacante1(String idCategoria,String idPlantel,String idPrograma,String idCategoria1){        
        String respuesta="<option value=''>-Seleccione-</option>";
        if(idCategoria.contains("R") || idCategoria.contains("C")){
            String[] categoria;
        categoria = idCategoria.split("-");
                idCategoria=categoria[0];
        }
        String[] parametros={idCategoria,idPlantel,idPrograma,idCategoria1};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaJornadaVacante",parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[1]+"' clave='"+dato[2]+"'>"+dato[3]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesJornadaVacanteHoras(String idCategoria,String idPlantel,String idPrograma,String idCategoria1){        
        String respuesta="<option value=''>-Seleccione-</option>";
        if(idCategoria.contains("R") || idCategoria.contains("C")){
            String[] categoria;
        categoria = idCategoria.split("-");
                idCategoria=categoria[0];
        }
        String[] parametros={idCategoria,idPlantel,idPrograma,idCategoria1};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaJornadaVacante",parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[4]+"' clave='"+dato[2]+"'>"+dato[4]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesJornadaVacante(String idCategoria,String idPlantel,String idPrograma,String id){
        String respuesta=desplegarOpcionesJornadaVacante(idCategoria,idPlantel,idPrograma);
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");        
        return respuesta;  
    }
    public String desplegarOpcionesHorasVacante(String idCategoria,String idPlantel,String idPrograma){        
        String respuesta="<option value=''>-Seleccione-</option>";
        if(idCategoria.contains("R") || idCategoria.contains("C")){
            String[] categoria;
        categoria = idCategoria.split("-");
                idCategoria=categoria[0];
        }
        String[] parametros={idCategoria,idPlantel,idPrograma};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaJornadaVacante",parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[1]+"' clave='"+dato[2]+"'>"+dato[4]+"</option>";
                System.out.println("11111");
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesHorasVacante(String idCategoria,String idPlantel,String idPrograma,String id){
        String respuesta=desplegarOpcionesHorasVacante(idCategoria,idPlantel,idPrograma);
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;  
    }
    public String desplegarOpcionesConvocatoria(String idPlantel){        
        String respuesta="<option value=''>-Seleccione-</option>";
        String[] parametros={idPlantel};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaProgramasPlantel",parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"' >"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesAportacion(){        
        String respuesta="<option value=''>-Seleccione-</option>";        
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatAportacion");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"' >"+dato[1]+"</option>";
            }
            respuesta+="<option value='-1'>Otra</option>";
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesParticipacion(){        
        String respuesta="<option value=''>-Seleccione-</option>";        
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatParticipacion");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"' >"+dato[1]+"</option>";
            }
            respuesta+="<option value='-1'>Otra</option>";
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarPlanteles(String idPlantel){        
        String respuesta="<option value=''>-Seleccione-</option>";
        String[] parametros={"1",idPlantel};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatPlanteles",parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[2]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarCatalogosEstatus(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatEstatus");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    
    public String desplegarCatalogosEstatus(String idUsuario, String idPermisoActual, Object vinculos){        
        String respuesta="<option value=''>-Seleccione-</option>";
        String[] parametros={idUsuario};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatEstatusidUsuario",parametros);
            if(!datos.isEmpty())
            {   
                if(idPermisoActual.equals("5") && ((List<String[]>)vinculos).size()==1)
                {respuesta+="<option value='-1'>-Todos-</option>";}
            }
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarCatalogosEstatusFinal(String idUsuario){        
        String respuesta="<option value=''>-Seleccione-</option>";
        String idPermisoActual="";
        
        String[] parametros1={idUsuario};
                List<String[]> datos1=metodos.ejecutaSP("sp_consultaRegistro",parametros1);
                if(!datos1.isEmpty()){
                    idPermisoActual=datos1.get(0)[66];
                }
                
                String[] parametros={idUsuario};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatEstatusFinalidUsuario",parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
            if(idPermisoActual.equals("14") || idPermisoActual.equals("15") || idPermisoActual.equals("16") || idPermisoActual.equals("17")){
             String aux="value='"+idPermisoActual+"'";
            respuesta=respuesta.replaceFirst(aux, aux+" selected");   
            }
            
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    
     public String desplegarConvocatorio(String nombreUsuario, String _idEntidad, String _idPlantel, String _idEstatus){        
        String respuesta="";
        String[] parametros={nombreUsuario, _idEntidad, _idPlantel, _idEstatus};
        try{
            int cont= 1;
            List<String[]> datos=metodos.ejecutaSP("sp_consultaConvocatoriasUsuarios",parametros);
            for(String[] dato:datos){
                
                String valor9 = dato[9]==null?"Aun no hay ningun registro":dato[10];
                String valor10 = dato[10]==null?"Aun no hay ningun registro":dato[10];
                
                String enviarD = "enviar" + cont++;
                
                respuesta=
"                                    <td>"+dato[2]+"</td>" +
"                                    <td>"+dato[4]+"</td>" +
"                                    <td><input type='hidden' value='"+dato[8]+"' name='rfc'>"+dato[8]+"</td>" +
"                                    <td>"+dato[5]+"</td>" +
"                                    <td>"+dato[6]+"</td>" +
"                                     <td>"+dato[7]+"</td>" +
"                                    <td>"+valor9+"</td>"+
"                        <td><input type='hidden' value='"+dato[0]+"' name='idUsuario'><button class='btn btn-sm btn-primary' type='submit'>Enviar</button></td>"
                        + "</tr>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public  String desplegarProgramasPlanteles(){        
        String respuesta="<option value=''>-Seleccione-</option>";        
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatProgramas");
            for(String[] dato:datos)
            {
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarComite(String _idEntidad, String _idPlantel, String _idPrograma, String _tipoComite){        
        String respuesta="";
        int cont = 0;
        String[] parametros={_idEntidad, _idPlantel, _idPrograma, _tipoComite};
        try{
            
            List<String[]> datosBuscar=metodos.ejecutaSP("sp_consultarComites",parametros);
            if(datosBuscar.size()==0){
               String valor9 = "";
            List<String[]> datos=metodos.ejecutaSP("sp_insertComites",parametros);
            for(String[] dato:datos){
                
                valor9 = dato[0];
            }
            return respuesta = valor9; 
            }
            
            for(String[] datos:datosBuscar){
                
                String enviarD = "enviar" + cont++;
                String eliminarD = "eliminar" + cont++;
                
                respuesta+="<tr>\n" +
"                                    <td>"+datos[2]+"</td>\n" +
"                                    <td>"+datos[4]+"</td>\n" +
"                                    <td>"+datos[8]+"</td>\n" +
"                                    <td>"+datos[7]+"</td>\n" +
"                                    <td>"+datos[6]+"</td>\n" +
"                        <td><button class='btn btn-sm btn-primary' type='button' data-toggle='modal' data-target='#exampleModalCenter' id='"+enviarD+"'name='"+enviarD+"'-><span class='glyphicon glyphicon-pencil'></span></button>"
                        + "<button class='btn btn-sm btn-primary' type='button' onclick='msg()' id='"+enviarD+"'name='"+enviarD+"'-><span class='glyphicon glyphicon-search'></span></button>"
                        + "<button class='btn btn-sm btn-primary' type='button' onclick='borrarComite("+datos[1]+","+datos[3]+","+datos[5]+","+datos[6]+","+datos[0]+")' id='"+eliminarD+"'name='"+eliminarD+"'-><span class='glyphicon glyphicon-trash'></span></button></td>"
                        + "</tr>";
            }
            
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public void borraComites(String _idEntidad,String _idPlantel,String _idPrograma,String _tipo,String _idComite){
        Metodos_sql metodo = new Metodos_sql();
        String[] parametros={_idEntidad,_idPlantel,_idPrograma,_tipo,_idComite};
        List<String[]> datos=metodo.ejecutaSP("sp_deleteComites",parametros);          
    }
    public String desplegarOpcionesResultados(){        
        String respuesta="<option value=''>-Seleccione-</option>";        
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatResultado");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"' >"+dato[1]+"</option>";
            }
            respuesta+="<option value='-1'>Otra</option>";
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesPlanteles2(String idSubsistema,String idEstado){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            String[] parametros={idSubsistema, idEstado};
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatPlanteles",parametros);
            for(String[] dato:datos){
                respuesta+="<option marginacion='"+dato[3]+"' cct='"+dato[1]+"' value='"+dato[0]+"'>"+dato[2]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesPlanteles3(String idSubsistema,String idEstado,String idPlantel){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            String[] parametros={idSubsistema, idEstado};
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatPlanteles",parametros);
            for(String[] dato:datos){
                if(idPlantel.equals(dato[0])){respuesta+="<option marginacion='"+dato[3]+"' cct='"+dato[1]+"' value='"+dato[0]+"' selected>"+dato[2]+"</option>";}
                else{respuesta+="<option marginacion='"+dato[3]+"' cct='"+dato[1]+"' value='"+dato[0]+"'>"+dato[2]+"</option>";}
                
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesPlanteles2(String idSubsistema,String idEstado,String id){
        String respuesta=desplegarOpcionesPlanteles2(idSubsistema,idEstado);
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        
        return respuesta;  
    }
    
    public String desplegarOpcionesRolComite(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{            
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatRolComite");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesRolComite(String id){        
        String respuesta= desplegarOpcionesRolComite();
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;
    }
    
    public String desplegarOpcionesSubsistema(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{            
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatSubsistema");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesSubsistema(String id){ 
        String respuesta=desplegarOpcionesSubsistema();
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;
    }
    public String desplegarOpcionesPermisos(){        
        String respuesta="<table>";
        try{            
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatPermisos");
            for(String[] dato:datos){
                respuesta+="<tr><td><label><input onChange='cambioPermiso(this)' type='checkbox' class='permiso' id='permiso"+dato[0]+"' value='"+dato[0]+"' title='"+dato[2]+"'>"+dato[1]+"</label></td><td><label class='hidden' id='escritura"+dato[0]+"'><input type='checkbox' id='cbEscritura"+dato[0]+"' class='escritura'  value='"+dato[0]+"' title='Permitir al usuario modificar la información'>Permiso guardar</label></td></tr>";
            }
            respuesta+="</table>";
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesPermisos(String idUsuario){        
        String respuesta="<table>";
        try{      
            String[] parametros={idUsuario};
            String hidden="";
            List<String[]> datos=metodos.ejecutaSP("sp_consultaUsuarioPermiso",parametros);
            for(String[] dato:datos){
                if(dato[2].equals("checked")){
                    hidden="";
                }else{
                    hidden="hidden";
                }
                respuesta+="<tr><td><label><input type='checkbox' onChange='cambioPermiso(this)' class='permiso' id='permiso"+dato[0]+"' value='"+dato[0]+"' "+dato[2]+">"+dato[1]+"</label></td><td><label id='escritura"+dato[0]+"' class='"+hidden+"'><input type='checkbox' id='cbEscritura"+dato[0]+"' class='escritura' value='"+dato[0]+"' "+dato[3]+">Permiso escritura</label></td></tr>";
            }
            respuesta+="</table>";
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesNivel(){ 
        String respuesta="<option value=''>-Seleccione-</option>" +
            "<option value='N'>Nacional</option>" +
            "<option value='E'>Estatal</option>" +
            "<option value='P'>Plantel</option>"; 
        return respuesta;
    }
    public String desplegarOpcionesNivel(String id){ 
        String respuesta=desplegarOpcionesNivel();
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;
    }
    public String desplegarOpcionesEstatus(){ 
        String respuesta="<option value=''>-Seleccione-</option>" +
            "<option value='TEMPORAL'>Temporal</option>" +
            "<option value='DEFINITIVA'>Definitiva</option>"; 
        return respuesta;
    }
    public String desplegarOpcionesEstatus(String id){ 
        String respuesta=desplegarOpcionesEstatus();
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;
    }
    public String desplegarOpcionesTipoCategoria(){ 
        String respuesta="<option value=''>-Seleccione-</option>" +
            "<option value='TD'>Técnico Docente</option>" +
            "<option value='D'>Docente</option>"; 
        return respuesta;
    }
    public String desplegarOpcionesTipoCategoria(String id){ 
        String respuesta=desplegarOpcionesTipoCategoria();
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;
    }
    
    public String desplegarOpcionesTipoConvocatoria(){ 
        String respuesta="<option value=''>-Seleccione-</option>" +
            "<option value='ESTATAL'>Estatal</option>" +
            "<option value='NACIONAL'>Nacional</option>" +
            "<option value='PLANTEL'>Plantel</option>"; 
        return respuesta;
    }
    
    public String desplegarOpcionesTipoConvocatoria1(String id){
        String respuestaOption="<option value=''>-Seleccione-</option>" +
            "<option value='ESTATAL'>Estatal</option>" +
            "<option value='NACIONAL'>Nacional</option>" +
            "<option value='PLANTEL'>Plantel</option>";
        
        String aux="value='"+id+"'";
        respuestaOption=respuestaOption.replaceFirst(aux, aux+" selected");
        return respuestaOption;
    }
    
    public String desplegarOpcionesEstatusConvocatoria(String id){
        String respuestaOption="<option value=''>-Seleccione-</option>" +
            "<option value='1'>Terminada</option>" +
            "<option value='0'>Vigente</option>";
        
        String aux="value='"+id+"'";
        respuestaOption=respuestaOption.replaceFirst(aux, aux+" selected");
        return respuestaOption;
    }

    public  String desplegarAspirantesVacancia(String idPrograma,String idSubsistema,String idEntidad,String idPlantel){        
        String respuesta="<tr><td colspan='9' class='text-center'>Sin información</td></tr>";        
        try{
            String[] parametros={idPrograma,idSubsistema,idEntidad,idPlantel};
            if(idEntidad.isEmpty() && idPlantel.isEmpty()){
                return respuesta;
            }else{
                List<String[]> datos=metodos.ejecutaSP("sp_consultaGanadorAspirante",parametros);
                
                if(!datos.isEmpty()){
                    respuesta="";
                    for(String[] dato:datos)
                    {
                        respuesta+="<tr><td>"+dato[2]+"</td><td>"+dato[4]+"</td><td>"+dato[6]+"</td><td>"+dato[8]+"</td><td>"+dato[10]+"</td><td>"+dato[19]+"</td><td>"+dato[17]+"</td><td>"+dato[18]+"</td><td>";
                            respuesta+=dato[14]+"</td><td>";
                            if(!dato[14].equals("")){
                                respuesta+="<span class='glyphicon glyphicon-ok-sign completo' title='Aspirante evaluado'></span>";
                            }
                            if(!dato[13].equals("")){
                                respuesta+="<span class='glyphicon glyphicon-ok-sign completo' title='Aspirante evaluado'></span>";
                            }
                        respuesta+="<form method='POST' action='VistaDocente'><input type='hidden' name='idUsuario' value='"+dato[0]+"'><input type='hidden' name='rfc' value='"+dato[6]+"'><input class='btn btn-sm btn-link' type='submit' value='Ver información'/></form>";                                                               


                        respuesta+="</td></tr>";
                    }
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    
    public String desplegarOpcionesVacancia(String idPrograma,String idSubsistema,String idEntidad,String idPlantel,String vacancia,String periodo){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            String[] parametros={idPrograma, idSubsistema, idEntidad, idPlantel, vacancia, periodo};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaVacanciasResultados",parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    
    public String desplegarOpcionesJornada(String idPrograma,String idSubsistema,String idEntidad,String idPlantel, String idCategoria){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            String[] parametros={idPrograma, idSubsistema, idEntidad, idPlantel, idCategoria};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaJornadasActuales",parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[2]+"'>"+dato[3]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    
    public String desplegarNumeroPlazas(String idPrograma,String idSubsistema,String idEntidad,String idPlantel, String idCategoria, String idJornada,String periodo){        
        String respuesta="";
        try{
            String[] parametros={idPrograma, idSubsistema, idEntidad, idPlantel, "D", idCategoria, idJornada, periodo};
            List<String[]> datos=metodos.ejecutaSP("sp_consultaNumeroPlazas",parametros);
            respuesta+=datos.get(0)[8];
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;
        }
    }
    
       public ArrayList<String> getSelectObservacionPaso1(String idUsuario){ 
            ArrayList<String> lista=new ArrayList<>();
        List<String[]> datos=null;
        try{
            String[] parametros={idUsuario};
           datos=metodos.ejecutaSP("sp_selectObservacionPaso1", parametros);
            for(String[] dato:datos){
                lista.add(dato[0]);
                lista.add(dato[1]);
                lista.add(dato[2]);
                lista.add(dato[3]);
                lista.add(dato[4]);
                lista.add(dato[5]);
                lista.add(dato[6]);
                lista.add(dato[7]);
            }
        }catch(Exception e){

        }finally{
            return lista;        
        }
    }
       
    public String getPeriodoActivo(){        
        String respuesta="<option value='0'>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaPeriodoRegistro");
            for(String[] dato:datos){
                if(dato[2].equals("V")){
                respuesta+="<option value='"+dato[0]+"' selected>"+dato[1]+"</option>";
                }
                else{
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }  
        
     public String getPeriodoActivoUnicamenteId(){        
        String respuesta="";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaPeriodoRegistro");
            for(String[] dato:datos){
                if(dato[2].equals("V")){
                respuesta=dato[0];
                }
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
     
     public String desplegarAsignaturasCompBPDGETI(String idVersion,String semestre,String idSubsistema){        
        String respuesta="<option value=''>-Seleccione-</option>";
        respuesta+="<option value='0'> NA </option>";
        String[] parametros={idVersion,semestre};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaAsignaturaCBP", parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"' clave='"+dato[2]+"' horas='"+dato[4]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    
    public String desplegarVersionesCompBPDGETI(String idSubsistema){        
        String respuesta="<option value=''>-Seleccione-</option>";
        respuesta+="<option value='0'> NA </option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaVersionCBP");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
            if(idSubsistema.contains("2")){
                respuesta+="<option value='-1'>Otro</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    
    public String desplegarCarrerasCompPDGETI(String idVersion,String semestre ){        
        String respuesta="<option value=''>-Seleccione-</option>"; 
        respuesta+="<option value='0'> NA </option>";
        String[] param={idVersion,semestre};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaCarreraCP",param);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"' clave='"+dato[2]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
        
    public String desplegarSubmodulosCompPDGETI(String idVersion,String semestre,String idCarrera,String idModulo ){        
        String respuesta="<option value=''>-Seleccione-</option>";
        respuesta+="<option value='0'> NA </option>";
        String[] parametros={idVersion,semestre,idCarrera,idModulo};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaSubModuloCP",parametros);
            for(String[] dato:datos){
                respuesta+="<option clave='"+dato[2]+"' horas='"+dato[4]+"' value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }

    public String desplegarModulosCompPDGETI(String idVersion,String semestre,String idCarrera ){        
        String respuesta="<option value=''>-Seleccione-</option>";
        respuesta+="<option value='0'> NA </option>";
        String[] parametros={idVersion,semestre,idCarrera};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaModuloCP", parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"' clave='"+dato[2]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }

     public String desplegarVersionesCompPDGETI(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        respuesta+="<option value='0'> NA </option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaVersionCP");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
     
    public ArrayList<String> getSelectUsuarioByID(String idUsuario){ 
            ArrayList<String> lista=new ArrayList<>();
        List<String[]> datos=null;
        try{
            String[] parametros={idUsuario};
           datos=metodos.ejecutaSP("sp_selectUsuario", parametros);
            for(String[] dato:datos){
                lista.add(dato[0]);
                lista.add(dato[1]);
                lista.add(dato[2]);
                lista.add(dato[3]);
                lista.add(dato[4]);
                lista.add(dato[5]);
                lista.add(dato[6]);
                lista.add(dato[7]);
                lista.add(dato[8]);
                lista.add(dato[9]);
                lista.add(dato[10]);
                lista.add(dato[11]);
                lista.add(dato[12]);
                lista.add(dato[13]);
                lista.add(dato[14]);
                lista.add(dato[15]);
                lista.add(dato[16]);
            }
        }catch(Exception e){

        }finally{
            return lista;        
        }
    }
    
        public String desplegarCategoriasPresupuestales2(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatCategoriasPresupuestales");
            for(String[] dato:datos){
                respuesta+="<option ClavePresupuestal='"+dato[1]+"' idCategoriaPlazaCP='"+dato[2]+"' idJornadaCP='"+dato[3]+"' value='"+dato[1]+"'>"+dato[1]+"</option>";
               
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
}
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import java.sql.ResultSet;
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
            String[] parametros={idEstado};
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
    public String desplegarOpcionesCategorias(String id){
        String respuesta=desplegarOpcionesCategorias();
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
    public String desplegarVersionesCompBP(){        
        String respuesta="<option value=''>-Seleccione-</option>";
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaVersionCBP");
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"'>"+dato[1]+"</option>";
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
    public String desplegarAsignaturasCompBP(String idVersion,String semestre ){        
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
        String respuesta="";
        String[] parametros={idCategoria};
        try{
            List<String[]> datos=metodos.ejecutaSP("sp_consultaRequisitosCategoria",parametros);
            for(String[] dato:datos){
                respuesta+="<label class='control-label'><input type='radio' name='opReqCat' value='"+dato[0]+"' required>&nbsp;"+dato[1]+"</label><br/>";
            }
            respuesta+="<label><input type='radio' name='opReqCat' value='' checked required>&nbsp;Ninguno</label>";
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarRequisitosCategoria(String idCategoria,String id){
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
    public String desplegarOpcionesPuntaje(String idCriterio){        
        String respuesta="<option value='' puntaje='0'>-Seleccione-</option>";
        try{
            String[] parametros={idCriterio};
            List<String[]> datos=metodos.ejecutaSP("sp_selectCatPuntaje",parametros);
            for(String[] dato:datos){
                respuesta+="<option value='"+dato[0]+"' puntaje='"+dato[2]+"'>"+dato[1]+"</option>";
            }
        }catch(Exception e){
            respuesta=e.toString();
        }finally{
            return respuesta;        
        }
    }
    public String desplegarOpcionesCategoriasPlantel(){        
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
    public String desplegarOpcionesCategoriasPlantel(String id){
        String respuesta=desplegarOpcionesCategoriasPlantel();
        String aux="value='"+id+"'";
        respuesta=respuesta.replaceFirst(aux, aux+" selected");
        return respuesta;  
    }
}

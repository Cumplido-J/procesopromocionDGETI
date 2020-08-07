/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatorias.tests;

import com.convocatoria.datos.EntidadJDBC;
import com.convocatoria.domain.Entidad;
import java.util.List;

/**
 *
 * @author ja1000
 */
public class EntidadJDBCTest {
    public static void main(String args[]){
        List<Entidad> entidades = new EntidadJDBC().select();
        for(Entidad e : entidades){
            System.out.println(e.toString());
        }
    }
    
}

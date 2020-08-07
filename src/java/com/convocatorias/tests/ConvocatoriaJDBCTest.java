/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatorias.tests;

import com.convocatoria.datos.ConvocatoriaJDBC;
import com.convocatoria.domain.Convocatoria;
import java.util.List;

/**
 *
 * @author ja1000
 */
public class ConvocatoriaJDBCTest {

    public static void main(String[] args) {

        List<Convocatoria> convocatorias = new ConvocatoriaJDBC().select();
        for (Convocatoria c : convocatorias) {
            System.out.println(c.toString());
        }
    }
}

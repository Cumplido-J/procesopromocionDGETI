/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatorias.tests;

import com.convocatoria.datos.PlantelJDBC;
import com.convocatoria.domain.Plantel;
import java.util.List;

/**
 *
 * @author ja1000
 */
public class PlantelJDBCTest {

    public static void main(String args[]) {
        List<Plantel> planteles = new PlantelJDBC().select(30);
        for (Plantel p : planteles) {
            System.out.println(p.toString());
        }

    }

}

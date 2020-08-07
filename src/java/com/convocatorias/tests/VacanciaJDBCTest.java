/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.convocatorias.tests;
import com.vacancia.datos.VacanciaJDBC;
/**
 *
 * @author ja1000
 */
public class VacanciaJDBCTest {
    
    public static void main(String args[]){
    int tot = new VacanciaJDBC().selectPorConvocatoria(1, 1);
        System.out.printf("Total vacancias %d \n", tot);
    }
    
}

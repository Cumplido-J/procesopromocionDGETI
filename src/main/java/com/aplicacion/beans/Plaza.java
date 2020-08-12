/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.beans;

/**
 *
 * @author David Reyna
 */
public class Plaza {
    private final String clavepresupuestal;
    private final String movimiento;
    private final String horasplaza;
    private final String horasdescarga;

    public Plaza(String clavepresupuestal, String movimiento, String horasplaza, String horasdescarga) {
        this.clavepresupuestal = clavepresupuestal;
        this.movimiento = movimiento;
        this.horasplaza = horasplaza;
        this.horasdescarga = horasdescarga;
    }

    public String getClavepresupuestal() {
        return clavepresupuestal;
    }

    public String getMovimiento() {
        return movimiento;
    }

    public String getHorasplaza() {
        return horasplaza;
    }

    public String getHorasdescarga() {
        return horasdescarga;
    }

    
    
}

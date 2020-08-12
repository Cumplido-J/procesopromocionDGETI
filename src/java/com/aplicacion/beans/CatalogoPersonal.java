/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.aplicacion.beans;

import java.util.List;

/**
 *
 * @author David Reyna
 */
public class CatalogoPersonal {
    public final List<Personal> personas;

    public CatalogoPersonal(List<Personal> personas) {
        this.personas = personas;
    }

    public List<Personal> getPersonas() {
        return personas;
    }
    
}

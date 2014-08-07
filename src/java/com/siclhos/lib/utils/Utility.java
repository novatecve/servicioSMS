/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.siclhos.lib.utils;

import java.io.FileInputStream;
import java.rmi.server.UID;
import java.util.Properties;

/**
 *
 * @author akuma
 */
public class Utility {  
    
    /**
     * genera una cadena representativa tipo UUID
     * @return 
     */
    static String generateUUID(){
        UID id = new UID();
        return id.toString();
    }
    
    /**
     * Metodo para interpretacion 
     * del documento
     */
    public String[] getInit(String url, String name){        
        
        try {             
            // Cargando documento .ini
            Properties p = new Properties();        
            p.load(new FileInputStream(url));            
            // Cargando la informacion en el array
            String[] pool = p.getProperty(name).split(",");            
            return pool;
            
        } catch (Exception ex) {
        }    
        return null;
        
    }
}

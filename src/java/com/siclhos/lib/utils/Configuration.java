/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.siclhos.lib.utils;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.Properties;
import java.util.ResourceBundle;
 
/**
 *
 * @author v3rgu1
 */
public class Configuration {
 
    Properties properties = null;
 
    /** Configuration file name */
    public final static String CONFIG_FILE_NAME = "config.properties";
    public final static String SMTP_HOST = "smtp.gmail.com";
    public final static String SMTP_PORT = "587";
    public final static String SMTP_USERNAME = "prueba220814@gmail.com";
    public final static String SMTP_PASSWORD = "Ph1n11b14";
    public final static String SMTP_STARTTLS = "true";
    public final static String SMTP_AUTH = "true"; 
 
    private Configuration() {
        this.properties = new Properties();
        try {
         
         this.properties.load(getClass().getResourceAsStream(CONFIG_FILE_NAME));
         
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }//Configuration
 
    /**
     * Implementando Singleton
     *
     * @return
     */
    public static Configuration getInstance() {
        return ConfigurationHolder.INSTANCE;
    }
 
    private static class ConfigurationHolder {
 
        private static final Configuration INSTANCE = new Configuration();
    }
 
    /**
     * Retorna la propiedad de configuración solicitada
     *
     * @param key
     * @return
     */
    public String getProperty(String key) {
        return this.properties.getProperty(key);
    }//getProperty
    
    public Properties getProperties() {
        return this.properties;
    }//getProperty

    
    
}

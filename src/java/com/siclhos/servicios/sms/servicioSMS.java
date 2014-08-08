/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.siclhos.servicios.sms;

import com.siclhos.lib.database.HelperDAO;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;

/**
 *
 * @author akuma
 */
@WebService(serviceName = "servicioSMS")
public class servicioSMS {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        try {
            // Nombre del Pool de Conexion
            HelperDAO helper = new HelperDAO("postgresql");
            helper.query("SELECT *FROM dfa_address WHERE idaddress = 1");
            ResultSet result = helper.getResult();
           
            while(result.next()){
                return "Hello " + txt + " ! "+result.getString("nameaddress");
            }
        } catch (Exception ex) {
            Logger.getLogger(servicioSMS.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}

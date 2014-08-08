/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.siclhos.servicios.sms;

import com.siclhos.lib.database.HelperDAO;
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
        // Nombre del Pool de Conexion
        HelperDAO helper = new HelperDAO("oracle");
        return "Hello " + txt + " ! "+helper.getDbPool();
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.siclhos.servicios.sms;

import com.siclhos.lib.database.HelperDAO;
import com.siclhos.lib.database.NotifierDao;
import com.siclhos.lib.utils.Email;
import com.siclhos.servicios.sms.domain.Cliente;
import com.siclhos.servicios.sms.domain.Estatus;
import com.siclhos.servicios.sms.domain.EstatusMensaje;
import com.siclhos.servicios.sms.domain.Mensaje;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import oracle.jdbc.OracleTypes;
import com.siclhos.lib.utils.Utility;


/**
 *
 * @author akuma
 */
@WebService(serviceName = "servicioSMS")
public class servicioSMS {
    private Logger log = Logger.getLogger(servicioSMS.class.getName());
    
    
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
        
    /**
     * Web service operation
     */
    private String enviarSMS(int idMensaje, int tipoMensaje, int idCliente, String fecha, int estatus) {
        
        List objMensajes = new ArrayList<>();
        Mensaje objMensaje;
        String resultado = new String();
        Integer lote = new Integer(0);
        Integer result = new Integer(0);
        Integer exitoso = new Integer(2);
        Integer fallido = new Integer(3);
        Integer estado = new Integer(2);
        NotifierDao notifierDao = new NotifierDao();         
        Utility utility = new Utility();
        try { 
         
        SimpleDateFormat formatoDelTexto = new SimpleDateFormat("dd/MM/yyyy");
        Date fechaEnviar = null;
        Email email = new Email();

        boolean envio = false;
        int smsFallidos = 0;
        int smsExistosos = 0;
        if (fecha != null)
             fechaEnviar = formatoDelTexto.parse(fecha);
            
            
         objMensajes = notifierDao.buscarMensajes(idMensaje, tipoMensaje, idCliente, fechaEnviar, estatus);
        
         if (objMensajes.size() > 0 ) {
            lote = notifierDao.crearLote();
             
            for(int i =0; i<objMensajes.size(); i++){
               objMensaje = (Mensaje)objMensajes.get(i);
               
               envio = email.enviarEmail(objMensaje.getCliente().getEmail(), "Prueba SMS", objMensaje.getContenido());
               
               if (envio) {
                  estado = exitoso;
                  smsExistosos++;
               }else {
                  estado = fallido;
                  smsFallidos++;
               }
                   
               result = notifierDao.crearEstado(objMensaje.getId(), estado, lote);                        
               
            }
         } else {
         
         }

         resultado = "SMS Exitosos: " + smsExistosos + " SMS Fallidos: "+ smsFallidos;

        } catch (Exception ex) {
            Logger.getLogger(servicioSMS.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return resultado;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "enviarSMSPendientes")
    public String enviarSMSPendientes(@WebParam(name = "idMensaje") int idMensaje,@WebParam(name = "tipoMensaje") int tipoMensaje,@WebParam(name = "idCliente") int idCliente,@WebParam(name = "fecha") String fecha) {
        
        String resultado = new String();
     
        try { 
         
            resultado = enviarSMS(idMensaje, tipoMensaje, idCliente, fecha, 1);
        
        } catch (Exception ex) {
            Logger.getLogger(servicioSMS.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return resultado;
    }
    
    @WebMethod(operationName = "enviarSMSFallidos")
    public String enviarSMSFallidos(@WebParam(name = "idMensaje") int idMensaje,@WebParam(name = "tipoMensaje") int tipoMensaje,@WebParam(name = "idCliente") int idCliente,@WebParam(name = "fecha") String fecha) {
        
        String resultado = new String();
     
        try { 
         
            resultado = enviarSMS(idMensaje, tipoMensaje, idCliente, fecha, 3);
        
        } catch (Exception ex) {
            Logger.getLogger(servicioSMS.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return resultado;
    }

    @WebMethod(operationName = "reenviarSMS")
    public String reenviarSMS(@WebParam(name = "idMensaje") int idMensaje,@WebParam(name = "tipoMensaje") int tipoMensaje,@WebParam(name = "idCliente") int idCliente,@WebParam(name = "fecha") String fecha) {
        
        String resultado = new String();
     
        try { 
         
            resultado = enviarSMS(idMensaje, tipoMensaje, idCliente, fecha, 4);
        
        } catch (Exception ex) {
            Logger.getLogger(servicioSMS.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return resultado;
    }    
}



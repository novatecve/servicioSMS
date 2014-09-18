/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.siclhos.lib.database;

import com.siclhos.servicios.sms.domain.Cliente;
import com.siclhos.servicios.sms.domain.Estatus;
import com.siclhos.servicios.sms.domain.EstatusMensaje;
import com.siclhos.servicios.sms.domain.Mensaje;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import oracle.jdbc.OracleTypes;


/**
 *
 * @author Yasbaby
 */
public class NotifierDao extends Database {


    public NotifierDao() {
    }

    public NotifierDao(String poolName) {
        
        this.getPool(poolName);
        this.connect();
        
    }
    
     /**
     * Consulta los mensajes por identificador de mensaje, tipo,cliente, fecha o estatus del mismo.
     * @param idMensaje Identificador del mensaje.
     * @param tipoMensaje Identificadpr del tipo de mensaje.
     * @param idCliente Identificador el cliente.
     * @param fecha Fecha.
     * @param estatus Identificador estatus.
     * @return Lista de mensajes  
     * @throws SQLException Si ocurre un error de acceso a datos.
     */
    public  List buscarMensajes(Integer idMensaje,Integer tipoMensaje,Integer idCliente,Date fecha, Integer estatus) throws SQLException {
        String mensajeError = new String();
        List objMensajes = new ArrayList<>();
        Integer valor = new Integer(0);
        ResultSet rs;
        
       try {

            Logger.getLogger(NotifierDao.class.getName()+ "idMensaje " + idMensaje+ " tipoMensaje"+tipoMensaje + " idCliente"+idCliente+" fecha"+fecha+" estatus"+estatus);

            // Nombre del Pool de Conexion
            HelperDAO helper = new HelperDAO("OracleDS");
            helper.prepareCall("{ ? = call PKG_SMS.F_LISTAR_MENSAJES(?,?,?,?,?,?)");
            
            // Se indica que el primer interrogante es de salida.
            helper.registerOutParameter(1,OracleTypes.CURSOR);

            // Se pasa un parámetro en el segundo interrogante.
            if (idMensaje != null && !idMensaje.equals(valor)) {
               helper.setIntegerCS(2,idMensaje);
            } else {  
               helper.setNullCS(2, OracleTypes.INTEGER);
            }

            if (fecha != null) {
               helper.setDateCS(3,fecha);
            } else {  
               helper.setNullCS(3, OracleTypes.DATE);
            }
            
            if (tipoMensaje != null && !tipoMensaje.equals(valor)) {  
               helper.setIntegerCS(4,tipoMensaje);
            } else {  
               helper.setNullCS(4, OracleTypes.INTEGER);
            }

            if (idCliente != null && !idCliente.equals(valor)) {  
               helper.setIntegerCS(5,idCliente);
            } else {  
               helper.setNullCS(5, OracleTypes.INTEGER);
            }
               
            if (estatus != null && !estatus.equals(valor)) {     
               helper.setIntegerCS(6,estatus);
            } else {  
               helper.setNullCS(6, OracleTypes.INTEGER);
            }
               
            helper.registerOutParameter(7,Types.VARCHAR);
            helper.execute();
            
            if (helper.getObjectCS(7) == null) {
            rs = (ResultSet)helper.getObjectCS(1);
            
            while (rs.next()){
                Mensaje objMensaje = new Mensaje();
                Cliente objCliente = new Cliente();
                Estatus objEstatus   = new Estatus();
                EstatusMensaje objEstMensaje = new EstatusMensaje();
                
                //objEstMensaje
                objEstatus.setId(rs.getInt("ID_ESTATUS"));
                objEstatus.setDescripcion(rs.getString("DESCRIPCION"));
                objEstatus.setCodigoProveedor(rs.getString("CODIGO_PROVEEDOR"));
                
                objCliente.setCelular(rs.getString("CELULAR"));
                objCliente.setNombre(rs.getString("NOMBRE"));
                objCliente.setEmail(rs.getString("EMAIL"));
                
                objMensaje.setId(rs.getInt("ID_MENSAJE"));
                objMensaje.setFecha(rs.getDate("FECHA_MENSAJE"));
                objMensaje.setContenido(rs.getString("CELULAR"));
                objMensaje.setContenido(rs.getString("CONTENIDO"));
                objMensaje.setCliente(objCliente);
                
                objMensajes.add(objMensaje);
            }
            } else {
             Logger.getLogger(NotifierDao.class.getName() + ": Lista de mensajes vacia");
           }
            helper.close();
            
         } catch (Exception ex) {
            Logger.getLogger(NotifierDao.class.getName()).log(Level.SEVERE, null, ex);
            throw new SQLException("Error al buscar la lista de mensajes:" + ex.getMessage(), ex);
          } 
        
        return objMensajes;
    }

     /**
     * Genera un numero de lote.
     * @return Numero de lote 
     * @throws SQLException Si ocurre un error de acceso a datos.
     */
    public  Integer crearLote() throws SQLException {
        String mensajeError = new String();
        Integer lote = new Integer(0);
 
        try {
            
            // Nombre del Pool de Conexion
            HelperDAO helper = new HelperDAO("OracleDS");
            helper.prepareCall("call PKG_SMS.P_INSERTA_LOTE(?,?)");
            
            // Se indica que el primer interrogante es de salida.
            helper.registerOutParameter(1,OracleTypes.INTEGER);
            helper.registerOutParameter(2,OracleTypes.VARCHAR);

            helper.execute();
            
            mensajeError = helper.getStringCS(2);

            if (mensajeError == null){
                lote = helper.getIntegerCS(1);
            } else {
               throw new SQLException("Error al crear el numero del lote:" + mensajeError);
            }
            
            helper.close();
            
            
         } catch (Exception ex) {
             Logger.getLogger(NotifierDao.class.getName()).log(Level.SEVERE, null, ex);
             throw new SQLException("Error al crear el numero del lote:" + ex.getMessage(), ex);
          }    
            return lote;
    }

     /**
     * Inserta un nuevo estado del mensaje.
     * @param idStatusMensaje Identificador del estatus del mensaje.
     * @param idMensaje Identificador del mensaje.
     * @param idStatus Identificador del estatus.
     * @param fecha Fecha.
     * @param lote Numero de lote.
     * @throws SQLException Si ocurre un error de acceso a datos.
     */
    public Integer crearEstado(Integer idMensaje,Integer idStatus, Integer lote) throws SQLException {
        String mensajeError = new String();
        List objMensajes = new ArrayList<>();
        Integer valor = new Integer(0);
        Integer resultado = new Integer(0);        
      
        try {
            // Nombre del Pool de Conexion
            HelperDAO helper = new HelperDAO("OracleDS");
            helper.prepareCall("call PKG_SMS.P_INSERTA_ESTATUS_MENSAJE(?,?,?,?,?)");
            
            
            if (idMensaje != null && !idMensaje.equals(valor)) {  
               helper.setIntegerCS(1,idMensaje);
            } else {  
               helper.setNullCS(1, OracleTypes.INTEGER);
            }

            if (idStatus != null && !idStatus.equals(valor)) {  
               helper.setIntegerCS(2,idStatus);
            } else {  
               helper.setNullCS(2, OracleTypes.INTEGER);
            }

            if (lote != null && !lote.equals(valor)) {  
               helper.setIntegerCS(3,lote);
            } else {  
               helper.setNullCS(3, OracleTypes.INTEGER);
            }

            helper.registerOutParameter(4,Types.INTEGER);
            helper.registerOutParameter(5,Types.VARCHAR);
            helper.execute();
            
            mensajeError = helper.getStringCS(5);

            if (mensajeError == null){
               resultado = helper.getIntegerCS(4);
            } else {
               throw new SQLException("Error al insertar el esatus del mensaje:" + mensajeError);
            } 

            helper.close();
            
         } catch (Exception ex) {
             Logger.getLogger(NotifierDao.class.getName()).log(Level.SEVERE, null, ex);
             throw new SQLException("Error al crear el estatus del mensaje "+idMensaje +":" + ex.getMessage(), ex);
          }   
            return resultado;
    }


}

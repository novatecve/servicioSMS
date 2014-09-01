/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.siclhos.lib.database;

/**
 *
 * @author delimce
 */
public class HelperDAO extends Database {

    protected String EntityTable; ///atributo de tabla fisica a la entidad

    public HelperDAO() {
    }

    public HelperDAO(String poolName) {
        
        this.getPool(poolName);
        this.connect();
        
    }
    
    public String getEntityTable() {
        return EntityTable;
    }

    public void setEntityTable(String EntityTable) {
        this.EntityTable = EntityTable;
    }

}

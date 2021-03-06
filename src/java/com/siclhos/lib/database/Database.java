/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.siclhos.lib.database;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.Date;
import java.util.HashMap;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 * @author Administrador
 */
abstract class Database {

    private static int nconexiones; ////numero de conexiones existentes a la base de datos
    //////////////////////////////////////////////////
    protected int nreg;
    protected long ultimoID;
    protected Connection dbc;
    /////////////////////////////////////prepared vars
    protected PreparedStatement pstmt;
    //////////////////////VARIABLES PARA LA CONEXION
//    private String dbserver = "10.16.44.139";
//    private String dbuser = "postgres";
//    private String dbpass = "12345";
//
    private String dbserver;
    private String dbuser;
    private String dbpass;
    private String dbname;
    private String dbport; //CASO PG, oracle mssql
    private String dbms;
    private String dbservice; ////caso ORACLE thin
    private String dbPool = ""; ///pool de conexiones en caso de usarlo
    private Statement stmt;
    private ResultSet result;
    private DataSource ds; ///conexion obtenida del pool
    private HashMap<String, String> dbConfigParams = new HashMap<>();
    private CallableStatement cstmt;

    /**
     * devuelve el numero de conexiones hechas con la clase Database
     *
     * @return
     */
    public static int getNcons() {
        return nconexiones;
    }

    /**
     * lectura de los parametros de conexion de un archivo externo el archivo
     * debe existir en la raiz del proyecto y ser .property, si no existe toma
     * los parametros por defecto
     */
    public void getConfig(String archivo) {

        try {
            //se crea una instancia a la clase Properties
            Properties propiedades = new Properties();
            //se leen el archivo .properties

            try {

                propiedades.load(new FileInputStream(archivo));

            } catch (NullPointerException e2) {

                Logger.getLogger(Database.class.getName() + ":No es posible leer el archivo de propiedades de conexion \n " + e2);

            }

            //si el archivo de propiedades NO esta vacio retornan las propiedes leidas
            if (!propiedades.isEmpty()) {

                this.dbms = propiedades.getProperty("dbms").trim(); ///motor de base de datos a usar Mysql, Postgres u Oracle
                this.dbserver = propiedades.getProperty("dbserver").trim(); ////nombre o ip del servidor
                this.dbname = propiedades.getProperty("dbname").trim(); ///nombre de la base de datos
                this.dbuser = propiedades.getProperty("dbuser").trim(); ///usuario de la db
                this.dbpass = propiedades.getProperty("dbpass").trim(); ///password de la db

                if (!propiedades.getProperty("dbport").trim().isEmpty()) {
                    this.dbport = propiedades.getProperty("dbport").trim(); ///puerto
                }
                if (!propiedades.getProperty("dbservice").trim().isEmpty()) {
                    this.dbservice = propiedades.getProperty("dbservice").trim(); ///SID oracle
                }
            } else {//sino  retornara NULL
                Logger.getLogger(Database.class.getName() + ":el archivo esta vacio: " + archivo);

            }
        } catch (IOException ex) {
            Logger.getLogger(Database.class.getName() + ":No es posible leer el archivo de propiedades de conexion " + archivo);
        }
    }

    public void setConfig() {

        //si el archivo de propiedades NO esta vacio retornan las propiedes leidas
        this.dbms = dbConfigParams.get("dbms"); ///motor de base de datos a usar Mysql, Postgres u Oracle
        this.dbserver = dbConfigParams.get("dbserver"); ////nombre o ip del servidor
        this.dbname = dbConfigParams.get("dbname"); ///nombre de la base de datos
        this.dbuser = dbConfigParams.get("dbuser"); ///usuario de la db
        this.dbpass = dbConfigParams.get("dbpass"); ///password de la db

        if (!dbConfigParams.get("dbport").trim().isEmpty()) {
            this.dbport = dbConfigParams.get("dbport").trim(); ///puerto
        }
        if (!dbConfigParams.get("dbservice").trim().isEmpty()) {
            this.dbservice = dbConfigParams.get("dbservice").trim(); ///SID oracle
        }

    }

    /**
     * metodo que obtiene el objeto JNDI con el nombre del pool
     *
     * @param poolName
     */
    protected void getPool(String poolName) {

        try {
            Context initContext = new InitialContext();
            //  Context envContext = (Context) initContext.lookup("java:/comp/env"); //tomcat
            Context envContext = (Context) initContext.lookup("java:jboss/datasources"); //jboss (incluye el prefijo)
            this.ds = (DataSource) envContext.lookup(poolName);
            this.setDbPool(poolName);
        } catch (NamingException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }

    }

    private void selectDbms() throws ClassNotFoundException, SQLException {

        switch (this.dbms.toLowerCase()) {
            case "oracle":
                Class.forName("oracle.jdbc.OracleDriver");
                //this.dbc =  DriverManager.getConnection ("jdbc:oracle:oci8:@BDDESA","providencia","providencia");
                this.dbc = DriverManager.getConnection("jdbc:oracle:thin:@" + this.dbserver + ":" + this.dbport + ":" + this.dbservice, this.dbuser, this.dbpass);
                break;

            case "mysql":
                Class.forName("com.mysql.jdbc.Driver");
                this.dbc = DriverManager.getConnection("jdbc:mysql://" + this.dbserver + "/" + this.dbname, this.dbuser, this.dbpass);
                break;
            case "mssql":
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                this.dbc = DriverManager.getConnection("jdbc:sqlserver://" + this.dbserver + ":" + this.dbport + ";databaseName=" + this.dbname + ";user=" + this.dbuser + ";password=" + this.dbpass);
                break;

            case "pgsql":
                Class.forName("org.postgresql.Driver");
                this.dbc = DriverManager.getConnection("jdbc:postgresql://" + this.dbserver + ":" + this.dbport + "/" + this.dbname, this.dbuser, this.dbpass);
                break;

            default: ///apache derby

                Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
                this.dbc = DriverManager.getConnection("jdbc:derby:" + this.dbname + ";user=" + this.dbuser + ";password=" + this.dbpass);

                break;

        }

    }

    /**
     * metodo que realiza la conexion a la base de datos hasta la fecha la
     * conexion es con mysql,oracle y por defecto postgres
     */
    public void connect() {

        this.dbc = null;

        try {

            if (!this.dbPool.isEmpty()) {
                this.dbc = this.ds.getConnection();
            } else ///////////crea el objeto statement para realizar querys
            {
                selectDbms();
            }

            this.stmt = this.dbc.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);
            //////setea las transacciones para que sean por sentencia
            this.dbc.setAutoCommit(true);

        } catch (ClassNotFoundException | SQLException | NullPointerException e) {
            Logger.getLogger(Database.class.getName() + ":No se encuentra el driver de conexion necesario: " + e);

        };

    }

    public void close() {
        try {
            this.dbc.close();
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    /**
     * metodo que ejecuta un query T eje: insert, update delete ..
     */
    public void tquery(String sql) throws SQLException {

        this.stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);

        this.result = this.stmt.getGeneratedKeys();

        if (this.result != null && result.next()) {
            this.ultimoID = this.result.getLong(1);
        }

    }

    /**
     * metodo que ejecuta un query sencillo ejemplo: select ..
     */
    public void query(String sql) throws SQLException {

        this.stmt.executeQuery(sql);
        ///numero de registros
        this.result = this.stmt.getResultSet();
        this.result.last();
        this.nreg = this.result.getRow();

        this.result.beforeFirst();

    }

    /**
     * Metodo que ejecuta una consulta sql diferente a insert,select,update
     */
    public void execute(String sql) throws SQLException {

        this.stmt.execute(sql);

    }

    /**
     * trae el numero de filas q devuelve el query
     *
     * @return
     */
    public int getNreg() {

        return this.nreg;
    }

    public long getUltimoID() {
        return ultimoID;
    }

    public ResultSet getResult() {
        return result;
    }

    public void setResult(ResultSet result) {
        this.result = result;
    }

    public String getDbPool() {
        return dbPool;
    }

    public void setDbPool(String dbPool) {
        this.dbPool = dbPool;
    }

    /**
     * libera una conexion tanto stmt y resulset
     */
    public void free() {

        try {
            this.result.close();

        } catch (SQLException e) {

            Logger.getLogger(Database.class.getName() + ": fallo liberando resultset");

            return;

        }

    }

    /**
     * cierra un objeto de tipo statement
     */
    public void closes() {
        try {
            this.stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * cierra todos los elementos de una conexion result, stmt, dbc
     */
    public void closeAll() {
        try {
            this.result.close();
            this.stmt.close();
            this.cstmt.close();
            this.dbc.close();
        } /////////////////////////////////////////metodos para transacciones
        catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    /////////////////////////////////////////metodos para transacciones
/////abrir transaccion
    public void begin_transaccion() {
        try {
            this.dbc.setAutoCommit(false);
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    ////pasa el parametro booleano confirmando o no la aplicar cambios o no
    public void commit_transaccion(boolean confirm) {

        try {
            if (confirm) {
                this.dbc.commit();
            } else {
                this.dbc.rollback();
            }

        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                this.dbc.setAutoCommit(true); ////setiando autocommit
            } catch (SQLException ex) {
                Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    /////////////////////////////////////prepared methods
    /**
     * query usado solo para INSERT, update y delete, devuelve el id del ult
     * registro modificado
     *
     * @param query
     */
    public void prepareTSQL(String query) {

        try {

            this.pstmt = this.dbc.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
            ///trata de guardar el ultimo id insertado

        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * usado para SELECT y operaciones que no devuelvan id
     *
     * @param query
     */
    public void prepareSQL(String query) {

        try {

            this.pstmt = this.dbc.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);

        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    /**
     * metodos para setiar los valores
     */
    public void setString(Integer pos, String Cadena) {
        try {

            this.pstmt.setString(pos, Cadena);
        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public String getString(String campo) throws SQLException {

        return this.result.getString(campo);
    }

    public void setTimestamp(Integer pos, Date fecha) {
        try {
            this.pstmt.setTimestamp(pos, (fecha == null ? null : new java.sql.Timestamp(fecha.getTime())));
        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }

    }

    public void setInteger(Integer pos, Integer Numero) {
        try {
            this.pstmt.setInt(pos, Numero);
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public int getInteger(String campo) throws SQLException {

        return this.result.getInt(campo);
    }

    public void setLong(Integer pos, long Numero) {
        try {
            this.pstmt.setLong(pos, Numero);
        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public long getLong(String campo) throws SQLException {

        return this.result.getLong(campo);
    }

    public void setFloat(Integer pos, float Numero) {
        try {
            this.pstmt.setFloat(pos, Numero);
        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public float getFloat(String campo) throws SQLException {

        return this.result.getFloat(campo);
    }

    public void setDoble(Integer pos, double Numero) {
        try {
            this.pstmt.setDouble(pos, Numero);
        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public double getDouble(String campo) throws SQLException {

        return this.result.getDouble(campo);
    }

    public void setDate(Integer pos, Date Fecha) {
        try {
            //psInsertar.setDate(pos, (java.sql.Date) Fecha);
            if (Fecha == null) {
                this.pstmt.setDate(pos, null);
            } else {
                this.pstmt.setDate(pos, new java.sql.Date(Fecha.getTime()));
            }
        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public void tquery() throws SQLException {

        this.pstmt.executeUpdate();
        this.result = this.pstmt.getGeneratedKeys();

        if (this.result != null && result.next()) {
            this.ultimoID = this.result.getLong(1);
        }

    }

    public void query() throws SQLException {

        this.pstmt.executeQuery();
        ///numero de registros
        this.result = this.pstmt.getResultSet();
        this.result.last();
        this.nreg = this.result.getRow();

        this.result.beforeFirst();

    }

    /**
     * cierra un objeto de tipo Pstmt
     */
    public void closePrepare() {
        try {
            this.pstmt.close();
        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    /**
     * usado para SELECT y operaciones que no devuelvan id
     *
     * @param query
     */
    public void prepareCall(String functionName) {

        try {

            this.cstmt = this.dbc.prepareCall(functionName, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE, ResultSet.HOLD_CURSORS_OVER_COMMIT);

        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public void registerOutParameter(Integer pos, Integer type) {
        try {
            this.cstmt.registerOutParameter(pos, type);
        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    /**
     * cierra un objeto de tipo cstmt
     */
    public void closeCallable() {
        try {
            this.cstmt.close();
        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    /**
     * metodos para setiar los valores
     */
    public void setStringCS(Integer pos, String Cadena) {
        try {

            this.cstmt.setString(pos, Cadena);
        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public double getDoubleCS(Integer pos) throws SQLException {

        return this.cstmt.getDouble(pos);
    }

    public String getStringCS(String campo) throws SQLException {

        return this.result.getString(campo);
    }

    public String getStringCS(Integer pos) throws SQLException {

        return this.cstmt.getString(pos);
    }

    public Object getObjectCS(Integer pos) throws SQLException {

        return this.cstmt.getObject(pos);
    }

    public void setTimestampCS(Integer pos, Date fecha) {
        try {
            this.cstmt.setTimestamp(pos, (fecha == null ? null : new java.sql.Timestamp(fecha.getTime())));
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }

    }

    public java.sql.Timestamp getTimestampCS(Integer pos) throws SQLException {

        return this.cstmt.getTimestamp(pos);
    }

    public void setIntegerCS(Integer pos, Integer Numero) {
        try {
            this.cstmt.setInt(pos, Numero);
        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public Integer getIntegerCS(Integer pos) throws SQLException {

        return this.cstmt.getInt(pos);
    }

    public void setLongCS(Integer pos, long Numero) {
        try {
            this.cstmt.setLong(pos, Numero);
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public Long getLongCS(Integer pos) throws SQLException {

        return this.cstmt.getLong(pos);
    }

    public void setFloatCS(Integer pos, float Numero) {
        try {
            this.cstmt.setFloat(pos, Numero);
        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public Long getFloatCS(Integer pos) throws SQLException {

        return this.cstmt.getLong(pos);
    }

    public void setDobleCS(Integer pos, double Numero) {
        try {
            this.cstmt.setDouble(pos, Numero);
        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public Double getDobleCS(Integer pos) throws SQLException {

        return this.cstmt.getDouble(pos);
    }

    public void setDateCS(Integer pos, Date Fecha) {
        try {
            //psInsertar.setDate(pos, (java.sql.Date) Fecha);
            if (Fecha == null) {
                this.cstmt.setDate(pos, null);
            } else {
                this.cstmt.setDate(pos, new java.sql.Date(Fecha.getTime()));
            }
        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public Date getDateCS(Integer pos) throws SQLException {

        return this.cstmt.getDate(pos);
    }

    public void setNullCS(Integer pos, Integer tipo) {
        try {
            this.cstmt.setNull(pos, tipo);
        } catch (SQLException ex) {
            //Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    /**
     * Metodo que ejecuta una consulta sql diferente a insert,select,update
     */
    public void execute() throws SQLException {

        this.cstmt.execute();

    }

}

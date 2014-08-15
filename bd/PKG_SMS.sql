CREATE OR REPLACE PACKAGE PKG_SMS AS
/******************************************************************************
   NAME:       PKG_SMS
   PURPOSE:    CONTIENE LAS FUNCIONES Y PROCEDIMIENTOS PARA ENVIO DE MENSAJES 

******************************************************************************/
  TYPE RESULSET IS REF CURSOR;

  PROCEDURE P_INSERTA_LOTE(PO_ID OUT NUMBER,PO_ERROR OUT NVARCHAR2);

  PROCEDURE P_INSERTA_AFILIADO(PI_NOMBRE    IN AFILIADOS.NOMBRE%TYPE,
                               PI_TELEFONO  IN AFILIADOS.TELEFONO%TYPE,
                               PI_DIRECCION IN AFILIADOS.DIRECCION%TYPE,
                               PI_EMAIL     IN AFILIADOS.EMAIL%TYPE,
                               PO_ID OUT NUMBER,
                               PO_ERROR OUT NVARCHAR2
                               );

  PROCEDURE P_INSERTA_PROVEEDOR(PI_NOMBRE    IN PROVEEDORES.NOMBRE%TYPE,
                                PI_RIF       IN PROVEEDORES.RIF%TYPE,
                                PI_TELEFONO  IN PROVEEDORES.TELEFONO%TYPE,
                                PI_DIRECCION IN PROVEEDORES.DIRECCION%TYPE,
                                PI_EMAIL      IN PROVEEDORES.EMAIL%TYPE,
                                PO_ID OUT NUMBER,
                                PO_ERROR OUT NVARCHAR2
                                );

  PROCEDURE P_INSERTA_CLIENTE(PI_CEDULA    IN CLIENTES.CEDULA%TYPE,
                              PI_NOMBRE    IN CLIENTES.NOMBRE%TYPE,
                              PI_CELULAR   IN CLIENTES.CELULAR%TYPE,
                              PI_DIRECCION IN CLIENTES.DIRECCION%TYPE,
                              PI_EMAIL     IN CLIENTES.EMAIL%TYPE,
                              PO_ID OUT NUMBER,
                              PO_ERROR OUT NVARCHAR2
                              );

  PROCEDURE P_INSERTA_TIPO_MENSAJE(PI_CONTENIDO   IN SMS_TIPOS_MENSAJES.CONTENIDO%TYPE, 
                                   PI_ID_AFILIADO IN SMS_TIPOS_MENSAJES.ID_AFILIADO%TYPE,
                                   PO_ID OUT NUMBER,
                                   PO_ERROR OUT NVARCHAR2
                                   );
                             
  PROCEDURE P_INSERTA_ESTATUS_MENSAJE(PI_ID_MENSAJE IN SMS_ESTATUS_MENSAJES.ID_MENSAJE%TYPE,
                                      PI_ID_ESTATUS IN SMS_ESTATUS_MENSAJES.ID_ESTATUS%TYPE,
                                      PI_FECHA      IN SMS_ESTATUS_MENSAJES.FECHA%TYPE, 
                                      PI_LOTE       IN SMS_ESTATUS_MENSAJES.LOTE%TYPE,
                                      PO_ID OUT NUMBER,
                                      PO_ERROR OUT NVARCHAR2
                                      );

  PROCEDURE P_INSERTA_ESTATUS(PI_DESCRIPCION      IN SMS_ESTATUS.DESCRIPCION%TYPE,
                              PI_CODIGO_PROVEEDOR IN SMS_ESTATUS.CODIGO_PROVEEDOR%TYPE,
                              PI_ID_PROVEEDOR     IN SMS_ESTATUS.ID_PROVEEDOR%TYPE,
                              PO_ID OUT NUMBER,
                              PO_ERROR OUT NVARCHAR2
                              );

  PROCEDURE P_INSERTA_MENSAJE(PI_FECHA           IN SMS_MENSAJES.FECHA%TYPE,
                              PI_ID_TIPO_MENSAJE IN SMS_MENSAJES.ID_TIPO_MENSAJE%TYPE,
                              PI_ID_CLIENTE      IN SMS_MENSAJES.ID_CLIENTE%TYPE,
                              PO_ID OUT NUMBER,
                              PO_ERROR OUT NVARCHAR2
                              );
                               
  FUNCTION F_ELIMINA_LOTE(PI_ID IN SMS_LOTES.ID%TYPE,
                          PO_ERROR OUT NVARCHAR2
                          ) RETURN NUMBER;

  FUNCTION F_ELIMINA_TIPO_MENSAJE(PI_ID IN SMS_TIPOS_MENSAJES.ID%TYPE,
                                  PO_ERROR OUT NVARCHAR2
                                  ) RETURN NUMBER;

  FUNCTION F_ELIMINA_CLIENTE(PI_ID IN CLIENTES.ID%TYPE,
                             PO_ERROR OUT NVARCHAR2
                             ) RETURN NUMBER;

  FUNCTION F_ELIMINA_PROVEEDOR(PI_ID IN PROVEEDORES.ID%TYPE,
                               PO_ERROR OUT NVARCHAR2
                               ) RETURN NUMBER;
                             
  FUNCTION F_ELIMINA_AFILIADO(PI_ID IN AFILIADOS.ID%TYPE,
                              PO_ERROR OUT NVARCHAR2
                              ) RETURN NUMBER;

  FUNCTION F_ELIMINA_ESTATUS_MENSAJE(PI_ID IN SMS_ESTATUS_MENSAJES.ID%TYPE,
                                     PO_ERROR OUT NVARCHAR2
                                     ) RETURN NUMBER;

  FUNCTION F_ELIMINA_ESTATUS(PI_ID IN SMS_ESTATUS.ID%TYPE,
                             PO_ERROR OUT NVARCHAR2
                             ) RETURN NUMBER;

  FUNCTION F_ELIMINA_MENSAJE(PI_ID IN SMS_MENSAJES.ID%TYPE,
                             PO_ERROR OUT NVARCHAR2
                             ) RETURN NUMBER;                           

   FUNCTION F_LISTAR_LOTE_X_ESTATUS(PI_ID_LOTE IN SMS_LOTES.ID%TYPE,
                                    PI_ID_ESTATUS IN SMS_ESTATUS.ID%TYPE,
                                    PI_ID_PROVEEDOR IN PROVEEDORES.ID%TYPE,
                                    PO_ERROR OUT NVARCHAR2                                                                   
                                    ) RETURN RESULSET;

   FUNCTION F_BUSCA_TIPO_MENSAJE(PI_ID IN SMS_TIPOS_MENSAJES.ID%TYPE,
                                 PO_ERROR OUT NVARCHAR2                                                                   
                                 )  RETURN RESULSET;

    FUNCTION F_LISTAR_CLIENTE(PI_ID IN CLIENTES.ID%TYPE, 
                              PI_CEDULA IN CLIENTES.CEDULA%TYPE,
                              PI_CELULAR IN CLIENTES.CELULAR%TYPE,
                              PO_ERROR OUT NVARCHAR2
                             ) RETURN RESULSET;

   FUNCTION F_LISTAR_PROVEEDOR(PI_ID IN PROVEEDORES.ID%TYPE,
                              PI_RIF IN PROVEEDORES.ID%TYPE,    
                              PO_ERROR OUT NVARCHAR2
   ) RETURN RESULSET;
                             
  FUNCTION F_LISTAR_AFILIADO(PI_ID IN AFILIADOS.ID%TYPE,
                             PI_NOMBRE IN AFILIADOS.NOMBRE%TYPE,
                             PO_ERROR OUT NVARCHAR2
                             ) RETURN RESULSET;

   FUNCTION F_LISTAR_ESTATUS_MENSAJE(PI_ID_EST_MENSAJE IN SMS_ESTATUS_MENSAJES.ID%TYPE,
                                     PI_ID_ESTATUS IN SMS_ESTATUS_MENSAJES.ID_ESTATUS%TYPE,
                                     PI_FECHA      IN SMS_ESTATUS_MENSAJES.FECHA%TYPE,
                                     PI_LOTE       IN SMS_ESTATUS_MENSAJES.LOTE%TYPE,
                                     PO_ERROR OUT NVARCHAR2) RETURN RESULSET;

   FUNCTION F_LISTAR_ESTATUS(PI_ID_ESTATUS IN SMS_ESTATUS.ID%TYPE,
                             PI_ID_PROVEEDOR SMS_ESTATUS.ID_PROVEEDOR%TYPE,
                             PO_ERROR OUT NVARCHAR2   
                             ) 
   RETURN RESULSET; 

   FUNCTION F_LISTAR_MENSAJES(PI_ID IN SMS_MENSAJES.ID%TYPE,
                             PI_FECHA IN SMS_MENSAJES.FECHA%TYPE,
                             PI_ID_TIPO_MENSAJE IN SMS_MENSAJES.ID_TIPO_MENSAJE%TYPE,
                             PI_ID_CLIENTE IN SMS_MENSAJES.ID_CLIENTE%TYPE,
                             PI_ID_ESTATUS IN SMS_ESTATUS.ID%TYPE,
                             PO_ERROR OUT NVARCHAR2   
                             ) 
   RETURN RESULSET;                         

  FUNCTION F_ACTUALIZA_TIPO_MENSAJE(PI_ID          IN SMS_TIPOS_MENSAJES.ID%TYPE,
                                    PI_CONTENIDO   IN SMS_TIPOS_MENSAJES.CONTENIDO%TYPE, 
                                    PI_ID_AFILIADO IN SMS_TIPOS_MENSAJES.ID_AFILIADO%TYPE,
                                    PO_ERROR OUT NVARCHAR2
                                    ) RETURN NUMBER;

  FUNCTION F_ACTUALIZA_CLIENTE(PI_ID        IN CLIENTES.ID%TYPE,
                               PI_CEDULA    IN CLIENTES.CEDULA%TYPE,
                               PI_NOMBRE    IN CLIENTES.NOMBRE%TYPE,
                               PI_CELULAR   IN CLIENTES.CELULAR%TYPE,
                               PI_DIRECCION IN CLIENTES.DIRECCION%TYPE,
                               PI_EMAIL     IN CLIENTES.EMAIL%TYPE,
                               PO_ERROR OUT NVARCHAR2
                               ) RETURN NUMBER;

  FUNCTION F_ACTUALIZA_PROVEEDOR(PI_ID        IN PROVEEDORES.ID%TYPE,
                                 PI_NOMBRE    IN PROVEEDORES.NOMBRE%TYPE,
                                 PI_RIF       IN PROVEEDORES.RIF%TYPE,
                                 PI_TELEFONO  IN PROVEEDORES.TELEFONO%TYPE,
                                 PI_DIRECCION IN PROVEEDORES.DIRECCION%TYPE,
                                 PI_EMAIL     IN PROVEEDORES.EMAIL%TYPE,
                                 PO_ERROR OUT NVARCHAR2                                 
                                 ) RETURN NUMBER;
                             
  FUNCTION F_ACTUALIZA_AFILIADO(PI_ID        IN AFILIADOS.ID%TYPE,
                                PI_NOMBRE    IN AFILIADOS.NOMBRE%TYPE,
                                PI_TELEFONO  IN AFILIADOS.TELEFONO%TYPE,
                                PI_DIRECCION IN AFILIADOS.DIRECCION%TYPE,
                                PI_EMAIL     IN AFILIADOS.EMAIL%TYPE, 
                                PO_ERROR OUT NVARCHAR2                                
                                ) RETURN NUMBER;

  FUNCTION F_ACTUALIZA_ESTATUS_MENSAJE(PI_ID         IN SMS_ESTATUS_MENSAJES.ID%TYPE,
                                       PI_ID_MENSAJE IN SMS_ESTATUS_MENSAJES.ID_MENSAJE%TYPE,
                                       PI_ID_ESTATUS IN SMS_ESTATUS_MENSAJES.ID_ESTATUS%TYPE,
                                       PI_FECHA      IN SMS_ESTATUS_MENSAJES.FECHA%TYPE, 
                                       PI_LOTE       IN SMS_ESTATUS_MENSAJES.LOTE%TYPE,
                                       PO_ERROR OUT NVARCHAR2                                
                                       ) RETURN NUMBER;

  FUNCTION F_ACTUALIZA_ESTATUS(PI_ID               IN SMS_ESTATUS.ID%TYPE,
                               PI_DESCRIPCION      IN SMS_ESTATUS.DESCRIPCION%TYPE,
                               PI_CODIGO_PROVEEDOR IN SMS_ESTATUS.CODIGO_PROVEEDOR%TYPE,
                               PI_ID_PROVEEDOR     IN SMS_ESTATUS.ID_PROVEEDOR%TYPE,
                               PO_ERROR OUT NVARCHAR2                                
                               ) RETURN NUMBER;


  FUNCTION F_ACTUALIZA_MENSAJE(PI_ID              IN SMS_MENSAJES.ID%TYPE,
                               PI_FECHA           IN SMS_MENSAJES.FECHA%TYPE,
                               PI_ID_TIPO_MENSAJE IN SMS_MENSAJES.ID_TIPO_MENSAJE%TYPE,
                               PI_ID_CLIENTE      IN SMS_MENSAJES.ID_CLIENTE%TYPE,
                               PO_ERROR OUT NVARCHAR2                                
                               ) RETURN NUMBER;
 
END PKG_SMS;

CREATE OR REPLACE PACKAGE BODY PKG_SMS AS

    PROCEDURE P_INSERTA_LOTE(PO_ID OUT NUMBER,PO_ERROR OUT NVARCHAR2) 
    IS
      vSec SMS_LOTES.ID%TYPE;
    BEGIN

     SELECT SEC_LOTES.NEXTVAL
     INTO vSec
     FROM DUAL;
     
     INSERT INTO SMS_LOTES VALUES (vSec, SYSDATE);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
    END P_INSERTA_LOTE;

    PROCEDURE P_INSERTA_AFILIADO(PI_NOMBRE    IN AFILIADOS.NOMBRE%TYPE,
                                 PI_TELEFONO  IN AFILIADOS.TELEFONO%TYPE,
                                 PI_DIRECCION IN AFILIADOS.DIRECCION%TYPE,
                                 PI_EMAIL     IN AFILIADOS.EMAIL%TYPE,
                                 PO_ID OUT NUMBER,
                                 PO_ERROR OUT NVARCHAR2
                                ) 
    IS
      vSec AFILIADOS.ID%TYPE;
    BEGIN

     SELECT SEC_AFILIADOS.NEXTVAL
     INTO vSec
     FROM DUAL;
     
     INSERT INTO AFILIADOS VALUES (vSec,PI_NOMBRE,PI_TELEFONO,PI_DIRECCION,PI_EMAIL);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     
    END P_INSERTA_AFILIADO;
    
    
    PROCEDURE P_INSERTA_PROVEEDOR(PI_NOMBRE    IN PROVEEDORES.NOMBRE%TYPE,
                                 PI_RIF       IN PROVEEDORES.RIF%TYPE,
                                 PI_TELEFONO  IN PROVEEDORES.TELEFONO%TYPE,
                                 PI_DIRECCION IN PROVEEDORES.DIRECCION%TYPE,
                                 PI_EMAIL     IN PROVEEDORES.EMAIL%TYPE,
                                 PO_ID OUT NUMBER,
                                 PO_ERROR OUT NVARCHAR2
                                 ) 
    IS
      vSec PROVEEDORES.ID%TYPE;
    BEGIN
     
    
     SELECT SEC_PROVEEDORES.NEXTVAL
     INTO vSec
     FROM DUAL;
    
     INSERT INTO PROVEEDORES VALUES (vSec,PI_NOMBRE,PI_RIF,PI_TELEFONO,PI_DIRECCION,PI_EMAIL);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     
    END P_INSERTA_PROVEEDOR;

    PROCEDURE P_INSERTA_CLIENTE(PI_CEDULA    IN CLIENTES.CEDULA%TYPE,
                               PI_NOMBRE    IN CLIENTES.NOMBRE%TYPE,
                               PI_CELULAR   IN CLIENTES.CELULAR%TYPE,
                               PI_DIRECCION IN CLIENTES.DIRECCION%TYPE,
                               PI_EMAIL     IN CLIENTES.EMAIL%TYPE,
                               PO_ID OUT NUMBER,
                               PO_ERROR OUT NVARCHAR2
                               ) 
    IS
      vSec CLIENTES.ID%TYPE;
    BEGIN

     SELECT SEC_CLIENTES.NEXTVAL
     INTO vSec
     FROM DUAL;

     
     INSERT INTO CLIENTES VALUES (vSec,PI_CEDULA,PI_NOMBRE,PI_CELULAR,PI_DIRECCION,PI_EMAIL);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     
    END P_INSERTA_CLIENTE;

    PROCEDURE P_INSERTA_TIPO_MENSAJE(PI_CONTENIDO   IN SMS_TIPOS_MENSAJES.CONTENIDO%TYPE, 
                                    PI_ID_AFILIADO IN SMS_TIPOS_MENSAJES.ID_AFILIADO%TYPE,
                                    PO_ID OUT NUMBER,
                                    PO_ERROR OUT NVARCHAR2
                                    ) 
    IS
      vSec SMS_TIPOS_MENSAJES.ID%TYPE;
    BEGIN
     
     SELECT SEC_TIPOS_MENSAJES.NEXTVAL
     INTO vSec
     FROM DUAL;

    
     INSERT INTO SMS_TIPOS_MENSAJES VALUES (vSec,PI_CONTENIDO,PI_ID_AFILIADO);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     
    END P_INSERTA_TIPO_MENSAJE;
   
                          
   PROCEDURE P_INSERTA_ESTATUS_MENSAJE(PI_ID_MENSAJE IN SMS_ESTATUS_MENSAJES.ID_MENSAJE%TYPE,
                                       PI_ID_ESTATUS IN SMS_ESTATUS_MENSAJES.ID_ESTATUS%TYPE,
                                       PI_FECHA      IN SMS_ESTATUS_MENSAJES.FECHA%TYPE, 
                                       PI_LOTE       IN SMS_ESTATUS_MENSAJES.LOTE%TYPE,
                                       PO_ID OUT NUMBER,
                                       PO_ERROR OUT NVARCHAR2
                                      ) 
    IS
      vSec PROVEEDORES.ID%TYPE;
    BEGIN
     
     SELECT SEC_ESTATUS_MENSAJES.NEXTVAL
     INTO vSec
     FROM DUAL;

    
     INSERT INTO SMS_ESTATUS_MENSAJES VALUES (vSec,PI_ID_MENSAJE,PI_ID_ESTATUS,PI_FECHA,PI_LOTE);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     
    END P_INSERTA_ESTATUS_MENSAJE;

    PROCEDURE P_INSERTA_ESTATUS(PI_DESCRIPCION      IN SMS_ESTATUS.DESCRIPCION%TYPE,
                               PI_CODIGO_PROVEEDOR IN SMS_ESTATUS.CODIGO_PROVEEDOR%TYPE,
                               PI_ID_PROVEEDOR     IN SMS_ESTATUS.ID_PROVEEDOR%TYPE,
                               PO_ID OUT NUMBER,
                               PO_ERROR OUT NVARCHAR2
                               ) 
    IS
    vSec SMS_ESTATUS.ID%TYPE;
    BEGIN
     
     SELECT SEC_ESTATUS.NEXTVAL
     INTO vSec
     FROM DUAL;

    
     INSERT INTO SMS_ESTATUS VALUES (vSec,PI_DESCRIPCION,PI_CODIGO_PROVEEDOR,PI_ID_PROVEEDOR);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     
    END P_INSERTA_ESTATUS;


   PROCEDURE P_INSERTA_MENSAJE(PI_FECHA           IN SMS_MENSAJES.FECHA%TYPE,
                              PI_ID_TIPO_MENSAJE IN SMS_MENSAJES.ID_TIPO_MENSAJE%TYPE,
                              PI_ID_CLIENTE      IN SMS_MENSAJES.ID_CLIENTE%TYPE,
                              PO_ID OUT NUMBER,
                              PO_ERROR OUT NVARCHAR2
                              ) 
    IS
    vSec SMS_MENSAJES.ID%TYPE;
    BEGIN
     
     SELECT SEC_MENSAJES.NEXTVAL
     INTO vSec
     FROM DUAL;

    
     INSERT INTO SMS_MENSAJES  VALUES (vSec,SYSDATE,PI_ID_TIPO_MENSAJE,PI_ID_CLIENTE);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     
    END P_INSERTA_MENSAJE;

    FUNCTION F_ELIMINA_LOTE(PI_ID IN SMS_LOTES.ID%TYPE,
                            PO_ERROR OUT NVARCHAR2
                            ) 
    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM SMS_MENSAJES m WHERE m.ID = PI_ID;
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
    END F_ELIMINA_LOTE;

    FUNCTION F_ELIMINA_TIPO_MENSAJE(PI_ID IN SMS_TIPOS_MENSAJES.ID%TYPE,
                                    PO_ERROR OUT NVARCHAR2
                                    )

    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM SMS_TIPOS_MENSAJES tp WHERE tp.ID = PI_ID;
     
     PO_ERROR := NULL;
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
      PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
    END F_ELIMINA_TIPO_MENSAJE;

    FUNCTION F_ELIMINA_CLIENTE(PI_ID IN CLIENTES.ID%TYPE,
                               PO_ERROR OUT NVARCHAR2
                               )
    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM CLIENTES c WHERE c.ID = PI_ID;
     
    PO_ERROR := NULL;
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
      PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
      
    END F_ELIMINA_CLIENTE;

    FUNCTION F_ELIMINA_PROVEEDOR(PI_ID IN PROVEEDORES.ID%TYPE,
                                 PO_ERROR OUT NVARCHAR2
                                 )
    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM PROVEEDORES p WHERE p.ID = PI_ID;
     
    PO_ERROR := NULL;
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
      PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
      
    END F_ELIMINA_PROVEEDOR;
                             
    FUNCTION F_ELIMINA_AFILIADO(PI_ID IN AFILIADOS.ID%TYPE,
                                PO_ERROR OUT NVARCHAR2
                                )
    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM AFILIADOS a WHERE a.ID = PI_ID;
     
    PO_ERROR := NULL;
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
      PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
      
    END F_ELIMINA_AFILIADO;

    FUNCTION F_ELIMINA_ESTATUS_MENSAJE(PI_ID IN SMS_ESTATUS_MENSAJES.ID%TYPE,
                                       PO_ERROR OUT NVARCHAR2
                                       )
    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM SMS_ESTATUS_MENSAJES em WHERE em.ID = PI_ID;
     
    PO_ERROR := NULL;
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
      PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
      
    END F_ELIMINA_ESTATUS_MENSAJE;

    FUNCTION F_ELIMINA_ESTATUS(PI_ID IN SMS_ESTATUS.ID%TYPE,
                               PO_ERROR OUT NVARCHAR2
                               )
    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM SMS_ESTATUS e WHERE e.ID = PI_ID;
     
    PO_ERROR := NULL;
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
      PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
      
    END F_ELIMINA_ESTATUS;

    FUNCTION F_ELIMINA_MENSAJE(PI_ID IN SMS_MENSAJES.ID%TYPE,
                               PO_ERROR OUT NVARCHAR2
                               )
    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM SMS_MENSAJES m WHERE m.ID = PI_ID;
     
     PO_ERROR := NULL;
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
      PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
      
    END F_ELIMINA_MENSAJE;

   FUNCTION F_ACTUALIZA_TIPO_MENSAJE(PI_ID          IN SMS_TIPOS_MENSAJES.ID%TYPE,   
                                     PI_CONTENIDO   IN SMS_TIPOS_MENSAJES.CONTENIDO%TYPE, 
                                     PI_ID_AFILIADO IN SMS_TIPOS_MENSAJES.ID_AFILIADO%TYPE,
                                     PO_ERROR OUT NVARCHAR2                                     
                                     ) RETURN NUMBER
    IS
    BEGIN
     
     UPDATE SMS_TIPOS_MENSAJES tm 
     SET tm.CONTENIDO = PI_CONTENIDO,tm.ID_AFILIADO = PI_ID_AFILIADO
     WHERE tm.ID = PI_ID;  
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
    END F_ACTUALIZA_TIPO_MENSAJE;
                                     

   FUNCTION F_ACTUALIZA_CLIENTE(PI_ID        IN CLIENTES.ID%TYPE,
                                PI_CEDULA    IN CLIENTES.CEDULA%TYPE,
                                PI_NOMBRE    IN CLIENTES.NOMBRE%TYPE,
                                PI_CELULAR   IN CLIENTES.CELULAR%TYPE,
                                PI_DIRECCION IN CLIENTES.DIRECCION%TYPE,
                                PI_EMAIL     IN CLIENTES.EMAIL%TYPE,
                                PO_ERROR OUT NVARCHAR2                                     
                                ) RETURN NUMBER
    IS
    BEGIN
     
     UPDATE CLIENTES c 
     SET c.CEDULA = PI_CEDULA,c.NOMBRE = PI_NOMBRE,c.CELULAR = PI_CELULAR,c.DIRECCION = PI_DIRECCION,c.EMAIL = PI_EMAIL 
     WHERE c.ID = PI_ID;  
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
   END F_ACTUALIZA_CLIENTE;

  FUNCTION F_ACTUALIZA_PROVEEDOR(PI_ID        IN PROVEEDORES.ID%TYPE,
                                 PI_NOMBRE    IN PROVEEDORES.NOMBRE%TYPE,
                                 PI_RIF       IN PROVEEDORES.RIF%TYPE,
                                 PI_TELEFONO  IN PROVEEDORES.TELEFONO%TYPE,
                                 PI_DIRECCION IN PROVEEDORES.DIRECCION%TYPE,
                                 PI_EMAIL     IN PROVEEDORES.EMAIL%TYPE,
                                 PO_ERROR OUT NVARCHAR2                                     
                                 ) RETURN NUMBER
    IS
    BEGIN
     
     UPDATE PROVEEDORES p 
     SET p.NOMBRE = PI_NOMBRE,p.RIF = PI_RIF,p.TELEFONO = PI_TELEFONO,p.DIRECCION = PI_DIRECCION,p.EMAIL = PI_EMAIL 
     WHERE p.ID = PI_ID;  
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
   END F_ACTUALIZA_PROVEEDOR;
                             
  FUNCTION F_ACTUALIZA_AFILIADO(PI_ID        IN AFILIADOS.ID%TYPE,
                                PI_NOMBRE    IN AFILIADOS.NOMBRE%TYPE,
                                PI_TELEFONO  IN AFILIADOS.TELEFONO%TYPE,
                                PI_DIRECCION IN AFILIADOS.DIRECCION%TYPE,
                                PI_EMAIL      IN AFILIADOS.EMAIL%TYPE,
                                PO_ERROR OUT NVARCHAR2                                     
                                ) RETURN NUMBER
    IS
    BEGIN
     
     UPDATE AFILIADOS p 
     SET p.NOMBRE = PI_NOMBRE,p.TELEFONO = PI_TELEFONO,p.DIRECCION = PI_DIRECCION,p.EMAIL = PI_EMAIL 
     WHERE p.ID = PI_ID;  
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
   END F_ACTUALIZA_AFILIADO;

  FUNCTION F_ACTUALIZA_ESTATUS_MENSAJE(PI_ID         IN SMS_ESTATUS_MENSAJES.ID%TYPE,
                                       PI_ID_MENSAJE IN SMS_ESTATUS_MENSAJES.ID_MENSAJE%TYPE,
                                       PI_ID_ESTATUS IN SMS_ESTATUS_MENSAJES.ID_ESTATUS%TYPE,
                                       PI_FECHA      IN SMS_ESTATUS_MENSAJES.FECHA%TYPE, 
                                       PI_LOTE       IN SMS_ESTATUS_MENSAJES.LOTE%TYPE,
                                       PO_ERROR OUT NVARCHAR2                                                                            
                                       ) RETURN NUMBER
    IS
    BEGIN
     
     UPDATE SMS_ESTATUS_MENSAJES em 
     SET em.ID_MENSAJE = PI_ID_MENSAJE,em.ID_ESTATUS = PI_ID_ESTATUS,em.FECHA = PI_FECHA,em.LOTE = PI_LOTE
     WHERE em.ID = PI_ID;  
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
   END F_ACTUALIZA_ESTATUS_MENSAJE;

  FUNCTION F_ACTUALIZA_ESTATUS(PI_ID               IN SMS_ESTATUS.ID%TYPE,
                               PI_DESCRIPCION      IN SMS_ESTATUS.DESCRIPCION%TYPE,
                               PI_CODIGO_PROVEEDOR IN SMS_ESTATUS.CODIGO_PROVEEDOR%TYPE,
                               PI_ID_PROVEEDOR     IN SMS_ESTATUS.ID_PROVEEDOR%TYPE,
                               PO_ERROR OUT NVARCHAR2                                     
                               ) RETURN NUMBER
    IS
    BEGIN
     
     UPDATE SMS_ESTATUS e 
     SET e.DESCRIPCION = PI_DESCRIPCION,e.CODIGO_PROVEEDOR = PI_CODIGO_PROVEEDOR,e.ID_PROVEEDOR = PI_ID_PROVEEDOR
     WHERE e.ID = PI_ID;  
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
   END F_ACTUALIZA_ESTATUS;

  FUNCTION F_ACTUALIZA_MENSAJE(PI_ID              IN SMS_MENSAJES.ID%TYPE,
                               PI_FECHA           IN SMS_MENSAJES.FECHA%TYPE,
                               PI_ID_TIPO_MENSAJE IN SMS_MENSAJES.ID_TIPO_MENSAJE%TYPE,
                               PI_ID_CLIENTE      IN SMS_MENSAJES.ID_CLIENTE%TYPE,
                               PO_ERROR OUT NVARCHAR2                                                                   
                               ) RETURN NUMBER
      IS
    BEGIN
     
     UPDATE SMS_MENSAJES m 
     SET m.FECHA = PI_FECHA,m.ID_TIPO_MENSAJE = PI_ID_TIPO_MENSAJE,m.ID_CLIENTE = PI_ID_CLIENTE
     WHERE m.ID = PI_ID;  
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
   END F_ACTUALIZA_MENSAJE;

   FUNCTION F_LISTAR_LOTE_X_ESTATUS(PI_ID_LOTE IN SMS_LOTES.ID%TYPE,
                                    PI_ID_ESTATUS IN SMS_ESTATUS.ID%TYPE,
                                    PI_ID_PROVEEDOR IN PROVEEDORES.ID%TYPE,
                                    PO_ERROR OUT NVARCHAR2                                                                   
   ) 
   RETURN RESULSET
   IS
     vCursor RESULSET;

    BEGIN
     
    OPEN vCursor FOR
     SELECT l.ID, l.FECHA, count(*) cantidad
     FROM SMS_LOTES l, sms_estatus_mensajes em, SMS_ESTATUS e
     WHERE l.ID = em.LOTE
       AND l.ID = PI_ID_LOTE 
       AND em.ID_ESTATUS = e.ID
       AND e.ID = PI_ID_ESTATUS
       AND e.ID_PROVEEDOR = PI_ID_PROVEEDOR
     GROUP BY l.ID,l.fecha;  
     
     PO_ERROR := NULL;
     RETURN (vCursor);
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			BEGIN
				PO_ERROR := '0|NOT_DATA_FOUND';
                RETURN NULL;
			END;
		WHEN OTHERS THEN
			BEGIN
				PO_ERROR := 'SQLCODE|' || SQLERRM;
                RETURN NULL; 
			END;
   END F_LISTAR_LOTE_X_ESTATUS;

   FUNCTION F_BUSCA_TIPO_MENSAJE(PI_ID IN SMS_TIPOS_MENSAJES.ID%TYPE,
                                 PO_ERROR OUT NVARCHAR2                                                                   
                                 ) 
   RETURN RESULSET
   IS
     vCursor RESULSET;

    BEGIN
   
    OPEN vCursor FOR  
     SELECT * 
     FROM SMS_TIPOS_MENSAJES tm  
     WHERE tm.ID = PI_ID;  
     
     RETURN (vCursor);
    EXCEPTION
		WHEN NO_DATA_FOUND THEN
			BEGIN
				PO_ERROR := '0|NOT_DATA_FOUND';
                RETURN NULL;
			END;
		WHEN OTHERS THEN
			BEGIN
				PO_ERROR := 'SQLCODE|' || SQLERRM;
                RETURN NULL; 
			END;
     
   END F_BUSCA_TIPO_MENSAJE;

  FUNCTION F_LISTAR_CLIENTE(PI_ID IN CLIENTES.ID%TYPE, 
                            PI_CEDULA IN CLIENTES.CEDULA%TYPE,
                            PI_CELULAR IN CLIENTES.CELULAR%TYPE,
                            PO_ERROR OUT NVARCHAR2
                            ) RETURN RESULSET
   IS
     vCursor RESULSET;
    BEGIN
     
     OPEN vCursor FOR 
     SELECT * 
     FROM CLIENTES c  
     WHERE ((PI_ID IS NOT NULL AND c.ID = PI_ID) OR PI_ID IS NULL) 
      AND  c.cedula = NVL (PI_CEDULA, c.cedula)
      AND  c.celular = NVL (PI_CELULAR, c.cedula);
            
     RETURN (vCursor);
    EXCEPTION
		WHEN NO_DATA_FOUND THEN
			BEGIN
				PO_ERROR := '0|NOT_DATA_FOUND';
                RETURN NULL;
			END;
		WHEN OTHERS THEN
			BEGIN
				PO_ERROR := 'SQLCODE|' || SQLERRM;
                RETURN NULL; 
			END;
     
   END F_LISTAR_CLIENTE;

   FUNCTION F_LISTAR_PROVEEDOR(PI_ID IN PROVEEDORES.ID%TYPE,
                              PI_RIF IN PROVEEDORES.ID%TYPE,    
                              PO_ERROR OUT NVARCHAR2
   ) RETURN RESULSET
   IS
     vCursor RESULSET;

    BEGIN

     OPEN vCursor FOR      
     SELECT * 
     FROM PROVEEDORES p  
     WHERE ((PI_ID IS NOT NULL AND p.ID = PI_ID) OR PI_ID IS NULL)
        AND p.RIF = NVL(PI_RIF,p.RIF);  
     
     RETURN (vCursor);
    EXCEPTION
		WHEN NO_DATA_FOUND THEN
			BEGIN
				PO_ERROR := '0|NOT_DATA_FOUND';
                RETURN NULL;
			END;
		WHEN OTHERS THEN
			BEGIN
				PO_ERROR := 'SQLCODE|' || SQLERRM;
                RETURN NULL; 
			END;
     
   END F_LISTAR_PROVEEDOR;
                             
  FUNCTION F_LISTAR_AFILIADO(PI_ID IN AFILIADOS.ID%TYPE,
                            PI_NOMBRE IN AFILIADOS.NOMBRE%TYPE,
                            PO_ERROR OUT NVARCHAR2
                            ) RETURN RESULSET
   IS
     vCursor RESULSET;

    BEGIN

     OPEN vCursor FOR           
     SELECT *
     FROM AFILIADOS a  
     WHERE ((PI_ID IS NOT NULL AND a.ID = PI_ID) OR PI_ID IS NULL)
       AND a.NOMBRE = NVL(PI_NOMBRE,a.NOMBRE);  
     
     RETURN (vCursor);
    EXCEPTION
		WHEN NO_DATA_FOUND THEN
			BEGIN
				PO_ERROR := '0|NOT_DATA_FOUND';
                RETURN NULL;
			END;
		WHEN OTHERS THEN
			BEGIN
				PO_ERROR := 'SQLCODE|' || SQLERRM;
                RETURN NULL; 
			END;
     
   END F_LISTAR_AFILIADO;

   FUNCTION F_LISTAR_ESTATUS_MENSAJE(PI_ID_EST_MENSAJE IN SMS_ESTATUS_MENSAJES.ID%TYPE,
                                     PI_ID_ESTATUS IN SMS_ESTATUS_MENSAJES.ID_ESTATUS%TYPE,
                                     PI_FECHA      IN SMS_ESTATUS_MENSAJES.FECHA%TYPE,
                                     PI_LOTE       IN SMS_ESTATUS_MENSAJES.LOTE%TYPE,
                                     PO_ERROR OUT NVARCHAR2   
   ) RETURN RESULSET
   IS
     vCursor RESULSET;

    BEGIN

     OPEN vCursor FOR                
     SELECT * 
     FROM SMS_ESTATUS_MENSAJES l  
     WHERE ((PI_ID_EST_MENSAJE IS NOT NULL AND l.ID = PI_ID_EST_MENSAJE) OR PI_ID_EST_MENSAJE IS NULL)
       AND ((PI_ID_ESTATUS IS NOT NULL AND l.ID_ESTATUS = PI_ID_ESTATUS) OR PI_ID_ESTATUS IS NULL)
       AND trunc(l.FECHA) = NVL(trunc(PI_FECHA),trunc(l.FECHA))
       AND ((PI_LOTE IS NOT NULL AND l.LOTE = PI_LOTE) OR PI_LOTE IS NULL);  
     
     RETURN (vCursor);
    EXCEPTION
		WHEN NO_DATA_FOUND THEN
			BEGIN
				PO_ERROR := '0|NOT_DATA_FOUND';
                RETURN NULL;
			END;
		WHEN OTHERS THEN
			BEGIN
				PO_ERROR := 'SQLCODE|' || SQLERRM;
                RETURN NULL; 
			END;
     
   END F_LISTAR_ESTATUS_MENSAJE;

   FUNCTION F_LISTAR_ESTATUS(PI_ID_ESTATUS IN SMS_ESTATUS.ID%TYPE,
                             PI_ID_PROVEEDOR SMS_ESTATUS.ID_PROVEEDOR%TYPE,
                             PO_ERROR OUT NVARCHAR2   
                             ) 
   RETURN RESULSET
   IS
     vCursor RESULSET;

    BEGIN
     
     OPEN vCursor FOR           
     SELECT * 
     FROM SMS_ESTATUS e  
     WHERE ((PI_ID_PROVEEDOR IS NOT NULL AND e.ID_PROVEEDOR = PI_ID_PROVEEDOR) OR PI_ID_PROVEEDOR IS NULL)
       AND ((PI_ID_ESTATUS IS NOT NULL AND e.ID = PI_ID_ESTATUS) OR PI_ID_ESTATUS IS NULL);
       
     RETURN (vCursor);
    EXCEPTION
		WHEN NO_DATA_FOUND THEN
			BEGIN
				PO_ERROR := '0|NOT_DATA_FOUND';
                RETURN NULL;
			END;
		WHEN OTHERS THEN
			BEGIN
				PO_ERROR := 'SQLCODE|' || SQLERRM;
                RETURN NULL; 
			END;
     
   END F_LISTAR_ESTATUS;

   FUNCTION F_LISTAR_MENSAJES(PI_ID IN SMS_MENSAJES.ID%TYPE,
                              PI_FECHA IN SMS_MENSAJES.FECHA%TYPE,
                              PI_ID_TIPO_MENSAJE IN SMS_MENSAJES.ID_TIPO_MENSAJE%TYPE,
                              PI_ID_CLIENTE IN SMS_MENSAJES.ID_CLIENTE%TYPE,
                              PI_ID_ESTATUS IN SMS_ESTATUS.ID%TYPE,
                              PO_ERROR OUT NVARCHAR2   
                              ) 
   RETURN RESULSET                         
   IS
     vCursor RESULSET;

    BEGIN

     OPEN vCursor FOR                
      SELECT em1.ID,s.ID,s.DESCRIPCION,m.FECHA as FECHA_MENSAJE,em1.FECHA as FECHA_ESTATUS,em1.LOTE,s.CODIGO_PROVEEDOR, c.NOMBRE, c.CELULAR, tp.CONTENIDO 
      FROM SMS_ESTATUS_MENSAJES em1, SMS_ESTATUS s, SMS_MENSAJES m,CLIENTES c, SMS_TIPOS_MENSAJES tp 
      WHERE em1.ID_ESTATUS = s.ID
        AND em1.ID_MENSAJE = m.ID
        AND m.ID_CLIENTE = c.ID
        AND m.ID_TIPO_MENSAJE = tp.ID  
        AND EXISTS (
                SELECT em.ID_MENSAJE, MAX(em.fecha) 
                FROM SMS_ESTATUS_MENSAJES em 
                WHERE em.ID = em1.ID
                GROUP BY em.ID_MENSAJE
              )
        AND em1.ID_ESTATUS = PI_ID_ESTATUS
        AND ((PI_ID IS NOT NULL AND m.ID = PI_ID) OR PI_ID IS NULL)
        AND trunc(m.FECHA) = NVL(trunc(PI_FECHA),trunc(m.FECHA))
        AND ((PI_ID_TIPO_MENSAJE IS NOT NULL AND m.ID = PI_ID_TIPO_MENSAJE) OR PI_ID_TIPO_MENSAJE IS NULL)
        AND ((PI_ID_CLIENTE IS NOT NULL AND m.ID = PI_ID_CLIENTE) OR PI_ID_CLIENTE IS NULL);
     RETURN (vCursor);
    EXCEPTION
		WHEN NO_DATA_FOUND THEN
			BEGIN
				PO_ERROR := '0|NOT_DATA_FOUND';
                RETURN NULL;
			END;
		WHEN OTHERS THEN
			BEGIN
				PO_ERROR := 'SQLCODE|' || SQLERRM;
                RETURN NULL; 
			END;
     
   END F_LISTAR_MENSAJES;

END PKG_SMS;
/

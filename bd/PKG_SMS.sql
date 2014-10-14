CREATE OR REPLACE PACKAGE PKG_SMS AS
/******************************************************************************
   NAME:       PKG_SMS
   PURPOSE:    CONTIENE LAS FUNCIONES Y PROCEDIMIENTOS PARA ENVIO DE MENSAJES 

******************************************************************************/
TYPE RESULSET IS REF CURSOR;

  PROCEDURE P_INSERTA_LOTE(PO_ID OUT NUMBER,PO_ERROR OUT NVARCHAR2);

  PROCEDURE P_INSERTA_CENTRO_SALUD(PI_NOMBRE    IN CS_EX_CENTROS_SALUD.NOMBRE%TYPE,
                               PI_TELEFONO  IN CS_EX_CENTROS_SALUD.TELEFONO%TYPE,
                               PI_DIRECCION IN CS_EX_CENTROS_SALUD.DIRECCION%TYPE,
                               PI_EMAIL     IN CS_EX_CENTROS_SALUD.EMAIL%TYPE,
                               PO_ID OUT NUMBER,
                               PO_ERROR OUT NVARCHAR2
                               );

  PROCEDURE P_INSERTA_PROVEEDOR(PI_NOMBRE    IN CS_EX_PROVEEDORES.NOMBRE%TYPE,
                                PI_RIF       IN CS_EX_PROVEEDORES.RIF%TYPE,
                                PI_TELEFONO  IN CS_EX_PROVEEDORES.TELEFONO%TYPE,
                                PI_DIRECCION IN CS_EX_PROVEEDORES.DIRECCION%TYPE,
                                PI_EMAIL      IN CS_EX_PROVEEDORES.EMAIL%TYPE,
                                PO_ID OUT NUMBER,
                                PO_ERROR OUT NVARCHAR2
                                );

  PROCEDURE P_INSERTA_CLIENTE(PI_CEDULA    IN CS_EX_CLIENTES.CEDULA%TYPE,
                              PI_NOMBRE    IN CS_EX_CLIENTES.NOMBRE%TYPE,
                              PI_CELULAR   IN CS_EX_CLIENTES.CELULAR%TYPE,
                              PI_DIRECCION IN CS_EX_CLIENTES.DIRECCION%TYPE,
                              PI_EMAIL     IN CS_EX_CLIENTES.EMAIL%TYPE,
                              PO_ID OUT NUMBER,
                              PO_ERROR OUT NVARCHAR2
                              );
                              
    PROCEDURE P_INSERTA_TIPO_MENSAJE(PI_TIPO  IN CS_EX_TIPOS_MENSAJES.TIPO%TYPE,
                                    PI_ID_CORPORATE IN CS_EX_TIPOS_MENSAJES.ID_CORPORATE%TYPE,
                                    PI_RESTRICCION IN CS_EX_TIPOS_MENSAJES.RESTRICCION%TYPE,
                                    PO_ID OUT NUMBER,
                                    PO_ERROR OUT NVARCHAR2
                                    );
                             
  PROCEDURE P_INSERTA_ESTATUS_MENSAJE(PI_ID_MENSAJE IN CS_EX_ESTATUS_MENSAJES.ID_MENSAJE%TYPE,
                                      PI_ID_ESTATUS IN CS_EX_ESTATUS_MENSAJES.ID_ESTATUS%TYPE,
                                      PI_LOTE       IN CS_EX_ESTATUS_MENSAJES.LOTE%TYPE,
                                      PO_ID OUT NUMBER,
                                      PO_ERROR OUT NVARCHAR2
                                      );
   
  PROCEDURE P_INSERTA_ESTATUS(PI_DESCRIPCION      IN CS_EX_ESTATUS.DESCRIPCION%TYPE,
                              PI_CODIGO_PROVEEDOR IN CS_EX_ESTATUS.CODIGO_PROVEEDOR%TYPE,
                              PI_ID_PROVEEDOR     IN CS_EX_ESTATUS.ID_PROVEEDOR%TYPE,
                              PO_ID OUT NUMBER,
                              PO_ERROR OUT NVARCHAR2
                              );
    
    PROCEDURE P_INSERTA_MENSAJE(PI_FECHA           IN CS_EX_MENSAJES.FECHA%TYPE,
                              PI_ID_TIPO_MENSAJE IN CS_EX_MENSAJES.ID_TIPO_MENSAJE%TYPE,
                              PI_ID_CLIENTE      IN CS_EX_MENSAJES.ID_CLIENTE%TYPE,
                              PI_CONTENIDO       IN CS_EX_MENSAJES.CONTENIDO%TYPE,
                              PI_ID_PLANTILLA      IN CS_EX_MENSAJES.ID_PLANTILLA%TYPE,
                              PO_ID OUT NUMBER,
                              PO_ERROR OUT NVARCHAR2
                              ); 
                               
  FUNCTION F_ELIMINA_LOTE(PI_ID IN CS_EX_LOTES.ID%TYPE,
                          PO_ERROR OUT NVARCHAR2
                          ) RETURN NUMBER;

  FUNCTION F_ELIMINA_TIPO_MENSAJE(PI_ID IN CS_EX_TIPOS_MENSAJES.ID%TYPE,
                                  PO_ERROR OUT NVARCHAR2
                                  ) RETURN NUMBER;

  FUNCTION F_ELIMINA_CLIENTE(PI_ID IN CS_EX_CLIENTES.ID%TYPE,
                             PO_ERROR OUT NVARCHAR2
                             ) RETURN NUMBER;

  FUNCTION F_ELIMINA_PROVEEDOR(PI_ID IN CS_EX_PROVEEDORES.ID%TYPE,
                               PO_ERROR OUT NVARCHAR2
                               ) RETURN NUMBER;
                             
  FUNCTION F_ELIMINA_CENTRO_SALUD(PI_ID IN CS_EX_CENTROS_SALUD.ID_CORPORATE%TYPE,
                              PO_ERROR OUT NVARCHAR2
                              ) RETURN NUMBER;

  FUNCTION F_ELIMINA_ESTATUS_MENSAJE(PI_ID IN CS_EX_ESTATUS_MENSAJES.ID%TYPE,
                                     PO_ERROR OUT NVARCHAR2
                                     ) RETURN NUMBER;

  FUNCTION F_ELIMINA_ESTATUS(PI_ID IN CS_EX_ESTATUS.ID%TYPE,
                             PO_ERROR OUT NVARCHAR2
                             ) RETURN NUMBER;

  FUNCTION F_ELIMINA_MENSAJE(PI_ID IN CS_EX_MENSAJES.ID%TYPE,
                             PO_ERROR OUT NVARCHAR2
                             ) RETURN NUMBER;                           

   FUNCTION F_LISTAR_LOTE_X_ESTATUS(PI_ID_LOTE IN CS_EX_LOTES.ID%TYPE,
                                    PI_ID_ESTATUS IN CS_EX_ESTATUS.ID%TYPE,
                                    PI_ID_PROVEEDOR IN CS_EX_PROVEEDORES.ID%TYPE,
                                    PO_ERROR OUT NVARCHAR2                                                                   
                                    ) RETURN RESULSET;

   FUNCTION F_BUSCA_TIPO_MENSAJE(PI_ID IN CS_EX_TIPOS_MENSAJES.ID%TYPE,
                                 PO_ERROR OUT NVARCHAR2                                                                   
                                 )  RETURN RESULSET;

    FUNCTION F_LISTAR_CLIENTE(PI_ID IN CS_EX_CLIENTES.ID%TYPE, 
                              PI_CEDULA IN CS_EX_CLIENTES.CEDULA%TYPE,
                              PI_CELULAR IN CS_EX_CLIENTES.CELULAR%TYPE,
                              PI_ID_CORPORATE IN CS_EX_CENTROS_CLIENTES.ID_CORPORATE%TYPE,
                              PO_ERROR OUT NVARCHAR2
                             ) RETURN RESULSET;

   FUNCTION F_LISTAR_PROVEEDOR(PI_ID IN CS_EX_PROVEEDORES.ID%TYPE,
                              PI_RIF IN CS_EX_PROVEEDORES.ID%TYPE,    
                              PO_ERROR OUT NVARCHAR2
   ) RETURN RESULSET;
                             
  FUNCTION F_LISTAR_CENTRO_SALUD(PI_ID IN CS_EX_CENTROS_SALUD.ID_CORPORATE %TYPE,
                             PI_NOMBRE IN CS_EX_CENTROS_SALUD.NOMBRE%TYPE,
                             PO_ERROR OUT NVARCHAR2
                             ) RETURN RESULSET;

   FUNCTION F_LISTAR_ESTATUS_MENSAJE(PI_ID_EST_MENSAJE IN CS_EX_ESTATUS_MENSAJES.ID%TYPE,
                                     PI_ID_ESTATUS IN CS_EX_ESTATUS_MENSAJES.ID_ESTATUS%TYPE,
                                     PI_FECHA      IN CS_EX_ESTATUS_MENSAJES.FECHA%TYPE,
                                     PI_LOTE       IN CS_EX_ESTATUS_MENSAJES.LOTE%TYPE,
                                     PO_ERROR OUT NVARCHAR2) RETURN RESULSET;

   FUNCTION F_LISTAR_ESTATUS(PI_ID_ESTATUS IN CS_EX_ESTATUS.ID%TYPE,
                             PI_ID_PROVEEDOR CS_EX_ESTATUS.ID_PROVEEDOR%TYPE,
                             PO_ERROR OUT NVARCHAR2   
                             ) 
   RETURN RESULSET; 

   FUNCTION F_LISTAR_MENSAJES(PI_ID IN CS_EX_MENSAJES.ID%TYPE,
                             PI_FECHA IN CS_EX_MENSAJES.FECHA%TYPE,
                             PI_ID_TIPO_MENSAJE IN CS_EX_MENSAJES.ID_TIPO_MENSAJE%TYPE,
                             PI_ID_CLIENTE IN CS_EX_MENSAJES.ID_CLIENTE%TYPE,
                             PI_ID_ESTATUS IN CS_EX_ESTATUS.ID%TYPE,
                             PO_ERROR OUT NVARCHAR2   
                             ) 
   RETURN RESULSET;                         

   FUNCTION F_ACTUALIZA_TIPO_MENSAJE(PI_ID          IN CS_EX_TIPOS_MENSAJES.ID%TYPE,   
                                     PI_ID_CORPORATE IN CS_EX_TIPOS_MENSAJES.ID_CORPORATE%TYPE,
                                     PI_RESTRICCION IN CS_EX_TIPOS_MENSAJES.RESTRICCION%TYPE,
                                     PO_ERROR OUT NVARCHAR2                                     
                                     ) RETURN NUMBER;

  FUNCTION F_ACTUALIZA_CLIENTE(PI_ID        IN CS_EX_CLIENTES.ID%TYPE,
                               PI_CEDULA    IN CS_EX_CLIENTES.CEDULA%TYPE,
                               PI_NOMBRE    IN CS_EX_CLIENTES.NOMBRE%TYPE,
                               PI_CELULAR   IN CS_EX_CLIENTES.CELULAR%TYPE,
                               PI_DIRECCION IN CS_EX_CLIENTES.DIRECCION%TYPE,
                               PI_EMAIL     IN CS_EX_CLIENTES.EMAIL%TYPE,
                               PO_ERROR OUT NVARCHAR2
                               ) RETURN NUMBER;

  FUNCTION F_ACTUALIZA_PROVEEDOR(PI_ID        IN CS_EX_PROVEEDORES.ID%TYPE,
                                 PI_NOMBRE    IN CS_EX_PROVEEDORES.NOMBRE%TYPE,
                                 PI_RIF       IN CS_EX_PROVEEDORES.RIF%TYPE,
                                 PI_TELEFONO  IN CS_EX_PROVEEDORES.TELEFONO%TYPE,
                                 PI_DIRECCION IN CS_EX_PROVEEDORES.DIRECCION%TYPE,
                                 PI_EMAIL     IN CS_EX_PROVEEDORES.EMAIL%TYPE,
                                 PO_ERROR OUT NVARCHAR2                                 
                                 ) RETURN NUMBER;
                             
  FUNCTION F_ACTUALIZA_CENTRO_SALUD(PI_ID        IN CS_EX_CENTROS_SALUD.ID_CORPORATE%TYPE,
                                PI_NOMBRE    IN CS_EX_CENTROS_SALUD.NOMBRE%TYPE,
                                PI_TELEFONO  IN CS_EX_CENTROS_SALUD.TELEFONO%TYPE,
                                PI_DIRECCION IN CS_EX_CENTROS_SALUD.DIRECCION%TYPE,
                                PI_EMAIL     IN CS_EX_CENTROS_SALUD.EMAIL%TYPE, 
                                PO_ERROR OUT NVARCHAR2                                
                                ) RETURN NUMBER;

  FUNCTION F_ACTUALIZA_ESTATUS_MENSAJE(PI_ID         IN CS_EX_ESTATUS_MENSAJES.ID%TYPE,
                                       PI_ID_MENSAJE IN CS_EX_ESTATUS_MENSAJES.ID_MENSAJE%TYPE,
                                       PI_ID_ESTATUS IN CS_EX_ESTATUS_MENSAJES.ID_ESTATUS%TYPE,
                                       PI_FECHA      IN CS_EX_ESTATUS_MENSAJES.FECHA%TYPE, 
                                       PI_LOTE       IN CS_EX_ESTATUS_MENSAJES.LOTE%TYPE,
                                       PO_ERROR OUT NVARCHAR2                                
                                       ) RETURN NUMBER;

  FUNCTION F_ACTUALIZA_ESTATUS(PI_ID               IN CS_EX_ESTATUS.ID%TYPE,
                               PI_DESCRIPCION      IN CS_EX_ESTATUS.DESCRIPCION%TYPE,
                               PI_CODIGO_PROVEEDOR IN CS_EX_ESTATUS.CODIGO_PROVEEDOR%TYPE,
                               PI_ID_PROVEEDOR     IN CS_EX_ESTATUS.ID_PROVEEDOR%TYPE,
                               PO_ERROR OUT NVARCHAR2                                
                               ) RETURN NUMBER;


  FUNCTION F_ACTUALIZA_MENSAJE(PI_ID              IN CS_EX_MENSAJES.ID%TYPE,
                               PI_FECHA           IN CS_EX_MENSAJES.FECHA%TYPE,
                               PI_ID_TIPO_MENSAJE IN CS_EX_MENSAJES.ID_TIPO_MENSAJE%TYPE,
                               PI_ID_CLIENTE      IN CS_EX_MENSAJES.ID_CLIENTE%TYPE,
                               PO_ERROR OUT NVARCHAR2                                
                               ) RETURN NUMBER;

  PROCEDURE P_INSERTA_UNIDAD(PI_NOMBRE IN CS_EX_UNIDAD.NOMBRE%TYPE,PO_ID OUT NUMBER,PO_ERROR OUT NVARCHAR2);
  
  FUNCTION F_BUSCAR_UNIDAD(PI_ID IN CS_EX_UNIDAD.ID%TYPE,
                            PI_NOMBRE IN CS_EX_UNIDAD.NOMBRE%TYPE,    
                            PO_ERROR OUT NVARCHAR2
   ) RETURN RESULSET;

  FUNCTION F_ARMAR_SMS(PI_TIPO_MENSAJE IN CS_EX_PLANTILLAS.ID_TIPO_MENSAJE%TYPE,
                        PI_ID_CLIENTE IN CS_EX_CLIENTES.ID%TYPE,    
                        PI_SERVICIO IN CS_EX_UNIDAD.ID%TYPE,
                        PI_FECHA IN DATE
                        ) RETURN VARCHAR;
 
  PROCEDURE P_INSERTA_MENSAJE_SMS( PI_ID_TIPO_MENSAJE IN CS_EX_TIPOS_MENSAJES.ID%TYPE,
                                   PI_CEDULA          IN CS_EX_CLIENTES.CEDULA%TYPE,
                                   PI_NOMBRE_UNIDAD   IN CS_EX_UNIDAD.NOMBRE%TYPE, 
                                   PO_ID OUT NUMBER,
                                   PO_ERROR OUT NVARCHAR2
                              );

   FUNCTION F_BUSCAR_PARAMETROS(PI_ID_UNIDAD IN CS_EX_UNIDAD.ID%TYPE,
                                PI_ID_TIPO_MENSAJE IN CS_EX_TIPOS_MENSAJES.ID%TYPE,    
                                PO_ERROR OUT NVARCHAR2
   ) RETURN RESULSET;

END PKG_SMS;

CREATE OR REPLACE PACKAGE BODY PKG_SMS AS

    PROCEDURE P_INSERTA_LOTE(PO_ID OUT NUMBER,PO_ERROR OUT NVARCHAR2) 
    IS
      vSec CS_EX_LOTES.ID%TYPE;
    BEGIN

     SELECT CS_EX_SEC_LOTES.NEXTVAL
     INTO vSec
     FROM DUAL;
     
     INSERT INTO CS_EX_LOTES VALUES (vSec, SYSDATE);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
    END P_INSERTA_LOTE;

    PROCEDURE P_INSERTA_CENTRO_SALUD(PI_NOMBRE    IN CS_EX_CENTROS_SALUD.NOMBRE%TYPE,
                                 PI_TELEFONO  IN CS_EX_CENTROS_SALUD.TELEFONO%TYPE,
                                 PI_DIRECCION IN CS_EX_CENTROS_SALUD.DIRECCION%TYPE,
                                 PI_EMAIL     IN CS_EX_CENTROS_SALUD.EMAIL%TYPE,
                                 PO_ID OUT NUMBER,
                                 PO_ERROR OUT NVARCHAR2
                                ) 
    IS
      vSec CS_EX_CENTROS_SALUD.ID_CORPORATE%TYPE;
    BEGIN

     SELECT CS_EX_SEC_CENTROS_SALUD.NEXTVAL
     INTO vSec
     FROM DUAL;
     
     INSERT INTO CS_EX_CENTROS_SALUD VALUES (vSec,PI_NOMBRE,PI_TELEFONO,PI_DIRECCION,PI_EMAIL);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     
    END P_INSERTA_CENTRO_SALUD;
    
    
  PROCEDURE P_INSERTA_PROVEEDOR(PI_NOMBRE    IN CS_EX_PROVEEDORES.NOMBRE%TYPE,
                                PI_RIF       IN CS_EX_PROVEEDORES.RIF%TYPE,
                                PI_TELEFONO  IN CS_EX_PROVEEDORES.TELEFONO%TYPE,
                                PI_DIRECCION IN CS_EX_PROVEEDORES.DIRECCION%TYPE,
                                PI_EMAIL      IN CS_EX_PROVEEDORES.EMAIL%TYPE,
                                PO_ID OUT NUMBER,
                                PO_ERROR OUT NVARCHAR2
                                )
    IS
      vSec CS_EX_PROVEEDORES.ID%TYPE;
    BEGIN
     
    
     SELECT CS_EX_SEC_PROVEEDORES.NEXTVAL
     INTO vSec
     FROM DUAL;
    
     INSERT INTO CS_EX_PROVEEDORES VALUES (vSec,PI_NOMBRE,PI_RIF,PI_TELEFONO,PI_DIRECCION,PI_EMAIL);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     
    END P_INSERTA_PROVEEDOR;

  PROCEDURE P_INSERTA_CLIENTE(PI_CEDULA    IN CS_EX_CLIENTES.CEDULA%TYPE,
                              PI_NOMBRE    IN CS_EX_CLIENTES.NOMBRE%TYPE,
                              PI_CELULAR   IN CS_EX_CLIENTES.CELULAR%TYPE,
                              PI_DIRECCION IN CS_EX_CLIENTES.DIRECCION%TYPE,
                              PI_EMAIL     IN CS_EX_CLIENTES.EMAIL%TYPE,
                              PI_ID_CORPORATE IN CS_EX_CENTROS_CLIENTES.ID%TYPE,
                              PO_ID OUT NUMBER,
                              PO_ERROR OUT NVARCHAR2
                              )
    IS
      vSec CS_EX_CLIENTES.ID%TYPE;
      vSecCC CS_EX_CENTROS_CLIENTES.ID%TYPE;
      vExiste NUMBER;
    BEGIN
     vSec := 1;

         SELECT count(*) into vExiste 
         FROM CS_EX_CLIENTES c
         WHERE c.cedula = PI_CEDULA;

     IF (vExiste = 0) THEN
         SELECT CS_EX_SEC_CLIENTES.NEXTVAL
         INTO vSec
         FROM DUAL;

        INSERT INTO CS_EX_CLIENTES VALUES (vSec,PI_CEDULA,PI_NOMBRE,PI_CELULAR,PI_DIRECCION,PI_EMAIL,SYSDATE);  
     END IF;
     
     SELECT count(*) into vExiste 
     FROM CS_EX_CLIENTES c,  CS_EX_CENTROS_CLIENTES cc
     WHERE c.cedula = PI_CEDULA
       AND c.id = cc.id_cliente
       AND cc.id_corporate = PI_ID_CORPORATE;

     IF (vExiste = 0) THEN

         SELECT id into vSec 
         FROM CS_EX_CLIENTES c
         WHERE c.cedula = PI_CEDULA;
         
         
         SELECT CS_EX_SEC_CENTROS_CLIENT.NEXTVAL
         INTO vSecCC
         FROM DUAL;
     
         INSERT INTO CS_EX_CENTROS_CLIENTES VALUES (vSecCC,PI_ID_CORPORATE ,vSec);  
              
     END IF;
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     
    END P_INSERTA_CLIENTE;

    PROCEDURE P_INSERTA_TIPO_MENSAJE(PI_TIPO  IN CS_EX_TIPOS_MENSAJES.TIPO%TYPE,
                                    PI_ID_CORPORATE IN CS_EX_TIPOS_MENSAJES.ID_CORPORATE%TYPE,
                                    PI_RESTRICCION IN CS_EX_TIPOS_MENSAJES.RESTRICCION%TYPE,
                                    PO_ID OUT NUMBER,
                                    PO_ERROR OUT NVARCHAR2
                                    ) 
    IS
      vSec CS_EX_TIPOS_MENSAJES.ID%TYPE;
    BEGIN
     
     SELECT CS_EX_SEC_TIPOS_MENSAJES.NEXTVAL
     INTO vSec
     FROM DUAL;

    
     INSERT INTO CS_EX_TIPOS_MENSAJES (ID, TIPO,ID_CORPORATE,RESTRICCION) VALUES (vSec,PI_TIPO,PI_ID_CORPORATE,PI_RESTRICCION);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     
    END P_INSERTA_TIPO_MENSAJE;
   
                          
   PROCEDURE P_INSERTA_ESTATUS_MENSAJE(PI_ID_MENSAJE IN CS_EX_ESTATUS_MENSAJES.ID_MENSAJE%TYPE,
                                       PI_ID_ESTATUS IN CS_EX_ESTATUS_MENSAJES.ID_ESTATUS%TYPE,
                                       PI_LOTE       IN CS_EX_ESTATUS_MENSAJES.LOTE%TYPE,
                                       PO_ID OUT NUMBER,
                                       PO_ERROR OUT NVARCHAR2
                                      ) 
    IS
      vSec CS_EX_ESTATUS_MENSAJES.ID%TYPE;
    BEGIN
     
     SELECT CS_EX_SEC_ESTATUS_MENSAJES.NEXTVAL
     INTO vSec
     FROM DUAL;

    
     INSERT INTO CS_EX_ESTATUS_MENSAJES VALUES (vSec,PI_ID_MENSAJE,PI_ID_ESTATUS,SYSDATE,PI_LOTE);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     
    END P_INSERTA_ESTATUS_MENSAJE;

    PROCEDURE P_INSERTA_ESTATUS(PI_DESCRIPCION      IN CS_EX_ESTATUS.DESCRIPCION%TYPE,
                               PI_CODIGO_PROVEEDOR IN CS_EX_ESTATUS.CODIGO_PROVEEDOR%TYPE,
                               PI_ID_PROVEEDOR     IN CS_EX_ESTATUS.ID_PROVEEDOR%TYPE,
                               PO_ID OUT NUMBER,
                               PO_ERROR OUT NVARCHAR2
                               ) 
    IS
    vSec CS_EX_ESTATUS.ID%TYPE;
    BEGIN
     
     SELECT CS_EX_SEC_ESTATUS.NEXTVAL
     INTO vSec
     FROM DUAL;

    
     INSERT INTO CS_EX_ESTATUS VALUES (vSec,PI_DESCRIPCION,PI_CODIGO_PROVEEDOR,PI_ID_PROVEEDOR);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     
    END P_INSERTA_ESTATUS;


   PROCEDURE P_INSERTA_MENSAJE(PI_FECHA           IN CS_EX_MENSAJES.FECHA%TYPE,
                              PI_ID_TIPO_MENSAJE IN CS_EX_MENSAJES.ID_TIPO_MENSAJE%TYPE,
                              PI_ID_CLIENTE      IN CS_EX_MENSAJES.ID_CLIENTE%TYPE,
                              PI_CONTENIDO       IN CS_EX_MENSAJES.CONTENIDO%TYPE,
                              PI_ID_PLANTILLA      IN CS_EX_MENSAJES.ID_PLANTILLA%TYPE,
                              PO_ID OUT NUMBER,
                              PO_ERROR OUT NVARCHAR2
                              ) 
    IS
    vSec CS_EX_MENSAJES.ID%TYPE;
    BEGIN
     
     SELECT CS_EX_SEC_MENSAJES.NEXTVAL
     INTO vSec
     FROM DUAL;

    
     INSERT INTO CS_EX_MENSAJES  VALUES (vSec,SYSDATE,PI_ID_TIPO_MENSAJE,PI_ID_CLIENTE, PI_CONTENIDO,PI_ID_PLANTILLA);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     
    END P_INSERTA_MENSAJE;

    FUNCTION F_ELIMINA_LOTE(PI_ID IN CS_EX_LOTES.ID%TYPE,
                            PO_ERROR OUT NVARCHAR2
                            ) 
    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM CS_EX_MENSAJES m WHERE m.ID = PI_ID;
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
    END F_ELIMINA_LOTE;

    FUNCTION F_ELIMINA_TIPO_MENSAJE(PI_ID IN CS_EX_TIPOS_MENSAJES.ID%TYPE,
                                    PO_ERROR OUT NVARCHAR2
                                    )

    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM CS_EX_TIPOS_MENSAJES tp WHERE tp.ID = PI_ID;
     
     PO_ERROR := NULL;
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
      PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
    END F_ELIMINA_TIPO_MENSAJE;

    FUNCTION F_ELIMINA_CLIENTE(PI_ID IN CS_EX_CLIENTES.ID%TYPE,
                               PO_ERROR OUT NVARCHAR2
                               )
    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM CS_EX_CLIENTES c WHERE c.ID = PI_ID;
     
    PO_ERROR := NULL;
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
      PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
      
    END F_ELIMINA_CLIENTE;

    FUNCTION F_ELIMINA_PROVEEDOR(PI_ID IN CS_EX_PROVEEDORES.ID%TYPE,
                                 PO_ERROR OUT NVARCHAR2
                                 )
    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM CS_EX_PROVEEDORES p WHERE p.ID = PI_ID;
     
    PO_ERROR := NULL;
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
      PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
      
    END F_ELIMINA_PROVEEDOR;
                             
    FUNCTION F_ELIMINA_CENTRO_SALUD(PI_ID IN CS_EX_CENTROS_SALUD.ID_CORPORATE%TYPE,
                                PO_ERROR OUT NVARCHAR2
                                )
    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM CS_EX_CENTROS_SALUD a WHERE a.ID_CORPORATE = PI_ID;
     
    PO_ERROR := NULL;
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
      PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
      
    END F_ELIMINA_CENTRO_SALUD;

    FUNCTION F_ELIMINA_ESTATUS_MENSAJE(PI_ID IN CS_EX_ESTATUS_MENSAJES.ID%TYPE,
                                       PO_ERROR OUT NVARCHAR2
                                       )
    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM CS_EX_ESTATUS_MENSAJES em WHERE em.ID = PI_ID;
     
    PO_ERROR := NULL;
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
      PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
      
    END F_ELIMINA_ESTATUS_MENSAJE;

    FUNCTION F_ELIMINA_ESTATUS(PI_ID IN CS_EX_ESTATUS.ID%TYPE,
                               PO_ERROR OUT NVARCHAR2
                               )
    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM CS_EX_ESTATUS e WHERE e.ID = PI_ID;
     
    PO_ERROR := NULL;
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
      PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
      
    END F_ELIMINA_ESTATUS;

    FUNCTION F_ELIMINA_MENSAJE(PI_ID IN CS_EX_MENSAJES.ID%TYPE,
                               PO_ERROR OUT NVARCHAR2
                               )
    RETURN NUMBER
    IS
    BEGIN
     
     DELETE FROM CS_EX_MENSAJES m WHERE m.ID = PI_ID;
     
     PO_ERROR := NULL;
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
      PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
      
    END F_ELIMINA_MENSAJE;

   FUNCTION F_ACTUALIZA_TIPO_MENSAJE(PI_ID          IN CS_EX_TIPOS_MENSAJES.ID%TYPE,   
                                     PI_ID_CORPORATE IN CS_EX_TIPOS_MENSAJES.ID_CORPORATE%TYPE,
                                     PI_RESTRICCION IN CS_EX_TIPOS_MENSAJES.RESTRICCION%TYPE,
                                     PO_ERROR OUT NVARCHAR2                                     
                                     ) RETURN NUMBER
    IS
    BEGIN
     
     UPDATE CS_EX_TIPOS_MENSAJES tm 
     SET tm.RESTRICCION = PI_RESTRICCION,tm.ID_CORPORATE = PI_ID_CORPORATE
     WHERE tm.ID = PI_ID;  
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
    END F_ACTUALIZA_TIPO_MENSAJE;
                                     

   FUNCTION F_ACTUALIZA_CLIENTE(PI_ID        IN CS_EX_CLIENTES.ID%TYPE,
                                PI_CEDULA    IN CS_EX_CLIENTES.CEDULA%TYPE,
                                PI_NOMBRE    IN CS_EX_CLIENTES.NOMBRE%TYPE,
                                PI_CELULAR   IN CS_EX_CLIENTES.CELULAR%TYPE,
                                PI_DIRECCION IN CS_EX_CLIENTES.DIRECCION%TYPE,
                                PI_EMAIL     IN CS_EX_CLIENTES.EMAIL%TYPE,
                                PO_ERROR OUT NVARCHAR2                                     
                                ) RETURN NUMBER
    IS
    BEGIN
     
     UPDATE CS_EX_CLIENTES c 
     SET c.CEDULA = PI_CEDULA,c.NOMBRE = PI_NOMBRE,c.CELULAR = PI_CELULAR,c.DIRECCION = PI_DIRECCION,c.EMAIL = PI_EMAIL 
     WHERE c.ID = PI_ID;  
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
   END F_ACTUALIZA_CLIENTE;

  FUNCTION F_ACTUALIZA_PROVEEDOR(PI_ID        IN CS_EX_PROVEEDORES.ID%TYPE,
                                 PI_NOMBRE    IN CS_EX_PROVEEDORES.NOMBRE%TYPE,
                                 PI_RIF       IN CS_EX_PROVEEDORES.RIF%TYPE,
                                 PI_TELEFONO  IN CS_EX_PROVEEDORES.TELEFONO%TYPE,
                                 PI_DIRECCION IN CS_EX_PROVEEDORES.DIRECCION%TYPE,
                                 PI_EMAIL     IN CS_EX_PROVEEDORES.EMAIL%TYPE,
                                 PO_ERROR OUT NVARCHAR2                                     
                                 ) RETURN NUMBER
    IS
    BEGIN
     
     UPDATE CS_EX_PROVEEDORES p 
     SET p.NOMBRE = PI_NOMBRE,p.RIF = PI_RIF,p.TELEFONO = PI_TELEFONO,p.DIRECCION = PI_DIRECCION,p.EMAIL = PI_EMAIL 
     WHERE p.ID = PI_ID;  
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
   END F_ACTUALIZA_PROVEEDOR;
                             
  FUNCTION F_ACTUALIZA_CENTRO_SALUD(PI_ID        IN CS_EX_CENTROS_SALUD.ID_CORPORATE%TYPE,
                                PI_NOMBRE    IN CS_EX_CENTROS_SALUD.NOMBRE%TYPE,
                                PI_TELEFONO  IN CS_EX_CENTROS_SALUD.TELEFONO%TYPE,
                                PI_DIRECCION IN CS_EX_CENTROS_SALUD.DIRECCION%TYPE,
                                PI_EMAIL      IN CS_EX_CENTROS_SALUD.EMAIL%TYPE,
                                PO_ERROR OUT NVARCHAR2                                     
                                ) RETURN NUMBER
    IS
    BEGIN
     
     UPDATE CS_EX_CENTROS_SALUD p 
     SET p.NOMBRE = PI_NOMBRE,p.TELEFONO = PI_TELEFONO,p.DIRECCION = PI_DIRECCION,p.EMAIL = PI_EMAIL 
     WHERE p.ID_CORPORATE = PI_ID;  
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
   END F_ACTUALIZA_CENTRO_SALUD;

  FUNCTION F_ACTUALIZA_ESTATUS_MENSAJE(PI_ID         IN CS_EX_ESTATUS_MENSAJES.ID%TYPE,
                                       PI_ID_MENSAJE IN CS_EX_ESTATUS_MENSAJES.ID_MENSAJE%TYPE,
                                       PI_ID_ESTATUS IN CS_EX_ESTATUS_MENSAJES.ID_ESTATUS%TYPE,
                                       PI_FECHA      IN CS_EX_ESTATUS_MENSAJES.FECHA%TYPE, 
                                       PI_LOTE       IN CS_EX_ESTATUS_MENSAJES.LOTE%TYPE,
                                       PO_ERROR OUT NVARCHAR2                                                                            
                                       ) RETURN NUMBER
    IS
    BEGIN
     
     UPDATE CS_EX_ESTATUS_MENSAJES em 
     SET em.ID_MENSAJE = PI_ID_MENSAJE,em.ID_ESTATUS = PI_ID_ESTATUS,em.FECHA = PI_FECHA,em.LOTE = PI_LOTE
     WHERE em.ID = PI_ID;  
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
   END F_ACTUALIZA_ESTATUS_MENSAJE;

  FUNCTION F_ACTUALIZA_ESTATUS(PI_ID               IN CS_EX_ESTATUS.ID%TYPE,
                               PI_DESCRIPCION      IN CS_EX_ESTATUS.DESCRIPCION%TYPE,
                               PI_CODIGO_PROVEEDOR IN CS_EX_ESTATUS.CODIGO_PROVEEDOR%TYPE,
                               PI_ID_PROVEEDOR     IN CS_EX_ESTATUS.ID_PROVEEDOR%TYPE,
                               PO_ERROR OUT NVARCHAR2                                     
                               ) RETURN NUMBER
    IS
    BEGIN
     
     UPDATE CS_EX_ESTATUS e 
     SET e.DESCRIPCION = PI_DESCRIPCION,e.CODIGO_PROVEEDOR = PI_CODIGO_PROVEEDOR,e.ID_PROVEEDOR = PI_ID_PROVEEDOR
     WHERE e.ID = PI_ID;  
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
   END F_ACTUALIZA_ESTATUS;

  FUNCTION F_ACTUALIZA_MENSAJE(PI_ID              IN CS_EX_MENSAJES.ID%TYPE,
                               PI_FECHA           IN CS_EX_MENSAJES.FECHA%TYPE,
                               PI_ID_TIPO_MENSAJE IN CS_EX_MENSAJES.ID_TIPO_MENSAJE%TYPE,
                               PI_ID_CLIENTE      IN CS_EX_MENSAJES.ID_CLIENTE%TYPE,
                               PO_ERROR OUT NVARCHAR2                                                                   
                               ) RETURN NUMBER
      IS
    BEGIN
     
     UPDATE CS_EX_MENSAJES m 
     SET m.FECHA = PI_FECHA,m.ID_TIPO_MENSAJE = PI_ID_TIPO_MENSAJE,m.ID_CLIENTE = PI_ID_CLIENTE
     WHERE m.ID = PI_ID;  
     
     RETURN (1);
    EXCEPTION
     WHEN OTHERS THEN
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
      RETURN (0);
     
   END F_ACTUALIZA_MENSAJE;

   FUNCTION F_LISTAR_LOTE_X_ESTATUS(PI_ID_LOTE IN CS_EX_LOTES.ID%TYPE,
                                    PI_ID_ESTATUS IN CS_EX_ESTATUS.ID%TYPE,
                                    PI_ID_PROVEEDOR IN CS_EX_PROVEEDORES.ID%TYPE,
                                    PO_ERROR OUT NVARCHAR2                                                                   
   ) 
   RETURN RESULSET
   IS
     vCursor RESULSET;

    BEGIN
     
    OPEN vCursor FOR
     SELECT l.ID, l.FECHA, count(*) cantidad
     FROM CS_EX_LOTES l, CS_EX_estatus_mensajes em, CS_EX_ESTATUS e
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

   FUNCTION F_BUSCA_TIPO_MENSAJE(PI_ID IN CS_EX_TIPOS_MENSAJES.ID%TYPE,
                                 PO_ERROR OUT NVARCHAR2                                                                   
                                 ) 
   RETURN RESULSET
   IS
     vCursor RESULSET;

    BEGIN
   
    OPEN vCursor FOR  
     SELECT * 
     FROM CS_EX_TIPOS_MENSAJES tm  
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

  FUNCTION F_LISTAR_CLIENTE(PI_ID IN CS_EX_CLIENTES.ID%TYPE, 
                            PI_CEDULA IN CS_EX_CLIENTES.CEDULA%TYPE,
                            PI_CELULAR IN CS_EX_CLIENTES.CELULAR%TYPE,
                            PI_ID_CORPORATE IN CS_EX_CENTROS_CLIENTES.ID_CORPORATE%TYPE, 
                            PO_ERROR OUT NVARCHAR2
                            ) RETURN RESULSET
   IS
     vCursor RESULSET;
    BEGIN
     
     OPEN vCursor FOR 
     SELECT * 
     FROM CS_EX_CLIENTES c,CS_EX_CENTROS_CLIENTES cc  
     WHERE ((PI_ID IS NOT NULL AND c.ID = PI_ID) OR PI_ID IS NULL) 
      AND  c.cedula = NVL (PI_CEDULA, c.cedula)
      AND  c.celular = NVL (PI_CELULAR, c.celular)
      AND  c.id = cc.id_cliente
      AND  cc.id_corporate = PI_ID_CORPORATE;
            
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

   FUNCTION F_LISTAR_PROVEEDOR(PI_ID IN CS_EX_PROVEEDORES.ID%TYPE,
                              PI_RIF IN CS_EX_PROVEEDORES.ID%TYPE,    
                              PO_ERROR OUT NVARCHAR2
   ) RETURN RESULSET
   IS
     vCursor RESULSET;

    BEGIN

     OPEN vCursor FOR      
     SELECT * 
     FROM CS_EX_PROVEEDORES p  
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
                             
  FUNCTION F_LISTAR_CENTRO_SALUD(PI_ID IN CS_EX_CENTROS_SALUD.ID_CORPORATE%TYPE,
                            PI_NOMBRE IN CS_EX_CENTROS_SALUD.NOMBRE%TYPE,
                            PO_ERROR OUT NVARCHAR2
                            ) RETURN RESULSET
   IS
     vCursor RESULSET;

    BEGIN

     OPEN vCursor FOR           
     SELECT *
     FROM CS_EX_CENTROS_SALUD a  
     WHERE ((PI_ID IS NOT NULL AND a.ID_CORPORATE = PI_ID) OR PI_ID IS NULL)
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
     
   END F_LISTAR_CENTRO_SALUD;

   FUNCTION F_LISTAR_ESTATUS_MENSAJE(PI_ID_EST_MENSAJE IN CS_EX_ESTATUS_MENSAJES.ID%TYPE,
                                     PI_ID_ESTATUS IN CS_EX_ESTATUS_MENSAJES.ID_ESTATUS%TYPE,
                                     PI_FECHA      IN CS_EX_ESTATUS_MENSAJES.FECHA%TYPE,
                                     PI_LOTE       IN CS_EX_ESTATUS_MENSAJES.LOTE%TYPE,
                                     PO_ERROR OUT NVARCHAR2   
   ) RETURN RESULSET
   IS
     vCursor RESULSET;

    BEGIN

     OPEN vCursor FOR                
     SELECT * 
     FROM CS_EX_ESTATUS_MENSAJES l  
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

   FUNCTION F_LISTAR_ESTATUS(PI_ID_ESTATUS IN CS_EX_ESTATUS.ID%TYPE,
                             PI_ID_PROVEEDOR CS_EX_ESTATUS.ID_PROVEEDOR%TYPE,
                             PO_ERROR OUT NVARCHAR2   
                             ) 
   RETURN RESULSET
   IS
     vCursor RESULSET;

    BEGIN
     
     OPEN vCursor FOR           
     SELECT * 
     FROM CS_EX_ESTATUS e  
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

   FUNCTION F_LISTAR_MENSAJES(PI_ID IN CS_EX_MENSAJES.ID%TYPE,
                              PI_FECHA IN CS_EX_MENSAJES.FECHA%TYPE,
                              PI_ID_TIPO_MENSAJE IN CS_EX_MENSAJES.ID_TIPO_MENSAJE%TYPE,
                              PI_ID_CLIENTE IN CS_EX_MENSAJES.ID_CLIENTE%TYPE,
                              PI_ID_ESTATUS IN CS_EX_ESTATUS.ID%TYPE,
                              PO_ERROR OUT NVARCHAR2   
                              ) 
   RETURN RESULSET                         
   IS
     vCursor RESULSET;

    BEGIN

     OPEN vCursor FOR                
   SELECT em.ID id_est_mensaje,s.ID id_estatus,s.DESCRIPCION,m.FECHA as FECHA_MENSAJE,em.FECHA as FECHA_ESTATUS,em.LOTE,s.CODIGO_PROVEEDOR, c.NOMBRE, c.CELULAR, m.CONTENIDO, m.ID id_mensaje, c.EMAIL
  FROM cs_ex_mensajes m 
  JOIN cs_ex_estatus_mensajes em ON m.ID = em.id_mensaje
  JOIN CS_EX_ESTATUS s ON em.ID_ESTATUS = s.ID  
  JOIN CS_EX_TIPOS_MENSAJES tp  ON  m.ID_TIPO_MENSAJE = tp.ID 
  JOIN CS_EX_CLIENTES c ON m.ID_CLIENTE = c.ID      
     AND em.fecha IN (SELECT MAX (em2.fecha)
                        FROM cs_ex_estatus_mensajes em2
                       WHERE em2.id_mensaje = m.ID)
     AND ((PI_ID IS NOT NULL AND m.ID = PI_ID) OR PI_ID IS NULL)
     AND trunc(m.FECHA) = NVL(trunc(PI_FECHA),trunc(m.FECHA))
     AND ((PI_ID_TIPO_MENSAJE IS NOT NULL AND m.ID_TIPO_MENSAJE = PI_ID_TIPO_MENSAJE) OR PI_ID_TIPO_MENSAJE IS NULL)
     AND ((PI_ID_CLIENTE IS NOT NULL AND m.ID_CLIENTE = PI_ID_CLIENTE) OR PI_ID_CLIENTE IS NULL)
     AND s.ID = PI_ID_ESTATUS;
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

   PROCEDURE P_INSERTA_UNIDAD(PI_NOMBRE IN CS_EX_UNIDAD.NOMBRE%TYPE,PO_ID OUT NUMBER,PO_ERROR OUT NVARCHAR2)
    IS
      vSec CS_EX_UNIDAD.ID%TYPE;
   BEGIN

     SELECT CS_EX_SEC_UNIDAD.NEXTVAL
     INTO vSec
     FROM DUAL;
     
     INSERT INTO CS_EX_UNIDAD VALUES (vSec, PI_NOMBRE);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
   END P_INSERTA_UNIDAD;

   FUNCTION F_BUSCAR_UNIDAD(PI_ID IN CS_EX_UNIDAD.ID%TYPE,
                            PI_NOMBRE IN CS_EX_UNIDAD.NOMBRE%TYPE,    
                            PO_ERROR OUT NVARCHAR2
   ) RETURN RESULSET
   IS
     vCursor RESULSET;

    BEGIN

     OPEN vCursor FOR      
     SELECT * 
     FROM CS_EX_UNIDAD u  
     WHERE ((PI_ID IS NOT NULL AND u.ID = PI_ID) OR PI_ID IS NULL)
        AND UPPER(u.NOMBRE) = UPPER(NVL(PI_NOMBRE,u.NOMBRE));  
     
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
     
   END F_BUSCAR_UNIDAD;

  FUNCTION F_ARMAR_SMS(PI_TIPO_MENSAJE IN CS_EX_PLANTILLAS.ID_TIPO_MENSAJE%TYPE,
                       PI_ID_CLIENTE IN CS_EX_CLIENTES.ID%TYPE,    
                       PI_SERVICIO IN CS_EX_UNIDAD.ID%TYPE,
                       PI_FECHA IN DATE
   ) RETURN VARCHAR
   IS
    vCadena NVARCHAR2(200);
    vContenido cs_ex_plantillas.contenido%type;
    vSql VARCHAR(200);
    CURSOR vCursor IS select nombre_campo, nombre_tabla, clave,tipo_parametro from cs_ex_param_plantilla where id_plantilla = 1;
    vCampo cs_ex_param_plantilla.NOMBRE_CAMPO%type;
    vTabla cs_ex_param_plantilla.NOMBRE_TABLA%type;
    vTipoParam cs_ex_param_plantilla.TIPO_PARAMETRO%type;
    auxTabla cs_ex_param_plantilla.NOMBRE_TABLA%type;
    vClave cs_ex_param_plantilla.CLAVE%type; 
    auxClave cs_ex_param_plantilla.CLAVE%type; 
    vServicio cs_ex_unidad.NOMBRE%type;

    vResult NVARCHAR2(300);
  
    begin
    
    select contenido into vContenido 
    from cs_ex_plantillas
    where id_tipo_mensaje = pi_tipo_mensaje;

    select nombre into vServicio 
    from cs_ex_unidad
    where id = PI_SERVICIO;

    vContenido := vContenido || ' FROM ';

   OPEN vCursor;
   LOOP
      FETCH vCursor INTO vCampo, vTabla, vClave, vTipoParam; 
      EXIT WHEN vCursor%NOTFOUND;

      IF (vTipoParam = 'V') THEN
        vContenido := replace(vContenido, '|1' ||vCampo||'|2', vCampo || ' || ');
        auxTabla := vTabla;
        auxClave := vClave;      
      ELSE
        IF (vCampo = 'PI_FECHA') THEN
          vContenido := replace(vContenido, vCampo, PI_FECHA);
        ELSE 
          IF (vCampo = 'PI_UNIDAD') THEN
          vContenido := replace(vContenido, vCampo, vServicio); 
          END IF;
        END IF;
      END IF;

  END LOOP;

  vContenido := replace(vContenido,'|| FROM', ' FROM ');
  
  vSql := 'SELECT ' || vContenido ||' ' || auxTabla || ' WHERE ' || auxClave || ' = ' ||  pi_id_cliente;

  EXECUTE IMMEDIATE vSql INTO vResult;
  
  RETURN vResult;
  
  END F_ARMAR_SMS;

   FUNCTION F_BUSCAR_PARAMETROS(PI_ID_UNIDAD IN CS_EX_UNIDAD.ID%TYPE,
                            PI_ID_TIPO_MENSAJE IN CS_EX_TIPOS_MENSAJES.ID%TYPE,    
                            PO_ERROR OUT NVARCHAR2
   ) RETURN RESULSET
   IS
     vCursor RESULSET;

    BEGIN

     OPEN vCursor FOR      
         SELECT C.ID, C.ID_UNIDAD, U.NOMBRE, C.FRECUENCIA, 
             C.RANGO_INICIO, C.RANGO_FINAL, NVL(C.DIA_SEMANA,0) DIA_SEMANA, 
             C.HORA, C.ID_TIPO_MENSAJE
      FROM CS_EX_PARAMETROS C, CS_EX_UNIDAD U
      WHERE C.ID_UNIDAD = U.ID
      AND C.ID_UNIDAD = NVL(PI_ID_UNIDAD,C.ID_UNIDAD)
      AND C.ID_TIPO_MENSAJE = NVL(PI_ID_TIPO_MENSAJE,C.ID_TIPO_MENSAJE);
     
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
     
   END F_BUSCAR_PARAMETROS;


  PROCEDURE P_INSERTA_MENSAJE_SMS( PI_ID_TIPO_MENSAJE IN CS_EX_TIPOS_MENSAJES.ID%TYPE,
                                   PI_CEDULA          IN CS_EX_CLIENTES.CEDULA%TYPE,
                                   PI_NOMBRE_UNIDAD   IN CS_EX_UNIDAD.NOMBRE%TYPE, 
                                   PO_ID OUT NUMBER,
                                   PO_ERROR OUT NVARCHAR2
                              ) 
    IS
    vSec CS_EX_MENSAJES.ID%TYPE;
    vId CS_EX_CLIENTES.ID%type;
    vContenido CS_EX_MENSAJES.CONTENIDO%TYPE;
    vIdPlantilla CS_EX_MENSAJES.ID_PLANTILLA%TYPE;
    vIdUnidad CS_EX_UNIDAD.ID%TYPE;
    BEGIN
     
     BEGIN
         SELECT c.id 
         INTO vId
         FROM CS_EX_CLIENTES c
         WHERE c.cedula = PI_CEDULA;
     EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     END;
     
     BEGIN
         SELECT u.id 
         INTO vIdUnidad
         FROM CS_EX_UNIDAD u
         WHERE UPPER(u.nombre) = UPPER(PI_NOMBRE_UNIDAD);
     EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     END;

     BEGIN
         SELECT p.id 
         INTO vIdPlantilla
         FROM CS_EX_PLANTILLAS p
         WHERE p.id_tipo_mensaje =  PI_ID_TIPO_MENSAJE;
     EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     END;
        
     SELECT CS_EX_SEC_MENSAJES.NEXTVAL 
     INTO vSec
     FROM DUAL;
     
     vContenido := F_ARMAR_SMS(PI_ID_TIPO_MENSAJE,vId,vIdUnidad,SYSDATE);
    
     INSERT INTO CS_EX_MENSAJES  VALUES (vSec,SYSDATE,PI_ID_TIPO_MENSAJE,vId, vContenido,vIdPlantilla);  
     
     PO_ID := vSec;
     PO_ERROR := NULL;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
     
    END P_INSERTA_MENSAJE_SMS;


    
        
END PKG_SMS;
/

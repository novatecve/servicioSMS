CREATE OR REPLACE PACKAGE ORDERHANDLER.PKG_SMS AS
/******************************************************************************
   NAME:       PKG_SMS
   PURPOSE:    CONTIENE LAS FUNCIONES Y PROCEDIMIENTOS PARA ENVIO DE MENSAJES 

******************************************************************************/
  TYPE RESULSET IS REF CURSOR;

  PROCEDURE P_INSERTA_LOTE(PO_ID OUT NUMBER,PO_ERROR OUT NVARCHAR2);

  PROCEDURE P_INSERTA_AFILIADO(PI_NOMBRE    IN CS_EX_CENTROS_SALUD.NOMBRE%TYPE,
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

  PROCEDURE P_INSERTA_TIPO_MENSAJE(PI_CONTENIDO   IN SMS_TIPOS_MENSAJES.CONTENIDO%TYPE, 
                                   PI_ID_CORPORATE IN CS_EX_TIPOS_MENSAJES.ID_CORPORATE%TYPE,
                                   PO_ID OUT NUMBER,
                                   PO_ERROR OUT NVARCHAR2
                                   );
                             
  PROCEDURE P_INSERTA_ESTATUS_MENSAJE(PI_ID_MENSAJE IN CS_EX_ESTATUS_MENSAJES.ID_MENSAJE%TYPE,
                                      PI_ID_ESTATUS IN CS_EX_ESTATUS_MENSAJES.ID_ESTATUS%TYPE,
                                      PI_FECHA      IN CS_EX_ESTATUS_MENSAJES.FECHA%TYPE, 
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
                              PO_ID OUT NUMBER,
                              PO_ERROR OUT NVARCHAR2
                              );
                               
  FUNCTION F_ELIMINA_LOTE(PI_ID IN CS_EX_LOTES.ID%TYPE,
                          PO_ERROR OUT NVARCHAR2
                          ) RETURN NUMBER;

  FUNCTION F_ELIMINA_TIPO_MENSAJE(PI_ID IN CS_EX_TIPOS_MENSAJES.ID%TYPE,
                                  PO_ERROR OUT NVARCHAR2
                                  ) RETURN NUMBER;

  FUNCTION F_ELIMINA_CLIENTE(PI_ID IN CLIENTES.ID%TYPE,
                             PO_ERROR OUT NVARCHAR2
                             ) RETURN NUMBER;

  FUNCTION F_ELIMINA_PROVEEDOR(PI_ID IN PROVEEDORES.ID%TYPE,
                               PO_ERROR OUT NVARCHAR2
                               ) RETURN NUMBER;
                             
  FUNCTION F_ELIMINA_AFILIADO(PI_ID IN CS_EX_CENTROS_SALUD.ID%TYPE,
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
                                    PI_ID_PROVEEDOR IN PROVEEDORES.ID%TYPE,
                                    PO_ERROR OUT NVARCHAR2                                                                   
                                    ) RETURN RESULSET;

   FUNCTION F_BUSCA_TIPO_MENSAJE(PI_ID IN CS_EX_TIPOS_MENSAJES.ID%TYPE,
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
                             
  FUNCTION F_LISTAR_AFILIADO(PI_ID IN CS_EX_CENTROS_SALUD.ID%TYPE,
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
                                    PI_CONTENIDO   IN CS_EX_TIPOS_MENSAJES.CONTENIDO%TYPE, 
                                    PI_ID_CORPORATE IN CS_EX_TIPOS_MENSAJES.ID_CORPORATE%TYPE,
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
                             
  FUNCTION F_ACTUALIZA_AFILIADO(PI_ID        IN CS_EX_CENTROS_SALUD.ID%TYPE,
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
 
END PKG_SMS;
/

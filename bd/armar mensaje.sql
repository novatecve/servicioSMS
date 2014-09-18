declare
  vCadena NVARCHAR2(200);
  vContenido cs_ex_plantillas.contenido%type;
  vSql VARCHAR(200);
  --TYPE RESULSET IS REF CURSOR;
  CURSOR vCursor IS select nombre_campo, nombre_tabla, clave,tipo_parametro from cs_ex_param_plantilla where id_plantilla = 1;
  vCampo cs_ex_param_plantilla.NOMBRE_CAMPO%type;
  vTabla cs_ex_param_plantilla.NOMBRE_TABLA%type;
  vTipoParam cs_ex_param_plantilla.TIPO_PARAMETRO%type;
  auxTabla cs_ex_param_plantilla.NOMBRE_TABLA%type;
  vClave cs_ex_param_plantilla.CLAVE%type; 
  auxClave cs_ex_param_plantilla.CLAVE%type; 

  vResult NVARCHAR2(300);
  
  --Variables de entrada
  pi_tipo_mensaje cs_ex_plantillas.ID_TIPO_MENSAJE%type;
  pi_id_cliente cs_ex_clientes.ID%type;
  PI_FECHA NVARCHAR2(10);
  PI_SERVICIO cs_ex_unidad.ID%type;
  vServicio cs_ex_unidad.NOMBRE%type;

begin
  
  pi_tipo_mensaje := 1;
  pi_id_cliente := 1;
  PI_FECHA :='10/10/2014';
  PI_SERVICIO := 1;
  
  select contenido into vContenido 
  from cs_ex_plantillas
  where id_tipo_mensaje = pi_tipo_mensaje;

  select nombre into vServicio 
  from cs_ex_unidad
  where id = PI_SERVICIO;

  DBMS_OUTPUT.PUT_LINE('vContenido: ' ||vContenido);

  vContenido := vContenido || ' FROM ';

  DBMS_OUTPUT.PUT_LINE('vServicio: ' ||vServicio);
 
  OPEN vCursor;
  LOOP
      FETCH vCursor INTO vCampo, vTabla, vClave, vTipoParam; 
      EXIT WHEN vCursor%NOTFOUND;

  DBMS_OUTPUT.PUT_LINE('vCampo: ' ||vCampo);

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

      --vContenido := replace(vContenido, '''''', '''');      
       
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('vCampo: ' ||vCampo);

  vContenido := replace(vContenido,'|| FROM', ' FROM ');
  
  vSql := 'SELECT ' || vContenido ||' ' || auxTabla || ' WHERE ' || auxClave || ' = ' ||  pi_id_cliente;

  DBMS_OUTPUT.PUT_LINE('1 vSql: ' ||vSql);

  EXECUTE IMMEDIATE vSql INTO vResult;
  
  DBMS_OUTPUT.PUT_LINE('vResult: ' ||vResult);

END;


-----------------------------------

    PROCEDURE P_INSERTA_UNIDAD(PI_NOMBRE IN CS_EX_UNIDAD.NOMBRE%TYPE,PO_ID OUT NUMBER,PO_ERROR OUT NVARCHAR2) 
    IS
      vSec CS_EX_UNIDAD.ID%TYPE;
    BEGIN

     SELECT CS_EX_SEC_UNIDAD.NEXTVAL
     INTO vSec
     FROM DUAL;
     
     SELECT COUNT() INTO vCantidad 
     FROM CS_EX_UNIDAD WHERE NOMBRE = PI_NOMBRE;
     
     IF (vCantidad = 0) THEN
     
         INSERT INTO CS_EX_UNIDAD VALUES (vSec, PI_NOMBRE);  
         
         PO_ID := vSec;
         PO_ERROR := NULL;
     ELSE
       PO_ID := 0;
       PO_ERROR := 'ERROR: LA UNIDAD: '||PI_NOMBRE||'YA EXISTE';              
     END IF;
    EXCEPTION
     WHEN OTHERS THEN
       PO_ID := 0;
       PO_ERROR := 'ERROR: ' || SQLCODE || '|' || SQLERRM;
    END P_INSERTA_UNIDAD;



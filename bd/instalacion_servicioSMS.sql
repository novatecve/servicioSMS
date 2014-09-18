CREATE TABLE "CS_EX_ESTATUS" (

"ID" NUMBER(10) NOT NULL,

"DESCRIPCION" NVARCHAR2(20) NULL,

"CODIGO_PROVEEDOR" NVARCHAR2(20) NULL,

"ID_PROVEEDOR" NUMBER(10) NULL,

CONSTRAINT "PK_CS_EX_ESTATUS" PRIMARY KEY ("ID") 

);



COMMENT ON TABLE "CS_EX_ESTATUS" IS 'CONTIENE LOS POSIBLES ESTADOS EN LOS QUE PUEDE ESTAR UN MENSAJE';

COMMENT ON COLUMN "CS_EX_ESTATUS"."ID" IS 'Identificador del estatus del mensaje';

COMMENT ON COLUMN "CS_EX_ESTATUS"."DESCRIPCION" IS 'Texto del mensaje a enviar';

COMMENT ON COLUMN "CS_EX_ESTATUS"."CODIGO_PROVEEDOR" IS 'Codigo que asigna el proveedor de servicio al estado del mensaje';

COMMENT ON COLUMN "CS_EX_ESTATUS"."ID_PROVEEDOR" IS 'Identificador del proveedor de servicios';



CREATE TABLE "CS_EX_CENTROS_SALUD" (

"ID_CORPORATE" NUMBER(10) NOT NULL,

"NOMBRE" NVARCHAR2(50) NULL,

"TELEFONO" NVARCHAR2(14) NULL,

"DIRECCION" NVARCHAR2(300) NULL,

"EMAIL" NVARCHAR2(50) NULL,

CONSTRAINT "PK_CS_EX_CENTROS_SALUD" PRIMARY KEY ("ID_CORPORATE") 

);



COMMENT ON TABLE "CS_EX_CENTROS_SALUD" IS 'CONTIENE LOS CENTROS DE SALUS, TALES COMO CLINICAS, HOSPITALES, ETC

';

COMMENT ON COLUMN "CS_EX_CENTROS_SALUD"."ID_CORPORATE" IS 'Identificador del centro de salud';

COMMENT ON COLUMN "CS_EX_CENTROS_SALUD"."NOMBRE" IS 'Nombre del centro de salu';

COMMENT ON COLUMN "CS_EX_CENTROS_SALUD"."TELEFONO" IS 'Telefono del centro de salud';

COMMENT ON COLUMN "CS_EX_CENTROS_SALUD"."DIRECCION" IS 'Direccion del centro de salud';

COMMENT ON COLUMN "CS_EX_CENTROS_SALUD"."EMAIL" IS 'Email del centro de salus';



CREATE TABLE "CS_EX_TIPOS_MENSAJES" (

"ID" NUMBER(10) NOT NULL,

"TIPO" NVARCHAR2(10) NULL,

"ID_CORPORATE" NUMBER(10) NULL,

"RESTRICCION" NUMBER(5) NULL,

CONSTRAINT "PK_CS_EX_TIPOS_MENSAJES" PRIMARY KEY ("ID") 

);



COMMENT ON TABLE "CS_EX_TIPOS_MENSAJES" IS 'CONTIENE LA CLASIFICACION DE LOS MENSAJES QUE PUEDE SE PUEDEN ENVIAR';

COMMENT ON COLUMN "CS_EX_TIPOS_MENSAJES"."ID" IS 'Identificador del mensaje';

COMMENT ON COLUMN "CS_EX_TIPOS_MENSAJES"."TIPO" IS 'TIPO DE MENSAJE (SMS, EMAIL)';

COMMENT ON COLUMN "CS_EX_TIPOS_MENSAJES"."ID_CORPORATE" IS 'IDENTIFICADOR DEL CENTRO DE SALUD AL CUAL PERTENECE EL MENSAJE';

COMMENT ON COLUMN "CS_EX_TIPOS_MENSAJES"."RESTRICCION" IS 'CANTIDAD DE CARACTERES MAXIMO QUE SE PUEDEN ENVIAR';



CREATE TABLE "CS_EX_PROVEEDORES" (

"ID" NUMBER(10) NOT NULL,

"NOMBRE" NVARCHAR2(255) NULL,

"RIF" NVARCHAR2(10) NULL,

"TELEFONO" NVARCHAR2(14) NULL,

"DIRECCION" NVARCHAR2(500) NULL,

"EMAIL" NVARCHAR2(50) NULL,

PRIMARY KEY ("ID") 

);



CREATE TABLE "CS_EX_MENSAJES" (

"ID" NUMBER(10) NOT NULL,

"FECHA" DATE NULL,

"ID_TIPO_MENSAJE" NUMBER(10) NULL,

"ID_CLIENTE" NUMBER(10) NULL,

"CONTENIDO" NVARCHAR2(2000) NULL,

"ID_PLANTILLA" NUMBER NULL,

CONSTRAINT "PK_EX_MENSAJES" PRIMARY KEY ("ID") 

);



COMMENT ON TABLE "CS_EX_MENSAJES" IS 'CONTIENE LOS MENSAJES A ENVIAR, ENVIADO Y FALLIDOS O POR REENVIAR';

COMMENT ON COLUMN "CS_EX_MENSAJES"."ID" IS 'Identificador del mensaje que sera enviado';

COMMENT ON COLUMN "CS_EX_MENSAJES"."FECHA" IS 'Fecha de envio del mensaje';

COMMENT ON COLUMN "CS_EX_MENSAJES"."ID_TIPO_MENSAJE" IS 'Identificador del tipo de mensaje que sera enviado';

COMMENT ON COLUMN "CS_EX_MENSAJES"."ID_CLIENTE" IS 'Identificador del cliente al cual se le enviara el mensaje';

COMMENT ON COLUMN "CS_EX_MENSAJES"."CONTENIDO" IS 'TEXTO DEL MENSAJE';

COMMENT ON COLUMN "CS_EX_MENSAJES"."ID_PLANTILLA" IS 'IDETIFICADOR DE LA PLANTILLA DEL MENSAJE';



CREATE TABLE "CS_EX_LOTES" (

"ID" NUMBER(10) NOT NULL,

"FECHA" DATE NULL,

CONSTRAINT "PK_CS_EX_LOTES" PRIMARY KEY ("ID") 

);



COMMENT ON COLUMN "CS_EX_LOTES"."ID" IS 'Identificador del lote';

COMMENT ON COLUMN "CS_EX_LOTES"."FECHA" IS 'Fecha de envio del lote';



CREATE TABLE "CS_EX_CLIENTES" (

"ID" NUMBER(10) NOT NULL,

"CEDULA" NUMBER(10) NULL,

"NOMBRE" NVARCHAR2(50) NULL,

"CELULAR" NVARCHAR2(14) NULL,

"DIRECCION" NVARCHAR2(300) NULL,

"EMAIL" NVARCHAR2(50) NULL,

"FECHA" DATE NULL,

CONSTRAINT "PK_CS_EX_CLIENTES" PRIMARY KEY ("ID") 

);



COMMENT ON TABLE "CS_EX_CLIENTES" IS 'CONTIENE LOS DATOS BASICO DEL CLIENTE';

COMMENT ON COLUMN "CS_EX_CLIENTES"."ID" IS 'IDENTIFICADOR DEL CLIENTE';

COMMENT ON COLUMN "CS_EX_CLIENTES"."CEDULA" IS 'CEDULA DEL CLIENTE';

COMMENT ON COLUMN "CS_EX_CLIENTES"."NOMBRE" IS 'NOMBRE DEL CLIENTE';

COMMENT ON COLUMN "CS_EX_CLIENTES"."CELULAR" IS 'CELULAR DEL CLIENTE';

COMMENT ON COLUMN "CS_EX_CLIENTES"."DIRECCION" IS 'DIRECCION DEL CLIENTE';

COMMENT ON COLUMN "CS_EX_CLIENTES"."EMAIL" IS 'EMAIL DEL CLIENTE';

COMMENT ON COLUMN "CS_EX_CLIENTES"."FECHA" IS 'FECHA DE CREACION O ACTULIZACION DE DATOS';



CREATE TABLE "CS_EX_ESTATUS_MENSAJES" (

"ID" NUMBER(10) NOT NULL,

"ID_MENSAJE" NUMBER(10) NULL,

"ID_ESTATUS" NUMBER(10) NULL,

"FECHA" DATE NULL,

"LOTE" NUMBER(10) NULL,

CONSTRAINT "PK_CS_EX_EST_MENSAJES" PRIMARY KEY ("ID") 

);



COMMENT ON TABLE "CS_EX_ESTATUS_MENSAJES" IS 'CONTIENE EL CICLO DE VIDA DE LOS MENSAJES';

COMMENT ON COLUMN "CS_EX_ESTATUS_MENSAJES"."ID" IS 'Numero de secuencia de los  posibles estados del mensaje';

COMMENT ON COLUMN "CS_EX_ESTATUS_MENSAJES"."ID_MENSAJE" IS 'Identificador del mensaje ';

COMMENT ON COLUMN "CS_EX_ESTATUS_MENSAJES"."ID_ESTATUS" IS 'Identificador del estado del mensaje';

COMMENT ON COLUMN "CS_EX_ESTATUS_MENSAJES"."FECHA" IS 'Fecha de envio del mensaje';

COMMENT ON COLUMN "CS_EX_ESTATUS_MENSAJES"."LOTE" IS 'Numero de lote utilizado para envios masivo';



CREATE TABLE "CS_EX_PARAMETROS" (

"ID" NUMBER NOT NULL,

"ID_UNIDAD" NUMBER NULL,

"FRECUENCIA" NUMBER NULL,

"RANGO_INICIO" DATE NULL,

"RANGO_FINAL" DATE NULL,

"DIA_SEMANA" NUMBER NULL,

"HORA" TIMESTAMP(0) NULL,

"ID_TIPO_MENSAJE" VARCHAR2(255) NULL,

CONSTRAINT "PK_CS_EX_PARAMETROS" PRIMARY KEY ("ID") 

);



COMMENT ON TABLE "CS_EX_PARAMETROS" IS 'CONTIENE LOS PARAMETROS DE CONFIGURACION DEL MENSAJE';

COMMENT ON COLUMN "CS_EX_PARAMETROS"."ID" IS 'IDENTIFICADOR DE PARAMETROS DE CONFIGURACION';

COMMENT ON COLUMN "CS_EX_PARAMETROS"."ID_UNIDAD" IS 'IDENTIFICADOR DEL SERVICIO';

COMMENT ON COLUMN "CS_EX_PARAMETROS"."FRECUENCIA" IS 'CANTIDAD DE DIAS ANTES DE ENVIA EL MENSAJE';

COMMENT ON COLUMN "CS_EX_PARAMETROS"."RANGO_INICIO" IS 'FECHA INICIAL DE ENVIO DEL MENSAJE';

COMMENT ON COLUMN "CS_EX_PARAMETROS"."RANGO_FINAL" IS 'FECHA FINALIZACION DEL ENVIO DE MENSAJES';

COMMENT ON COLUMN "CS_EX_PARAMETROS"."DIA_SEMANA" IS 'DIA EN PARTICULAR QUE SE DESEA QUE SE ENVIE EL MENSAJE';

COMMENT ON COLUMN "CS_EX_PARAMETROS"."HORA" IS 'HORA DE ENVIO DEL MENSAJE';

COMMENT ON COLUMN "CS_EX_PARAMETROS"."ID_TIPO_MENSAJE" IS 'IDENTIFICADOR DEL TIPO DE MENSAJE';


CREATE TABLE "CS_EX_PLANTILLAS" (

"ID" NUMBER NOT NULL,

"ID_TIPO_MENSAJE" NUMBER NULL,

"CONTENIDO" VARCHAR2(2000) NULL,

CONSTRAINT "PK_PLANTILLAS" PRIMARY KEY ("ID") 

);



COMMENT ON COLUMN "CS_EX_PLANTILLAS"."ID" IS 'IDENTIFICADOR DE LA PLANTILLA';

COMMENT ON COLUMN "CS_EX_PLANTILLAS"."ID_TIPO_MENSAJE" IS 'IDENTIFICADOR DEL TIPO DE MENSAJE AL CUAL PERTENECE LA PLANTILLA';

COMMENT ON COLUMN "CS_EX_PLANTILLAS"."CONTENIDO" IS 'CONTENIDO DE LA PLANTILLA';



CREATE TABLE "CS_EX_CENTROS_CLIENTES" (

"ID" NUMBER NOT NULL,

"ID_CORPORATE" NUMBER NOT NULL,

"ID_CLIENTE" VARCHAR2(20) NULL,

PRIMARY KEY ("ID") 

);



COMMENT ON TABLE "CS_EX_CENTROS_CLIENTES" IS 'CONTIENE LOS IDENTIFICADORES UNICOS QUE POSEE UN PACIENTE EN LOS DISTINTOS CENTROS DE SALUD DE SU PREFERENCIA';

COMMENT ON COLUMN "CS_EX_CENTROS_CLIENTES"."ID" IS 'Identificador de la tabla';

COMMENT ON COLUMN "CS_EX_CENTROS_CLIENTES"."ID_CORPORATE" IS 'Identificador unico del paciente en el centro de salud';

COMMENT ON COLUMN "CS_EX_CENTROS_CLIENTES"."ID_CLIENTE" IS 'Identificador del cliente en Comsalud';



CREATE TABLE "CS_EX_UNIDAD" (

"ID" NUMBER NULL,

"NOMBRE" VARCHAR2(255) NULL,

PRIMARY KEY ("ID") 

);



COMMENT ON TABLE "CS_EX_UNIDAD" IS 'SERVICIOS QUE PUEDE PRESTAR UN CENTRO DE SALUD';

COMMENT ON COLUMN "CS_EX_UNIDAD"."ID" IS 'IDENTIFICADOR DEL LA UNIDAD';

COMMENT ON COLUMN "CS_EX_UNIDAD"."NOMBRE" IS 'NOMBRE DE LA UNIDAD';



CREATE TABLE "CS_EX_PARAM_TIPO_MENSAJE" (

"ID" NUMBER NOT NULL,

"ID_TIPOS_MENSAJES" NUMBER NULL,

"ID_PARAMETRO" NUMBER NULL,

"ID_CORPORATE" NUMBER NULL,

CONSTRAINT "PK_CS_EX_PARAM_TIP_MENS" PRIMARY KEY ("ID") 

);



COMMENT ON TABLE "CS_EX_PARAM_TIPO_MENSAJE" IS 'CONTIENE LOS PARAMETROS DE CONFIGURACION DE UN TIPO DE MENSAJE';

COMMENT ON COLUMN "CS_EX_PARAM_TIPO_MENSAJE"."ID" IS 'IDENTIFICADOR DE LOS PARAMETROS DE CONFIGURACION DE UN TIPO DE MENSAJE';

COMMENT ON COLUMN "CS_EX_PARAM_TIPO_MENSAJE"."ID_TIPOS_MENSAJES" IS 'IDENTIFICADOR DEL TIPO DE MENSAJE';

COMMENT ON COLUMN "CS_EX_PARAM_TIPO_MENSAJE"."ID_PARAMETRO" IS 'IDENTIFICADOR DE PARAMETROS DE CONFIGURACION';

COMMENT ON COLUMN "CS_EX_PARAM_TIPO_MENSAJE"."ID_CORPORATE" IS 'IDENTIFICACION DEL CENTRO DE SALUD';


ALTER TABLE "CS_EX_ESTATUS" ADD CONSTRAINT "FK_CS_ESTATUS_PROVEEDOR" FOREIGN KEY ("ID_PROVEEDOR") REFERENCES "CS_EX_PROVEEDORES" ("ID");

ALTER TABLE "CS_EX_MENSAJES" ADD CONSTRAINT "FK_CS_EX_MENS_TIPOS_MENS" FOREIGN KEY ("ID_TIPO_MENSAJE") REFERENCES "CS_EX_TIPOS_MENSAJES" ("ID");

ALTER TABLE "CS_EX_MENSAJES" ADD CONSTRAINT "FK_CS_EX_MENS_CLIENTES" FOREIGN KEY ("ID_CLIENTE") REFERENCES "CS_EX_CLIENTES" ("ID");

ALTER TABLE "CS_EX_ESTATUS_MENSAJES" ADD CONSTRAINT "FK_CS_EX_EST_MENSAJES_LOTES" FOREIGN KEY ("LOTE") REFERENCES "CS_EX_LOTES" ("ID");

ALTER TABLE "CS_EX_ESTATUS_MENSAJES" ADD CONSTRAINT "FK_CS_EX_EST_MENS_MENS" FOREIGN KEY ("ID_MENSAJE") REFERENCES "CS_EX_MENSAJES" ("ID");

ALTER TABLE "CS_EX_ESTATUS_MENSAJES" ADD CONSTRAINT "FK_CS_EST_MENSAJES_ESTATUS" FOREIGN KEY ("ID_ESTATUS") REFERENCES "CS_EX_ESTATUS" ("ID");

ALTER TABLE "CS_EX_MENSAJES"  ADD CONSTRAINT "FK_CS_EX_MENS_PLANTILLAS" FOREIGN KEY ("ID_PLANTILLA") REFERENCES  "CS_EX_PLANTILLAS"("ID");

ALTER TABLE "CS_EX_TIPOS_MENSAJES" ADD CONSTRAINT "FK_CS_EX_TI_MEN_CENT_SAL" FOREIGN KEY ("ID_CORPORATE") REFERENCES "CS_EX_CENTROS_SALUD" ("ID_CORPORATE");

ALTER TABLE  "CS_EX_CENTROS_CLIENTES" ADD CONSTRAINT "FK_CS_EX_CENT_CLI_CENT_SAL" FOREIGN KEY ("ID_CORPORATE") REFERENCES "CS_EX_CENTROS_SALUD" ("ID_CORPORATE");

ALTER TABLE  "CS_EX_PARAM_TIPO_MENSAJE" ADD CONSTRAINT "FK_CS_EX_PAR_TI_MENS_TIP_MENS" FOREIGN KEY ("ID_TIPOS_MENSAJES") REFERENCES "CS_EX_TIPOS_MENSAJES" ("ID");

ALTER TABLE  "CS_EX_PARAM_TIPO_MENSAJE" ADD CONSTRAINT "FK_CS_EX_PAR_TI_MENS_PAR" FOREIGN KEY ("ID_PARAMETRO") REFERENCES "CS_EX_PARAMETROS" ("ID");

ALTER TABLE  "CS_EX_PARAM_TIPO_MENSAJE" ADD CONSTRAINT "FK_CS_EX_PAR_TI_MEN_CEN_SAL" FOREIGN KEY ("ID_CORPORATE") REFERENCES "CS_EX_CENTROS_SALUD" ("ID_CORPORATE");

ALTER TABLE "CS_EX_PARAMETROS" ADD CONSTRAINT "FK_CS_EX_PARAM_UNIDAD" FOREIGN KEY ("ID_UNIDAD") REFERENCES "CS_EX_UNIDAD" ("ID");

--SECUENCIAS

CREATE SEQUENCE CS_EX_SEC_ESTATUS
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 1
  NOORDER;

CREATE SEQUENCE CS_EX_SEC_CENTROS_SALUD
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 1
  NOORDER;

CREATE SEQUENCE CS_EX_SEC_TIPOS_MENSAJES
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 1
  NOORDER;

CREATE SEQUENCE CS_EX_SEC_PROVEEDORES
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 1
  NOORDER;

CREATE SEQUENCE CS_EX_SEC_MENSAJES
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 1
  NOORDER;


CREATE SEQUENCE CS_EX_SEC_CLIENTES
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 1
  NOORDER;

CREATE SEQUENCE CS_EX_SEC_ESTATUS_MENSAJES
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 1
  NOORDER;

CREATE SEQUENCE CS_EX_SEC_PARAMETROS
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 1
  NOORDER;

CREATE SEQUENCE CS_EX_SEC_LOTES
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 1
  NOORDER;

CREATE SEQUENCE CS_EX_SEC_PLANTILLAS
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 1
  NOORDER;

CREATE SEQUENCE CS_EX_SEC_UNIDAD
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 1
  NOORDER;

 
--TRIGGERS
CREATE OR REPLACE TRIGGER CS_EX_TRI_MENSAJES
BEFORE INSERT ON SYSTEM.CS_EX_MENSAJES REFERENCING NEW AS NEW FOR EACH ROW
DECLARE vSec NUMBER := 0;
BEGIN

 IF (:NEW.id is null) THEN
  SELECT CS_EX_SEC_MENSAJES.NEXTVAL INTO vSec FROM DUAL;
  :NEW.id := vSec;
 END IF;

END;

CREATE OR REPLACE TRIGGER CS_EX_TRI_ESTATUS_MENSAJES
BEFORE INSERT ON SYSTEM.CS_EX_ESTATUS_MENSAJES REFERENCING NEW AS NEW FOR EACH ROW
DECLARE vSec NUMBER := 0;
BEGIN

 IF (:NEW.id is null) THEN
  SELECT CS_EX_SEC_ESTATUS_MENSAJES.NEXTVAL INTO vSec FROM DUAL;
  :NEW.id := vSec;
 END IF;

END;

CREATE OR REPLACE TRIGGER CS_EX_TRI_TIPOS_MENSAJES
BEFORE INSERT ON SYSTEM.CS_EX_TIPOS_MENSAJES REFERENCING NEW AS NEW FOR EACH ROW
DECLARE vSec NUMBER := 0;
BEGIN

 IF (:NEW.id is null) THEN
  SELECT CS_EX_SEC_TIPOS_MENSAJES.NEXTVAL INTO vSec FROM DUAL;
  :NEW.id := vSec;
 END IF;

END;

CREATE OR REPLACE TRIGGER CS_EX_TRI_CLIENTES
BEFORE INSERT ON SYSTEM.CS_EX_CLIENTES REFERENCING NEW AS NEW FOR EACH ROW
DECLARE vSec NUMBER := 0;
BEGIN

 IF (:NEW.id is null) THEN
  SELECT CS_EX_SEC_CLIENTES.NEXTVAL INTO vSec FROM DUAL;
  :NEW.id := vSec;
 END IF;

END;

CREATE OR REPLACE TRIGGER CS_EX_TRI_PROVEEDORES
BEFORE INSERT ON SYSTEM.CS_EX_PROVEEDORES REFERENCING NEW AS NEW FOR EACH ROW
DECLARE vSec NUMBER := 0;
BEGIN

 IF (:NEW.id is null) THEN
  SELECT CS_EX_SEC_PROVEEDORES.NEXTVAL INTO vSec FROM DUAL;
  :NEW.id := vSec;
 END IF;

END;

CREATE OR REPLACE TRIGGER CS_EX_TRI_AFILIADOS
BEFORE INSERT ON SYSTEM.CS_EX_CENTROS_SALUD REFERENCING NEW AS NEW FOR EACH ROW
DECLARE vSec NUMBER := 0;
BEGIN

 IF (:NEW.id_corporate is null) THEN
  SELECT CS_EX_SEC_CENTROS_SALUD.NEXTVAL INTO vSec FROM DUAL;
  :NEW.id_corporate := vSec;
 END IF;

END;

CREATE OR REPLACE TRIGGER CS_EX_TRI_ESTATUS
BEFORE INSERT ON SYSTEM.CS_EX_ESTATUS REFERENCING NEW AS NEW FOR EACH ROW
DECLARE vSec NUMBER := 0;
BEGIN

 IF (:NEW.id is null) THEN
  SELECT CS_EX_SEC_ESTATUS.NEXTVAL INTO vSec FROM DUAL;
  :NEW.id := vSec;
 END IF;

END;

CREATE OR REPLACE TRIGGER CS_EX_TRI_LOTES
BEFORE INSERT ON SYSTEM.CS_EX_LOTES REFERENCING NEW AS NEW FOR EACH ROW
DECLARE vSec NUMBER := 0;
BEGIN

 IF (:NEW.id is null) THEN
  SELECT CS_EX_SEC_LOTES.NEXTVAL INTO vSec FROM DUAL;
  :NEW.id := vSec;
 END IF;

END;

CREATE OR REPLACE TRIGGER CS_EX_TRI_PARAMETROS
BEFORE INSERT ON SYSTEM.CS_EX_PARAMETROS REFERENCING NEW AS NEW FOR EACH ROW
DECLARE vSec NUMBER := 0;
BEGIN

 IF (:NEW.id is null) THEN
  SELECT CS_EX_SEC_PARAMETROS.NEXTVAL INTO vSec FROM DUAL;
  :NEW.id := vSec;
 END IF;

END;

CREATE OR REPLACE TRIGGER CS_EX_TRI_PLANTILLAS
BEFORE INSERT ON SYSTEM.CS_EX_PLANTILLAS REFERENCING NEW AS NEW FOR EACH ROW
DECLARE vSec NUMBER := 0;
BEGIN

 IF (:NEW.id is null) THEN
  SELECT CS_EX_SEC_PLANTILLAS.NEXTVAL INTO vSec FROM DUAL;
  :NEW.id := vSec;
 END IF;

END;

CREATE OR REPLACE TRIGGER CS_EX_TRI_UNIDAD
BEFORE INSERT ON SYSTEM.CS_EX_UNIDAD REFERENCING NEW AS NEW FOR EACH ROW
DECLARE vSec NUMBER := 0;
BEGIN

 IF (:NEW.id is null) THEN
  SELECT CS_EX_SEC_UNIDAD.NEXTVAL INTO vSec FROM DUAL;
  :NEW.id := vSec;
 END IF;

END;
/
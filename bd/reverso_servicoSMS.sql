--ELIMINADO LAS TABLAS EXISTENTES

ALTER TABLE AFILIADOS
 DROP PRIMARY KEY CASCADE;
DROP TABLE AFILIADOS CASCADE CONSTRAINTS;

ALTER TABLE PROVEEDORES
 DROP PRIMARY KEY CASCADE;
DROP TABLE PROVEEDORES CASCADE CONSTRAINTS;

ALTER TABLE CLIENTES
 DROP PRIMARY KEY CASCADE;
DROP TABLE CLIENTES CASCADE CONSTRAINTS;

ALTER TABLE SMS_ESTATUS
 DROP PRIMARY KEY CASCADE;
DROP TABLE SMS_ESTATUS CASCADE CONSTRAINTS;

ALTER TABLE SMS_TIPOS_MENSAJES
 DROP PRIMARY KEY CASCADE;
DROP TABLE SMS_TIPOS_MENSAJES CASCADE CONSTRAINTS;

ALTER TABLE SMS_LOTES
 DROP PRIMARY KEY CASCADE;
DROP TABLE SMS_LOTES CASCADE CONSTRAINTS;

ALTER TABLE SMS_ESTATUS_MENSAJES
 DROP PRIMARY KEY CASCADE;
DROP TABLE SMS_ESTATUS_MENSAJES CASCADE CONSTRAINTS;

ALTER TABLE SMS_MENSAJES
 DROP PRIMARY KEY CASCADE;
DROP TABLE SMS_MENSAJES CASCADE CONSTRAINTS;

--ELIMINADO SECUENCIAS
 DROP SEQUENCE SEC_MENSAJES;
 DROP SEQUENCE SEC_ESTATUS_MENSAJES;
 DROP SEQUENCE SEC_TIPOS_MENSAJES;
 DROP SEQUENCE SEC_LOTES;
 DROP SEQUENCE SEC_ESTATUS;
 DROP SEQUENCE SEC_AFILIADOS;
 DROP SEQUENCE SEC_PROVEEDORES;
 DROP SEQUENCE SEC_CLIENTES;

 /
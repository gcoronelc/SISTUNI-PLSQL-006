/* 
===========================
  INICIO PROCESO
===========================
*/
SET TERMOUT ON
SET ECHO OFF
SET SERVEROUTPUT ON
BEGIN
	DBMS_OUTPUT.PUT_LINE('INICIO');
END ;
/
SET TERMOUT OFF

/*
============================
   CREACIÓN DEL ESQUEMA
============================
*/
-- VERIFICAR CUENTA

DECLARE
  N NUMBER(3);
BEGIN
  SELECT COUNT(*) INTO N FROM DBA_USERS WHERE USERNAME = 'VENTASPLSQL';
  IF(N = 1) THEN
    EXECUTE IMMEDIATE 'DROP USER VENTASPLSQL CASCADE';
  END IF;
  EXECUTE IMMEDIATE 'CREATE USER VENTASPLSQL IDENTIFIED BY admin';  
END;
/

-- ASIGNA PRIVILEGIOS

GRANT CONNECT, RESOURCE TO VENTASPLSQL;

-- CONEXIÓN CON LA BASE DE DATOS

CONNECT VENTASPLSQL/admin

/*
============================
   CREACIÓN DE LAS TABLAS
============================
*/

-- Tablas

CREATE TABLE categoria(
  codcat INTEGER NOT NULL,
  nombre VARCHAR2(20) NOT NULL
);

CREATE TABLE unidad(
  coduni INTEGER NOT NULL,
  nombre VARCHAR2(20) NOT NULL
);

CREATE TABLE producto(
  codprod VARCHAR2(10) NOT NULL,
  nombre VARCHAR2(40) NOT NULL,
  marca VARCHAR2(25) NOT NULL,
  precio NUMBER(9,2) NOT NULL,
  descuento NUMBER(2,2) DEFAULT 0, 
  stock NUMBER NOT NULL,  
  descripcion VARCHAR2(100),
  fecha_actualizacion DATE,
  codcat INTEGER NOT NULL,
  coduni INTEGER NOT NULL
);

CREATE TABLE cliente(
   codcli VARCHAR2(15) NOT NULL,
   apellidos VARCHAR2(30) NOT NULL,
   nombre VARCHAR2(30) NOT NULL,
   direccion VARCHAR2(100),
   email VARCHAR2(50),
   telefono VARCHAR2(15)
);

CREATE TABLE venta(
    codven VARCHAR2(10),
    fecha DATE,
    total NUMBER(9,2) NOT NULL,
    factura VARCHAR2(15) NOT NULL,
    codcli VARCHAR2(15) NOT NULL
);

CREATE TABLE detalle_venta(
     coddetven NUMBER NOT NULL,
     codven VARCHAR2(10) NOT NULL,
     codprod VARCHAR2(10) NOT NULL,
     cantidad NUMBER NOT NULL,
     precio NUMBER(9,2) NOT NULL,
     subtotal NUMBER(9,2) NOT NULL
);

CREATE TABLE pago(
   codpag NUMBER NOT NULL,
   fecha DATE,
   monto_pagado NUMBER(9,2) NOT NULL,
   saldo NUMBER(9,2) NOT NULL,
   observacion VARCHAR2(50),
   codven VARCHAR2(10) NOT NULL
);

-- Restricciones

ALTER TABLE categoria
ADD CONSTRAINT PK_categoria
PRIMARY KEY (codcat);

ALTER TABLE unidad
ADD CONSTRAINT PK_unidad
PRIMARY KEY (coduni);

ALTER TABLE producto 
ADD CONSTRAINT PK_producto
PRIMARY KEY (codprod);

ALTER TABLE cliente 
ADD CONSTRAINT PK_cliente
PRIMARY KEY (codcli);

ALTER TABLE producto 
ADD CONSTRAINT FK_producto_categoria
FOREIGN KEY (codcat) REFERENCES categoria(codcat);

ALTER TABLE producto 
ADD CONSTRAINT FK_producto_unidad
FOREIGN KEY (coduni) REFERENCES unidad(coduni);

ALTER TABLE venta 
ADD CONSTRAINT PK_venta
PRIMARY KEY (codven);

ALTER TABLE venta 
ADD CONSTRAINT FK_venta_cliente
FOREIGN KEY (codcli) REFERENCES cliente(codcli);

ALTER TABLE detalle_venta 
ADD CONSTRAINT PK_detalle_venta
PRIMARY KEY (coddetven);

ALTER TABLE detalle_venta 
ADD CONSTRAINT UQ_detalle_venta
UNIQUE (codven,codprod);

ALTER TABLE detalle_venta 
ADD CONSTRAINT FK_detalle_venta_venta
FOREIGN KEY (codven) REFERENCES venta(codven);

ALTER TABLE detalle_venta 
ADD CONSTRAINT FK_detalle_venta_producto
FOREIGN KEY (codprod) REFERENCES producto(codprod);

ALTER TABLE pago 
ADD CONSTRAINT PK_pago
PRIMARY KEY (codpag);

ALTER TABLE pago 
ADD CONSTRAINT FK_pago_venta
FOREIGN KEY (codven) REFERENCES venta(codven);

CREATE SEQUENCE SEQ_DETVEN
	INCREMENT BY 1
	START WITH 3050;

CREATE SEQUENCE SEQ_PAGO
	INCREMENT BY 1
	START WITH 4050;

/*
============================
   INSERCION EN BD
============================
*/

-- Categoria
 
INSERT INTO categoria(codcat,nombre)
VALUES(1001,'LACTEOS');
INSERT INTO categoria(codcat,nombre)
VALUES(1002,'CARNE');
INSERT INTO categoria(codcat,nombre)
VALUES(1003,'VERDURAS');
INSERT INTO categoria(codcat,nombre)
VALUES(1004,'FRUTA');
INSERT INTO categoria(codcat,nombre)
VALUES(1005,'EMBUTIDO');

-- Unidad
 
INSERT INTO unidad(coduni,nombre)
VALUES(2001,'Unidad');
INSERT INTO unidad(coduni,nombre)
VALUES(2002,'Kilogramo');
INSERT INTO unidad(coduni,nombre)
VALUES(2003,'Metro');

-- Producto

INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD01','LECHE UTH','GLORIA',6.50,50,to_date('20180330','YYYYMMDD'),'LECHE DESCREMADA',1001,2001);
INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD02','YOGURT LIGHT','LAIVE',8.50,50,to_date('20180913','YYYYMMDD'),'YOGURT LIBRE DE LACTOSA',1001,2001);
INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD03','CARNE PICADA','CERDENA',10.50,50,to_date('20181221','YYYYMMDD'),'CARNE DE RES TROZADO',1002,2002);
INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD04','HIGADO','CERDENA',5.50,15,to_date('20170127','YYYYMMDD'),'HIGADO DE VACUNO EN LONJAS',1002,2002);
INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD05','TOMATE','LOS FRUTALES',1.50,38,to_date('20190102','YYYYMMDD'),'TOMATE',1003,2002);
INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD06','SANDIA AMARILLA','LOS FRUTALES',1.50,22,to_date('20180618','YYYYMMDD'),'SANDIA AMARILLA',1004,2001);

INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD07','QUESO DESCREMADO','GLORIA',6.50,40,to_date('20180330','YYYYMMDD'),'QUESO DESCREMADA',1001,2001);
INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD08','QUESILLO','LAIVE',8.50,50,to_date('20180913','YYYYMMDD'),'QUESO APLASTADO Y PUESTO EN MOLDE',1001,2001);
INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD09','CHORIZO','CERDENA',10.50,50,to_date('20181221','YYYYMMDD'),'CARNE MOLIDA EN FORMA DE SALCHICA',1005,2002);
INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD10','BOFE','CERDENA',5.50,15,to_date('20170127','YYYYMMDD'),'BOFE DE VACUNO',1002,2002);
INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD11','PEPINO','LOS FRUTALES',1.50,38,to_date('20190102','YYYYMMDD'),'PEPINO',1003,2002);
INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD12','GRANADILLA','LOS FRUTALES',1.50,22,to_date('20180618','YYYYMMDD'),'GRANADILLA',1004,2001);

INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD13','MANTEQUILLA SIN SAL','GLORIA',6.50,40,to_date('20180330','YYYYMMDD'),'MANTEQUILLA CON 50% MENOS DE SAL',1001,2001);
INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD14','MANTEQUILLA CON SAL','LAIVE',8.50,50,to_date('20180913','YYYYMMDD'),'YMANTEQUILLA CON SAL',1001,2001);
INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD15','CORAZON DE RES','CERDENA',10.50,50,to_date('20181221','YYYYMMDD'),'CORAZON DE RES EN LONJAS',1002,2002);
INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD16','PULMON DE RES','CERDENA',5.50,15,to_date('20170127','YYYYMMDD'),'PULMON DE RES PICADO',1002,2002);
INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD17','ZANAHORIA','LOS FRUTALES',1.50,38,to_date('20190102','YYYYMMDD'),'ZANAHORIA',1003,2002);
INSERT INTO producto(codprod,nombre,marca,precio,stock,fecha_actualizacion,descripcion,codcat,coduni )
VALUES('PROD18','PLATANOS DE SEDA','LOS FRUTALES',1.50,22,to_date('20180618','YYYYMMDD'),'PLATANOS  DE SEDA',1004,2001);
-- Cliente

INSERT INTO cliente(codcli ,apellidos,nombre ,direccion,telefono ,email )
VALUES('47467459','SALAZAR MENENDEZ','JULIO ARMANDO','LOS GIRASOLES 34 MAGDALENA','456-7676','juliosalazar@gmail.com');
INSERT INTO cliente(codcli ,apellidos,nombre,direccion,telefono ,email )
VALUES('48283249','TRUJILLO MERINO','JOSE LEANDRO' ,'AV. 25 DE MARZO 434 SURCO','924-567-679','josetrujillo@gmail.com');
INSERT INTO cliente(codcli ,apellidos,nombre,direccion,telefono ,email )
VALUES('08527781','FUENTES LINARES','ANA MARIA','LOS GIRASOLES 34 SAN MIGUEL','436-1679','anafuentes@gmail.com');
INSERT INTO cliente(codcli ,apellidos,nombre,direccion,telefono ,email )
VALUES('26890019','JUAREZ KIOMA','MARIA FERNANDA','AV. ROSA TORO 456 LA VICTORIA','381-7246','mariajuarez@gmail.com');

INSERT INTO cliente(codcli ,apellidos,nombre ,direccion,telefono ,email )
VALUES('47467460','MENDOZA RAMIREZ','MARIA JOSEFINA','LOS ALAMOS 34 SURCO','456-7678','maria.j@gmail.com');
INSERT INTO cliente(codcli ,apellidos,nombre,direccion,telefono ,email )
VALUES('48283261','CARDENAS ARMAS','EMILIA' ,'AV. 28 DE JULIO 2888 LA VICTORIA','927-567-679','emi.24@gmail.com');
INSERT INTO cliente(codcli ,apellidos,nombre,direccion,telefono ,email )
VALUES('08527762','CACERES TORO','JEAN PIERRE','AV. HEROES DEL CENEPA 56 CHORRILLOS','436-1679','jean.toro@gmail.com');
INSERT INTO cliente(codcli ,apellidos,nombre,direccion,telefono ,email )
VALUES('26890063','TORRES CARRERA','LIDIA MIRIAM','PSJE 3 DE FEBRERO 34 INT J','657-7246','lidia_34@gmail.com');

INSERT INTO cliente(codcli ,apellidos,nombre ,direccion,telefono ,email )
VALUES('47467464','ALVAREDA COSIO','DANIEL','AV. FERROCARRIL 34 LOS OLIVOS','456-7690','alva.cosio.daniel@gmail.com');
INSERT INTO cliente(codcli ,apellidos,nombre,direccion,telefono ,email )
VALUES('48283265','CUEVA GUTIERREZ','PEDRO EMILIO' ,'AV.LOS CIPRESES 56 LA MOLINA','927-997-679','pablo.emilio@gmail.com');
INSERT INTO cliente(codcli ,apellidos,nombre,direccion,telefono ,email )
VALUES('08527766','LACUNZA SALAZAR','JUANITO','AV. MENDIOLA 45 SAN MARTIN DE PORRES','490-1679','lacunza.juanito@gmail.com');
INSERT INTO cliente(codcli ,apellidos,nombre,direccion,telefono ,email )
VALUES('26890067','RIOS TEJADA','CAMILA MARIANA','AV. SIEMPRE VIVA 45 SAN ISIDRO','657-7256','rios_camila@gmail.com');
-- Venta

INSERT INTO venta(codven,fecha,total,factura,codcli)
VALUES('VENT01',to_date('20181215','YYYYMMDD'),180.0,'FACT001','47467459');
INSERT INTO venta(codven,fecha,total,factura,codcli)
VALUES('VENT02',to_date('20190102','YYYYMMDD'),125.5,'FACT002','48283249');
INSERT INTO venta(codven,fecha,total,factura,codcli)
VALUES('VENT03',to_date('20181118','YYYYMMDD'),16.5,'FACT003','08527781');
INSERT INTO venta(codven,fecha,total,factura,codcli)
VALUES('VENT04',to_date('20181115','YYYYMMDD'),51.5,'FACT004','47467464');
INSERT INTO venta(codven,fecha,total,factura,codcli)
VALUES('VENT05',to_date('20190102','YYYYMMDD'),125.5,'FACT005','48283249');
INSERT INTO venta(codven,fecha,total,factura,codcli)
VALUES('VENT06',to_date('20181125','YYYYMMDD'),16.5,'FACT006','26890067');

-- Detalle venta

INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3001,'PROD01',4,6.50,26.00,'VENT01');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3002,'PROD02',3,8.50,25.50,'VENT01');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3003,'PROD03',2,6.50,13.00,'VENT01');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3004,'PROD04',1,8.50,8.50,'VENT01');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3005,'PROD05',2,6.50,13.00,'VENT01');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3006,'PROD06',3,8.50,25.50,'VENT01');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3007,'PROD07',4,6.50,26.00,'VENT01');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3008,'PROD08',5,8.50,42.50,'VENT01');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3009,'PROD01',1,6.50,6.50,'VENT02');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3010,'PROD02',2,8.50,17.00,'VENT02');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3011,'PROD04',1,5.50,5.50,'VENT02');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3012,'PROD06',3,1.50,5.50,'VENT02');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3013,'PROD10',4,5.50,22.00,'VENT02');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3014,'PROD11',1,1.50,1.50,'VENT02');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3015,'PROD12',6,1.50,9.00,'VENT02');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3016,'PROD18',10,1.50,10.50,'VENT02');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3017,'PROD01',1,6.50,6.50,'VENT03');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3018,'PROD02',2,8.50,17.00,'VENT03');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3019,'PROD04',1,5.50,5.50,'VENT03');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3020,'PROD06',3,1.50,5.50,'VENT03');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3021,'PROD10',4,5.50,22.00,'VENT03');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3022,'PROD11',1,1.50,1.50,'VENT03');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3023,'PROD01',1,6.50,6.50,'VENT04');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3024,'PROD02',2,8.50,17.00,'VENT04');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3025,'PROD04',1,5.50,5.50,'VENT04');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3026,'PROD06',3,1.50,5.50,'VENT04');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3027,'PROD10',4,5.50,22.00,'VENT04');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3028,'PROD11',1,1.50,1.50,'VENT04');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3029,'PROD01',4,6.50,26.00,'VENT05');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3030,'PROD02',3,8.50,25.50,'VENT05');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3031,'PROD08',2,6.50,13.00,'VENT05');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3032,'PROD04',1,8.50,8.50,'VENT05');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3033,'PROD05',2,6.50,13.00,'VENT05');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3034,'PROD10',3,8.50,25.50,'VENT05');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3035,'PROD07',4,6.50,26.00,'VENT05');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3036,'PROD18',5,8.50,42.50,'VENT05');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3037,'PROD01',1,6.50,6.50,'VENT06');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3038,'PROD11',2,8.50,17.00,'VENT06');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3039,'PROD04',1,5.50,5.50,'VENT06');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3040,'PROD17',3,1.50,5.50,'VENT06');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3041,'PROD10',4,5.50,22.00,'VENT06');
INSERT INTO detalle_venta(coddetven,codprod,cantidad ,precio,subtotal ,codven )
VALUES(3042,'PROD18',1,1.50,1.50,'VENT06');

-- Pago

INSERT INTO pago(codpag,fecha,monto_pagado,saldo,observacion,codven)
VALUES(4001,to_date('20181215','YYYYMMDD'),180.0,0.0,'sin deudas','VENT01');
INSERT INTO pago(codpag,fecha,monto_pagado,saldo,observacion,codven)
VALUES(4002,to_date('20190102','YYYYMMDD'),125.5,10.00,'Pendiente pago de envio','VENT02');
INSERT INTO pago(codpag,fecha,monto_pagado,saldo,observacion,codven)
VALUES(4003,to_date('20190105','YYYYMMDD'),89.6,0.00,'sin deudas','VENT03');
INSERT INTO pago(codpag,fecha,monto_pagado,saldo,observacion,codven)
VALUES(4004,to_date('20181118','YYYYMMDD'),123.5,50.0,'Pendiente pago de envio','VENT04');
INSERT INTO pago(codpag,fecha,monto_pagado,saldo,observacion,codven)
VALUES(4005,to_date('20181118','YYYYMMDD'),140.3,0,'sin deudas','VENT05');
INSERT INTO pago(codpag,fecha,monto_pagado,saldo,observacion,codven)
VALUES(4006,to_date('20181118','YYYYMMDD'),98.5,0,'sin deudas','VENT06');

--COMMIT
COMMIT;
/* 
===========================
  FIN PROCESO
===========================
*/
SET TERMOUT ON
SET ECHO OFF
SET SERVEROUTPUT ON
BEGIN
	DBMS_OUTPUT.PUT_LINE('FIN');
END ;
/
SET TERMOUT OFF
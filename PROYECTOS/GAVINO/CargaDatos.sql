/*
Empresa        :  EMPRESA DE TAXI
Base de Datos  :  c##hg
VERSION 	   :  ORACLE 12C
DESCRIPCION    :  LA EMPRESA DE TAXI CUENTA CON VEHICULOS LOS CUALES PUEDE ASIGNAR A CHOFERES PARA BRINDAR EL SERVICIO DE TAXI
				  EL CLIENTE DISPONE DE UN APP PARA SOLICITAR UN TAXI
				  EL SISTEMA CALCULA LA UNIDAD MAS CERCANA Y RETORNA LA DISTANCIA Y LAS COORDENADAS DE UBICACIÓN
*/


DROP TABLE c##hg.cliente PURGE;

CREATE TABLE c##hg.cliente (
  idCliente NUMBER GENERATED ALWAYS AS IDENTITY,
  vDNI varchar(8),
  vNombre VARCHAR2(50) not null, 
  vApellidoPat VARCHAR2(50) not null,
  vApellidoMat VARCHAR2(50) not null,
  vEMail VARCHAR2(100),
  CONSTRAINT pkEmpleado PRIMARY KEY (idCliente)
);

INSERT INTO c##hg.cliente(vDNI,vNombre,vApellidoPat,vApellidoMat,vEMail) VALUES ('20075293','Raúl','Carrillo','Eslaba','rcarrillo@gmail.com');
select * from c##hg.cliente;

DROP TABLE c##hg.vehiculotipo PURGE;
CREATE TABLE c##hg.vehiculotipo(
  idVehiculoTipo NUMBER GENERATED ALWAYS AS IDENTITY,
  vVehiculoTipo varchar(20),
  CONSTRAINT pkVehiculoTipo PRIMARY KEY (idVehiculoTipo)
);
INSERT INTO c##hg.vehiculotipo(vVehiculoTipo) VALUES ('Auto');
INSERT INTO c##hg.vehiculotipo(vVehiculoTipo) VALUES ('SUV');
INSERT INTO c##hg.vehiculotipo(vVehiculoTipo) VALUES ('Camioneta');
INSERT INTO c##hg.vehiculotipo(vVehiculoTipo) VALUES ('Hachback');
select * from c##hg.vehiculotipo;


DROP TABLE c##hg.vehiculomarca PURGE;
CREATE TABLE c##hg.vehiculomarca(
  idVehiculoMarca NUMBER GENERATED ALWAYS AS IDENTITY,
  vVehiculoMarca varchar(20),
  CONSTRAINT pkVehiculoMarca PRIMARY KEY (idVehiculoMarca)
);
INSERT INTO c##hg.vehiculomarca(vVehiculoMarca) VALUES ('Hyundai');
INSERT INTO c##hg.vehiculomarca(vVehiculoMarca) VALUES ('Suvaru');
INSERT INTO c##hg.vehiculomarca(vVehiculoMarca) VALUES ('Toyota');
INSERT INTO c##hg.vehiculomarca(vVehiculoMarca) VALUES ('Nisan');
INSERT INTO c##hg.vehiculomarca(vVehiculoMarca) VALUES ('Kia');
select * from c##hg.vehiculomarca;

DROP TABLE c##hg.vehiculomodelo PURGE;
CREATE TABLE c##hg.vehiculomodelo(
  idVehiculoModelo NUMBER GENERATED ALWAYS AS IDENTITY,
  vVehiculoModelo varchar(20),
  idVehiculoMarca int,
  idVehiculoTipo int,
  CONSTRAINT pkVehiculoModelo PRIMARY KEY (idVehiculoModelo),
  CONSTRAINT fk_VehiculoMarca FOREIGN KEY (idVehiculoMarca) REFERENCES c##hg.vehiculomarca(idVehiculoMarca),
  CONSTRAINT fk_VehiculoTipo FOREIGN KEY (idVehiculoTipo) REFERENCES c##hg.vehiculotipo(idVehiculoTipo)
);
INSERT INTO c##hg.vehiculomodelo(vVehiculoModelo,idVehiculoMarca,idVehiculoTipo) VALUES ('Tucson',1,2);
INSERT INTO c##hg.vehiculomodelo(vVehiculoModelo,idVehiculoMarca,idVehiculoTipo) VALUES ('Santa Fe',1,2);
INSERT INTO c##hg.vehiculomodelo(vVehiculoModelo,idVehiculoMarca,idVehiculoTipo) VALUES ('Accent',1,2);
INSERT INTO c##hg.vehiculomodelo(vVehiculoModelo,idVehiculoMarca,idVehiculoTipo) VALUES ('Elantra',1,2);
INSERT INTO c##hg.vehiculomodelo(vVehiculoModelo,idVehiculoMarca,idVehiculoTipo) VALUES ('I10',1,2);
INSERT INTO c##hg.vehiculomodelo(vVehiculoModelo,idVehiculoMarca,idVehiculoTipo) VALUES ('Veloster',1,3);
select * from c##hg.vehiculomodelo;

DROP TABLE c##hg.vehiculo PURGE;
CREATE TABLE c##hg.vehiculo(
  idVehiculo NUMBER GENERATED ALWAYS AS IDENTITY,
  idVehiculoModelo int,
  vPlaca varchar(10),
  vSoat VARCHAR2(20),
  fSoatVenc date,
  vColor varchar(20),
  gPosicion sdo_geometry,
  CONSTRAINT pkvehiculo PRIMARY KEY (idVehiculo)
);
select * from c##hg.vehiculomodelo;
INSERT INTO c##hg.vehiculo(idVehiculoModelo, vPlaca, vSoat, fSoatVenc, vColor) 
VALUES(1,'AB-123','1235489658','15/01/2019','Verde');
INSERT INTO c##hg.vehiculo(idVehiculoModelo, vPlaca, vSoat, fSoatVenc, vColor) 
VALUES(4,'AB-123','1235489658','15/01/2019','Verde');

select * from c##hg.vehiculo;

DROP TABLE c##hg.chofer PURGE;
CREATE TABLE c##hg.chofer (
  idChofer NUMBER GENERATED ALWAYS AS IDENTITY,
  vDNI varchar(8),
  vNombre VARCHAR2(50) not null, 
  vApellidoPat VARCHAR2(50) not null,
  vApellidoMat VARCHAR2(50) not null,
  vEMail VARCHAR2(100),
  CONSTRAINT pkChofer PRIMARY KEY (idChofer)
);

INSERT INTO c##hg.chofer(vDNI,vNombre,vApellidoPat,vApellidoMat,vEMail) VALUES ('20075292','Alex','Sanchez','Peréz','asanchez@gmail.com');
INSERT INTO c##hg.chofer(vDNI,vNombre,vApellidoPat,vApellidoMat,vEMail) VALUES ('20075295','Juan','Sanchez','Samán','jsanchez@gmail.com');
select * from c##hg.chofer;


DROP TABLE c##hg.asignacion PURGE;
CREATE TABLE c##hg.asignacion (
  idAsignacion NUMBER GENERATED ALWAYS AS IDENTITY,
  idVehiculo int,
  idChofer int,
  tFechaInicio Timestamp,
  tFechaFin Timestamp,
  tFechaCreacion Timestamp,
  tFechaModificacion Timestamp,
  CONSTRAINT pkAsignacion PRIMARY KEY (idAsignacion),
  CONSTRAINT fk_asignacion_vehiculo FOREIGN KEY (idVehiculo) REFERENCES c##hg.vehiculo(idVehiculo),
  CONSTRAINT fk_asignacion_chofer FOREIGN KEY (idChofer) REFERENCES c##hg.chofer(idChofer)
);

select * from c##hg.vehiculo;
select * from c##hg.chofer;

INSERT INTO c##hg.asignacion(idVehiculo,idChofer,tFechaInicio,tFechaFin,tFechaCreacion)
VALUES (1,1,'01/01/2019','02/01/2019',current_timestamp);
INSERT INTO c##hg.asignacion(idVehiculo,idChofer,tFechaInicio,tFechaFin,tFechaCreacion)
VALUES (2,2,'01/01/2019','02/01/2019',current_timestamp);
select * from c##hg.asignacion;

DROP TABLE c##hg.recorrido PURGE;
CREATE TABLE c##hg.recorrido (
  idRecorrido NUMBER GENERATED ALWAYS AS IDENTITY,
  idVehiculo int,
  gPosicion sdo_geometry,
  tFecha Timestamp,
  CONSTRAINT pkRecorrido PRIMARY KEY (idRecorrido),
  CONSTRAINT fk_recorrido_vehiculo FOREIGN KEY (idVehiculo) REFERENCES c##hg.vehiculo(idVehiculo)
);

insert into c##hg.recorrido(idVehiculo,gPosicion,tFecha)values(1, sdo_geometry(2001,4326,sdo_point_type(14,12,null),null,null) ,current_timestamp)
select r.gPosicion.SDO_POINT.srid,* from c##hg.recorrido r where r.gPosicion.SDO_POINT.x=14


DROP TABLE c##hg.pedido PURGE;
CREATE TABLE c##hg.pedido (
  idpedido NUMBER GENERATED ALWAYS AS IDENTITY,
  idCliente int,
  gPosicion sdo_geometry,
  tFecha Timestamp,
  CONSTRAINT pkpedido PRIMARY KEY (idpedido),
  CONSTRAINT fk_pedido_cliente FOREIGN KEY (idCliente) REFERENCES c##hg.cliente(idCliente)
);

insert into c##hg.pedido(idCliente,gPosicion,tFecha)values(1, sdo_geometry(2001,4326,sdo_point_type(14,10,null),null,null) ,current_timestamp)
select * from c##hg.pedido r where r.gPosicion.SDO_POINT.x=14

select * from c##hg.vehiculo;
create or replace procedure c##hg.vehiculo_actualizarposicion(p_idVehiculo int, p_lng numeric, p_lat numeric)
is
BEGIN
   update vehiculo set gPosicion = sdo_geometry(2001,4326,sdo_point_type(p_lng,p_lat,null),null,null)
   where idVehiculo = p_idVehiculo;
    Commit;
  DBMS_Output.Put_Line( 'Proceso OK' );
Exception
  When others THEN
    ROLLBACK;
    DBMS_Output.Put_Line( 'Código no existe.' );
    DBMS_Output.Put_Line( 'Código: ' || sqlcode );
    DBMS_Output.Put_Line( 'Mensaje: ' || sqlerrm );
    Raise_application_error(sqlcode, sqlerrm);
END;
/

select * from c##hg.vehiculo;
begin
  c##hg.vehiculo_actualizarposicion(1,14,2);
End;
begin
  c##hg.vehiculo_actualizarposicion(2,14,20);
End;

create or replace procedure c##hg.pedido_vehiculocercano(p_idCliente int, p_lng numeric, p_lat numeric)
is
   v_gClientePsc sdo_geometry;
   v_idVehiculo int;
   v_nDist numeric;
BEGIN
   v_gClientePsc:= sdo_geometry(2001,4326,sdo_point_type(p_lng,p_lat,null),null,null);
   
   select s.idVehiculo into v_idVehiculo from (
      select idVehiculo
      from c##hg.vehiculo a ORDER BY SDO_GEOM.SDO_DISTANCE(v_gClientePsc,a.gPosicion,0.005)
   )s where ROWNUM<=1 ;
   select SDO_GEOM.SDO_DISTANCE(v_gClientePsc,a.gPosicion,0.005) into v_nDist
   from c##hg.vehiculo a where idVehiculo=v_idVehiculo;
   DBMS_OUTPUT.PUT_LINE('Vehiculo: '||v_idVehiculo);
   DBMS_OUTPUT.PUT_LINE('Distancia: '||v_nDist);
   DBMS_OUTPUT.PUT_LINE('Coordenada: ('||v_gClientePsc.SDO_POINT.X||','||v_gClientePsc.SDO_POINT.Y||')');
   
END;
/
begin
  c##hg.pedido_vehiculocercano(1,14,1);
End;
begin
  c##hg.pedido_vehiculocercano(1,14,18);
End;

select * from c##hg.vehiculo




CREATE OR REPLACE PACKAGE c##hg.PKG_CLIENTE AS

END PKG_CLIENTE;


CREATE OR REPLACE PACKAGE BODY c##hg.PKG_CLIENTE AS

create or replace procedure registrar(p_idVehiculo c##hg.cliente.idVehiculo%TYPE, p_vDNI c##hg.cliente.vDNI%TYPE, 
    p_vNombre c##hg.cliente.vNombre%TYPE, p_vApellidoPat c##hg.cliente.vApellidoPat%TYPE, 
    p_vApellidoMat c##hg.cliente.vApellidoMat%TYPE, p_vEMail c##hg.cliente.vEMail%TYPE)
is
BEGIN
  if(p_idVehiculo is null) Then
   INSERT INTO c##hg.cliente(vDNI,vNombre,vApellidoPat,vApellidoMat,vEMail) 
   VALUES (p_vDNI,p_vNombre,p_vApellidoPat,p_vApellidoMat,p_vEMail);
  else
   update c##hg.cliente set vDNI=p_vDNI,vNombre=p_vNombre,vApellidoPat=p_vApellidoPat,vApellidoMat=p_vApellidoMat,vEMail=p_vEMail
   where idCliente = p_idCliente;
  End if;
    Commit;
  DBMS_Output.Put_Line( 'Proceso OK' );
Exception
  When others THEN
    ROLLBACK;
    DBMS_Output.Put_Line( 'Código no existe.' );
    DBMS_Output.Put_Line( 'Código: ' || sqlcode );
    DBMS_Output.Put_Line( 'Mensaje: ' || sqlerrm );
    Raise_application_error(sqlcode, sqlerrm);
END;
/
	
	/*FUNCTION suma(n1 IN NUMBER, n2 IN number, n3 IN number) RETURN NUMBER
	AS
		RTN NUMBER;
	BEGIN
		RTN:= n1+n2+n3;
		RETURN RTN;
	END;*/

END PKG_CLIENTE;

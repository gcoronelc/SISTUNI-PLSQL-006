/*
Empresa        :  EMPRESA DE TAXI
Base de Datos  :  c##hg
VERSION 	   :  ORACLE 12C
DESCRIPCION    :  LA EMPRESA DE TAXI CUENTA CON VEHICULOS LOS CUALES PUEDE ASIGNAR A CHOFERES PARA BRINDAR EL SERVICIO DE TAXI
				  EL CLIENTE DISPONE DE UN APP PARA SOLICITAR UN TAXI
				  EL SISTEMA CALCULA LA UNIDAD MAS CERCANA Y RETORNA LA DISTANCIA Y LAS COORDENADAS DE UBICACIÓN
*/

-- =============================================
-- CRACIÓN DE LA APLICACIÓN
-- =============================================

DECLARE
	N INT;
	COMMAND VARCHAR2(200);
BEGIN
	COMMAND := 'DROP USER c##hg CASCADE';
	SELECT COUNT(*) INTO N
	FROM DBA_USERS
	WHERE USERNAME = 'c##hg';
	IF ( N = 1 ) THEN
		EXECUTE IMMEDIATE COMMAND;
	END IF;
END;
/


CREATE USER c##hg IDENTIFIED BY sistemas;

GRANT CONNECT, RESOURCE TO c##hg;

ALTER USER c##hg
QUOTA UNLIMITED ON USERS;

GRANT CREATE VIEW TO c##hg;


-- =============================================
-- CONECTARSE A LA APLICACIÓN
-- =============================================

CONNECT c##hg/sistemas


-- =============================================
-- CREACIÓN DE LOS OBJETOS DE LA BASE DE DATOS
-- =============================================




/* 
===========================
  PACKAGE PRODUCTO
===========================
*/

-- DEFINIFICION

CREATE OR REPLACE PACKAGE VENTASPLSQL.PKG_PRODUCTO AS

PROCEDURE INSERTAR(
  P_CODPROD 	IN PRODUCTO.CODPROD%TYPE,
  P_NOMBRE 		IN PRODUCTO.NOMBRE%TYPE,
  P_MARCA 		IN PRODUCTO.MARCA%TYPE,
  P_PRECIO 		IN PRODUCTO.PRECIO%TYPE,
  P_DESCUENTO IN PRODUCTO.DESCUENTO%TYPE,
  P_STOCK 		IN PRODUCTO.STOCK%TYPE,
  P_DESCRIPCION		IN PRODUCTO.DESCRIPCION%TYPE,
  P_CODCAT IN PRODUCTO.CODCAT%TYPE,
  P_CODUNI IN PRODUCTO.CODUNI%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);
  
PROCEDURE ACTUALIZAR(
	P_CODPROD 	IN PRODUCTO.CODPROD%TYPE,
  P_NOMBRE 		IN PRODUCTO.NOMBRE%TYPE,
  P_MARCA 		IN PRODUCTO.MARCA%TYPE,
  P_PRECIO 		IN PRODUCTO.PRECIO%TYPE,
  P_DESCUENTO IN PRODUCTO.DESCUENTO%TYPE,
  P_STOCK 		IN PRODUCTO.STOCK%TYPE,
  P_DESCRIPCION		IN PRODUCTO.DESCRIPCION%TYPE,
  P_CODCAT IN PRODUCTO.CODCAT%TYPE,
  P_CODUNI IN PRODUCTO.CODUNI%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);
  
PROCEDURE ELIMINAR(
	P_CODPROD 	IN PRODUCTO.CODPROD%TYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);
  
PROCEDURE OBTENER(
	P_CODPROD 	IN 	PRODUCTO.CODPROD%TYPE,
	P_PRODUCTO			OUT PRODUCTO%ROWTYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);

END PKG_PRODUCTO;

-- CUERPO

CREATE OR REPLACE PACKAGE BODY VENTASPLSQL.PKG_PRODUCTO AS

PROCEDURE INSERTAR(
  P_CODPROD 	IN PRODUCTO.CODPROD%TYPE,
  P_NOMBRE 		IN PRODUCTO.NOMBRE%TYPE,
  P_MARCA 		IN PRODUCTO.MARCA%TYPE,
  P_PRECIO 		IN PRODUCTO.PRECIO%TYPE,
  P_DESCUENTO IN PRODUCTO.DESCUENTO%TYPE,
  P_STOCK 		IN PRODUCTO.STOCK%TYPE,
  P_DESCRIPCION		IN PRODUCTO.DESCRIPCION%TYPE,
  P_CODCAT IN PRODUCTO.CODCAT%TYPE,
  P_CODUNI IN PRODUCTO.CODUNI%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO DUPLICADO
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.PRODUCTO
  	WHERE CODPROD = P_CODPROD;
  IF (V_CONTADOR > 0) THEN
    RAISE_APPLICATION_ERROR(-20001, 'CODIGO DUPLICADO DE PRODUCTO');
  END IF;
  
  --VALIDA CODIGO CATEGORIA EXISTE
  V_CONTADOR := 0;
  SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.CATEGORIA
  	WHERE CODCAT = P_CODCAT;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20002, 'CODIGO DE CATEGORIA NO EXISTE');
  END IF;
	
  --VALIDA CODIGO UNIDAD EXISTE
  V_CONTADOR := 0;
  SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.UNIDAD
  	WHERE CODUNI = P_CODUNI;
  IF (V_CONTADOR = 0) THEN
		RAISE_APPLICATION_ERROR(-20003, 'CODIGO DE UNIDAD NO EXISTE');
  END IF;
	
	--INSERTA REGISTRO
	INSERT INTO VENTASPLSQL.PRODUCTO(CODPROD,NOMBRE,MARCA,PRECIO,DESCUENTO,STOCK,FECHA_ACTUALIZACION,DESCRIPCION,CODCAT,CODUNI) 
  	VALUES (P_CODPROD,P_NOMBRE,P_MARCA,P_PRECIO,P_DESCUENTO,P_STOCK,SYSDATE,P_DESCRIPCION,P_CODCAT,P_CODUNI);
   
  
  P_COD_RESPUESTA := 0;
	P_MENSAJE := 'PRODUCTO INSERTADO CON EXITO';    
      
EXCEPTION

	WHEN OTHERS THEN
		 
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
		
END;
  
PROCEDURE ACTUALIZAR(
  P_CODPROD 	IN PRODUCTO.CODPROD%TYPE,
  P_NOMBRE 		IN PRODUCTO.NOMBRE%TYPE,
  P_MARCA 		IN PRODUCTO.MARCA%TYPE,
  P_PRECIO 		IN PRODUCTO.PRECIO%TYPE,
  P_DESCUENTO IN PRODUCTO.DESCUENTO%TYPE,
  P_STOCK 		IN PRODUCTO.STOCK%TYPE,
  P_DESCRIPCION		IN PRODUCTO.DESCRIPCION%TYPE,
  P_CODCAT IN PRODUCTO.CODCAT%TYPE,
  P_CODUNI IN PRODUCTO.CODUNI%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO PRODUCTO EXISTE
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.PRODUCTO
  	WHERE CODPROD = P_CODPROD;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20004, 'PRODUCTO NO EXISTE');
  END IF;
  
  --VALIDA CODIGO CATEGORIA EXISTE
  V_CONTADOR := 0;
  SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.CATEGORIA
  	WHERE CODCAT = P_CODCAT;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20002, 'CODIGO DE CATEGORIA NO EXISTE');
  END IF;
	
  --VALIDA CODIGO UNIDAD EXISTE
  V_CONTADOR := 0;
  SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.UNIDAD
  	WHERE CODUNI = P_CODUNI;
  IF (V_CONTADOR = 0) THEN
		RAISE_APPLICATION_ERROR(-20003, 'CODIGO DE UNIDAD NO EXISTE');
  END IF;
	
	--ACTUALIZA REGISTRO
	UPDATE VENTASPLSQL.PRODUCTO
		SET 
			NOMBRE	=	P_NOMBRE,
			MARCA		=	P_MARCA,
			PRECIO	=	P_PRECIO,
			DESCUENTO	=	P_DESCUENTO,
			STOCK		=	P_STOCK,
			FECHA_ACTUALIZACION	=	SYSDATE,
			DESCRIPCION	=	P_DESCRIPCION,
			CODCAT	=	P_CODCAT,
			CODUNI	=	P_CODUNI
  	WHERE CODPROD = P_CODPROD;
   
  
  P_COD_RESPUESTA := 0;
	P_MENSAJE := 'PRODUCTO ACTUALIZADO CON EXITO';    
      
EXCEPTION

	WHEN OTHERS THEN
		 
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
END;
  
PROCEDURE ELIMINAR(
	P_CODPROD		IN PRODUCTO.CODPROD%TYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO PRODUCTO EXISTE
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.PRODUCTO
  	WHERE CODPROD = P_CODPROD;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20004, 'PRODUCTO NO EXISTE');
  END IF;

	--ELIMINA REGISTRO
	DELETE FROM VENTASPLSQL.PRODUCTO
		WHERE CODPROD = P_CODPROD; 
	 
  
  P_COD_RESPUESTA := 0;
	P_MENSAJE := 'PRODUCTO ELIMINADO CON EXITO';  
	
EXCEPTION

	WHEN OTHERS THEN
		 
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
END;
  
PROCEDURE OBTENER(
	P_CODPROD 	IN 	PRODUCTO.CODPROD%TYPE,
	P_PRODUCTO			OUT PRODUCTO%ROWTYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO PRODUCTO EXISTE
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.PRODUCTO
  	WHERE CODPROD = P_CODPROD;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20004, 'PRODUCTO NO EXISTE');
  END IF;
  
  --OBTIENE PRODUCTO
	SELECT * INTO P_PRODUCTO 
		FROM VENTASPLSQL.PRODUCTO
		WHERE CODPROD = P_CODPROD;
		
	P_COD_RESPUESTA := 0;
	P_MENSAJE := 'PRODUCTO OBTENIDO CON EXITO'; 
		
EXCEPTION

	WHEN OTHERS THEN
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
END;

END PKG_PRODUCTO;


/* 
===========================
  PACKAGE VENTA
===========================
*/

-- DEFINICION

CREATE OR REPLACE PACKAGE VENTASPLSQL.PKG_VENTA AS

PROCEDURE INSERTAR(
  P_CODVEN 	IN VENTA.CODVEN%TYPE,
  P_FECHA 	IN VENTA.FECHA%TYPE,
  P_TOTAL 	IN VENTA.TOTAL%TYPE,
  P_FACTURA IN VENTA.FACTURA%TYPE,
  P_CODCLI 	IN VENTA.CODCLI%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);
  
PROCEDURE ACTUALIZAR(
  P_CODVEN 	IN VENTA.CODVEN%TYPE,
  P_FECHA 	IN VENTA.FECHA%TYPE,
  P_TOTAL 	IN VENTA.TOTAL%TYPE,
  P_FACTURA IN VENTA.FACTURA%TYPE,
  P_CODCLI 	IN VENTA.CODCLI%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);
  
PROCEDURE ELIMINAR(
	P_CODVEN 	IN VENTA.CODVEN%TYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);
  
PROCEDURE OBTENER(
	P_CODVEN 	IN VENTA.CODVEN%TYPE,
	P_VENTA			OUT VENTA%ROWTYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);

END PKG_VENTA;

-- CUERPO

CREATE OR REPLACE PACKAGE BODY VENTASPLSQL.PKG_VENTA AS


PROCEDURE INSERTAR(

  P_CODVEN 	IN VENTA.CODVEN%TYPE,
  P_FECHA 	IN VENTA.FECHA%TYPE,
  P_TOTAL 	IN VENTA.TOTAL%TYPE,
  P_FACTURA IN VENTA.FACTURA%TYPE,
  P_CODCLI 	IN VENTA.CODCLI%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO DUPLICADO
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.VENTA
  	WHERE CODVEN = P_CODVEN;
  IF (V_CONTADOR > 0) THEN
    RAISE_APPLICATION_ERROR(-20005, 'CODIGO DUPLICADO DE VENTA');
  END IF;
  
  --VALIDA CODIGO CLIENTE EXISTE
  V_CONTADOR := 0;
  SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.CLIENTE
  	WHERE CODCLI = P_CODCLI;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20006, 'CODIGO DE CLIENTE NO EXISTE');
  END IF;
	
	--INSERTA REGISTRO
	INSERT INTO VENTASPLSQL.VENTA(CODVEN,FECHA,TOTAL,FACTURA,CODCLI) 
  	VALUES (P_CODVEN,P_FECHA,P_TOTAL,P_FACTURA,P_CODCLI);
  
  P_COD_RESPUESTA := 0;
	P_MENSAJE := 'VENTA INSERTADA CON EXITO';    
      
EXCEPTION

	WHEN OTHERS THEN
		 
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
		
END;
  
  
PROCEDURE ACTUALIZAR(

  P_CODVEN 	IN VENTA.CODVEN%TYPE,
  P_FECHA 	IN VENTA.FECHA%TYPE,
  P_TOTAL 	IN VENTA.TOTAL%TYPE,
  P_FACTURA IN VENTA.FACTURA%TYPE,
  P_CODCLI 	IN VENTA.CODCLI%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO VENTA EXISTE
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.VENTA
  	WHERE CODVEN = P_CODVEN;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20007, 'VENTA NO EXISTE');
  END IF;
  
  --VALIDA CODIGO CLIENTE EXISTE
  V_CONTADOR := 0;
  SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.CLIENTE
  	WHERE CODCLI = P_CODCLI;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20006, 'CODIGO DE CLIENTE NO EXISTE');
  END IF;
	
	--ACTUALIZA REGISTRO
	UPDATE VENTASPLSQL.VENTA
		SET 
			FECHA		=	P_FECHA,
			TOTAL		=	P_TOTAL,
			FACTURA	=	P_FACTURA,
			CODCLI	=	P_CODCLI
  	WHERE CODVEN = P_CODVEN;
   
  
  P_COD_RESPUESTA := 0;
	P_MENSAJE := 'VENTA ACTUALIZADA CON EXITO';    
      
EXCEPTION

	WHEN OTHERS THEN
		 
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
END;
  
  
PROCEDURE ELIMINAR(

	P_CODVEN 	IN VENTA.CODVEN%TYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO VENTA EXISTE
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.VENTA
  	WHERE CODVEN = P_CODVEN;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20007, 'VENTA NO EXISTE');
  END IF;

	--ELIMINA REGISTRO
	DELETE FROM VENTASPLSQL.VENTA
		WHERE CODVEN = P_CODVEN; 
	 
  
  P_COD_RESPUESTA := 0;
	P_MENSAJE := 'VENTA ELIMINADA CON EXITO';  
	
EXCEPTION

	WHEN OTHERS THEN
		 
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
END;

  
PROCEDURE OBTENER(

	P_CODVEN 	IN VENTA.CODVEN%TYPE,
	P_VENTA			OUT VENTA%ROWTYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO VENTA EXISTE
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.VENTA
  	WHERE CODVEN = P_CODVEN;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20007, 'VENTA NO EXISTE');
  END IF;
  
  --OBTIENE PRODUCTO
	SELECT * INTO P_VENTA 
		FROM VENTASPLSQL.VENTA
		WHERE CODVEN = P_CODVEN;

	P_COD_RESPUESTA := 0;
	P_MENSAJE := 'VENTA OBTENIDA CON EXITO'; 
			
EXCEPTION

	WHEN OTHERS THEN
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
END;

END PKG_VENTA;


/* 
===========================
  PACKAGE DETALLE VENTA
===========================
*/

-- DEFINIFICION

CREATE OR REPLACE PACKAGE VENTASPLSQL.PKG_DETALLE_VENTA AS

PROCEDURE INSERTAR(
  P_CODVEN 		IN DETALLE_VENTA.CODVEN%TYPE,
  P_CODPROD		IN DETALLE_VENTA.CODPROD%TYPE,
  P_CANTIDAD 	IN DETALLE_VENTA.CANTIDAD%TYPE,
  P_PRECIO		IN DETALLE_VENTA.PRECIO%TYPE,
  P_SUBTOTAL	IN DETALLE_VENTA.SUBTOTAL%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);
  
PROCEDURE ACTUALIZAR(
  P_CODDETVEN	IN DETALLE_VENTA.CODDETVEN%TYPE,
  P_CODVEN 		IN DETALLE_VENTA.CODVEN%TYPE,
  P_CODPROD		IN DETALLE_VENTA.CODPROD%TYPE,
  P_CANTIDAD 	IN DETALLE_VENTA.CANTIDAD%TYPE,
  P_PRECIO		IN DETALLE_VENTA.PRECIO%TYPE,
  P_SUBTOTAL	IN DETALLE_VENTA.SUBTOTAL%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);
  
PROCEDURE ELIMINAR(
  P_CODDETVEN	IN DETALLE_VENTA.CODDETVEN%TYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);
  
PROCEDURE OBTENER(
  P_CODDETVEN	IN DETALLE_VENTA.CODDETVEN%TYPE,
	P_DETALLE_VENTA	OUT DETALLE_VENTA%ROWTYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);

END PKG_DETALLE_VENTA;

-- CUERPO

CREATE OR REPLACE PACKAGE BODY VENTASPLSQL.PKG_DETALLE_VENTA AS

PROCEDURE INSERTAR(

  P_CODVEN 		IN DETALLE_VENTA.CODVEN%TYPE,
  P_CODPROD		IN DETALLE_VENTA.CODPROD%TYPE,
  P_CANTIDAD 	IN DETALLE_VENTA.CANTIDAD%TYPE,
  P_PRECIO		IN DETALLE_VENTA.PRECIO%TYPE,
  P_SUBTOTAL	IN DETALLE_VENTA.SUBTOTAL%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	V_CODDETVEN DETALLE_VENTA.CODDETVEN%TYPE;
	
BEGIN

	V_CODDETVEN := SEQ_DETVEN.NEXTVAL;

	--VALIDA CODIGO DUPLICADO
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.DETALLE_VENTA
  	WHERE CODDETVEN = V_CODDETVEN;
  IF (V_CONTADOR > 0) THEN
    RAISE_APPLICATION_ERROR(-20008, 'CODIGO DUPLICADO DE DETALLE');
  END IF;
  
	--VALIDA CODIGO PRODUCTO EXISTE
	V_CONTADOR := 0;
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.PRODUCTO
  	WHERE CODPROD = P_CODPROD;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20009, 'CODIGO DE PRODUCTO NO EXISTE');
  END IF;
	
	--VALIDA CODIGO VENTA EXISTE
	V_CONTADOR := 0;
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.VENTA
  	WHERE CODVEN = P_CODVEN;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20010, 'CODIGO DE VENTA NO EXISTE');
  END IF;

	--INSERTA REGISTRO
	INSERT INTO VENTASPLSQL.DETALLE_VENTA(CODDETVEN,CODVEN,CODPROD,CANTIDAD,PRECIO,SUBTOTAL) 
  	VALUES (V_CODDETVEN,P_CODVEN,P_CODPROD,P_CANTIDAD,P_PRECIO,P_SUBTOTAL);

  P_COD_RESPUESTA := 0;
	P_MENSAJE := 'DETALLE INSERTADO CON EXITO';    
      
EXCEPTION

	WHEN OTHERS THEN
		 
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
		
END;
  
  
PROCEDURE ACTUALIZAR(

  P_CODDETVEN	IN DETALLE_VENTA.CODDETVEN%TYPE,
  P_CODVEN 		IN DETALLE_VENTA.CODVEN%TYPE,
  P_CODPROD		IN DETALLE_VENTA.CODPROD%TYPE,
  P_CANTIDAD 	IN DETALLE_VENTA.CANTIDAD%TYPE,
  P_PRECIO		IN DETALLE_VENTA.PRECIO%TYPE,
  P_SUBTOTAL	IN DETALLE_VENTA.SUBTOTAL%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO DETALLE EXISTE
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.DETALLE_VENTA
  	WHERE CODDETVEN = P_CODDETVEN;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20011, 'DETALLE NO EXISTE');
  END IF;
  
	--VALIDA CODIGO PRODUCTO EXISTE
	V_CONTADOR := 0;
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.PRODUCTO
  	WHERE CODPROD = P_CODPROD;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20009, 'CODIGO DE PRODUCTO NO EXISTE');
  END IF;
	
	--VALIDA CODIGO VENTA EXISTE
	V_CONTADOR := 0;
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.VENTA
  	WHERE CODVEN = P_CODVEN;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20010, 'CODIGO DE VENTA NO EXISTE');
  END IF;
	
	--ACTUALIZA REGISTRO
	UPDATE VENTASPLSQL.DETALLE_VENTA
		SET 
			CODVEN		=	P_CODVEN,
			CODPROD		=	P_CODPROD,
			CANTIDAD	=	P_CANTIDAD,
			PRECIO		=	P_PRECIO,
			SUBTOTAL	=	P_SUBTOTAL
  	WHERE CODDETVEN = P_CODDETVEN;
   
  
  P_COD_RESPUESTA := 0;
	P_MENSAJE := 'DETALLE ACTUALIZADO CON EXITO';    
      
EXCEPTION

	WHEN OTHERS THEN
		 
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
END;
  
  
PROCEDURE ELIMINAR(

  P_CODDETVEN	IN DETALLE_VENTA.CODDETVEN%TYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO DETALLE EXISTE
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.DETALLE_VENTA
  	WHERE CODDETVEN = P_CODDETVEN;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20011, 'DETALLE NO EXISTE');
  END IF;

	--ELIMINA REGISTRO
	DELETE FROM VENTASPLSQL.DETALLE_VENTA
		WHERE CODDETVEN = P_CODDETVEN; 
	 
  
  P_COD_RESPUESTA := 0;
	P_MENSAJE := 'DETALLE ELIMINADO CON EXITO';  
	
EXCEPTION

	WHEN OTHERS THEN
		 
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
END;
  
  
PROCEDURE OBTENER(

  P_CODDETVEN	IN DETALLE_VENTA.CODDETVEN%TYPE,
	P_DETALLE_VENTA	OUT DETALLE_VENTA%ROWTYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO DETALLE EXISTE
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.DETALLE_VENTA
  	WHERE CODDETVEN = P_CODDETVEN;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20011, 'DETALLE NO EXISTE');
  END IF;
  
  --OBTIENE DETALLE
	SELECT * INTO P_DETALLE_VENTA 
		FROM VENTASPLSQL.DETALLE_VENTA
		WHERE CODDETVEN = P_CODDETVEN;

	P_COD_RESPUESTA := 0;
	P_MENSAJE := 'DETALLE OBTENIDO CON EXITO'; 
			
EXCEPTION

	WHEN OTHERS THEN
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
END;

END PKG_DETALLE_VENTA;


/* 
===========================
  PACKAGE CLIENTE
===========================
*/

-- DEFINICION

CREATE OR REPLACE PACKAGE VENTASPLSQL.PKG_CLIENTE AS

PROCEDURE INSERTAR(
  P_CODCLI 		IN CLIENTE.CODCLI%TYPE,
  P_APELLIDOS IN CLIENTE.APELLIDOS%TYPE,
  P_NOMBRE 		IN CLIENTE.NOMBRE%TYPE,
  P_DIRECCION IN CLIENTE.DIRECCION%TYPE,
  P_EMAIL 		IN CLIENTE.EMAIL%TYPE,
  P_TELEFONO 	IN CLIENTE.TELEFONO%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);
  
PROCEDURE ACTUALIZAR(
  P_CODCLI 		IN CLIENTE.CODCLI%TYPE,
  P_APELLIDOS IN CLIENTE.APELLIDOS%TYPE,
  P_NOMBRE 		IN CLIENTE.NOMBRE%TYPE,
  P_DIRECCION IN CLIENTE.DIRECCION%TYPE,
  P_EMAIL 		IN CLIENTE.EMAIL%TYPE,
  P_TELEFONO 	IN CLIENTE.TELEFONO%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);
  
PROCEDURE ELIMINAR(
  P_CODCLI 		IN CLIENTE.CODCLI%TYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);
  
PROCEDURE OBTENER(
  P_CODCLI 		IN CLIENTE.CODCLI%TYPE,
	P_CLIENTE				OUT CLIENTE%ROWTYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);

END PKG_CLIENTE;

-- CUERPO

CREATE OR REPLACE PACKAGE BODY VENTASPLSQL.PKG_CLIENTE AS


PROCEDURE INSERTAR(

  P_CODCLI 		IN CLIENTE.CODCLI%TYPE,
  P_APELLIDOS IN CLIENTE.APELLIDOS%TYPE,
  P_NOMBRE 		IN CLIENTE.NOMBRE%TYPE,
  P_DIRECCION IN CLIENTE.DIRECCION%TYPE,
  P_EMAIL 		IN CLIENTE.EMAIL%TYPE,
  P_TELEFONO 	IN CLIENTE.TELEFONO%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO DUPLICADO
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.CLIENTE
  	WHERE CODCLI = P_CODCLI;
  IF (V_CONTADOR > 0) THEN
    RAISE_APPLICATION_ERROR(-20012, 'CODIGO DUPLICADO DE CLIENTE');
  END IF;
  
	--INSERTA REGISTRO
	INSERT INTO VENTASPLSQL.CLIENTE(CODCLI,APELLIDOS,NOMBRE,DIRECCION,EMAIL,TELEFONO) 
  	VALUES (P_CODCLI,P_APELLIDOS,P_NOMBRE,P_DIRECCION,P_EMAIL,P_TELEFONO);
   
  
  P_COD_RESPUESTA := 0;
	P_MENSAJE := 'CLIENTE INSERTADO CON EXITO';    
      
EXCEPTION

	WHEN OTHERS THEN
		 
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
		
END;
  
  
PROCEDURE ACTUALIZAR(

  P_CODCLI 		IN CLIENTE.CODCLI%TYPE,
  P_APELLIDOS IN CLIENTE.APELLIDOS%TYPE,
  P_NOMBRE 		IN CLIENTE.NOMBRE%TYPE,
  P_DIRECCION IN CLIENTE.DIRECCION%TYPE,
  P_EMAIL 		IN CLIENTE.EMAIL%TYPE,
  P_TELEFONO 	IN CLIENTE.TELEFONO%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO CLIENTE EXISTE
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.CLIENTE
  	WHERE CODCLI = P_CODCLI;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20013, 'CLIENTE NO EXISTE');
  END IF;
  
	--ACTUALIZA REGISTRO
	UPDATE VENTASPLSQL.CLIENTE
		SET 
			APELLIDOS	=	P_APELLIDOS,
			NOMBRE		=	P_NOMBRE,
			DIRECCION	=	P_DIRECCION,
			EMAIL			=	P_EMAIL,
			TELEFONO	=	P_TELEFONO
  	WHERE CODCLI = P_CODCLI;
   
  
  P_COD_RESPUESTA := 0;
	P_MENSAJE := 'CLIENTE ACTUALIZADO CON EXITO';    
      
EXCEPTION

	WHEN OTHERS THEN
		 
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
END;
  
  
PROCEDURE ELIMINAR(

  P_CODCLI 		IN CLIENTE.CODCLI%TYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO CLIENTE EXISTE
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.CLIENTE
  	WHERE CODCLI = P_CODCLI;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20013, 'CLIENTE NO EXISTE');
  END IF;

	--ELIMINA REGISTRO
	DELETE FROM VENTASPLSQL.CLIENTE
		WHERE CODCLI = P_CODCLI; 
	 
  
  P_COD_RESPUESTA := 0;
	P_MENSAJE := 'CLIENTE ELIMINADO CON EXITO';  
	
EXCEPTION

	WHEN OTHERS THEN
		 
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
END;

  
PROCEDURE OBTENER(

  P_CODCLI 		IN CLIENTE.CODCLI%TYPE,
	P_CLIENTE				OUT CLIENTE%ROWTYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO CLIENTE EXISTE
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.CLIENTE
  	WHERE CODCLI = P_CODCLI;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20013, 'CLIENTE NO EXISTE');
  END IF;
  
  --OBTIENE CLIENTE
	SELECT * INTO P_CLIENTE 
		FROM VENTASPLSQL.CLIENTE
		WHERE CODCLI = P_CODCLI;
		
	P_COD_RESPUESTA := 0;
	P_MENSAJE := 'CLIENTE OBTENIDO CON EXITO'; 
		
EXCEPTION

	WHEN OTHERS THEN
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
END;

END PKG_CLIENTE;

/* 
===========================
  PACKAGE VENTA
===========================
*/

-- DEFINICION

CREATE OR REPLACE PACKAGE VENTASPLSQL.PKG_PAGO AS

PROCEDURE INSERTAR(
  P_FECHA 	IN PAGO.FECHA%TYPE,
  P_MONTO_PAGADO 	IN PAGO.MONTO_PAGADO%TYPE,
  P_SALDO 	IN PAGO.SALDO%TYPE,
  P_OBSERVACION 	IN PAGO.OBSERVACION%TYPE,
  P_CODVEN 	IN PAGO.CODVEN%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);
  
PROCEDURE ACTUALIZAR(
  P_CODPAG 	IN PAGO.CODPAG%TYPE,
  P_FECHA 	IN PAGO.FECHA%TYPE,
  P_MONTO_PAGADO 	IN PAGO.MONTO_PAGADO%TYPE,
  P_SALDO 	IN PAGO.SALDO%TYPE,
  P_OBSERVACION 	IN PAGO.OBSERVACION%TYPE,
  P_CODVEN 	IN PAGO.CODVEN%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);
  
PROCEDURE ELIMINAR(
	P_CODPAG 	IN PAGO.CODPAG%TYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);
  
PROCEDURE OBTENER(
	P_CODPAG 	IN PAGO.CODPAG%TYPE,
	P_PAGO			OUT PAGO%ROWTYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2);

END PKG_PAGO;

-- CUERPO

CREATE OR REPLACE PACKAGE BODY VENTASPLSQL.PKG_PAGO AS


PROCEDURE INSERTAR(

  P_FECHA 	IN PAGO.FECHA%TYPE,
  P_MONTO_PAGADO 	IN PAGO.MONTO_PAGADO%TYPE,
  P_SALDO 	IN PAGO.SALDO%TYPE,
  P_OBSERVACION 	IN PAGO.OBSERVACION%TYPE,
  P_CODVEN 	IN PAGO.CODVEN%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	V_CODPAGO NUMBER := 0;
		
BEGIN

	V_CODPAGO := SEQ_PAGO.NEXTVAL;
		
	--VALIDA CODIGO DUPLICADO
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.PAGO
  	WHERE CODPAG = V_CODPAGO;
  IF (V_CONTADOR > 0) THEN
    RAISE_APPLICATION_ERROR(-20015, 'CODIGO DUPLICADO DE PAGO');
  END IF;
  
  --VALIDA CODIGO VENTA EXISTE
  V_CONTADOR := 0;
  SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.VENTA
  	WHERE CODVEN = P_CODVEN;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20010, 'CODIGO DE VENTA NO EXISTE');
  END IF;
	
	--INSERTA REGISTRO
	INSERT INTO VENTASPLSQL.PAGO(CODPAG,FECHA,MONTO_PAGADO,SALDO,OBSERVACION,CODVEN) 
  	VALUES (V_CODPAGO,SYSDATE,P_MONTO_PAGADO,P_SALDO,P_OBSERVACION,P_CODVEN);
   
  P_COD_RESPUESTA := 0;
	P_MENSAJE := 'PAGO INSERTADO CON EXITO';    
      
EXCEPTION

	WHEN OTHERS THEN
		 
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
		
END;
  
  
PROCEDURE ACTUALIZAR(

  P_CODPAG 	IN PAGO.CODPAG%TYPE,
  P_FECHA 	IN PAGO.FECHA%TYPE,
  P_MONTO_PAGADO 	IN PAGO.MONTO_PAGADO%TYPE,
  P_SALDO 	IN PAGO.SALDO%TYPE,
  P_OBSERVACION 	IN PAGO.OBSERVACION%TYPE,
  P_CODVEN 	IN PAGO.CODVEN%TYPE,
  P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO PAGO EXISTE
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.PAGO
  	WHERE CODPAG = P_CODPAG;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20017, 'PAGO NO EXISTE');
  END IF;
  
  --VALIDA CODIGO VENTA EXISTE
  V_CONTADOR := 0;
  SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.VENTA
  	WHERE CODVEN = P_CODVEN;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20010, 'CODIGO DE VENTA NO EXISTE');
  END IF;
	
	--ACTUALIZA REGISTRO
	UPDATE VENTASPLSQL.PAGO
		SET 
			FECHA				=	P_FECHA,
			MONTO_PAGADO=	P_MONTO_PAGADO,
			SALDO				=	P_SALDO,
			OBSERVACION	=	P_OBSERVACION,
			CODVEN			=	P_CODVEN
  	WHERE CODPAG = P_CODPAG;
   
  
  P_COD_RESPUESTA := 0;
	P_MENSAJE := 'PAGO ACTUALIZADO CON EXITO';    
      
EXCEPTION

	WHEN OTHERS THEN
		 
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
END;
  
  
PROCEDURE ELIMINAR(

	P_CODPAG 	IN PAGO.CODPAG%TYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO PAGO EXISTE
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.PAGO
  	WHERE CODPAG = P_CODPAG;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20017, 'PAGO NO EXISTE');
  END IF;

	--ELIMINA REGISTRO
	DELETE FROM VENTASPLSQL.PAGO
		WHERE CODPAG = P_CODPAG; 
	  
  P_COD_RESPUESTA := 0;
	P_MENSAJE := 'PAGO ELIMINADO CON EXITO';  
	
EXCEPTION

	WHEN OTHERS THEN
		 
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
END;

  
PROCEDURE OBTENER(

	P_CODPAG 	IN PAGO.CODPAG%TYPE,
	P_PAGO					OUT PAGO%ROWTYPE,
 	P_COD_RESPUESTA OUT NUMBER,
  P_MENSAJE 			OUT VARCHAR2)
IS
	V_CONTADOR NUMBER := 0;
	
BEGIN

	--VALIDA CODIGO PAGO EXISTE
	SELECT COUNT(*) INTO V_CONTADOR 
		FROM VENTASPLSQL.PAGO
  	WHERE CODPAG = P_CODPAG;
  IF (V_CONTADOR = 0) THEN
    RAISE_APPLICATION_ERROR(-20017, 'PAGO NO EXISTE');
  END IF;
  
  --OBTIENE PRODUCTO
	SELECT * INTO P_PAGO 
		FROM VENTASPLSQL.PAGO
		WHERE CODPAG = P_CODPAG;

	P_COD_RESPUESTA := 0;
	P_MENSAJE := 'PAGO OBTENIDO CON EXITO'; 
			
EXCEPTION

	WHEN OTHERS THEN
		P_COD_RESPUESTA := -1;
		P_MENSAJE := TO_CHAR(sqlcode) || ' - ' || SQLERRM;
END;

END PKG_PAGO;

/* 
===========================
  PACKAGE UTIL
===========================
*/

-- DEFINICION

CREATE OR REPLACE PACKAGE VENTASPLSQL.PKG_UTIL AS

TYPE T_ARRAY_STRING IS TABLE OF VARCHAR2(1000) 
INDEX BY BINARY_INTEGER;

FUNCTION SPLIT(P_DATA VARCHAR2, P_DELIMITADOR VARCHAR2 ) 
RETURN T_ARRAY_STRING;

FUNCTION SIGUIENTE_VALOR(P_DATA VARCHAR2, P_DELIMITADOR VARCHAR2 ) 
RETURN VARCHAR2;

FUNCTION RESTO(P_DATA VARCHAR2, P_DELIMITADOR VARCHAR2 ) 
RETURN VARCHAR2;

END PKG_UTIL;

-- BODY

CREATE OR REPLACE PACKAGE BODY VENTASPLSQL.PKG_UTIL AS

FUNCTION SPLIT(P_DATA VARCHAR2, P_DELIMITADOR VARCHAR2 ) 
RETURN T_ARRAY_STRING
IS
    I        NUMBER   := 0;
    POS      NUMBER   := 0;
    V_DATA   CLOB     := P_DATA;
    STRINGS  T_ARRAY_STRING;
BEGIN
  V_DATA := TRIM( V_DATA );
  POS := INSTR( V_DATA, P_DELIMITADOR, 1, 1 );
  WHILE ( POS != 0) LOOP
      I := I + 1;
      STRINGS(i) := SUBSTR( V_DATA, 1, POS - 1 );
      V_DATA :=  SUBSTR( V_DATA, POS + 1, LENGTH(V_DATA) );
      pos := instr(V_DATA, P_DELIMITADOR, 1, 1);
      IF POS = 0 THEN
          STRINGS( I + 1 ) := V_DATA;
      END IF;    
  END LOOP;
  IF I = 0 AND LENGTH( V_DATA ) > 0 THEN
    STRINGS( I + 1 ) := V_DATA;
  END IF;
  RETURN strings;
END SPLIT;

FUNCTION SIGUIENTE_VALOR(
	P_DATA VARCHAR2, 
	P_DELIMITADOR VARCHAR2) RETURN VARCHAR2
IS
	V_DATA   CLOB     := P_DATA;
	V_VALOR  CLOB;
	V_POS   NUMBER   := 0;
BEGIN
	V_DATA := TRIM( V_DATA );
	V_POS := INSTR( V_DATA, P_DELIMITADOR, 1, 1 );
  V_VALOR := SUBSTR( V_DATA, 1, V_POS - 1 );
  RETURN V_VALOR;
END SIGUIENTE_VALOR;

FUNCTION RESTO(
	P_DATA VARCHAR2, 
	P_DELIMITADOR VARCHAR2 ) RETURN VARCHAR2
IS
	V_DATA   CLOB     := P_DATA;
	V_VALOR  CLOB;
	V_POS_INI   NUMBER   := 0;
	V_POS_FIN   NUMBER   := 0;
BEGIN
  V_DATA := TRIM( V_DATA );
	V_POS_INI := INSTR( V_DATA, P_DELIMITADOR, 1, 1 );
	V_POS_FIN := LENGTH( V_DATA );
	V_VALOR := SUBSTR( V_DATA, V_POS_INI+1, V_POS_FIN - V_POS_INI);
	RETURN V_VALOR;
END RESTO;

END PKG_UTIL;
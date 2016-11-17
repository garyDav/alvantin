CREATE DATABASE alvantin;
use alvantin;

CREATE TABLE user (
	id integer PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nombre varchar(50),
	apellido varchar(50),
	correo varchar(100),
	contra varchar(100),
	celular int,
	tipo varchar(5),
	fecha datetime
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


CREATE TABLE reservacion (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_user int,
	fecha datetime,
	fecha_pedido datetime,

	FOREIGN KEY (id_user) REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE articulo (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_reservacion int,
	nombre varchar(50),
	cantidad int,

	FOREIGN KEY (id_reservacion) REFERENCES reservacion(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


CREATE TABLE menu (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nombre varchar(100),
	descripcion text,
	tipo varchar(10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*CREATE TABLE lugar (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_reservacion int,
	nombre varchar(100),

	FOREIGN KEY (id_reservacion) REFERENCES reservacion(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;*/

CREATE TABLE lugar (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nombre varchar(100),
	descripcion text,
	tipo varchar(10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

CREATE TABLE img_lugar (
	id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_lugar int,
	src varchar(255),

	FOREIGN KEY (id_lugar) REFERENCES lugar(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;







/*Procediminetos Almacenados*/
delimiter //
DROP PROCEDURE IF EXISTS pSession;
CREATE PROCEDURE pSession(
	IN v_correo varchar(100),
	IN v_pwd varchar(100)
)
BEGIN
	DECLARE us int(11);
	SET us = (SELECT id FROM user WHERE correo LIKE v_correo);
	IF(us) THEN
		IF EXISTS(SELECT id FROM user WHERE id = us AND contra LIKE v_pwd) THEN
			SELECT id,'success' error,tipo As tipo FROM user WHERE id = us;
		ELSE
			SELECT 'Error: Contraseña incorrecta.' error;
		END IF;
	ELSE
		SELECT 'Error: Correo no registrado.' error;
	END IF;
END //



DROP PROCEDURE IF EXISTS pInsertUser;
CREATE PROCEDURE pInsertUser (
	IN v_nombre varchar(50),
	IN v_apellido varchar(50),
	IN v_correo varchar(100),
	IN v_contra varchar(100),
	IN v_celular int,
	IN v_tipo varchar(5)
)
BEGIN
	IF NOT EXISTS(SELECT id FROM user WHERE correo LIKE v_correo) THEN
		INSERT INTO user VALUES(null,v_nombre,v_apellido,v_correo,v_contra,v_celular,v_tipo,CURRENT_TIMESTAMP);
		SELECT @@identity AS id,v_tipo AS tipo, 'Usuario creado exitosamente :)' AS error;
	ELSE
		SELECT 'Error: Correo ya registrado.' error;
	END IF;
END //

DROP PROCEDURE IF EXISTS pInsertReservacion;
CREATE PROCEDURE pInsertReservacion (
	IN v_id_user int,
	IN v_fecha_pedido datetime
)
BEGIN
	INSERT INTO reservacion VALUES(null,v_id_user,CURRENT_TIMESTAMP,v_fecha_pedido);
	SELECT @@identity AS id, 'Reservacion Registrada exitosamente.' AS error;
END //

DROP PROCEDURE IF EXISTS pInsertArticulo;
CREATE PROCEDURE pInsertArticulo (
	IN v_id_reservacion int,
	IN v_nombre varchar(50),
	IN v_cantidad int
)
BEGIN
	IF NOT EXISTS(SELECT id FROM articulo WHERE nombre LIKE v_nombre) THEN
		INSERT INTO articulo VALUES(null,v_id_reservacion,v_nombre,v_cantidad);
		SELECT @@identity AS id, 'Articulo Registrado exitosamente.' AS error;
	ELSE
		SELECT 'Error: Nombre del articulo ya registrado.' error;
	END IF;
END //

DROP PROCEDURE IF EXISTS pInsertMenu;
CREATE PROCEDURE pInsertMenu (
	IN nombre varchar(100),
	IN descripcion text,
	IN tipo varchar(10)
)
BEGIN
	INSERT INTO menu VALUES(null,nombre,descripcion,tipo);
	SELECT @@identity AS id, 'Registro insertado exitosamente.' AS error;
END //

DROP PROCEDURE IF EXISTS pInsertLugar;
CREATE PROCEDURE pInsertLugar (
	IN v_nombre varchar(100),
	IN v_descripcion text,
	IN v_tipo varchar(10)
)
BEGIN
	IF NOT EXISTS(SELECT id FROM lugar WHERE tipo LIKE v_tipo) THEN
		INSERT INTO lugar VALUES(null,v_nombre,v_descripcion,v_tipo);
		SELECT @@identity AS id, 'Lugar registrado exitosamente.' AS error;
	ELSE
		SELECT 'Error: Lugar ya registrado.' error;
	END IF;
END //

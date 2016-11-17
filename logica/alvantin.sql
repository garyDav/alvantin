-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 17-11-2016 a las 17:37:15
-- Versión del servidor: 10.1.9-MariaDB
-- Versión de PHP: 7.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `alvantin`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertArticulo` (IN `v_id_reservacion` INT, IN `v_nombre` VARCHAR(50), IN `v_cantidad` INT)  BEGIN
IF NOT EXISTS(SELECT id FROM articulo WHERE nombre LIKE v_nombre) THEN
INSERT INTO articulo VALUES(null,v_id_reservacion,v_nombre,v_cantidad);
SELECT @@identity AS id, 'Articulo Registrado exitosamente.' AS error;
ELSE
SELECT 'Error: Nombre del articulo ya registrado.' error;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertLugar` (IN `v_nombre` VARCHAR(100), IN `v_descripcion` TEXT, IN `v_tipo` VARCHAR(10))  BEGIN
IF NOT EXISTS(SELECT id FROM lugar WHERE tipo LIKE v_tipo) THEN
INSERT INTO lugar VALUES(null,v_nombre,v_descripcion,v_tipo);
SELECT @@identity AS id, 'Lugar registrado exitosamente.' AS error;
ELSE
SELECT 'Error: Lugar ya registrado.' error;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertMenu` (IN `nombre` VARCHAR(100), IN `descripcion` TEXT, IN `tipo` VARCHAR(10))  BEGIN
INSERT INTO menu VALUES(null,nombre,descripcion,tipo);
SELECT @@identity AS id, 'Registro insertado exitosamente.' AS error;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertReservacion` (IN `v_id_user` INT, IN `v_fecha_pedido` DATETIME)  BEGIN
INSERT INTO reservacion VALUES(null,v_id_user,CURRENT_TIMESTAMP,v_fecha_pedido);
SELECT @@identity AS id, 'Reservacion Registrada exitosamente.' AS error;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertUser` (IN `v_nombre` VARCHAR(50), IN `v_apellido` VARCHAR(50), IN `v_correo` VARCHAR(100), IN `v_contra` VARCHAR(100), IN `v_celular` INT, IN `v_tipo` VARCHAR(5))  BEGIN
IF NOT EXISTS(SELECT id FROM user WHERE correo LIKE v_correo) THEN
INSERT INTO user VALUES(null,v_nombre,v_apellido,v_correo,v_contra,v_celular,v_tipo,CURRENT_TIMESTAMP);
SELECT @@identity AS id,v_tipo AS tipo, 'Usuario creado exitosamente :)' AS error;
ELSE
SELECT 'Error: Correo ya registrado.' error;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pSession` (IN `v_correo` VARCHAR(100), IN `v_pwd` VARCHAR(100))  BEGIN
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
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE `articulo` (
  `id` int(11) NOT NULL,
  `id_reservacion` int(11) DEFAULT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `articulo`
--

INSERT INTO `articulo` (`id`, `id_reservacion`, `nombre`, `cantidad`) VALUES
(1, 1, 'mesa', 2),
(2, 2, 'sillas', 18),
(3, 3, 'mesas', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `img_lugar`
--

CREATE TABLE `img_lugar` (
  `id` int(11) NOT NULL,
  `id_lugar` int(11) DEFAULT NULL,
  `src` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lugar`
--

CREATE TABLE `lugar` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8_spanish_ci,
  `tipo` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `lugar`
--

INSERT INTO `lugar` (`id`, `nombre`, `descripcion`, `tipo`) VALUES
(1, 'Sala de juegos para niños', 'Es el mejor lugar para comer con tus niños', 'niño'),
(2, 'Aire libre', 'Un lugar tranquilo para comer', 'patio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8_spanish_ci,
  `tipo` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `menu`
--

INSERT INTO `menu` (`id`, `nombre`, `descripcion`, `tipo`) VALUES
(1, 'Pizza', 'con peperoni y piña y mas', 'rapido'),
(2, 'Cafe', 'calentito cafe', 'desayuno');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservacion`
--

CREATE TABLE `reservacion` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `fecha_pedido` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `reservacion`
--

INSERT INTO `reservacion` (`id`, `id_user`, `fecha`, `fecha_pedido`) VALUES
(1, 7, '2016-11-15 14:20:20', '2016-11-15 14:03:02'),
(2, 7, '2016-11-15 14:47:53', '2016-11-16 14:03:02'),
(3, 5, '2016-11-15 14:51:37', '2016-11-16 14:03:02'),
(4, 8, '2016-11-15 14:53:05', '2016-11-17 14:03:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `apellido` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `correo` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `contra` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `celular` int(11) DEFAULT NULL,
  `tipo` varchar(5) COLLATE utf8_spanish_ci NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `nombre`, `apellido`, `correo`, `contra`, `celular`, `tipo`, `fecha`) VALUES
(5, 'Raul', 'Nicolas', 'raul@gmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 75745122, 'admin', '0000-00-00 00:00:00'),
(7, 'Juan', 'Perez', 'juan@gmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 730065422, 'admin', '0000-00-00 00:00:00'),
(8, 'Pancho', 'Bargas', 'pancho@gmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 784512366, 'user', '0000-00-00 00:00:00'),
(9, 'Rosario', 'Jimenez', 'rosario@gmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 757441246, 'user', '0000-00-00 00:00:00'),
(14, 'Miguel', 'Cardozo', 'miguel@gmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 75784122, 'user', '2016-11-15 14:03:02'),
(15, 'terry', 'romero', 'terry@gmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 68691833, 'admin', '2016-11-17 11:58:36');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_reservacion` (`id_reservacion`);

--
-- Indices de la tabla `img_lugar`
--
ALTER TABLE `img_lugar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_lugar` (`id_lugar`);

--
-- Indices de la tabla `lugar`
--
ALTER TABLE `lugar`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `reservacion`
--
ALTER TABLE `reservacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulo`
--
ALTER TABLE `articulo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `img_lugar`
--
ALTER TABLE `img_lugar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `lugar`
--
ALTER TABLE `lugar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `reservacion`
--
ALTER TABLE `reservacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `articulo_ibfk_1` FOREIGN KEY (`id_reservacion`) REFERENCES `reservacion` (`id`);

--
-- Filtros para la tabla `img_lugar`
--
ALTER TABLE `img_lugar`
  ADD CONSTRAINT `img_lugar_ibfk_1` FOREIGN KEY (`id_lugar`) REFERENCES `lugar` (`id`);

--
-- Filtros para la tabla `reservacion`
--
ALTER TABLE `reservacion`
  ADD CONSTRAINT `reservacion_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

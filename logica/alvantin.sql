-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 14-11-2016 a las 21:07:50
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertUser` (IN `v_nombre` VARCHAR(50), IN `v_apellido` VARCHAR(50), IN `v_correo` VARCHAR(100), IN `v_contra` VARCHAR(100), IN `v_celular` INT, IN `v_tipo` VARCHAR(5))  BEGIN
IF NOT EXISTS(SELECT id FROM user WHERE correo LIKE v_correo) THEN
INSERT INTO user VALUES(null,v_nombre,v_apellido,v_correo,v_contra,v_celular,v_tipo);
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
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `apellido` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `correo` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `contra` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `celular` int(11) DEFAULT NULL,
  `tipo` varchar(5) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `nombre`, `apellido`, `correo`, `contra`, `celular`, `tipo`) VALUES
(5, 'Raul', 'Nicolas', 'raul@gmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 75745122, 'admin'),
(7, 'Juan', 'Perez', 'juan@gmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 730065422, 'admin'),
(8, 'Pancho', 'Bargas', 'pancho@gmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 784512366, 'user'),
(9, 'Rosario', 'Jimenez', 'rosario@gmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 757441246, 'user'),
(10, 'prueba', 'prueba', 'prueba@pruebaq', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 75221455, 'user'),
(11, 'asdfasd', 'fsdfa', 'fasdf@dafsd', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 75223131, 'user'),
(12, 'sdfas', 'sddjasdklj', 'dasd@asd', '51d342a69d83403c178ee7afcf12dd8f1925e207', 6545456, 'user'),
(13, 'SFSADF', 'ASDFASDF', 'asdfsdf@dfasdf', '6d56f91deec1b80520b7e0584ad36a6b745b202e', 2147483647, 'admin');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

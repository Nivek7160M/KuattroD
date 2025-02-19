-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-02-2025 a las 05:19:20
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pgrrhh`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ampliacion_solicitud`
--

CREATE TABLE `tbl_ampliacion_solicitud` (
  `id_ampliacion` int(11) NOT NULL,
  `nombre_ampliacion` varchar(255) NOT NULL,
  `prorroga` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_area_trabajo`
--

CREATE TABLE `tbl_area_trabajo` (
  `id_area` int(11) NOT NULL,
  `nombre_area` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_area_trabajo`
--

INSERT INTO `tbl_area_trabajo` (`id_area`, `nombre_area`) VALUES
(1, 'Sistemas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_bitacora`
--

CREATE TABLE `tbl_bitacora` (
  `id_bitacora` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `id_objeto` int(11) DEFAULT NULL,
  `acciones` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cargo`
--

CREATE TABLE `tbl_cargo` (
  `id_cargo` int(11) NOT NULL,
  `nombre_cargo` varchar(255) NOT NULL,
  `id_cargo_jefe` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ciudad`
--

CREATE TABLE `tbl_ciudad` (
  `id_ciudad` int(11) NOT NULL,
  `nombre_ciudad` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_ciudad`
--

INSERT INTO `tbl_ciudad` (`id_ciudad`, `nombre_ciudad`) VALUES
(1, 'La Ceiba'),
(2, 'Trujillo'),
(3, 'Comayagua'),
(4, 'Santa Rosa de Copán'),
(5, 'San Pedro Sula'),
(6, 'Choluteca'),
(7, 'Danlí'),
(8, 'Tegucigalpa'),
(9, 'Puerto Lempira'),
(10, 'La Esperanza'),
(11, 'Coxen Hole'),
(12, 'La Paz'),
(13, 'Gracias'),
(14, 'Nueva Ocotepeque'),
(15, 'Juticalpa'),
(16, 'Santa Bárbara'),
(17, 'Nacaome'),
(18, 'El Progreso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_correo`
--

CREATE TABLE `tbl_correo` (
  `id_correo` int(11) NOT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `correo` varchar(255) NOT NULL,
  `id_tipo_correo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_departamento`
--

CREATE TABLE `tbl_departamento` (
  `id_departamento` int(11) NOT NULL,
  `nombre_departamento` varchar(255) NOT NULL,
  `id_municipio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_departamento`
--

INSERT INTO `tbl_departamento` (`id_departamento`, `nombre_departamento`, `id_municipio`) VALUES
(1, 'Atlántida', 1),
(2, 'Colón', 2),
(3, 'Comayagua', 3),
(4, 'Copán', 4),
(5, 'Cortés', 5),
(6, 'Choluteca', 6),
(7, 'El Paraíso', 7),
(8, 'Francisco Morazán', 8),
(9, 'Gracias a Dios', 9),
(10, 'Intibucá', 10),
(11, 'Islas de la Bahía', 11),
(12, 'La Paz', 12),
(13, 'Lempira', 13),
(14, 'Ocotepeque', 14),
(15, 'Olancho', 15),
(16, 'Santa Bárbara', 16),
(17, 'Valle', 17),
(18, 'Yoro', 18);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_empleado`
--

CREATE TABLE `tbl_empleado` (
  `Id_empleado` int(11) NOT NULL,
  `id_cargo` int(11) DEFAULT NULL,
  `dni_empleado` varchar(100) NOT NULL,
  `Primer_nombre` varchar(255) NOT NULL,
  `segundo_nombre` varchar(255) DEFAULT NULL,
  `primer_apellido` varchar(255) NOT NULL,
  `segundo_apellido` varchar(255) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `fecha_contratacion` date DEFAULT NULL,
  `empleado_delegado` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_empleado`
--

INSERT INTO `tbl_empleado` (`Id_empleado`, `id_cargo`, `dni_empleado`, `Primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `fecha_nacimiento`, `fecha_contratacion`, `empleado_delegado`) VALUES
(2, NULL, '123456789', 'Juan', 'Carlos', 'Pérez', 'González', '1990-03-15', '2015-06-01', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_estado`
--

CREATE TABLE `tbl_estado` (
  `id_estado` int(11) NOT NULL,
  `nombre_estado` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_estado`
--

INSERT INTO `tbl_estado` (`id_estado`, `nombre_estado`) VALUES
(1, 'Aprobada'),
(2, 'Rechazada'),
(3, 'En revision');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_estado_usuario`
--

CREATE TABLE `tbl_estado_usuario` (
  `id_estado_usuario` int(11) NOT NULL,
  `nombre_estado_usuario` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_estado_usuario`
--

INSERT INTO `tbl_estado_usuario` (`id_estado_usuario`, `nombre_estado_usuario`) VALUES
(1, 'Activo'),
(2, 'Inactivo'),
(3, 'Bloqueado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_genero`
--

CREATE TABLE `tbl_genero` (
  `id_genero` int(11) NOT NULL,
  `nombre_genero` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_genero`
--

INSERT INTO `tbl_genero` (`id_genero`, `nombre_genero`) VALUES
(1, 'Masculino'),
(2, 'Femenino');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_historial_contraseña`
--

CREATE TABLE `tbl_historial_contraseña` (
  `id_contraseña` int(11) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `contraseña_antigua` varchar(255) DEFAULT NULL,
  `Recordar_datos` tinyint(1) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_municipio`
--

CREATE TABLE `tbl_municipio` (
  `id_municipio` int(11) NOT NULL,
  `nombre_municipio` varchar(255) NOT NULL,
  `id_ciudad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_municipio`
--

INSERT INTO `tbl_municipio` (`id_municipio`, `nombre_municipio`, `id_ciudad`) VALUES
(1, 'La Ceiba', 1),
(2, 'Trujillo', 2),
(3, 'Comayagua', 3),
(4, 'Santa Rosa de Copán', 4),
(5, 'San Pedro Sula', 5),
(6, 'Choluteca', 6),
(7, 'Danlí', 7),
(8, 'Distrito Central', 8),
(9, 'Puerto Lempira', 9),
(10, 'La Esperanza', 10),
(11, 'Coxen Hole', 11),
(12, 'La Paz', 12),
(13, 'Gracias', 13),
(14, 'Nueva Ocotepeque', 14),
(15, 'Juticalpa', 15),
(16, 'Santa Bárbara', 16),
(17, 'Nacaome', 17),
(18, 'El Progreso', 18);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_objeto`
--

CREATE TABLE `tbl_objeto` (
  `id_objeto` int(11) NOT NULL,
  `objeto` varchar(255) NOT NULL,
  `descripcion_objeto` varchar(255) DEFAULT NULL,
  `tipo_objeto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_otp`
--

CREATE TABLE `tbl_otp` (
  `Id_otp` int(11) NOT NULL,
  `otp` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_otp`
--

INSERT INTO `tbl_otp` (`Id_otp`, `otp`) VALUES
(2, 'assafas321');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_parametros`
--

CREATE TABLE `tbl_parametros` (
  `id_parametro` int(11) NOT NULL,
  `nombre_parametro` varchar(255) NOT NULL,
  `valor_parametro` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_permisos`
--

CREATE TABLE `tbl_permisos` (
  `id_permiso` int(11) NOT NULL,
  `id_objeto` int(11) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `permiso_creacion` tinyint(1) DEFAULT 0,
  `permiso_eliminacion` tinyint(1) DEFAULT 0,
  `permiso_actualizacion` tinyint(1) DEFAULT 0,
  `permiso_consultar` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_rol`
--

CREATE TABLE `tbl_rol` (
  `Id_roll` int(11) NOT NULL,
  `rol` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `creado_por` int(11) DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL,
  `modificado_por` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_rol`
--

INSERT INTO `tbl_rol` (`Id_roll`, `rol`, `descripcion`, `fecha_creacion`, `creado_por`, `fecha_modificacion`, `modificado_por`) VALUES
(1, 'Administrador', 'Rol con acceso total al sistema', '2025-02-03', NULL, '2025-02-03', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_solicitudes`
--

CREATE TABLE `tbl_solicitudes` (
  `id_solicitud` int(11) NOT NULL,
  `fecha_solicitud` date NOT NULL,
  `fecha_final_solicitud` date DEFAULT NULL,
  `fecha_inicio_solicitud` date DEFAULT NULL,
  `fecha_aprovacion` date DEFAULT NULL,
  `Usuario_aprobacion` varchar(255) DEFAULT NULL,
  `observaciones_solicitud` text DEFAULT NULL,
  `Id_usuario` int(11) DEFAULT NULL,
  `Id_estado` int(11) DEFAULT NULL,
  `validacion_img` blob DEFAULT NULL,
  `id_tipo_solicitud` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_sucursal`
--

CREATE TABLE `tbl_sucursal` (
  `Id_sucursal` int(11) NOT NULL,
  `nombre_sucursal` varchar(255) NOT NULL,
  `id_departamento` int(11) DEFAULT NULL,
  `id_ciudad` int(11) DEFAULT NULL,
  `id_municipio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_sucursal`
--

INSERT INTO `tbl_sucursal` (`Id_sucursal`, `nombre_sucursal`, `id_departamento`, `id_ciudad`, `id_municipio`) VALUES
(1, 'Sucursal La Ceiba', 1, 1, 1),
(2, 'Sucursal Trujillo', 2, 2, 2),
(3, 'Sucursal Comayagua', 3, 3, 3),
(4, 'Sucursal Copán', 4, 4, 4),
(5, 'Sucursal San Pedro Sula', 5, 5, 5),
(6, 'Sucursal Choluteca', 6, 6, 6),
(7, 'Sucursal Danlí', 7, 7, 7),
(8, 'Sucursal Tegucigalpa', 8, 8, 8),
(9, 'Sucursal Puerto Lempira', 9, 9, 9),
(10, 'Sucursal La Esperanza', 10, 10, 10),
(11, 'Sucursal Islas de la Bahía', 11, 11, 11),
(12, 'Sucursal La Paz', 12, 12, 12),
(13, 'Sucursal Gracias', 13, 13, 13),
(14, 'Sucursal Ocotepeque', 14, 14, 14),
(15, 'Sucursal Juticalpa', 15, 15, 15),
(16, 'Sucursal Santa Bárbara', 16, 16, 16),
(17, 'Sucursal Nacaome', 17, 17, 17),
(18, 'Sucursal El Progreso', 18, 18, 18),
(19, 'Sucursal La Ceiba', 1, 1, 1),
(20, 'Sucursal Trujillo', 2, 2, 2),
(21, 'Sucursal Comayagua', 3, 3, 3),
(22, 'Sucursal Copán', 4, 4, 4),
(23, 'Sucursal San Pedro Sula', 5, 5, 5),
(24, 'Sucursal Choluteca', 6, 6, 6),
(25, 'Sucursal Danlí', 7, 7, 7),
(26, 'Sucursal Tegucigalpa', 8, 8, 8),
(27, 'Sucursal Puerto Lempira', 9, 9, 9),
(28, 'Sucursal La Esperanza', 10, 10, 10),
(29, 'Sucursal Islas de la Bahía', 11, 11, 11),
(30, 'Sucursal La Paz', 12, 12, 12),
(31, 'Sucursal Gracias', 13, 13, 13),
(32, 'Sucursal Ocotepeque', 14, 14, 14),
(33, 'Sucursal Juticalpa', 15, 15, 15),
(34, 'Sucursal Santa Bárbara', 16, 16, 16),
(35, 'Sucursal Nacaome', 17, 17, 17),
(36, 'Sucursal El Progreso', 18, 18, 18);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_telefono`
--

CREATE TABLE `tbl_telefono` (
  `id_telefono` int(11) NOT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `numero_telefono` varchar(15) NOT NULL,
  `id_tipo_telefono` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipo_correo`
--

CREATE TABLE `tbl_tipo_correo` (
  `Id_Tipo_Correo` int(11) NOT NULL,
  `nombre_tipo_correo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_tipo_correo`
--

INSERT INTO `tbl_tipo_correo` (`Id_Tipo_Correo`, `nombre_tipo_correo`) VALUES
(1, 'Personal'),
(2, 'Institucional'),
(3, 'Personal'),
(4, 'Institucional');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipo_solicitud`
--

CREATE TABLE `tbl_tipo_solicitud` (
  `Id_tipo_solicitud` int(11) NOT NULL,
  `Nombre_tipo_solicitud` varchar(255) NOT NULL,
  `Descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_tipo_solicitud`
--

INSERT INTO `tbl_tipo_solicitud` (`Id_tipo_solicitud`, `Nombre_tipo_solicitud`, `Descripcion`) VALUES
(1, 'Vacaciones', 'Solicitude de vacaciones del empleado.'),
(2, 'Incapacidad', 'Solicitud de incapacidad del empleado.'),
(3, 'Permiso', 'Solicitud de permiso menor de 4 horas.'),
(4, 'Vacaciones', 'Solicitude de vacaciones del empleado.'),
(5, 'Incapacidad', 'Solicitud de incapacidad del empleado.'),
(6, 'Permiso', 'Solicitud de permiso menor de 4 horas.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipo_telefono`
--

CREATE TABLE `tbl_tipo_telefono` (
  `id_tipo_telefono` int(11) NOT NULL,
  `nombre_tipo_telefono` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_tipo_telefono`
--

INSERT INTO `tbl_tipo_telefono` (`id_tipo_telefono`, `nombre_tipo_telefono`) VALUES
(1, 'Ejecutivo'),
(2, 'Personal'),
(3, 'Ejecutivo'),
(4, 'Personal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuario`
--

CREATE TABLE `tbl_usuario` (
  `Id_Usuario` int(11) NOT NULL,
  `id_genero` int(11) DEFAULT NULL,
  `id_area` int(11) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `id_sucursal` int(11) DEFAULT NULL,
  `contraseña` varchar(255) NOT NULL,
  `Id_empleado` int(11) DEFAULT NULL,
  `id_contraseña` int(11) DEFAULT NULL,
  `nomb_usuario` varchar(255) NOT NULL,
  `id_estado_usuario` int(11) DEFAULT NULL,
  `Id_otp` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_usuario`
--

INSERT INTO `tbl_usuario` (`Id_Usuario`, `id_genero`, `id_area`, `id_rol`, `id_sucursal`, `contraseña`, `Id_empleado`, `id_contraseña`, `nomb_usuario`, `id_estado_usuario`, `Id_otp`) VALUES
(1, 1, 1, 1, 8, 'Admin_123', 2, NULL, 'Juan', 1, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_ampliacion_solicitud`
--
ALTER TABLE `tbl_ampliacion_solicitud`
  ADD PRIMARY KEY (`id_ampliacion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `tbl_area_trabajo`
--
ALTER TABLE `tbl_area_trabajo`
  ADD PRIMARY KEY (`id_area`);

--
-- Indices de la tabla `tbl_bitacora`
--
ALTER TABLE `tbl_bitacora`
  ADD PRIMARY KEY (`id_bitacora`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_objeto` (`id_objeto`);

--
-- Indices de la tabla `tbl_cargo`
--
ALTER TABLE `tbl_cargo`
  ADD PRIMARY KEY (`id_cargo`),
  ADD KEY `id_cargo_jefe` (`id_cargo_jefe`);

--
-- Indices de la tabla `tbl_ciudad`
--
ALTER TABLE `tbl_ciudad`
  ADD PRIMARY KEY (`id_ciudad`);

--
-- Indices de la tabla `tbl_correo`
--
ALTER TABLE `tbl_correo`
  ADD PRIMARY KEY (`id_correo`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `id_empleado` (`id_empleado`),
  ADD KEY `id_tipo_correo` (`id_tipo_correo`);

--
-- Indices de la tabla `tbl_departamento`
--
ALTER TABLE `tbl_departamento`
  ADD PRIMARY KEY (`id_departamento`),
  ADD KEY `id_municipio` (`id_municipio`);

--
-- Indices de la tabla `tbl_empleado`
--
ALTER TABLE `tbl_empleado`
  ADD PRIMARY KEY (`Id_empleado`),
  ADD UNIQUE KEY `dni_empleado` (`dni_empleado`),
  ADD KEY `id_cargo` (`id_cargo`);

--
-- Indices de la tabla `tbl_estado`
--
ALTER TABLE `tbl_estado`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `tbl_estado_usuario`
--
ALTER TABLE `tbl_estado_usuario`
  ADD PRIMARY KEY (`id_estado_usuario`);

--
-- Indices de la tabla `tbl_genero`
--
ALTER TABLE `tbl_genero`
  ADD PRIMARY KEY (`id_genero`);

--
-- Indices de la tabla `tbl_historial_contraseña`
--
ALTER TABLE `tbl_historial_contraseña`
  ADD PRIMARY KEY (`id_contraseña`),
  ADD KEY `IdUsuario` (`id_usuario`);

--
-- Indices de la tabla `tbl_municipio`
--
ALTER TABLE `tbl_municipio`
  ADD PRIMARY KEY (`id_municipio`),
  ADD KEY `id_ciudad` (`id_ciudad`);

--
-- Indices de la tabla `tbl_objeto`
--
ALTER TABLE `tbl_objeto`
  ADD PRIMARY KEY (`id_objeto`);

--
-- Indices de la tabla `tbl_otp`
--
ALTER TABLE `tbl_otp`
  ADD PRIMARY KEY (`Id_otp`);

--
-- Indices de la tabla `tbl_parametros`
--
ALTER TABLE `tbl_parametros`
  ADD PRIMARY KEY (`id_parametro`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `tbl_permisos`
--
ALTER TABLE `tbl_permisos`
  ADD PRIMARY KEY (`id_permiso`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `id_objeto` (`id_objeto`);

--
-- Indices de la tabla `tbl_rol`
--
ALTER TABLE `tbl_rol`
  ADD PRIMARY KEY (`Id_roll`);

--
-- Indices de la tabla `tbl_solicitudes`
--
ALTER TABLE `tbl_solicitudes`
  ADD PRIMARY KEY (`id_solicitud`),
  ADD KEY `Id_usuario` (`Id_usuario`),
  ADD KEY `Id_estado` (`Id_estado`);

--
-- Indices de la tabla `tbl_sucursal`
--
ALTER TABLE `tbl_sucursal`
  ADD PRIMARY KEY (`Id_sucursal`),
  ADD KEY `id_ciudad` (`id_ciudad`),
  ADD KEY `id_departamento` (`id_departamento`),
  ADD KEY `id_municipio` (`id_municipio`);

--
-- Indices de la tabla `tbl_telefono`
--
ALTER TABLE `tbl_telefono`
  ADD PRIMARY KEY (`id_telefono`),
  ADD KEY `id_empleado` (`id_empleado`),
  ADD KEY `id_tipo_telefono` (`id_tipo_telefono`);

--
-- Indices de la tabla `tbl_tipo_correo`
--
ALTER TABLE `tbl_tipo_correo`
  ADD PRIMARY KEY (`Id_Tipo_Correo`);

--
-- Indices de la tabla `tbl_tipo_solicitud`
--
ALTER TABLE `tbl_tipo_solicitud`
  ADD PRIMARY KEY (`Id_tipo_solicitud`);

--
-- Indices de la tabla `tbl_tipo_telefono`
--
ALTER TABLE `tbl_tipo_telefono`
  ADD PRIMARY KEY (`id_tipo_telefono`);

--
-- Indices de la tabla `tbl_usuario`
--
ALTER TABLE `tbl_usuario`
  ADD PRIMARY KEY (`Id_Usuario`),
  ADD KEY `genero` (`id_genero`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `id_sucursal` (`id_sucursal`),
  ADD KEY `Id_empleado` (`Id_empleado`),
  ADD KEY `id_contraseña` (`id_contraseña`),
  ADD KEY `id_estado_usuario` (`id_estado_usuario`),
  ADD KEY `id_area` (`id_area`),
  ADD KEY `Id_otp` (`Id_otp`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_empleado`
--
ALTER TABLE `tbl_empleado`
  MODIFY `Id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tbl_otp`
--
ALTER TABLE `tbl_otp`
  MODIFY `Id_otp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tbl_rol`
--
ALTER TABLE `tbl_rol`
  MODIFY `Id_roll` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tbl_sucursal`
--
ALTER TABLE `tbl_sucursal`
  MODIFY `Id_sucursal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `tbl_telefono`
--
ALTER TABLE `tbl_telefono`
  MODIFY `id_telefono` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_tipo_correo`
--
ALTER TABLE `tbl_tipo_correo`
  MODIFY `Id_Tipo_Correo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tbl_tipo_solicitud`
--
ALTER TABLE `tbl_tipo_solicitud`
  MODIFY `Id_tipo_solicitud` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tbl_tipo_telefono`
--
ALTER TABLE `tbl_tipo_telefono`
  MODIFY `id_tipo_telefono` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tbl_usuario`
--
ALTER TABLE `tbl_usuario`
  MODIFY `Id_Usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_bitacora`
--
ALTER TABLE `tbl_bitacora`
  ADD CONSTRAINT `tbl_bitacora_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_usuario` (`Id_Usuario`);

--
-- Filtros para la tabla `tbl_empleado`
--
ALTER TABLE `tbl_empleado`
  ADD CONSTRAINT `tbl_empleado_ibfk_1` FOREIGN KEY (`id_cargo`) REFERENCES `tbl_cargo` (`id_cargo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tbl_historial_contraseña`
--
ALTER TABLE `tbl_historial_contraseña`
  ADD CONSTRAINT `IdUsuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_usuario` (`Id_Usuario`);

--
-- Filtros para la tabla `tbl_parametros`
--
ALTER TABLE `tbl_parametros`
  ADD CONSTRAINT `tbl_parametros_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_usuario` (`Id_Usuario`);

--
-- Filtros para la tabla `tbl_permisos`
--
ALTER TABLE `tbl_permisos`
  ADD CONSTRAINT `tbl_permisos_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `tbl_rol` (`Id_roll`),
  ADD CONSTRAINT `tbl_permisos_ibfk_2` FOREIGN KEY (`id_objeto`) REFERENCES `tbl_objeto` (`id_objeto`);

--
-- Filtros para la tabla `tbl_solicitudes`
--
ALTER TABLE `tbl_solicitudes`
  ADD CONSTRAINT `tbl_solicitudes_ibfk_1` FOREIGN KEY (`Id_usuario`) REFERENCES `tbl_usuario` (`Id_Usuario`),
  ADD CONSTRAINT `tbl_solicitudes_ibfk_2` FOREIGN KEY (`Id_estado`) REFERENCES `tbl_estado` (`id_estado`);

--
-- Filtros para la tabla `tbl_sucursal`
--
ALTER TABLE `tbl_sucursal`
  ADD CONSTRAINT `tbl_sucursal_ibfk_1` FOREIGN KEY (`id_ciudad`) REFERENCES `tbl_ciudad` (`id_ciudad`),
  ADD CONSTRAINT `tbl_sucursal_ibfk_2` FOREIGN KEY (`id_departamento`) REFERENCES `tbl_departamento` (`id_departamento`),
  ADD CONSTRAINT `tbl_sucursal_ibfk_3` FOREIGN KEY (`id_municipio`) REFERENCES `tbl_municipio` (`id_municipio`);

--
-- Filtros para la tabla `tbl_telefono`
--
ALTER TABLE `tbl_telefono`
  ADD CONSTRAINT `tbl_telefono_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `tbl_empleado` (`Id_empleado`),
  ADD CONSTRAINT `tbl_telefono_ibfk_2` FOREIGN KEY (`id_tipo_telefono`) REFERENCES `tbl_tipo_telefono` (`id_tipo_telefono`);

--
-- Filtros para la tabla `tbl_usuario`
--
ALTER TABLE `tbl_usuario`
  ADD CONSTRAINT `genero` FOREIGN KEY (`id_genero`) REFERENCES `tbl_genero` (`id_genero`),
  ADD CONSTRAINT `tbl_usuario_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `tbl_rol` (`Id_roll`),
  ADD CONSTRAINT `tbl_usuario_ibfk_2` FOREIGN KEY (`id_sucursal`) REFERENCES `tbl_sucursal` (`Id_sucursal`),
  ADD CONSTRAINT `tbl_usuario_ibfk_3` FOREIGN KEY (`Id_empleado`) REFERENCES `tbl_empleado` (`Id_empleado`),
  ADD CONSTRAINT `tbl_usuario_ibfk_4` FOREIGN KEY (`id_contraseña`) REFERENCES `tbl_historial_contraseña` (`id_contraseña`),
  ADD CONSTRAINT `tbl_usuario_ibfk_5` FOREIGN KEY (`id_estado_usuario`) REFERENCES `tbl_estado_usuario` (`id_estado_usuario`),
  ADD CONSTRAINT `tbl_usuario_ibfk_6` FOREIGN KEY (`id_area`) REFERENCES `tbl_area_trabajo` (`id_area`),
  ADD CONSTRAINT `tbl_usuario_ibfk_7` FOREIGN KEY (`Id_otp`) REFERENCES `tbl_otp` (`Id_otp`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

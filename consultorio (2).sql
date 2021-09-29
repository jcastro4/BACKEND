-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 29-09-2021 a las 18:13:35
-- Versión del servidor: 10.4.13-MariaDB
-- Versión de PHP: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `consultorio`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agenda`
--

DROP TABLE IF EXISTS `agenda`;
CREATE TABLE IF NOT EXISTS `agenda` (
  `idagenda` int(11) NOT NULL,
  `idmedico` int(11) NOT NULL,
  `idpersona` int(11) NOT NULL,
  `fechaagenda` date NOT NULL,
  `horainicio` time NOT NULL,
  `estadoagenda` varchar(10) NOT NULL,
  PRIMARY KEY (`idagenda`),
  KEY `idmedico` (`idmedico`),
  KEY `idpersona` (`idpersona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultamedica`
--

DROP TABLE IF EXISTS `consultamedica`;
CREATE TABLE IF NOT EXISTS `consultamedica` (
  `idconsulta` int(11) NOT NULL,
  `idmedico` int(11) NOT NULL,
  `idpaciente` int(11) NOT NULL,
  `idagenda` int(11) NOT NULL,
  `diagnostico` varchar(100) NOT NULL,
  `remision` varchar(100) NOT NULL,
  `proximacita` varchar(100) NOT NULL,
  PRIMARY KEY (`idconsulta`),
  KEY `idmedico` (`idmedico`),
  KEY `idpaciente` (`idpaciente`),
  KEY `idagenda` (`idagenda`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `formulamedica`
--

DROP TABLE IF EXISTS `formulamedica`;
CREATE TABLE IF NOT EXISTS `formulamedica` (
  `idformula` int(11) NOT NULL,
  `idhistoria` int(11) NOT NULL,
  `consultaid` int(11) NOT NULL,
  `detalle` varchar(100) NOT NULL,
  PRIMARY KEY (`idformula`),
  KEY `idhistoria` (`idhistoria`),
  KEY `idconsulta` (`consultaid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `formula_medicamento`
--

DROP TABLE IF EXISTS `formula_medicamento`;
CREATE TABLE IF NOT EXISTS `formula_medicamento` (
  `idformulas` int(11) NOT NULL,
  `idmedicamentos` int(11) NOT NULL,
  KEY `idformulas` (`idformulas`),
  KEY `idmedicamentos` (`idmedicamentos`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamento`
--

DROP TABLE IF EXISTS `medicamento`;
CREATE TABLE IF NOT EXISTS `medicamento` (
  `idmedicamento` int(11) NOT NULL,
  `nombremedicamento` varchar(100) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `disponibilidad` varchar(10) NOT NULL,
  PRIMARY KEY (`idmedicamento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

DROP TABLE IF EXISTS `persona`;
CREATE TABLE IF NOT EXISTS `persona` (
  `idpersona` int(11) NOT NULL,
  `usuarioid` int(11) NOT NULL,
  `idtiporol` int(11) NOT NULL,
  `documento` int(11) NOT NULL,
  `nombre1` varchar(34) NOT NULL,
  `nombre2` varchar(34) NOT NULL,
  `apellido1` varchar(34) NOT NULL,
  `apellido2` varchar(34) NOT NULL,
  `fechanacimiento` date NOT NULL,
  `edad` int(11) NOT NULL,
  `departamentorecidencia` varchar(50) NOT NULL,
  `municipiorecidencia` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` int(11) NOT NULL,
  `celular` int(11) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `estado` varchar(34) NOT NULL,
  PRIMARY KEY (`idpersona`),
  KEY `idtiporol` (`idtiporol`),
  KEY `usuarioid` (`usuarioid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

DROP TABLE IF EXISTS `rol`;
CREATE TABLE IF NOT EXISTS `rol` (
  `Idrol` int(11) NOT NULL,
  `detallerol` varchar(34) NOT NULL,
  PRIMARY KEY (`Idrol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `idusuario` int(11) NOT NULL,
  `username` varchar(34) NOT NULL,
  `contraseña` varchar(34) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `consultamedica`
--
ALTER TABLE `consultamedica`
  ADD CONSTRAINT `consultamedica_ibfk_1` FOREIGN KEY (`idmedico`) REFERENCES `persona` (`idpersona`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `consultamedica_ibfk_2` FOREIGN KEY (`idpaciente`) REFERENCES `persona` (`idpersona`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `consultamedica_ibfk_3` FOREIGN KEY (`idagenda`) REFERENCES `agenda` (`idagenda`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `formulamedica`
--
ALTER TABLE `formulamedica`
  ADD CONSTRAINT `formulamedica_ibfk_1` FOREIGN KEY (`consultaid`) REFERENCES `consultamedica` (`idconsulta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `formula_medicamento`
--
ALTER TABLE `formula_medicamento`
  ADD CONSTRAINT `formula_medicamento_ibfk_1` FOREIGN KEY (`idformulas`) REFERENCES `formulamedica` (`idformula`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `formula_medicamento_ibfk_2` FOREIGN KEY (`idmedicamentos`) REFERENCES `medicamento` (`idmedicamento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`idtiporol`) REFERENCES `rol` (`Idrol`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `persona_ibfk_2` FOREIGN KEY (`usuarioid`) REFERENCES `usuario` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

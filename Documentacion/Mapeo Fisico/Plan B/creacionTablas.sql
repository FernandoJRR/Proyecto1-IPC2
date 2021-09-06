-- MariaDB dump 10.19  Distrib 10.6.4-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: muebleria_mimuebleria
-- ------------------------------------------------------
-- Server version	10.6.4-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `nit` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `municipio` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `departamento` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`nit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compra` (
  `factura` int(11) NOT NULL,
  `mueble_comprado` int(11) NOT NULL,
  `precio` float NOT NULL,
  `nombre_mueble` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`factura`,`mueble_comprado`),
  KEY `FK_compra_mueble` (`mueble_comprado`),
  KEY `FK_nombre_compra` (`nombre_mueble`),
  CONSTRAINT `FK_compra_factura` FOREIGN KEY (`factura`) REFERENCES `factura` (`id`),
  CONSTRAINT `FK_compra_mueble` FOREIGN KEY (`mueble_comprado`) REFERENCES `mueble` (`id`),
  CONSTRAINT `FK_nombre_compra` FOREIGN KEY (`nombre_mueble`) REFERENCES `mueble` (`nombre_mueble`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comprobante_devolucion`
--

DROP TABLE IF EXISTS `comprobante_devolucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comprobante_devolucion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cliente` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encargado` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_devolucion_encargado` (`encargado`),
  KEY `cliente` (`cliente`),
  CONSTRAINT `FK_devolucion_encargado` FOREIGN KEY (`encargado`) REFERENCES `usuario` (`username`),
  CONSTRAINT `comprobante_devolucion_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`nit`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `devolucion`
--

DROP TABLE IF EXISTS `devolucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devolucion` (
  `comprobante` int(11) NOT NULL,
  `mueble_devuelto` int(11) NOT NULL,
  `costo` float NOT NULL,
  `nombre_mueble` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`comprobante`,`mueble_devuelto`),
  KEY `FK_devolucion_mueble` (`mueble_devuelto`),
  KEY `FK_nombre_mueble` (`nombre_mueble`),
  CONSTRAINT `FK_devolucion_comprobante` FOREIGN KEY (`comprobante`) REFERENCES `comprobante_devolucion` (`id`),
  CONSTRAINT `FK_devolucion_mueble` FOREIGN KEY (`mueble_devuelto`) REFERENCES `mueble` (`id`),
  CONSTRAINT `FK_nombre_mueble` FOREIGN KEY (`nombre_mueble`) REFERENCES `mueble` (`nombre_mueble`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cliente` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encargado` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_factura_encargado` (`encargado`),
  KEY `cliente` (`cliente`),
  CONSTRAINT `FK_factura_encargado` FOREIGN KEY (`encargado`) REFERENCES `usuario` (`username`),
  CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`nit`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instrucciones_mueble`
--

DROP TABLE IF EXISTS `instrucciones_mueble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instrucciones_mueble` (
  `nombre_mueble` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_pieza` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad_pieza` int(11) NOT NULL,
  PRIMARY KEY (`nombre_mueble`,`tipo_pieza`),
  CONSTRAINT `FK_nombre_modelo` FOREIGN KEY (`nombre_mueble`) REFERENCES `modelo_mueble` (`nombre`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `modelo_mueble`
--

DROP TABLE IF EXISTS `modelo_mueble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modelo_mueble` (
  `nombre` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio_default` float NOT NULL,
  PRIMARY KEY (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mueble`
--

DROP TABLE IF EXISTS `mueble`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mueble` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_mueble` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio_venta` float NOT NULL,
  `usuario_ensamblador` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_ensamble` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mueble_usuario` (`usuario_ensamblador`),
  KEY `FK_mueble_nombre` (`nombre_mueble`),
  CONSTRAINT `FK_mueble_nombre` FOREIGN KEY (`nombre_mueble`) REFERENCES `modelo_mueble` (`nombre`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_mueble_usuario` FOREIGN KEY (`usuario_ensamblador`) REFERENCES `usuario` (`username`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pieza_de_madera`
--

DROP TABLE IF EXISTS `pieza_de_madera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pieza_de_madera` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `costo` float NOT NULL,
  `mueble` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`nombre`,`costo`),
  KEY `FK_pieza_mueble` (`mueble`),
  CONSTRAINT `FK_pieza_mueble` FOREIGN KEY (`mueble`) REFERENCES `mueble` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ultimas_lineas_cargadas`
--

DROP TABLE IF EXISTS `ultimas_lineas_cargadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ultimas_lineas_cargadas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expresion` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ultimos_errores`
--

DROP TABLE IF EXISTS `ultimos_errores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ultimos_errores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expresion` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `error` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=279 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `username` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_usuario` enum('FABRICA','VENTAS','FINANZAS') COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` enum('ACTIVO','CANCELADO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVO',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'muebleria_mimuebleria'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-06 11:32:25

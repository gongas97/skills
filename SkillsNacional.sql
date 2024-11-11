-- --------------------------------------------------------
-- Anfitrião:                    127.0.0.1
-- Versão do servidor:           10.4.32-MariaDB - mariadb.org binary distribution
-- SO do servidor:               Win64
-- HeidiSQL Versão:              12.7.0.6850
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- A despejar estrutura da base de dados para skillsnacional
DROP DATABASE IF EXISTS `skillsnacional`;
CREATE DATABASE IF NOT EXISTS `skillsnacional` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `skillsnacional`;

-- A despejar estrutura para tabela skillsnacional.admin
DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `idAdmin` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`idAdmin`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- A despejar dados para tabela skillsnacional.admin: ~1 rows (aproximadamente)
DELETE FROM `admin`;
INSERT INTO `admin` (`idAdmin`, `username`, `password`) VALUES
	(1, 'admin', 'admin');

-- A despejar estrutura para tabela skillsnacional.login
DROP TABLE IF EXISTS `login`;
CREATE TABLE IF NOT EXISTS `login` (
  `idLogin` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` int(11) NOT NULL,
  `hora` time NOT NULL,
  `IpOrigem` varchar(50) NOT NULL DEFAULT '',
  `estado` enum('Sucesso','Falha','Conta Bloqueada') NOT NULL,
  PRIMARY KEY (`idLogin`),
  KEY `FK__user` (`idUser`),
  CONSTRAINT `FK__user` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- A despejar dados para tabela skillsnacional.login: ~5 rows (aproximadamente)
DELETE FROM `login`;
INSERT INTO `login` (`idLogin`, `idUser`, `hora`, `IpOrigem`, `estado`) VALUES
	(18, 3, '10:58:51', '192.168.10.141', 'Sucesso'),
	(19, 3, '11:25:42', '192.168.10.141', 'Sucesso'),
	(20, 3, '12:00:00', '192.168.10.141', 'Sucesso'),
	(21, 3, '19:04:04', '192.168.1.5', 'Falha'),
	(22, 3, '19:04:10', '192.168.1.5', 'Sucesso');

-- A despejar estrutura para tabela skillsnacional.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `nomeUser` varchar(50) NOT NULL,
  `emailUser` varchar(50) NOT NULL,
  `nifUser` int(11) NOT NULL,
  `pergunta1` varchar(100) NOT NULL,
  `resposta1` varchar(100) NOT NULL,
  `pergunta2` varchar(100) NOT NULL,
  `resposta2` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `foto` varchar(200) DEFAULT NULL,
  `estado` enum('Ativo','Bloqueado','Inativo') DEFAULT 'Ativo',
  PRIMARY KEY (`idUser`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- A despejar dados para tabela skillsnacional.user: ~3 rows (aproximadamente)
DELETE FROM `user`;
INSERT INTO `user` (`idUser`, `nomeUser`, `emailUser`, `nifUser`, `pergunta1`, `resposta1`, `pergunta2`, `resposta2`, `username`, `password`, `foto`, `estado`) VALUES
	(3, 'Gonçalo Araújo', 'gongas19972@gmail.com', 256511977, 'Qual o Primeiro nome da Sua Mãe?', 'Helena', 'Qual o nome da cidade onde nasceu?', 'Lisboa', 'gongas97', '4bb0d2a2e258a47b5664a927b09f68d3', 'imagens/User/Foto_Gonçalo Araújo/Foto20241104161451.jpg', 'Ativo'),
	(5, 'Miguel Araújo', 'migas@gmail.com', 254543322, 'Qual o Seu signo?', 'Balança', 'Qual o nome do seu primeiro animal?', 'Millie', 'migas98', '93af40af6d7c38a607e72a1b7cf3952c', NULL, 'Ativo'),
	(7, 'Carolina Araújo', 'carocas1992@gmail.com', 234343455, 'Quantos irmãos tem?', '4', 'Qual o nome da cidade onde nasceu?', 'Lisboa', 'carocas1994', '4287479f96514f16c6dff0679f7b6c8f', NULL, 'Ativo');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

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


-- A despejar estrutura da base de dados para bdclinica_goncaloaraujo
DROP DATABASE IF EXISTS `bdclinica_goncaloaraujo`;
CREATE DATABASE IF NOT EXISTS `bdclinica_goncaloaraujo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `bdclinica_goncaloaraujo`;

-- A despejar estrutura para tabela bdclinica_goncaloaraujo.atleta
DROP TABLE IF EXISTS `atleta`;
CREATE TABLE IF NOT EXISTS `atleta` (
  `nif` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `codAtleta` int(11) DEFAULT NULL,
  `codPostal` varchar(100) DEFAULT NULL,
  `nacionalidade` varchar(100) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`nif`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- A despejar dados para tabela bdclinica_goncaloaraujo.atleta: ~6 rows (aproximadamente)
DELETE FROM `atleta`;
INSERT INTO `atleta` (`nif`, `nome`, `codAtleta`, `codPostal`, `nacionalidade`, `dataNascimento`, `email`, `descricao`) VALUES
	(100001, 'João Silva', 101, '1234-567', 'Portuguese', '1990-05-12', 'joao.silva@example.com', 'Experienced runner'),
	(100002, 'Ana Sousa', 102, '2345-678', 'Portuguese', '1985-08-22', 'ana.sousa@example.com', 'Professional swimmer'),
	(100003, 'Carlos Almeida', 103, '3456-789', 'Portuguese', '1993-11-15', 'carlos.almeida@example.com', 'Triathlete with international experience'),
	(100004, 'Maria Fernandes', 104, '4567-890', 'Portuguese', '1992-02-28', 'maria.fernandes@example.com', 'Young and upcoming gymnast'),
	(100005, 'Rita Martins', 105, '5678-901', 'Portuguese', '1989-12-04', 'rita.martins@example.com', 'Volleyball player at national level'),
	(234242423, 'Goncalo araujo', 2, '7100-152', 'Portuguesa', '1997-01-06', 'gongas19972@gmail.com', 'Bom Atleta.');

-- A despejar estrutura para tabela bdclinica_goncaloaraujo.consultas
DROP TABLE IF EXISTS `consultas`;
CREATE TABLE IF NOT EXISTS `consultas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nCedulaMedico` int(11) DEFAULT NULL,
  `nifAtleta` int(11) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `nImpresso` int(11) DEFAULT NULL,
  `valor` float DEFAULT NULL,
  `fCardica` float DEFAULT NULL,
  `pArtrialMin` float DEFAULT NULL,
  `pArtrialMax` float DEFAULT NULL,
  `comentario` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nCedulaMedico` (`nCedulaMedico`),
  KEY `nifAtleta` (`nifAtleta`),
  CONSTRAINT `consultas_ibfk_1` FOREIGN KEY (`nCedulaMedico`) REFERENCES `medico` (`nCedula`),
  CONSTRAINT `consultas_ibfk_2` FOREIGN KEY (`nifAtleta`) REFERENCES `atleta` (`nif`)
) ENGINE=InnoDB AUTO_INCREMENT=1007 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- A despejar dados para tabela bdclinica_goncaloaraujo.consultas: ~6 rows (aproximadamente)
DELETE FROM `consultas`;
INSERT INTO `consultas` (`id`, `nCedulaMedico`, `nifAtleta`, `data`, `nImpresso`, `valor`, `fCardica`, `pArtrialMin`, `pArtrialMax`, `comentario`) VALUES
	(1001, 20001, 100001, '2024-10-01', 10, 75, 60.5, 120, 180, 'Athlete in excellent health'),
	(1002, 20002, 100002, '2024-10-05', 15, 85, 62, 115, 170, 'Slight fatigue noticed, recommended rest'),
	(1003, 20003, 100003, '2024-10-10', 12, 65, 58, 110, 160, 'Good performance under stress test'),
	(1004, 20004, 100004, '2024-10-12', 18, 90, 65.5, 125, 175, 'Minor muscular strain observed'),
	(1005, 20005, 100005, '2024-10-15', 14, 95, 64.5, 130, 185, 'Recovered well from last season'),
	(1006, 20005, 234242423, '2024-11-09', 20, 70, 61.5, 125, 176, 'Está em ótima forma fisica.');

-- A despejar estrutura para procedimento bdclinica_goncaloaraujo.ContagemConsultasPorAtleta
DROP PROCEDURE IF EXISTS `ContagemConsultasPorAtleta`;
DELIMITER //
CREATE PROCEDURE `ContagemConsultasPorAtleta`()
BEGIN
    SELECT 
        atleta.nome AS nomeAtleta,
        atleta.nif AS nifAtleta,
        COUNT(consultas.id) AS totalConsultas
    FROM 
        atleta
    LEFT JOIN 
        consultas ON atleta.nif = consultas.nifAtleta
    GROUP BY 
        atleta.nif;
END//
DELIMITER ;

-- A despejar estrutura para tabela bdclinica_goncaloaraujo.exames
DROP TABLE IF EXISTS `exames`;
CREATE TABLE IF NOT EXISTS `exames` (
  `cod` int(11) NOT NULL,
  `designacao` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`cod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- A despejar dados para tabela bdclinica_goncaloaraujo.exames: ~5 rows (aproximadamente)
DELETE FROM `exames`;
INSERT INTO `exames` (`cod`, `designacao`) VALUES
	(1, 'Blood Test'),
	(2, 'Cardio Exam'),
	(3, 'Lung Capacity Test'),
	(4, 'X-Ray'),
	(5, 'Physical Fitness Test');

-- A despejar estrutura para tabela bdclinica_goncaloaraujo.examesconsulta
DROP TABLE IF EXISTS `examesconsulta`;
CREATE TABLE IF NOT EXISTS `examesconsulta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idExame` int(11) DEFAULT NULL,
  `idConsulta` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idExame` (`idExame`),
  KEY `idConsulta` (`idConsulta`),
  CONSTRAINT `examesconsulta_ibfk_1` FOREIGN KEY (`idExame`) REFERENCES `exames` (`cod`),
  CONSTRAINT `examesconsulta_ibfk_2` FOREIGN KEY (`idConsulta`) REFERENCES `consultas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- A despejar dados para tabela bdclinica_goncaloaraujo.examesconsulta: ~5 rows (aproximadamente)
DELETE FROM `examesconsulta`;
INSERT INTO `examesconsulta` (`id`, `idExame`, `idConsulta`) VALUES
	(1, 1, 1001),
	(2, 3, 1004),
	(3, 5, 1002),
	(4, 4, 1004),
	(5, 5, 1001);

-- A despejar estrutura para tabela bdclinica_goncaloaraujo.login
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- A despejar dados para tabela bdclinica_goncaloaraujo.login: ~0 rows (aproximadamente)
DELETE FROM `login`;
INSERT INTO `login` (`idLogin`, `idUser`, `hora`, `IpOrigem`, `estado`) VALUES
	(3, 2, '22:10:30', '172.20.10.2', 'Falha');

-- A despejar estrutura para tabela bdclinica_goncaloaraujo.medico
DROP TABLE IF EXISTS `medico`;
CREATE TABLE IF NOT EXISTS `medico` (
  `nCedula` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `nif` int(11) DEFAULT NULL,
  `codPostal` varchar(100) DEFAULT NULL,
  `morada` varchar(100) DEFAULT NULL,
  `nacionalidade` varchar(100) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `tel` int(11) DEFAULT NULL,
  PRIMARY KEY (`nCedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- A despejar dados para tabela bdclinica_goncaloaraujo.medico: ~5 rows (aproximadamente)
DELETE FROM `medico`;
INSERT INTO `medico` (`nCedula`, `nome`, `nif`, `codPostal`, `morada`, `nacionalidade`, `dataNascimento`, `email`, `tel`) VALUES
	(20001, 'Dr. Pedro Costa', 300001, '1234-001', 'Av. Liberdade 123', 'Portuguese', '1975-04-03', 'pedro.costa@clinic.com', 912345678),
	(20002, 'Dr. Sofia Ramos', 300002, '1234-002', 'Rua da Paz 45', 'Portuguese', '1980-06-10', 'sofia.ramos@clinic.com', 932456789),
	(20003, 'Dr. Miguel Duarte', 300003, '1234-003', 'Av. Republica 210', 'Portuguese', '1978-09-17', 'miguel.duarte@clinic.com', 922345678),
	(20004, 'Dr. Ana Ferreira', 300004, '1234-004', 'Rua do Sol 12', 'Portuguese', '1982-03-25', 'ana.ferreira@clinic.com', 952345678),
	(20005, 'Dr. Luis Carvalho', 300005, '1234-005', 'Rua das Flores 78', 'Portuguese', '1985-12-09', 'luis.carvalho@clinic.com', 962345678);

-- A despejar estrutura para tabela bdclinica_goncaloaraujo.modalidade
DROP TABLE IF EXISTS `modalidade`;
CREATE TABLE IF NOT EXISTS `modalidade` (
  `cod` int(11) NOT NULL,
  `NomeModalidade` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`cod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- A despejar dados para tabela bdclinica_goncaloaraujo.modalidade: ~5 rows (aproximadamente)
DELETE FROM `modalidade`;
INSERT INTO `modalidade` (`cod`, `NomeModalidade`) VALUES
	(1, 'Running'),
	(2, 'Swimming'),
	(3, 'Triathlon'),
	(4, 'Gymnastics'),
	(5, 'Volleyball');

-- A despejar estrutura para tabela bdclinica_goncaloaraujo.modalidadesatleta
DROP TABLE IF EXISTS `modalidadesatleta`;
CREATE TABLE IF NOT EXISTS `modalidadesatleta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nifAtleta` int(11) DEFAULT NULL,
  `codModalidade` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nifAtleta` (`nifAtleta`),
  KEY `codModalidade` (`codModalidade`),
  CONSTRAINT `modalidadesatleta_ibfk_1` FOREIGN KEY (`nifAtleta`) REFERENCES `atleta` (`nif`),
  CONSTRAINT `modalidadesatleta_ibfk_2` FOREIGN KEY (`codModalidade`) REFERENCES `modalidade` (`cod`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- A despejar dados para tabela bdclinica_goncaloaraujo.modalidadesatleta: ~5 rows (aproximadamente)
DELETE FROM `modalidadesatleta`;
INSERT INTO `modalidadesatleta` (`id`, `nifAtleta`, `codModalidade`) VALUES
	(1, 100003, 1),
	(2, 100004, 2),
	(3, 100001, 1),
	(4, 100004, 5),
	(5, 100002, 4);

-- A despejar estrutura para tabela bdclinica_goncaloaraujo.user
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
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- A despejar dados para tabela bdclinica_goncaloaraujo.user: ~1 rows (aproximadamente)
DELETE FROM `user`;
INSERT INTO `user` (`idUser`, `nomeUser`, `emailUser`, `nifUser`, `pergunta1`, `resposta1`, `pergunta2`, `resposta2`, `username`, `password`, `foto`, `estado`) VALUES
	(2, 'gongas97', 'gongas19972@gmail.com', 256511977, 'Qual o Primeiro nome da Sua Mãe?', 'Helena', 'Qual o nome do seu primeiro animal?', 'cao', 'gongas97', 'dkZqdTdhTG9HbkRLekoyQ0QvcEJVVXRMUW5sbWMzSk9Ta012Y1', NULL, 'Ativo');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

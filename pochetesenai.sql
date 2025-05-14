-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 09/05/2025 às 19:34
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `pochetesenai`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `movimentacoes`
--

CREATE TABLE `movimentacoes` (
  `id` bigint(20) NOT NULL,
  `professor_matricula` bigint(20) NOT NULL,
  `pochete_id` bigint(20) NOT NULL,
  `data_retirada` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_devolucao` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pochetes`
--

CREATE TABLE `pochetes` (
  `id` bigint(20) NOT NULL,
  `sala_id` bigint(20) NOT NULL,
  `idToken` varchar(8) UNIQUE,
  PRIMARY KEY (`id`),
  KEY `fk_sala` (`sala_id`),
  CONSTRAINT `fk_sala` FOREIGN KEY (`sala_id`) REFERENCES `salas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `professores`
--

CREATE TABLE `professores` (
  `matricula` int(4) NOT NULL PRIMARY KEY,
  `nome` VARCHAR(100) NOT NULL,
  INDEX (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `salas`
--

CREATE TABLE `salas` (
  `id` bigint(20) NOT NULL,
  `nome` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` bigint(20) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `dados_temporarios`
--

CREATE TABLE `dados_temporarios` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `conteudo1` INT(4),
  `conteudo2` INT(8),
  `criado_em` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Evento para limpeza automática dos dados temporários
--

SET GLOBAL event_scheduler = ON;

CREATE EVENT IF NOT EXISTS limpar_dados_temporarios
ON SCHEDULE EVERY 5 MINUTE
DO
  DELETE FROM dados_temporarios
  WHERE criado_em < NOW() - INTERVAL 30 MINUTE;

-- --------------------------------------------------------

-- Verifique se o agendador de eventos está ativado:
-- SHOW VARIABLES LIKE 'event_scheduler';

-- Caso esteja OFF e você tenha permissão:
-- SET GLOBAL event_scheduler = ON;

--
-- Índices para tabelas despejadas
--

ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

ALTER TABLE `movimentacoes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `professor_matricula` (`professor_matricula`),
  ADD KEY `pochete_id` (`pochete_id`);

ALTER TABLE `pochetes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_sala` (`sala_id`);

ALTER TABLE `salas`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas
--

ALTER TABLE `admins`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

ALTER TABLE `movimentacoes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

ALTER TABLE `pochetes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

ALTER TABLE `salas`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

ALTER TABLE `usuarios`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas `movimentacoes`
--

ALTER TABLE `movimentacoes`
  ADD CONSTRAINT `movimentacoes_ibfk_1` FOREIGN KEY (`professor_matricula`) REFERENCES `professores` (`matricula`),
  ADD CONSTRAINT `movimentacoes_ibfk_2` FOREIGN KEY (`pochete_id`) REFERENCES `pochetes` (`id`);

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- Cria o banco de dados, se ainda não existir
CREATE DATABASE IF NOT EXISTS `pochetesenai` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pochetesenai`;

-- Tabela de Professores
-- Cada professor possui uma matrícula única e um nome
CREATE TABLE professores (
  matricula INT NOT NULL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL
);

-- Tabela de Turmas
-- Cada turma tem um identificador único
CREATE TABLE turmas (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  identificador VARCHAR(255) NOT NULL
);

-- Tabela de Cursos
-- Cada curso pertence a UMA turma (1:1) e é ministrado por UM professor (1:1)
-- UNIQUE garante que um professor só ministra um curso
-- UNIQUE garante que uma turma está ligada a um único curso
CREATE TABLE cursos (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  professor_matricula INT NOT NULL UNIQUE, -- FK para professor (1:1)
  turma_id BIGINT NOT NULL UNIQUE,         -- FK para turma (1:1)
  CONSTRAINT fk_curso_professor FOREIGN KEY (professor_matricula) REFERENCES professores(matricula),
  CONSTRAINT fk_curso_turma FOREIGN KEY (turma_id) REFERENCES turmas(id)
);

-- Tabela de Salas
-- Cada sala tem um nome e um ID único
CREATE TABLE salas (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL
);

-- Tabela de Pochetes
-- Cada pochete está associada a uma sala específica
-- A relação é do tipo MUITAS pochetes para UMA sala
CREATE TABLE pochetes (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  sala_id BIGINT NOT NULL,                      -- FK para sala (n:1)
  idtoken VARCHAR(8) UNIQUE,                    -- Token único por pochete
  CONSTRAINT fk_sala FOREIGN KEY (sala_id) REFERENCES salas(id)
);

-- Tabela de Admins
-- Cada admin tem nome único e senha
CREATE TABLE admins (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) UNIQUE NOT NULL,
  senha VARCHAR(255) NOT NULL
);

-- Tabela de Usuários
-- Usuários do sistema com nome e senha
CREATE TABLE usuarios (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  senha VARCHAR(255) NOT NULL
);

-- Tabela de Dados Temporários
-- Armazena registros temporários com timestamp
CREATE TABLE dados_temporarios (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  conteudo1 INT,
  conteudo2 BIGINT,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Movimentações
-- Registra quando um professor retira ou devolve uma pochete
-- Cada movimentação está ligada a:
-- 1 professor (n:1)
-- 1 pochete (n:1)
CREATE TABLE movimentacoes (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  professor_matricula INT NOT NULL,             -- FK para professor (n:1)
  pochete_id BIGINT NOT NULL,                   -- FK para pochete (n:1)
  data_retirada TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  data_devolucao TIMESTAMP NULL DEFAULT NULL,
  CONSTRAINT fk_mov_professor FOREIGN KEY (professor_matricula) REFERENCES professores(matricula),
  CONSTRAINT fk_mov_pochete FOREIGN KEY (pochete_id) REFERENCES pochetes(id)
);

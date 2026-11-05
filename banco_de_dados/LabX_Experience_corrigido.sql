-- LABX EXPERIENCE: SCRIPT COMPLETO
-- ATENCAO: este script apaga e recria o banco labx_experience.
-- Execute somente se puder perder os dados atuais desse banco.

DROP DATABASE IF EXISTS labx_experience;
CREATE DATABASE labx_experience;

USE labx_experience;

CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    tipo ENUM('ADMINISTRADOR', 'PROFESSOR', 'ALUNO') NOT NULL,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE turma (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    serie VARCHAR(50) NOT NULL,
    periodo ENUM('MANHA', 'TARDE', 'NOITE') NOT NULL,
    ano INT NOT NULL
);

CREATE TABLE aluno_turma (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aluno_id INT NOT NULL,
    turma_id INT NOT NULL,

    FOREIGN KEY (aluno_id) REFERENCES usuario(id),
    FOREIGN KEY (turma_id) REFERENCES turma(id),

    UNIQUE (aluno_id, turma_id)
);

CREATE TABLE professor_turma (
    id INT AUTO_INCREMENT PRIMARY KEY,
    professor_id INT NOT NULL,
    turma_id INT NOT NULL,

    FOREIGN KEY (professor_id) REFERENCES usuario(id),
    FOREIGN KEY (turma_id) REFERENCES turma(id),

    UNIQUE (professor_id, turma_id)
);

CREATE TABLE laboratorio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    area ENUM('FISICA', 'QUIMICA', 'BIOLOGIA') NOT NULL,
    capacidade INT NOT NULL,
    descricao TEXT,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE tema (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descricao TEXT,
    area ENUM('FISICA', 'QUIMICA', 'BIOLOGIA') NOT NULL
);

CREATE TABLE atividade (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descricao TEXT,
    tema_id INT NOT NULL,
    professor_id INT NOT NULL,

    FOREIGN KEY (tema_id) REFERENCES tema(id),
    FOREIGN KEY (professor_id) REFERENCES usuario(id)
);

CREATE TABLE agendamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    laboratorio_id INT NOT NULL,
    professor_id INT NOT NULL,
    turma_id INT NOT NULL,
    atividade_id INT,

    data_agendamento DATE NOT NULL,
    horario_inicio TIME NOT NULL,
    horario_fim TIME NOT NULL,

    status ENUM(
        'AGENDADO',
        'REALIZADO',
        'CANCELADO'
    ) DEFAULT 'AGENDADO',

    observacao TEXT,

    FOREIGN KEY (laboratorio_id) REFERENCES laboratorio(id),
    FOREIGN KEY (professor_id) REFERENCES usuario(id),
    FOREIGN KEY (turma_id) REFERENCES turma(id),
    FOREIGN KEY (atividade_id) REFERENCES atividade(id)
);

CREATE TABLE participacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aluno_id INT NOT NULL,
    agendamento_id INT NOT NULL,
    presente BOOLEAN DEFAULT FALSE,
    observacao TEXT,

    FOREIGN KEY (aluno_id) REFERENCES usuario(id),
    FOREIGN KEY (agendamento_id) REFERENCES agendamento(id),

    UNIQUE (aluno_id, agendamento_id)
);

CREATE TABLE pontuacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    turma_id INT NOT NULL,
    agendamento_id INT,
    pontos INT DEFAULT 0,
    motivo VARCHAR(255),
    data_pontuacao DATE NOT NULL,

    FOREIGN KEY (turma_id) REFERENCES turma(id),
    FOREIGN KEY (agendamento_id) REFERENCES agendamento(id)
);

CREATE TABLE registro_atividade (
    id INT AUTO_INCREMENT PRIMARY KEY,
    atividade_id INT NOT NULL,
    turma_id INT NOT NULL,
    professor_id INT NOT NULL,

    data_realizacao DATE NOT NULL,
    resultado TEXT,
    observacao TEXT,

    FOREIGN KEY (atividade_id) REFERENCES atividade(id),
    FOREIGN KEY (turma_id) REFERENCES turma(id),
    FOREIGN KEY (professor_id) REFERENCES usuario(id)
);

USE labx_experience;

INSERT INTO usuario
(nome, email, senha, tipo)
VALUES
('Administrador LabX', 'admin@labx.com', '123456', 'ADMINISTRADOR'),
('Professor João', 'joao@labx.com', '123456', 'PROFESSOR'),
('Professor Maria', 'maria@labx.com', '123456', 'PROFESSOR'),
('Aluno Tobias', 'tobias@labx.com', '123456', 'ALUNO'),
('Aluno Pedro', 'pedro@labx.com', '123456', 'ALUNO');


INSERT INTO turma
(nome, serie, periodo, ano)
VALUES
('6º Ano A', '6º Ano do Ensino Fundamental', 'MANHA', 2026),
('7º Ano A', '7º Ano do Ensino Fundamental', 'MANHA', 2026),
('8º Ano A', '8º Ano do Ensino Fundamental', 'TARDE', 2026),
('9º Ano A', '9º Ano do Ensino Fundamental', 'TARDE', 2026),
('1º Ano A', '1º Ano do Ensino Médio', 'MANHA', 2026),
('2º Ano A', '2º Ano do Ensino Médio', 'TARDE', 2026),
('3º Ano A', '3º Ano do Ensino Médio', 'MANHA', 2026);


INSERT INTO laboratorio
(nome, area, capacidade, descricao)
VALUES
('Laboratório de Física', 'FISICA', 30,
'Laboratório destinado às aulas práticas de Física'),

('Laboratório de Química', 'QUIMICA', 30,
'Laboratório destinado às aulas práticas de Química'),

('Laboratório de Biologia', 'BIOLOGIA', 30,
'Laboratório destinado às aulas práticas de Biologia');


INSERT INTO tema
(nome, descricao, area)
VALUES
('Movimento e Velocidade',
'Experimentos relacionados ao movimento dos corpos',
'FISICA'),

('Eletricidade',
'Experimentos sobre circuitos e eletricidade',
'FISICA'),

('Reações Químicas',
'Experimentos sobre transformações químicas',
'QUIMICA'),

('Células',
'Estudo prático das células',
'BIOLOGIA');


INSERT INTO professor_turma
(professor_id, turma_id)
VALUES
(2, 1),
(2, 5),
(3, 2),
(3, 6);


INSERT INTO aluno_turma
(aluno_id, turma_id)
VALUES
(4, 1),
(5, 1);-- Tres novos usuarios adicionados
INSERT INTO usuario (nome, email, senha, tipo)
VALUES
('Professor Carlos', 'carlos@labx.com', '123456', 'PROFESSOR'),
('Aluna Ana', 'ana@labx.com', '123456', 'ALUNO'),
('Aluno Lucas', 'lucas@labx.com', '123456', 'ALUNO');

-- Vinculos dos novos usuarios com as turmas
INSERT INTO professor_turma (professor_id, turma_id)
VALUES (6, 3);

INSERT INTO aluno_turma (aluno_id, turma_id)
VALUES
(7, 2),
(8, 3);

-- CONSULTAS PARA CONFERIR OS DADOS
USE labx_experience;

SELECT * FROM usuario;
SELECT * FROM turma;
SELECT * FROM laboratorio;
SELECT * FROM tema;

SELECT u.nome AS aluno, t.nome AS turma
FROM aluno_turma at
INNER JOIN usuario u ON at.aluno_id = u.id
INNER JOIN turma t ON at.turma_id = t.id;

SELECT u.nome AS professor, t.nome AS turma
FROM professor_turma pt
INNER JOIN usuario u ON pt.professor_id = u.id
INNER JOIN turma t ON pt.turma_id = t.id;

SELECT a.nome AS atividade, te.nome AS tema, te.area
FROM atividade a
INNER JOIN tema te ON a.tema_id = te.id;

SELECT a.id, l.nome AS laboratorio, u.nome AS professor, t.nome AS turma,
       a.data_agendamento, a.horario_inicio, a.horario_fim, a.status
FROM agendamento a
INNER JOIN laboratorio l ON a.laboratorio_id = l.id
INNER JOIN usuario u ON a.professor_id = u.id
INNER JOIN turma t ON a.turma_id = t.id;

SELECT t.nome AS turma, SUM(p.pontos) AS total_pontos
FROM pontuacao p
INNER JOIN turma t ON p.turma_id = t.id
GROUP BY t.id, t.nome
ORDER BY total_pontos DESC;

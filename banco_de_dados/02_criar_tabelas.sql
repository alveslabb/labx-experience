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
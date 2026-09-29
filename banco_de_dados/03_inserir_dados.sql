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
(5, 1);
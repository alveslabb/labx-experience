USE labx_experience;

SELECT * FROM usuario;
SELECT * FROM turma;
SELECT * FROM laboratorio;
SELECT * FROM tema;

SELECT
    u.nome AS aluno,
    t.nome AS turma
FROM aluno_turma at
INNER JOIN usuario u
    ON at.aluno_id = u.id
INNER JOIN turma t
    ON at.turma_id = t.id;

SELECT
    u.nome AS professor,
    t.nome AS turma
FROM professor_turma pt
INNER JOIN usuario u
    ON pt.professor_id = u.id
INNER JOIN turma t
    ON pt.turma_id = t.id;

SELECT
    a.nome AS atividade,
    t.nome AS tema,
    t.area
FROM atividade a
INNER JOIN tema t
    ON a.tema_id = t.id;

SELECT
    a.id,
    l.nome AS laboratorio,
    u.nome AS professor,
    t.nome AS turma,
    a.data_agendamento,
    a.horario_inicio,
    a.horario_fim,
    a.status
FROM agendamento a
INNER JOIN laboratorio l
    ON a.laboratorio_id = l.id
INNER JOIN usuario u
    ON a.professor_id = u.id
INNER JOIN turma t
    ON a.turma_id = t.id;

SELECT
    t.nome AS turma,
    SUM(p.pontos) AS total_pontos
FROM pontuacao p
INNER JOIN turma t
    ON p.turma_id = t.id
GROUP BY t.id, t.nome
ORDER BY total_pontos DESC;
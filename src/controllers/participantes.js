const conexao = require("../../db")

function listar(req, res) {
    const sql = `
        SELECT id, nome, email, telefone, turma
        FROM usuario
        WHERE tipo = 'ALUNO' AND ativo = TRUE
    `

    conexao.query(sql, (erro, resultados) => {
        if (erro) {
            return res.status(500).json({ mensagem: "Erro ao listar participantes." })
        }

        res.json(resultados)
    })
}

function criar(req, res) {
    const { nome, email, telefone, turma } = req.body

    const sql = `
        INSERT INTO usuario (nome, email, telefone, turma, tipo)
        VALUES (?, ?, ?, ?, 'ALUNO')
    `

    conexao.query(sql, [nome, email, telefone, turma], (erro, resultado) => {
        if (erro) {
            return res.status(500).json({
                mensagem: "Erro ao cadastrar participante.",
                erro: erro.message
            })
        }

        res.status(201).json({
            id: resultado.insertId,
            nome,
            email,
            telefone,
            turma
        })
    })
}

function buscarPorId(req, res) {
    const sql = `
        SELECT id, nome, email, telefone, turma
        FROM usuario
        WHERE id = ? AND tipo = 'ALUNO' AND ativo = TRUE
    `

    conexao.query(sql, [req.params.id], (erro, resultados) => {
        if (erro) {
            return res.status(500).json({ mensagem: "Erro ao buscar participante." })
        }

        if (resultados.length === 0) {
            return res.status(404).json({ mensagem: "Participante não encontrado." })
        }

        res.json(resultados[0])
    })
}

function alterar(req, res) {
    const { nome, email, telefone, turma } = req.body

    const sql = `
        UPDATE usuario
        SET nome = ?, email = ?, telefone = ?, turma = ?
        WHERE id = ? AND tipo = 'ALUNO' AND ativo = TRUE
    `

    conexao.query(sql, [nome, email, telefone, turma, req.params.id], (erro, resultado) => {
        if (erro) {
            return res.status(500).json({
                mensagem: "Erro ao alterar participante.",
                erro: erro.message
            })
        }

        if (resultado.affectedRows === 0) {
            return buscarPorId(req, res)
        }

        res.json({ mensagem: "Participante alterado com sucesso!" })
    })
}

function excluir(req, res) {
    const sql = `
        UPDATE usuario
        SET ativo = FALSE
        WHERE id = ? AND tipo = 'ALUNO' AND ativo = TRUE
    `

    conexao.query(sql, [req.params.id], (erro, resultado) => {
        if (erro) {
            return res.status(500).json({ mensagem: "Erro ao excluir participante." })
        }

        if (resultado.affectedRows === 0) {
            return res.status(404).json({ mensagem: "Participante não encontrado." })
        }

        res.json({ mensagem: "Participante excluído com sucesso!" })
    })
}

module.exports = {
    listar,
    criar,
    buscarPorId,
    alterar,
    excluir
}
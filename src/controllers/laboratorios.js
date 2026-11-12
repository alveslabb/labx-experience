const conexao = require("../../db")

function listar(req, res) {
    const sql = "SELECT * FROM laboratorio WHERE ativo = TRUE"

    conexao.query(sql, (erro, resultados) => {
        if (erro) {
            return res.status(500).json({ mensagem: "Erro ao listar laboratórios." })
        }

        res.json(resultados)
    })
}

function criar(req, res) {
    const { nome, area, capacidade, descricao } = req.body

    const sql = `
        INSERT INTO laboratorio (nome, area, capacidade, descricao)
        VALUES (?, ?, ?, ?)
    `

    conexao.query(sql, [nome, area, capacidade, descricao], (erro, resultado) => {
        if (erro) {
            return res.status(500).json({ mensagem: "Erro ao cadastrar laboratório.", erro: erro.message })
        }

        res.status(201).json({
            id: resultado.insertId,
            nome,
            area,
            capacidade,
            descricao
        })
    })
}

function alterar(req, res) {
    const id = req.params.id
    const { nome, area, capacidade, descricao } = req.body

    const sql = `
        UPDATE laboratorio
        SET nome = ?, area = ?, capacidade = ?, descricao = ?
        WHERE id = ? AND ativo = TRUE
    `

    conexao.query(sql, [nome, area, capacidade, descricao, id], (erro, resultado) => {
        if (erro) {
            return res.status(500).json({ mensagem: "Erro ao alterar laboratório.", erro: erro.message })
        }

        if (resultado.affectedRows === 0) {
            return res.status(404).json({ mensagem: "Laboratório não encontrado." })
        }

        res.json({ mensagem: "Laboratório alterado com sucesso!" })
    })
}

function excluir(req, res) {
    const id = req.params.id

    const sql = "UPDATE laboratorio SET ativo = FALSE WHERE id = ? AND ativo = TRUE"

    conexao.query(sql, [id], (erro, resultado) => {
        if (erro) {
            return res.status(500).json({ mensagem: "Erro ao excluir laboratório.", erro: erro.message })
        }

        if (resultado.affectedRows === 0) {
            return res.status(404).json({ mensagem: "Laboratório não encontrado." })
        }

        res.json({ mensagem: "Laboratório excluído com sucesso!" })
    })
}

module.exports = {
    listar,
    criar,
    alterar,
    excluir
}